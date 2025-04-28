#!/bin/bash

# AWS Lambda CLI Commands

# Configure AWS CLI (if not already configured)
aws configure

# FUNCTION CREATION AND MANAGEMENT

# Create a basic Lambda function (assuming function code is in index.js)
# First, create a deployment package
mkdir my-lambda-function
cd my-lambda-function
echo 'exports.handler = async (event) => { return { statusCode: 200, body: JSON.stringify("Hello from Lambda!") }; };' > index.js
zip function.zip index.js

# Create the Lambda function
aws lambda create-function \
  --function-name my-function \
  --runtime nodejs18.x \
  --role arn:aws:iam::123456789012:role/lambda-role \
  --handler index.handler \
  --zip-file fileb://function.zip \
  --timeout 30 \
  --memory-size 128

# List Lambda functions
aws lambda list-functions

# Get function details
aws lambda get-function --function-name my-function

# Update function code
zip -r updated-function.zip index.js
aws lambda update-function-code \
  --function-name my-function \
  --zip-file fileb://updated-function.zip

# Update function configuration
aws lambda update-function-configuration \
  --function-name my-function \
  --timeout 60 \
  --memory-size 256

# Add environment variables
aws lambda update-function-configuration \
  --function-name my-function \
  --environment "Variables={DB_HOST=mydb.example.com,DB_USER=admin}"

# FUNCTION INVOCATION

# Invoke a function synchronously
aws lambda invoke \
  --function-name my-function \
  --payload '{"key": "value"}' \
  response.json

# Invoke a function asynchronously
aws lambda invoke \
  --function-name my-function \
  --invocation-type Event \
  --payload '{"key": "value"}' \
  response.json

# PERMISSIONS AND TRIGGERS

# Add permission to allow S3 to invoke function
aws lambda add-permission \
  --function-name my-function \
  --statement-id s3-trigger \
  --action lambda:InvokeFunction \
  --principal s3.amazonaws.com \
  --source-arn arn:aws:s3:::my-bucket

# Create an event source mapping (e.g., for SQS)
aws lambda create-event-source-mapping \
  --function-name my-function \
  --event-source-arn arn:aws:sqs:us-east-1:123456789012:my-queue \
  --batch-size 10

# List event source mappings
aws lambda list-event-source-mappings --function-name my-function

# Update event source mapping
aws lambda update-event-source-mapping \
  --uuid a1b2c3d4-5678-90ab-cdef-example11111 \
  --batch-size 5

# Delete event source mapping
aws lambda delete-event-source-mapping --uuid a1b2c3d4-5678-90ab-cdef-example11111

# VERSIONS AND ALIASES

# Publish a version
aws lambda publish-version \
  --function-name my-function \
  --description "Initial version"

# Create an alias
aws lambda create-alias \
  --function-name my-function \
  --name production \
  --function-version 1

# Update an alias
aws lambda update-alias \
  --function-name my-function \
  --name production \
  --function-version 2

# Create weighted alias (for traffic shifting)
aws lambda update-alias \
  --function-name my-function \
  --name production \
  --function-version 2 \
  --routing-config '{"AdditionalVersionWeights":{"3":0.1}}'

# Delete an alias
aws lambda delete-alias --function-name my-function --name production

# LAYERS

# Create a layer
zip -r layer.zip nodejs/
aws lambda publish-layer-version \
  --layer-name my-layer \
  --description "My dependency layer" \
  --zip-file fileb://layer.zip \
  --compatible-runtimes nodejs18.x

# Add a layer to a function
aws lambda update-function-configuration \
  --function-name my-function \
  --layers arn:aws:lambda:us-east-1:123456789012:layer:my-layer:1

# CONCURRENCY

# Configure reserved concurrency
aws lambda put-function-concurrency \
  --function-name my-function \
  --reserved-concurrent-executions 10

# Delete reserved concurrency
aws lambda delete-function-concurrency --function-name my-function

# Configure provisioned concurrency
aws lambda put-provisioned-concurrency-config \
  --function-name my-function \
  --qualifier production \
  --provisioned-concurrent-executions 5

# TAGS

# Tag a function
aws lambda tag-resource \
  --resource arn:aws:lambda:us-east-1:123456789012:function:my-function \
  --tags Department=Engineering,Project=Serverless

# List tags
aws lambda list-tags --resource arn:aws:lambda:us-east-1:123456789012:function:my-function

# Remove tags
aws lambda untag-resource \
  --resource arn:aws:lambda:us-east-1:123456789012:function:my-function \
  --tag-keys Department

# CLEANUP

# Delete a function
aws lambda delete-function --function-name my-function

# Delete a specific version
aws lambda delete-function --function-name my-function --qualifier 1

# Delete a layer version
aws lambda delete-layer-version --layer-name my-layer --version-number 1