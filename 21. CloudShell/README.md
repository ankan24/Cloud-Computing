# AWS CloudShell

## Introduction
AWS CloudShell is a **browser-based shell environment** that allows you to securely run CLI commands, manage AWS resources, and execute scripts without installing the AWS CLI on your local machine.

## Steps to Use AWS CloudShell

### 1. **Open AWS CloudShell**
- Sign in to the **AWS Management Console**.
- Click on the **CloudShell** icon (found in the top-right corner).
- A shell terminal opens in your browser.

### 2. **Run AWS CLI Commands**
- AWS CloudShell comes pre-installed with the AWS CLI.
- Example commands:
  ```sh
  aws s3 ls  # List all S3 buckets
  aws ec2 describe-instances  # View running EC2 instances
