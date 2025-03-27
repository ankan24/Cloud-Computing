Docker Commands for AWS

📌 Install Docker on AWS EC2 (Amazon Linux 2 / Ubuntu)
sudo yum update -y            # For Amazon Linux 2
sudo apt update -y            # For Ubuntu

sudo yum install docker -y    # Amazon Linux 2
sudo apt install docker.io -y # Ubuntu

sudo systemctl start docker   # Start Docker
sudo systemctl enable docker  # Enable Docker on boot

📌 Check Docker Version
docker --version

📌 Run a Docker Container
docker run -d -p 80:80 nginx

📌 List Running Containers
docker ps

📌 List All Containers (Including Stopped)
docker ps -a

📌 Stop a Running Container
docker stop <container_id>

📌 Remove a Container
docker rm <container_id>

📌 Remove All Stopped Containers
docker container prune

📌 List Downloaded Images
docker images

📌 Pull an Image from Docker Hub
docker pull nginx

📌 Remove an Image
docker rmi nginx

📌 Build a Docker Image from a Dockerfile
docker build -t myapp .

📌 Run a Container from a Custom Image
docker run -d -p 5000:5000 myapp

📌 Check Logs of a Running Container
docker logs <container_id>

📌 Execute a Command Inside a Running Container
docker exec -it <container_id> /bin/bash

📌 Stop All Running Containers
docker stop $(docker ps -q)

📌 Remove All Containers
docker rm $(docker ps -aq)

📌 Remove All Docker Images
docker rmi $(docker images -q)

📌 Login to DockerHub
docker login

📌 Push an Image to DockerHub
docker tag myapp username/myapp:v1
docker push username/myapp:v1

📌 Run Docker Compose
docker-compose up -d

📌 Stop Docker Compose
docker-compose down

📌 Check Docker System Info
docker info
