#!/bin/bash
# Create an IAM user
aws iam create-user --user-name new-user

# List IAM users
aws iam list-users

# Delete an IAM user
aws iam delete-user --user-name new-user
