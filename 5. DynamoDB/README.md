 # 📦 Amazon DynamoDB

Amazon DynamoDB is a **fully managed NoSQL database service** by AWS that delivers fast and predictable performance with seamless scalability. It allows you to create database tables to store and retrieve any amount of data and serve any level of request traffic.

---

## 🚀 Features

- **Fully managed** by AWS (no need for server management)
- **Highly scalable** (automatically scales up/down)
- **Millisecond latency** reads and writes
- **Built-in security** with fine-grained access control
- **Integrated with AWS Lambda, CloudWatch, IAM, and more**

---

## 🛠 Steps to Create and Use a DynamoDB Table

### 1. Create a Table Using AWS Console

- **Login to AWS Console**
- Navigate to **DynamoDB** service
- Click **Create Table**

#### Table Details:

- **Table Name**: (e.g., `Users`, `Products`)
- **Partition Key (Primary Key)**: A unique identifier (e.g., `userId`)
- **Sort Key** *(optional)*: Secondary part of the key to allow sorting (e.g., `timestamp`)
- Choose **settings** like read/write capacity (on-demand or provisioned)
- Click **Create**

---

### 2. Add Data to the Table

- Go to your created table
- Click on the **Items** tab
- Click **Create Item**
- Add key-value pairs (JSON format)
- Click **Save**

---

### 3. Query and Scan Data

#### 🔍 Query:
- Use when you know the **Partition Key**
- Efficient and fast
- Can filter using **Sort Key**

#### 🔎 Scan:
- Reads **every item** in the table
- Slower and more expensive
- Use filters to narrow results

---

### 4. Update and Delete Items

- **Update**:
  - Select an item
  - Click **Edit**
  - Modify attributes
  - Click **Save**

- **Delete**:
  - Select an item
  - Click **Actions > Delete**
  - Confirm deletion

---

## ✅ Benefits of DynamoDB

| Feature       | Description                                                                 |
|---------------|-----------------------------------------------------------------------------|
| 🚀 Scalability | Automatically scales up/down based on demand                                |
| ⚡ Performance | Consistent, single-digit millisecond latency                                |
| 🔧 Fully Managed | No servers to provision or manage                                           |
| 🔐 Security     | IAM-based access control, VPC support, encryption at rest and in-transit    |
| 🧩 Flexibility  | Supports key-value and document data models                                |

---

## 📚 Learn More

For in-depth tutorials and documentation:
👉 [AWS DynamoDB Documentation](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html)

---

## 🧪 Sample Use Cases

- User profile storage
- IoT device state tracking
- E-commerce shopping cart
- Real-time analytics with DynamoDB Streams + Lambda

---

## 🛡 Best Practices

- Always use **Query** over **Scan** for performance
- Use **Global Secondary Indexes (GSI)** to support alternate query patterns
- Enable **Auto Scaling**
- Monitor performance using **CloudWatch**
- Use **on-demand mode** for unpredictable workloads

---

