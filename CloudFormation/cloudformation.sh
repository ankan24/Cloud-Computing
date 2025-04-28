#!/bin/bash

# AWS CloudFormation CLI Commands

# Configure AWS CLI (if not already configured)
aws configure

# Validate a CloudFormation template
aws cloudformation validate-template --template-body file://template.yaml

# Create a new stack
aws cloudformation create-stack \
  --stack-name my-stack \
  --template-body file://template.yaml \
  --parameters ParameterKey=KeyName,ParameterValue=my-key-pair

# Create a stack with a template stored in S3
aws cloudformation create-stack \
  --stack-name my-stack \
  --template-url https://s3.amazonaws.com/bucket-name/template.yaml \
  --parameters ParameterKey=KeyName,ParameterValue=my-key-pair

# Create a stack with capabilities
aws cloudformation create-stack \
  --stack-name my-stack \
  --template-body file://template.yaml \
  --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM

# Update an existing stack
aws cloudformation update-stack \
  --stack-name my-stack \
  --template-body file://updated-template.yaml

# Create a change set (preview changes)
aws cloudformation create-change-set \
  --stack-name my-stack \
  --change-set-name my-change-set \
  --template-body file://updated-template.yaml

# Execute a change set
aws cloudformation execute-change-set \
  --stack-name my-stack \
  --change-set-name my-change-set

# List stacks
aws cloudformation list-stacks

# Describe a stack
aws cloudformation describe-stacks --stack-name my-stack

# Describe stack resources
aws cloudformation describe-stack-resources --stack-name my-stack

# List stack events
aws cloudformation describe-stack-events --stack-name my-stack

# Get stack outputs
aws cloudformation describe-stacks --stack-name my-stack --query "Stacks[0].Outputs"

# Delete a stack
aws cloudformation delete-stack --stack-name my-stack

# Create a stack set for multi-account/region deployment
aws cloudformation create-stack-set \
  --stack-set-name my-stack-set \
  --template-body file://template.yaml

# Deploy stack instances to specific accounts and regions
aws cloudformation create-stack-instances \
  --stack-set-name my-stack-set \
  --accounts 123456789012 \
  --regions us-east-1 us-west-2

# Package a template with local references
aws cloudformation package \
  --template-file template.yaml \
  --s3-bucket my-bucket \
  --output-template-file packaged-template.yaml

# Deploy a packaged template
aws cloudformation deploy \
  --template-file packaged-template.yaml \
  --stack-name my-stack \
  --capabilities CAPABILITY_IAM