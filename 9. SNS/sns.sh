#!/bin/bash
# Create an SNS topic
aws sns create-topic --name my-topic

# List SNS topics
aws sns list-topics

# Delete an SNS topic
aws sns delete-topic --topic-arn arn:aws:sns:us-east-1:123456789012:my-topic
