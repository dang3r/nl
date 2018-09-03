#!/usr/bin/env bash
#
# Generate terraform and format it

nl-tf > aws.tf
terraform fmt
