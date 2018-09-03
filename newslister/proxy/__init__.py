from newslister.proxy.aws import *

from .aws import ProxyPool

def factory(cloud, count, **kwargs):
    if cloud == 'aws':
        group = ProxyPool(count, **kwargs)
        return group
    raise Exception('No factory exists!')