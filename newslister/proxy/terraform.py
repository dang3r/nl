import logging
import pkg_resources
import subprocess


resource_package = __name__
nl_tf_dir = pkg_resources.resource_filename(resource_package, 'terraform')


class Terraform:
    def __init__(self, tf_dir=nl_tf_dir):
        self.dir = tf_dir

    def apply(self, region_to_count):
        """Bring up terraform infrastructure
        region_to_count is a map of aws regions to the number of instances desired
        """
        _vars = self._fmt_count(region_to_count)
        self._run(f'terraform init {self.dir} && terraform apply -auto-approve -var "counts={_vars}" {self.dir}')

    def destroy(self):
        """Destroy all terraform infrastructure"""
        self._run(f'terraform destroy --auto-approve {self.dir}')

    def _fmt_count(self, _vars):
        """Format the map of regions to count for the terraform cli.
        eg. terraform plan -var counts={us-east-1=20,us-east-2=17} terraform
        """
        return '{' + ','.join(f'{k}={v}' for k, v in _vars.items()) + '}'

    def _run(self, cmd):
        subprocess.run(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, shell=True, check=True)