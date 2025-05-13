# Amazon VPC (Virtual Private Cloud)

## Introduction
Amazon VPC (Virtual Private Cloud) allows users to create isolated cloud networks where AWS resources like EC2 instances, databases, and Lambda functions can securely operate.

## Steps to Create a VPC
1. **Sign in to AWS Console**  
   - Go to [AWS Management Console](https://aws.amazon.com/console/)  
   - Navigate to **VPC Dashboard**  

2. **Create a VPC**  
   - Click **Create VPC**  
   - Enter a **VPC Name**  
   - Set an **IPv4 CIDR Block** (e.g., `10.0.0.0/16`)  
   - Enable **IPv6 CIDR Block** (optional)  
   - Choose **Tenancy** (default or dedicated)  
   - Click **Create VPC**  

3. **Create Subnets**  
   - Go to **Subnets** → Click **Create Subnet**  
   - Select the **VPC**  
   - Choose **Availability Zone**  
   - Set **IPv4 CIDR Block** (e.g., `10.0.1.0/24`)  
   - Click **Create Subnet**  

4. **Create an Internet Gateway (IGW)**  
   - Go to **Internet Gateways** → Click **Create Internet Gateway**  
   - Attach the IGW to the VPC  

5. **Create a Route Table**  
   - Go to **Route Tables** → Click **Create Route Table**  
   - Associate it with the VPC  
   - Add a route for **0.0.0.0/0** pointing to the IGW  

6. **Modify Security Groups & NACLs**  
   - Go to **Security Groups** → Modify inbound/outbound rules  
   - Allow necessary traffic (e.g., SSH, HTTP, HTTPS)  
   - Set up **Network ACLs** to allow/block specific traffic  

## Benefits of VPC
✅ **Isolation** – Secure and private cloud environment  
✅ **Custom Networking** – Define IP ranges, subnets, and routing  
✅ **Scalability** – Easily add new subnets and resources  
✅ **Security** – Use security groups, NACLs, and VPNs for protection  
✅ **Integration** – Works with EC2, RDS, Lambda, and other AWS services  

---
