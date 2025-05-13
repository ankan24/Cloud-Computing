#!/bin/bash
# Create an S3 bucket
aws s3 mb s3://my-bucket-name

# List all S3 buckets
aws s3 ls

# Upload a file to S3
aws s3 cp myfile.txt s3://my-bucket-name/

# Download a file from S3
aws s3 cp s3://my-bucket-name/myfile.txt myfile.txt

# Delete a file from S3
aws s3 rm s3://my-bucket-name/myfile.txt

# Delete an S3 bucket (Must be empty)
aws s3 rb s3://my-bucket-name --force
