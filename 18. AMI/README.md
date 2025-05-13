# AWS AMI (Amazon Machine Image)

## Introduction
Amazon Machine Image (AMI) is a **pre-configured virtual machine template** that provides the information required to launch an instance in AWS EC2. AMIs include an OS, application software, and configurations.

## Steps to Create and Use AWS AMI

### 1. **Create an AMI from an EC2 Instance**
- Sign in to the **AWS Management Console**.
- Navigate to **EC2 Dashboard** → **Instances**.
- Select the **Instance** you want to create an AMI from.
- Click **"Actions"** → **"Create Image"**.
- Provide a name and description for the AMI.
- Click **"Create Image"** and wait for it to be available under **AMI**.

### 2. **Launch an EC2 Instance from an AMI**
- Go to the **EC2 Dashboard** → **AMIs**.
- Select your AMI and click **"Launch"**.
- Choose the **Instance Type** (e.g., t2.micro).
- Configure instance settings (network, storage, etc.).
- Click **"Launch"** to create an EC2 instance from your AMI.

### 3. **Use AWS CLI to Create and Manage AMIs**
- **Create an AMI from an instance:**
  ```sh
  aws ec2 create-image --instance-id i-1234567890abcdef0 --name "MyCustomAMI" --no-reboot
