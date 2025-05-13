#!/bin/bash
# Create an RDS instance
aws rds create-db-instance --db-instance-identifier mydb \
--db-instance-class db.t2.micro --engine mysql \
--allocated-storage 20 --master-username admin --master-user-password password123

# List RDS instances
aws rds describe-db-instances

# Delete an RDS instance
aws rds delete-db-instance --db-instance-identifier mydb --skip-final-snapshot
