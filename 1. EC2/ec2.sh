#!/bin/bash
# Create an EC2 instance
aws ec2 run-instances --image-id ami-12345678 --count 1 --instance-type t2.micro --key-name MyKeyPair --security-groups MySecurityGroup

# List running EC2 instances
aws ec2 describe-instances --query "Reservations[*].Instances[*].InstanceId"

# Stop an EC2 instance
aws ec2 stop-instances --instance-ids i-1234567890abcdef0

# Terminate an EC2 instance
aws ec2 terminate-instances --instance-ids i-1234567890abcdef0
