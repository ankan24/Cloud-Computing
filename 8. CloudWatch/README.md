# AWS CloudWatch

## Introduction
Amazon CloudWatch is a **monitoring and observability** service for AWS cloud resources and applications. It collects and tracks metrics, collects logs, sets alarms, and provides insights into AWS performance.

## Steps to Create and Use AWS CloudWatch

### 1. **Access CloudWatch Dashboard**
- Sign in to the **AWS Management Console**.
- Navigate to **CloudWatch**.

### 2. **Create a CloudWatch Alarm**
- Open the **Alarms** section in CloudWatch.
- Click **"Create Alarm"**.
- Select a **Metric** (e.g., EC2 CPU Utilization).
- Set a **Threshold** (e.g., trigger an alarm if CPU > 80%).
- Choose an **Action** (e.g., send an SNS notification).
- Click **"Create Alarm"**.

### 3. **Monitor Logs using CloudWatch Logs**
- Open **Log Groups** in CloudWatch.
- Click **"Create Log Group"**.
- Configure **Log Streams** to collect logs from services like EC2, Lambda, or ECS.

### 4. **Enable CloudWatch Metrics**
- Metrics automatically appear for AWS services like EC2, S3, and RDS.
- Click on **Metrics** in CloudWatch to explore various resource performance statistics.

### 5. **Use AWS CLI for CloudWatch**
- **List CloudWatch metrics:**
  ```sh
  aws cloudwatch list-metrics
