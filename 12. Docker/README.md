# Docker Setup Guide

A comprehensive guide for containerizing applications with Docker, covering development workflows, production deployments, and best practices.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Basic Docker Commands](#basic-docker-commands)
- [Creating Dockerfiles](#creating-dockerfiles)
- [Docker Compose](#docker-compose)
- [Multi-Stage Builds](#multi-stage-builds)
- [Environment Configuration](#environment-configuration)
- [Networking](#networking)
- [Volumes and Data Persistence](#volumes-and-data-persistence)
- [Production Deployment](#production-deployment)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)

## Introduction

Docker is a containerization platform that allows you to package applications and their dependencies into lightweight, portable containers. This guide covers everything from basic setup to advanced production deployments.

## Prerequisites

- Operating System: Windows 10+, macOS 10.14+, or Linux
- Minimum 4GB RAM (8GB recommended)
- 64-bit processor with virtualization support
- Basic command line knowledge

## Installation

### Windows
```bash
# Download Docker Desktop from docker.com
# Or use Chocolatey
choco install docker-desktop

# Or use winget
winget install Docker.DockerDesktop
```

### macOS
```bash
# Download Docker Desktop from docker.com
# Or use Homebrew
brew install --cask docker

# Or use MacPorts
sudo port install docker-desktop
```

### Linux (Ubuntu/Debian)
```bash
# Update package index
sudo apt-get update

# Install prerequisites
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Add user to docker group
sudo usermod -aG docker $USER
```

### Verify Installation
```bash
docker --version
docker-compose --version
docker run hello-world
```

## Basic Docker Commands

### Container Management
```bash
# List running containers
docker ps

# List all containers
docker ps -a

# Start a container
docker start container_name

# Stop a container
docker stop container_name

# Remove a container
docker rm container_name

# Remove all stopped containers
docker container prune

# View container logs
docker logs container_name

# Execute command in running container
docker exec -it container_name bash
```

### Image Management
```bash
# List images
docker images

# Pull an image
docker pull nginx:latest

# Build an image
docker build -t myapp:latest .

# Remove an image
docker rmi image_name

# Remove unused images
docker image prune

# Tag an image
docker tag myapp:latest myapp:v1.0

# Push to registry
docker push myapp:latest
```

### Running Containers
```bash
# Run a container
docker run nginx

# Run in detached mode
docker run -d nginx

# Run with port mapping
docker run -p 8080:80 nginx

# Run with environment variables
docker run -e NODE_ENV=production myapp

# Run with volume mounting
docker run -v /host/path:/container/path nginx

# Run interactively
docker run -it ubuntu bash

# Run with restart policy
docker run --restart=always nginx

# Run with memory limit
docker run -m 512m nginx
```

## Creating Dockerfiles

### Basic Dockerfile Structure
```dockerfile
# Use official base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Create non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001
USER nextjs

# Define startup command
CMD ["npm", "start"]
```

### Node.js Application Example
```dockerfile
FROM node:18-alpine AS base

# Install dependencies only when needed
FROM base AS deps
RUN apk add --no-cache libc6-compat
WORKDIR /app

COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./
RUN \
  if [ -f yarn.lock ]; then yarn --frozen-lockfile; \
  elif [ -f package-lock.json ]; then npm ci; \
  elif [ -f pnpm-lock.yaml ]; then yarn global add pnpm && pnpm i --frozen-lockfile; \
  else echo "Lockfile not found." && exit 1; \
  fi

# Rebuild the source code only when needed
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN yarn build

# Production image, copy all the files and run next
FROM base AS runner
WORKDIR /app

ENV NODE_ENV production

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

USER nextjs

EXPOSE 3000

ENV PORT 3000

CMD ["npm", "start"]
```

### Python Application Example
```dockerfile
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /app

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . /app/

# Create non-root user
RUN adduser --disabled-password --gecos '' appuser
RUN chown -R appuser:appuser /app
USER appuser

# Run the application
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myproject.wsgi:application"]
```

## Docker Compose

### Basic docker-compose.yml
```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
    volumes:
      - .:/app
      - /app/node_modules
    depends_on:
      - db

  db:
    image: postgres:15
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

volumes:
  postgres_data:
```

### Full-Stack Application Example
```yaml
version: '3.8'

services:
  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile
    ports:
      - "3000:3000"
    environment:
      - REACT_APP_API_URL=http://localhost:8000
    volumes:
      - ./frontend:/app
      - /app/node_modules
    depends_on:
      - backend

  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile
    ports:
      - "8000:8000"
    environment:
      - DATABASE_URL=postgresql://user:password@db:5432/myapp
      - REDIS_URL=redis://redis:6379
    volumes:
      - ./backend:/app
    depends_on:
      - db
      - redis

  db:
    image: postgres:15
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - frontend
      - backend

volumes:
  postgres_data:

networks:
  default:
    driver: bridge
```

### Docker Compose Commands
```bash
# Start services
docker-compose up

# Start in background
docker-compose up -d

# Build and start
docker-compose up --build

# Stop services
docker-compose down

# Remove volumes
docker-compose down -v

# View logs
docker-compose logs -f

# Scale services
docker-compose up --scale web=3

# Execute commands
docker-compose exec web bash

# Restart services
docker-compose restart
```

## Multi-Stage Builds

### Optimized Build Example
```dockerfile
# Build stage
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force
COPY . .
RUN npm run build

# Production stage  
FROM nginx:alpine AS production
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### Go Application Multi-Stage
```dockerfile
# Build stage
FROM golang:1.19-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Production stage
FROM alpine:latest AS production
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /app/main .
CMD ["./main"]
```

## Environment Configuration

### .env File
```bash
# Database
DB_HOST=localhost
DB_PORT=5432
DB_NAME=myapp
DB_USER=user
DB_PASSWORD=password

# Redis
REDIS_URL=redis://localhost:6379

# Application
NODE_ENV=development
PORT=3000
JWT_SECRET=your-secret-key
API_URL=http://localhost:8000
```

### Environment-Specific Compose Files
```yaml
# docker-compose.override.yml (development)
version: '3.8'
services:
  web:
    volumes:
      - .:/app
      - /app/node_modules
    environment:
      - NODE_ENV=development
      - DEBUG=true
```

```yaml
# docker-compose.prod.yml (production)
version: '3.8'
services:
  web:
    restart: always
    environment:
      - NODE_ENV=production
    deploy:
      replicas: 3
      resources:
        limits:
          memory: 512M
        reservations:
          memory: 256M
```

## Networking

### Custom Networks
```yaml
version: '3.8'

services:
  web:
    networks:
      - frontend
      - backend
  
  db:
    networks:
      - backend

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
    internal: true
```

### Network Commands
```bash
# List networks
docker network ls

# Create network
docker network create mynetwork

# Connect container to network
docker network connect mynetwork container_name

# Disconnect container from network
docker network disconnect mynetwork container_name

# Inspect network
docker network inspect mynetwork
```

## Volumes and Data Persistence

### Volume Types
```yaml
version: '3.8'

services:
  db:
    image: postgres:15
    volumes:
      # Named volume
      - postgres_data:/var/lib/postgresql/data
      # Bind mount
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql
      # Anonymous volume
      - /var/lib/postgresql/temp

volumes:
  postgres_data:
    driver: local
```

### Volume Commands
```bash
# List volumes
docker volume ls

# Create volume
docker volume create myvolume

# Inspect volume
docker volume inspect myvolume

# Remove volume
docker volume rm myvolume

# Remove unused volumes
docker volume prune
```

## Production Deployment

### Health Checks
```dockerfile
FROM nginx:alpine

# Add health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

COPY index.html /usr/share/nginx/html/
```

### Production Compose with Monitoring
```yaml
version: '3.8'

services:
  app:
    build: .
    restart: always
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    depends_on:
      - db
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
    deploy:
      resources:
        limits:
          memory: 512M
        reservations:
          memory: 256M

  db:
    image: postgres:15
    restart: always
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: ${DB_USER}
      POSTGRES_PASSWORD: ${DB_PASSWORD}
    volumes:
      - postgres_data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${DB_USER}"]
      interval: 10s
      timeout: 5s
      retries: 5

  nginx:
    image: nginx:alpine
    restart: always
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./ssl:/etc/nginx/ssl
    depends_on:
      - app

volumes:
  postgres_data:
```

## Best Practices

### Dockerfile Best Practices
- Use official base images
- Use specific tags, not `latest`
- Minimize layers by combining RUN commands
- Use multi-stage builds for smaller images
- Don't install unnecessary packages
- Use .dockerignore to exclude files
- Run as non-root user
- Use COPY instead of ADD when possible
- Set appropriate WORKDIR
- Use health checks

### Security Best Practices
- Scan images for vulnerabilities
- Use secrets management
- Don't hardcode credentials
- Keep base images updated
- Use read-only root filesystem when possible
- Limit container resources
- Use network segmentation

### Performance Best Practices
- Use appropriate base images (alpine for smaller size)
- Leverage build cache
- Use multi-stage builds
- Optimize layer caching
- Use .dockerignore effectively
- Monitor resource usage

## Troubleshooting

### Common Issues

**Container Won't Start:**
```bash
# Check logs
docker logs container_name

# Check if port is already in use
netstat -tulpn | grep :3000

# Check container resources
docker stats container_name
```

**Permission Denied:**
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Restart docker service
sudo systemctl restart docker
```

**Out of Space:**
```bash
# Clean up unused resources
docker system prune -a

# Remove unused volumes
docker volume prune

# Remove unused networks
docker network prune
```

**Build Failures:**
```bash
# Build with no cache
docker build --no-cache -t myapp .

# Check Dockerfile syntax
docker build --dry-run -t myapp .

# Build with verbose output
docker build --progress=plain -t myapp .
```

### Debugging Commands
```bash
# Enter running container
docker exec -it container_name bash

# Check container processes
docker top container_name

# Monitor resource usage
docker stats

# Inspect container details
docker inspect container_name

# Check container filesystem changes
docker diff container_name
```

## Useful Resources

- [Docker Official Documentation](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Dockerfile Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Docker Security](https://docs.docker.com/engine/security/)

## Contributing

When contributing to Docker configurations:

1. Test thoroughly in different environments
2. Document all configuration changes
3. Follow security best practices
4. Use consistent naming conventions
5. Include appropriate health checks
6. Optimize for production use

---

This guide provides a comprehensive foundation for working with Docker. Customize the configurations based on your specific application requirements and deployment needs.