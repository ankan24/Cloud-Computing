# Amazon EC2 (Elastic Compute Cloud)

## Introduction
Amazon EC2 (Elastic Compute Cloud) provides scalable computing capacity in the AWS cloud. It allows users to run virtual machines (instances) on demand.

## Steps to Create an EC2 Instance
1. **Sign in to AWS Console**  
   - Go to [AWS Management Console](https://aws.amazon.com/console/)  
   - Navigate to **EC2 Dashboard**  

2. **Launch an EC2 Instance**  
   - Click on **Launch Instance**  
   - Choose an **Amazon Machine Image (AMI)** (e.g., Ubuntu, Windows, Amazon Linux)  
   - Select an **Instance Type** (e.g., t2.micro for free tier)  
   - Configure instance details (e.g., number of instances, network settings)  
   - Add storage (default is 8GB for free tier)  
   - Configure security group (open required ports like SSH for Linux or RDP for Windows)  
   - Review and launch  

3. **Access EC2 Instance**  
   - If it's a **Linux Instance**:  
     - Use SSH:  
       ```sh
       ssh -i your-key.pem ec2-user@your-ec2-ip
       ```
   - If it's a **Windows Instance**:  
     - Use Remote Desktop Protocol (RDP)  
     - Download the key and get the password  

4. **Stop, Start, or Terminate EC2 Instance**  
   - **Start**: Select instance → Click "Start"  
   - **Stop**: Select instance → Click "Stop"  
   - **Terminate**: Select instance → Click "Terminate" (Warning: Data will be lost)  

## Benefits of EC2
✅ **Scalability** – Easily scale up or down as needed  
✅ **Flexibility** – Wide range of instance types and OS options  
✅ **Security** – Secure access with AWS IAM and security groups  
✅ **Cost-Effective** – Pay-as-you-go pricing  

---
