#!/bin/bash
# Docker Commands Reference
# A comprehensive collection of Docker commands for container management

# Installation (Ubuntu)
# --------------------

# Update package index
sudo apt-get update

# Install prerequisites
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up stable repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Verify installation
sudo docker run hello-world

# Post-installation steps for Linux
# -------------------------------

# Create docker group
sudo groupadd docker

# Add user to docker group
sudo usermod -aG docker $USER

# Apply new group membership (or logout and login)
newgrp docker

# Configure Docker to start on boot
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

# Basic Docker Commands
# -------------------

# Display Docker version
docker --version
docker version              # Detailed version info

# Display system-wide Docker info
docker info

# Show Docker disk usage
docker system df

# Basic Container Management
# -----------------------

# Run a container
docker run hello-world
docker run --name my-nginx nginx     # Run with name
docker run -d nginx                  # Run in detached mode
docker run -it ubuntu bash           # Run interactive with terminal
docker run -p 8080:80 nginx          # Port mapping
docker run -v /host/path:/container/path nginx  # Volume mapping
docker run -e ENV_VAR=value nginx    # Set environment variable
docker run --restart always nginx    # Always restart
docker run --rm nginx                # Remove when stopped

# List containers
docker ps                            # List running containers
docker ps -a                         # List all containers
docker ps -q                         # Only display container IDs
docker ps -s                         # Display container sizes

# Start/Stop containers
docker start container_id_or_name
docker stop container_id_or_name
docker restart container_id_or_name
docker pause container_id_or_name
docker unpause container_id_or_name

# Remove containers
docker rm container_id_or_name
docker rm -f container_id_or_name    # Force remove running container
docker rm $(docker ps -aq)           # Remove all containers (use with caution)

# Container Operations
# ------------------

# Execute command in running container
docker exec -it container_id_or_name bash
docker exec container_id_or_name ls -la

# Get container logs
docker logs container_id_or_name
docker logs -f container_id_or_name  # Follow log output
docker logs --tail 100 container_id_or_name  # Last 100 lines
docker logs --since 2021-01-01T00:00:00 container_id_or_name  # Since timestamp

# Inspect container
docker inspect container_id_or_name

# View container stats
docker stats
docker stats container_id_or_name

# View container processes
docker top container_id_or_name

# Copy files between container and host
docker cp container_id_or_name:/path/to/file /host/path
docker cp /host/path/file container_id_or_name:/path/to/file

# Rename a container
docker rename old_name new_name

# Update container configuration
docker update --cpus 0.5 --memory 512m container_id_or_name

# Working with Images
# -----------------

# List images
docker images
docker image ls
docker image ls -a                   # List all images
docker image ls -q                   # Only display image IDs

# Pull images
docker pull ubuntu
docker pull ubuntu:20.04             # Pull specific tag
docker pull ubuntu:latest            # Pull latest tag

# Build image from Dockerfile
docker build -t my-image:tag .
docker build -f Dockerfile.dev -t my-image:tag .  # Use specific Dockerfile

# Remove images
docker rmi image_id_or_name
docker rmi -f image_id_or_name       # Force remove
docker image prune                   # Remove unused images
docker image prune -a                # Remove all unused images

# Tag images
docker tag source_image:tag target_image:tag

# Save and load images
docker save -o image.tar image_name
docker load -i image.tar

# Image history and inspection
docker history image_id_or_name
docker inspect image_id_or_name

# Search Docker Hub
docker search ubuntu

# Image Building with Dockerfile
# ---------------------------

# Basic build
docker build -t app:1.0 .

# Build with build arguments
docker build --build-arg VAR=value -t app:1.0 .

# Build with no cache
docker build --no-cache -t app:1.0 .

# Build for specific platform
docker build --platform linux/amd64 -t app:1.0 .

# Multi-stage builds
# See Dockerfile examples for syntax

# Docker Registry & Sharing
# -----------------------

# Login to Docker Hub or private registry
docker login
docker login private-registry.com

# Push image to registry
docker push username/image:tag

# Pull image from registry
docker pull username/image:tag

# Logout from registry
docker logout
docker logout private-registry.com

# Docker Networks
# -------------

# List networks
docker network ls

# Create network
docker network create my-network
docker network create --driver bridge my-network
docker network create --subnet=192.168.0.0/16 my-network

# Inspect network
docker network inspect my-network

# Connect/disconnect container to network
docker network connect my-network container_id_or_name
docker network disconnect my-network container_id_or_name

# Remove network
docker network rm my-network
docker network prune                 # Remove all unused networks

# Run container with network
docker run --network=my-network nginx

# Docker Volumes
# ------------

# List volumes
docker volume ls

# Create volume
docker volume create my-volume

# Inspect volume
docker volume inspect my-volume

# Remove volume
docker volume rm my-volume
docker volume prune                  # Remove all unused volumes

# Run container with volume
docker run -v my-volume:/path/in/container nginx
docker run --mount source=my-volume,target=/path/in/container nginx

# Docker Compose
# ------------

# Note: Requires docker-compose installation
# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Basic compose commands
docker-compose up                    # Create and start containers
docker-compose up -d                 # In detached mode
docker-compose down                  # Stop and remove containers
docker-compose ps                    # List containers
docker-compose logs                  # View output from containers
docker-compose exec service_name command  # Run command in service
docker-compose build                 # Build or rebuild services
docker-compose pull                  # Pull service images
docker-compose restart               # Restart services
docker-compose stop                  # Stop services
docker-compose start                 # Start services
docker-compose rm                    # Remove stopped containers
docker-compose config                # Validate and view compose file

# System & Maintenance
# -----------------

# Show Docker disk usage
docker system df

