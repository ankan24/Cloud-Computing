#!/bin/bash
# Create a DynamoDB table
aws dynamodb create-table --table-name Users \
--attribute-definitions AttributeName=UserId,AttributeType=S \
--key-schema AttributeName=UserId,KeyType=HASH \
--billing-mode PAY_PER_REQUEST

# List DynamoDB tables
aws dynamodb list-tables

# Delete a DynamoDB table
aws dynamodb delete-table --table-name Users
