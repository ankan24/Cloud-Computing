# AWS IAM (Identity and Access Management)

## Introduction
AWS IAM (Identity and Access Management) is a service that helps manage access to AWS resources securely. It allows you to create users, groups, and roles with specific permissions.

## Steps to Create and Use IAM

### 1. **Create an IAM User**
- **Sign in to AWS Console**: Go to the [IAM Console](https://console.aws.amazon.com/iam/).
- **Create User**:
  - Click **"Users"** → **"Add user"**.
  - Enter a username.
  - Select **"Access key - Programmatic access"** for API access.
- **Set Permissions**:
  - Attach existing policies like **AdministratorAccess** or **AmazonS3FullAccess**.
  - Or create a custom policy.
- **Review and Create**: Click **"Create user"** and download the access key.

### 2. **Create an IAM Group**
- **Navigate to Groups**: Click **"Groups"** → **"Create group"**.
- **Add Permissions**:
  - Assign policies like **AmazonEC2FullAccess** or **AmazonRDSFullAccess**.
- **Add Users**: Assign users to the group.

### 3. **Create an IAM Role**
- **Go to Roles**: Click **"Roles"** → **"Create role"**.
- **Select Trusted Entity**:
  - Choose **AWS service** (e.g., EC2, Lambda).
- **Attach Policies**:
  - Assign permissions like **AmazonS3ReadOnlyAccess**.
- **Create the Role** and attach it to an AWS service.

### 4. **Attach an IAM Policy**
- **Go to Policies**: Click **"Policies"** → **"Create Policy"**.
- **Define Permissions**:
  - Example JSON Policy for S3 Access:
    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": "s3:*",
          "Resource": "*"
        }
      ]
    }
    ```
- **Attach Policy**: Assign to users, groups, or roles.

## Benefits of AWS IAM
- **Granular Access Control**: Fine-grained permissions for users.
- **Secure Authentication**: Uses MFA and temporary credentials.
- **Role-Based Access**: Assign roles for different AWS services.
- **Auditing and Monitoring**: Logs access with AWS CloudTrail.

---

For more details, visit the [AWS IAM Documentation](https://docs.aws.amazon.com/iam/).