# Clean up system
docker system prune                  # Remove unused data
docker system prune -a               # Remove unused data including unused images
docker system prune -a --volumes     # Remove all unused data including volumes

# Docker events
docker events                        # Get real-time events from server
docker events --since '1h'           # Events from the last hour
docker events --filter 'container=name'  # Filter events by container

# Check Docker
docker info                          # Display system-wide information

# Resource Constraints
# -----------------

# CPU constraints
docker run --cpus 0.5 nginx          # Use up to 50% of one CPU
docker run --cpu-shares 512 nginx    # Relative CPU shares (default 1024)

# Memory constraints
docker run --memory 512m nginx       # Memory limit
docker run --memory-reservation 256m nginx  # Soft limit
docker run --memory-swap 1g nginx    # Total memory+swap limit

# Advanced Docker Features
# ---------------------

# Docker content trust
export DOCKER_CONTENT_TRUST=1        # Enable content trust for Docker client
docker trust sign username/image:tag  # Sign an image

# Docker context
docker context ls                    # List contexts
docker context create my-context --docker "host=ssh://user@host"  # Create context
docker context use my-context        # Switch context
docker context rm my-context         # Remove context

# Docker buildx (for multi-platform builds)
# Install buildx
docker buildx create --name mybuilder
docker buildx use mybuilder
docker buildx inspect --bootstrap

# Multi-platform build
docker buildx build --platform linux/amd64,linux/arm64 -t username/image:tag --push .

# Container Security
# ---------------

# Run container with security options
docker run --security-opt no-new-privileges nginx
docker run --security-opt apparmor=docker-default nginx
docker run --security-opt seccomp=/path/to/seccomp/profile.json nginx

# Run containers in read-only mode
docker run --read-only nginx

# Run containers with dropped capabilities
docker run --cap-drop ALL --cap-add NET_BIND_SERVICE nginx

# Docker health checks
docker run --health-cmd="curl -f http://localhost || exit 1" nginx
docker health container_id_or_name

# Advanced Networking
# ----------------

# Create overlay network (for Swarm)
docker network create --driver overlay my-overlay-network

# Create macvlan network
docker network create -d macvlan \
  --subnet=192.168.1.0/24 \
  --gateway=192.168.1.1 \
  -o parent=eth0 my-macvlan-net

# DNS settings
docker run --dns 8.8.8.8 nginx
docker run --dns-search example.com nginx

# Container port commands
docker port container_id_or_name     # List port mappings

# Docker Swarm
# ----------

# Initialize a swarm
docker swarm init --advertise-addr <MANAGER-IP>

# Join a swarm as a worker
docker swarm join --token <TOKEN> <MANAGER-IP>:<PORT>

# Join a swarm as a manager
docker swarm join-token manager      # Get manager token
docker swarm join --token <MANAGER-TOKEN> <MANAGER-IP>:<PORT>

# Leave a swarm
docker swarm leave
docker swarm leave --force           # Force leave for managers

# List nodes
docker node ls
docker node inspect <NODE-ID>

# Manage services
docker service create --name web --replicas 3 -p 80:80 nginx
docker service ls
docker service ps web
docker service scale web=5
docker service update --image nginx:alpine web
docker service logs web
docker service rm web

# Stack management
docker stack deploy -c docker-compose.yml my-stack
docker stack ls
docker stack services my-stack
docker stack ps my-stack
docker stack rm my-stack

# Troubleshooting
# -------------

# Debug container issues
docker logs container_id_or_name     # View logs
docker inspect container_id_or_name  # Inspect container details
docker stats container_id_or_name    # View resource usage
docker top container_id_or_name      # View processes

# Debug network issues
docker network inspect bridge        # Inspect default network
docker run --net=host nginx          # Run with host networking

# Debug volume issues
docker inspect -f '{{.Mounts}}' container_id_or_name  # View mounts

# Restart Docker daemon
sudo systemctl restart docker

# Clean up system
docker system prune -a --volumes     # Remove everything not in use

# Get container IP address
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_id_or_name

# Docker API & SDK
# -------------

# Get Docker info via API
curl --unix-socket /var/run/docker.sock http://localhost/info

# List containers via API
curl --unix-socket /var/run/docker.sock http://localhost/containers/json

# Special Docker Features
# --------------------

# Docker experimental features
export DOCKER_CLI_EXPERIMENTAL=enabled

# Docker checkpoint (if supported)
docker checkpoint create container_id_or_name checkpoint-name
docker checkpoint ls container_id_or_name
docker checkpoint rm container_id_or_name checkpoint-name

# Docker storage drivers
# Check current storage driver
docker info | grep "Storage Driver"

# Sample Dockerfile
# ---------------
# FROM ubuntu:20.04
# LABEL maintainer="user@example.com"
# 
# ARG DEBIAN_FRONTEND=noninteractive
# ENV APP_HOME=/app
# 
# RUN apt-get update && apt-get install -y \
#     nginx \
#     curl \
#     && rm -rf /var/lib/apt/lists/*
# 
# WORKDIR $APP_HOME
# 
# COPY . .
# 
# EXPOSE 80
# 
# HEALTHCHECK --interval=30s --timeout=3s \
#   CMD curl -f http://localhost/ || exit 1
# 
# CMD ["nginx", "-g", "daemon off;"]

# Sample docker-compose.yml
# ----------------------
# version: '3'
# services:
#   web:
#     image: nginx
#     ports:
#       - "80:80"
#     volumes:
#       - ./html:/usr/share/nginx/html
#     depends_on:
#       - db
#   db:
#     image: postgres
#     environment:
#       POSTGRES_PASSWORD: example
#     volumes:
#       - db-data:/var/lib/postgresql/data
# 
# volumes:
#   db-data: