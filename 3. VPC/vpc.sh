#!/bin/bash
# Create a VPC
aws ec2 create-vpc --cidr-block 10.0.0.0/16

# List all VPCs
aws ec2 describe-vpcs --query "Vpcs[*].VpcId"

# Delete a VPC
aws ec2 delete-vpc --vpc-id vpc-12345678
