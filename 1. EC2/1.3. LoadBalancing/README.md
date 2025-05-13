# AWS Load Balancing

## Introduction
AWS Load Balancer distributes incoming traffic across multiple targets (EC2 instances, containers, or IPs) to ensure high availability and reliability of applications.

## Types of AWS Load Balancers
- **Application Load Balancer (ALB)** – Operates at Layer 7 (HTTP/HTTPS)
- **Network Load Balancer (NLB)** – Operates at Layer 4 (TCP/UDP)
- **Classic Load Balancer (CLB)** – Older version, used for basic use cases
- **Gateway Load Balancer (GWLB)** – Distributes traffic for third-party appliances

## Steps to Set Up a Load Balancer

### 1. **Create a Target Group**
- Go to **EC2 Dashboard** → **Target Groups**
- Click **Create Target Group**
- Select **Target Type** (EC2 instance or IP)
- Choose **Protocol (HTTP/HTTPS)** and **Port (80/443)**
- Select **VPC** and configure **Health Checks**
- Click **Create Target Group**  
- **Register Targets** (EC2 instances) and click **Add to Registered**  

### 2. **Create a Load Balancer**
- Go to **EC2 Dashboard** → **Load Balancers**
- Click **Create Load Balancer**
- Choose **Load Balancer Type (ALB, NLB, or CLB)**
- Enter **Name, Scheme (Internet-facing or Internal), and VPC**
- Select **Availability Zones**
- Configure **Listeners (e.g., HTTP on port 80)**
- Attach **Target Group**
- Click **Create Load Balancer**

### 3. **Test Load Balancer**
- Copy the **DNS Name** of the Load Balancer  
- Open a browser and paste the DNS URL to verify traffic distribution  

### 4. **Modify or Delete Load Balancer**
- To update settings, go to **Load Balancers** → Select the Load Balancer → Modify  
- To delete, select the Load Balancer → Click **Delete**  

## Benefits of Load Balancing
✅ **High Availability** – Distributes traffic across multiple instances  
✅ **Fault Tolerance** – Redirects traffic if one instance fails  
✅ **Scalability** – Works with Auto Scaling to handle increased traffic  
✅ **Security** – Supports HTTPS and SSL termination  
✅ **Performance Optimization** – Reduces latency with intelligent routing  

---
