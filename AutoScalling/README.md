# AWS Auto Scaling

## Introduction
AWS Auto Scaling automatically adjusts the number of EC2 instances based on demand to ensure high availability and cost efficiency.

## Steps to Set Up Auto Scaling

### 1. **Create a Launch Template**
- Go to the **EC2 Dashboard** → **Launch Templates**
- Click **Create Launch Template**
- Enter a **Template Name**  
- Choose an **Amazon Machine Image (AMI)**  
- Select an **Instance Type**  
- Configure **Security Groups** and **Key Pair**  
- Click **Create Template**  

### 2. **Create an Auto Scaling Group**
- Go to **EC2 Dashboard** → **Auto Scaling Groups**
- Click **Create Auto Scaling Group**
- Select the **Launch Template** created earlier
- Define **VPC and Subnets**  
- Configure **Load Balancing** (Optional)  
- Set **Desired, Minimum, and Maximum Instance Count**  
- Configure **Scaling Policies**  
  - **Target Tracking Scaling**: Auto adjust based on CPU/memory utilization  
  - **Step Scaling**: Adjusts based on predefined thresholds  
  - **Scheduled Scaling**: Adjusts based on a specific time schedule  
- Click **Create Auto Scaling Group**  

### 3. **Test Auto Scaling**
- Increase workload (e.g., using a load testing tool)
- Monitor instance count changes in **EC2 Dashboard**  

### 4. **Modify or Delete Auto Scaling Group**
- To update settings, go to **Auto Scaling Groups** → Select group → Modify  
- To delete, select the Auto Scaling Group → Click **Delete**  

## Benefits of Auto Scaling
✅ **High Availability** – Ensures application uptime  
✅ **Cost Efficiency** – Scales down when demand is low  
✅ **Performance Optimization** – Maintains optimal performance  
✅ **Automated Management** – Adjusts instances without manual intervention  
✅ **Integration** – Works with ELB, CloudWatch, and Route 53  

---
    