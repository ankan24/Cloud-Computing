#!/bin/bash
# Create an Auto Scaling group
aws autoscaling create-auto-scaling-group --auto-scaling-group-name my-asg \
--launch-template LaunchTemplateId=lt-0123456789abcdef \
--min-size 1 --max-size 3 --desired-capacity 2

# List Auto Scaling groups
aws autoscaling describe-auto-scaling-groups

# Delete an Auto Scaling group
aws autoscaling delete-auto-scaling-group --auto-scaling-group-name my-asg --force-delete
