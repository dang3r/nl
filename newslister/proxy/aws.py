from datetime import datetime
import logging
import queue
import socket
import time

import boto3

from .utils import retry
from .terraform import Terraform

# Amazon Linux AMIS for each region
region_to_amis = {
    'ap-northeast-1': 'ami-0cf78ae724f63bac0',
    'ap-northeast-2': 'ami-08cfa02141f9e9bee',
    'ap-south-1': 'ami-0aba92643213491b9',
    'ap-southeast-1': 'ami-0cf24653bcf894797',
    'ap-southeast-2': 'ami-00c1445796bc0a29f',
    'ca-central-1': 'ami-b61b96d2',
    'eu-central-1': 'ami-06465d49ba60cf770',
    'eu-west-1': 'ami-0ea87e2bfa81ca08a',
    'eu-west-2': 'ami-e6768381',
    'eu-west-3': 'ami-0050bb60cea70c5b3',
    'sa-east-1': 'ami-09c013530239687aa',
    'us-east-1': 'ami-0422d936d535c63b1',
    'us-east-2': 'ami-0f9c61b5a562a16af',
    'us-west-2': 'ami-40d1f038',
    'us-west-1': 'ami-0d4027d2cdbca669d',
}
region_limit = 20
max_instances = len(region_to_amis) * region_limit
ec2_regions = region_to_amis.keys()


def ec2_ami(region):
    return region_to_amis[region]


def assign_instances(regions, count):
    """Assign count instances to the given aws regions"""
    if count > len(regions) * region_limit:
        raise Exception('Too many instances!')

    d = {}
    for region in regions:
        if count == 0:
            break
        size = min(count, region_limit)
        count -= size
        d[region] = size
    return d


def destroy_instances(session, region):
    """Destroy all newslister ec2 instances in a region"""
    client = session.client('ec2', region_name=region)
    filters = [
        {'Name': 'tag:Name', 'Values': [f'newslister.{region}']},
        {'Name': 'tag:Project', 'Values':['newslister']}
    ]
                    
    resp = client.describe_instances(Filters=filters)
    instance_ids = [instance['InstanceId'] for res in resp['Reservations']
                                           for instance in res['Instances']]
    if instance_ids:
        client.terminate_instances(InstanceIds=instance_ids)
    size = len(instance_ids)
    return size


class Proxy:
    """An EC2 Socks5 proxy"""
    def __init__(self, instance, region, port=1080, schema='socks5', user='foo', password='bar'):
        self.instance = instance
        self.region = region
        self.port = port
        self.schema = schema
        self.user = user
        self.password = password

    def ready(self, timeout=None):
        while True:
            try:
                s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
                s.settimeout(timeout)
                s.connect((self.instance.public_ip_address, self.port))
                return True
            except socket.error:
                time.sleep(5)

    def url(self):
        addr = F'{self.instance.public_ip_address}:{self.port}'
        creds = F'{self.user}:{self.password}'
        return F"{self.schema}://{creds}@{addr}"

    def restart(self):
        session = boto3.session.Session()
        client = session.client('ec2', region_name=self.region)
        client.stop_instances(InstanceIds=[self.instance.id])
        client.get_waiter('instance_stopped').wait(InstanceIds=[self.instance.id])
        client.start_instances(InstanceIds=[self.instance.id])
        client.get_waiter('instance_running').wait(InstanceIds=[self.instance.id])
        retry(self.instance.load)


class ProxyPool:
    '''A pool of AWS EC2 proxies'''

    def __init__(self, count):
        self.count = count
        self.session = boto3.session.Session()
        self.queue = queue.Queue()
        self.tf = Terraform()
        r_to_s = self._create(count)

        logging.info('Waiting for %s aws instances to be ready', count)
        self._wait_instances_running(r_to_s)
        self._wait_instances_ready(r_to_s)

    def get(self):
        """Get a proxy"""
        return self.queue.get()

    def put(self, proxy):
        """Put a proxy into the pool"""
        self.queue.put(proxy)

    def replace(self, proxy):
        """Replace a proxy"""
        proxy.restart()
        proxy.ready()
        self.put(proxy)

    def destroy(self):
        """Destroy all terraform infrastructure"""
        self.tf.destroy()

    def __len__(self):
        return self.queue.qsize()

    def _create(self, count):
        """Create count number of instances on AWS"""
        r_to_size = assign_instances(region_to_amis.keys(), count)
        r_to_size = {region: size for region, size in r_to_size.items() if size}
        self.tf.apply(r_to_size)

        r_to_instances = {}
        for region in r_to_size.keys():
            ec2 = self.session.resource('ec2', region_name=region)
            instances = ec2.instances.filter(
                Filters=[
                    {'Name': 'tag:Name', 'Values': [f'newslister.{region}']},
                    {'Name': 'tag:Project', 'Values': ['newslister']},
                    {'Name': 'instance-state-name', 'Values': ['pending', 'running']}
                ]
            )
            r_to_instances[region] = list(instances)
    
        instances = [ instance for instances in r_to_instances.values()
                               for instance in instances ]
        retry(lambda : self._load_instances(instances))
        return r_to_instances

    def _load_instances(self, instances):
        """Load extra EC2 instance information.
        Required for extracting the public ip of an instance not included by default.
        """
        for instance in instances:
            instance.load()

    def _wait_instances_running(self, r_to_s):
        """Wait for all instances to be running"""
        for region, instances in r_to_s.items():
            logging.info('Waiting for %s instances in region %s to run',
                    len(instances), region)
            instance_ids = [instance.instance_id for instance in instances]
            waiter = self.session.client('ec2', region_name=region).get_waiter('instance_status_ok')
            waiter.wait(InstanceIds=instance_ids)

    def _wait_instances_ready(self, r_to_s):
        """Wait for all instances to be in the ready state"""
        for region, instances in r_to_s.items():
            for instance in instances:
                proxy = Proxy(instance, region)
                logging.info(F'Waiting for proxy {proxy.url()} to be ready...')
                retry(lambda pr=proxy: pr.ready(None), tries=18, delay=10)
                self.queue.put(proxy)
