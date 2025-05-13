#!/bin/bash
# Install Docker
sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker

# Run a container
docker run -d -p 80:80 nginx

# List running containers
docker ps

# Stop a container
docker stop $(docker ps -q)
