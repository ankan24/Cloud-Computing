# AWS SNS (Simple Notification Service)

## Introduction
AWS Simple Notification Service (SNS) is a fully managed messaging service that enables **publish/subscribe (Pub/Sub) messaging** for sending notifications to multiple subscribers via SMS, email, push notifications, or AWS services like SQS and Lambda.

## Steps to Create and Use AWS SNS

### 1. **Create an SNS Topic**
- Go to the **AWS Management Console** → **SNS**.
- Click **"Create Topic"**.
- Choose **Standard** or **FIFO (First-In-First-Out)**.
- Enter a **Topic Name**.
- Click **"Create Topic"**.

### 2. **Subscribe to the Topic**
- Open the created SNS topic.
- Click **"Create Subscription"**.
- Select **Protocol** (Email, SMS, SQS, Lambda, etc.).
- Enter the **Endpoint** (e.g., email address or phone number).
- Click **"Create Subscription"**.
- Confirm the subscription (if using email/SMS, check your inbox and verify).

### 3. **Publish a Message**
- Open the SNS Topic.
- Click **"Publish Message"**.
- Enter **Message Subject** and **Message Body**.
- Click **"Publish Message"** to send the notification.

### 4. **Integrate SNS with Other AWS Services**
- **Amazon SQS**: Deliver messages to queues for further processing.
- **AWS Lambda**: Trigger serverless functions on SNS messages.
- **Amazon CloudWatch**: Send alerts based on monitoring metrics.

### 5. **Use AWS CLI to Manage SNS**
- **Create a Topic:**
  ```sh
  aws sns create-topic --name myTopic
