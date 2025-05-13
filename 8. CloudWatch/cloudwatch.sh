#!/bin/bash
# List CloudWatch alarms
aws cloudwatch describe-alarms

# Create a CloudWatch alarm
aws cloudwatch put-metric-alarm --alarm-name CPU-Utilization-Alarm \
--metric-name CPUUtilization --namespace AWS/EC2 --statistic Average \
--period 300 --threshold 70 --comparison-operator GreaterThanThreshold \
--dimensions Name=InstanceId,Value=i-1234567890abcdef0 --evaluation-periods 2 \
--alarm-actions arn:aws:sns:us-east-1:123456789012:my-topic

# Delete a CloudWatch alarm
aws cloudwatch delete-alarms --alarm-names CPU-Utilization-Alarm
