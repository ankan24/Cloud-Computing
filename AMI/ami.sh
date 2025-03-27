#!/bin/bash
# Create an AMI from an EC2 instance
aws ec2 create-image --instance-id i-1234567890abcdef0 --name "MyServerImage"

# List AMIs
aws ec2 describe-images --owners self

# Deregister an AMI
aws ec2 deregister-image --image-id ami-12345678
