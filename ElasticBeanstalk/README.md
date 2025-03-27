# AWS Elastic Beanstalk

## Introduction
AWS Elastic Beanstalk is a Platform-as-a-Service (PaaS) that simplifies deploying, managing, and scaling web applications and services. It supports multiple programming languages, including **Node.js, Python, Java, PHP, Ruby, Go, and .NET**.

## Steps to Create and Use AWS Elastic Beanstalk

### 1. **Create an Elastic Beanstalk Application**
- **Sign in to AWS Console** and go to [Elastic Beanstalk](https://console.aws.amazon.com/elasticbeanstalk).
- Click **"Create Application"**.
- Enter **Application Name**.
- Select **Platform** (e.g., Node.js, Python, Java, etc.).
- Choose **Sample Application** (or upload your own code).
- Click **"Create Application"**.

### 2. **Deploy an Application**
- Use the AWS Elastic Beanstalk CLI or Console:
  - **AWS CLI Deployment**:
    ```sh
    eb init  # Initialize Elastic Beanstalk project
    eb create my-env  # Create an environment
    eb deploy  # Deploy application
    ```
  - **Using AWS Console**:
    - Go to your Elastic Beanstalk application.
    - Click **Upload and Deploy**.
    - Choose your application ZIP file and deploy.

### 3. **Monitor and Scale Your Application**
- **Scaling**:
  - Go to **"Configuration" > "Capacity"**.
  - Set the **desired number of instances**.
  - Enable **Auto Scaling** for automatic scaling.
- **Monitoring**:
  - Use the **Health Dashboard** to check application status.
  - View logs and metrics for performance monitoring.

### 4. **Update an Application**
- Make changes to the application code.
- Run:
  ```sh
  eb deploy  # Deploy latest changes
