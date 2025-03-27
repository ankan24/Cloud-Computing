#!/bin/bash
# Create a Load Balancer
aws elb create-load-balancer --load-balancer-name my-load-balancer \
--listeners Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80 \
--subnets subnet-abc12345

# List Load Balancers
aws elb describe-load-balancers

# Delete a Load Balancer
aws elb delete-load-balancer --load-balancer-name my-load-balancer
