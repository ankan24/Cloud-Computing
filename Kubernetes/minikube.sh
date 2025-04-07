#!/bin/bash
# Minikube Commands Reference
# A comprehensive list of commands for working with Minikube

# Installation
# -----------

# Install Minikube on Linux
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Install Minikube on macOS
brew install minikube
# OR
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
sudo install minikube-darwin-amd64 /usr/local/bin/minikube

# Install Minikube on Windows (using PowerShell)
# New-Item -Path 'c:\' -Name 'minikube' -ItemType Directory -Force
# Invoke-WebRequest -OutFile 'c:\minikube\minikube.exe' -Uri 'https://github.com/kubernetes/minikube/releases/latest/download/minikube-windows-amd64.exe'
# Add-MemberPath -Path 'c:\minikube'

# Check installation
minikube version

# Basic Operations
# --------------

# Start Minikube
minikube start

# Start with specific Kubernetes version
minikube start --kubernetes-version=v1.24.0

# Start with specific driver
minikube start --driver=docker
minikube start --driver=virtualbox
minikube start --driver=hyperv
minikube start --driver=kvm2

# Start with specific resources
minikube start --cpus=4 --memory=8192mb --disk-size=30g

# Start with custom configuration
minikube start --extra-config=kubelet.MaxPods=100 --extra-config=scheduler.address=0.0.0.0

# Stop Minikube
minikube stop

# Delete Minikube cluster
minikube delete

# Pause Kubernetes
minikube pause

# Unpause Kubernetes
minikube unpause

# Get status
minikube status

# Cluster Management
# ---------------

# Get cluster information
minikube ip                    # Get cluster IP
minikube node list             # List nodes
minikube node add              # Add a node to the cluster
minikube node delete           # Delete a node from the cluster

# Access Kubernetes Dashboard
minikube dashboard
minikube dashboard --url       # Get dashboard URL without opening browser

# Get Kubernetes service URL
minikube service <service-name> --url

# Open Kubernetes service in browser
minikube service <service-name>

# Add-ons Management
# ---------------

# List all available add-ons
minikube addons list

# Enable specific add-ons
minikube addons enable dashboard
minikube addons enable metrics-server
minikube addons enable ingress
minikube addons enable registry
minikube addons enable metallb
minikube addons enable storage-provisioner
minikube addons enable registry-aliases
minikube addons enable istio
minikube addons enable istio-provisioner
minikube addons enable olm
minikube addons enable csi-hostpath-driver
minikube addons enable volumesnapshots
minikube addons enable default-storageclass
minikube addons enable storage-provisioner-gluster
minikube addons enable logviewer

# Disable add-ons
minikube addons disable <addon-name>

# Get add-on status
minikube addons list

# Configure add-on
minikube addons configure <addon-name>

# Docker Integration
# ---------------

# Use Docker daemon inside Minikube
eval $(minikube docker-env)

# Stop using Docker daemon inside Minikube
eval $(minikube docker-env -u)

# Build image using Minikube's Docker daemon
docker build -t my-image:latest .

# Push image to Minikube
minikube image load my-image:latest

# List images in Minikube
minikube image ls

# Configuration and Customization
# ----------------------------

# Set configuration values
minikube config set cpus 4
minikube config set memory 8192
minikube config set driver docker
minikube config set kubernetes-version latest

# Get current configuration values
minikube config get cpus
minikube config get memory
minikube config get driver

# View all configuration values
minikube config view

# Unset configuration values
minikube config unset cpus

# Set default configuration
minikube config set vm-driver kvm2

# Profiles Management
# ----------------

# List profiles
minikube profile list

# Create and use a profile
minikube start -p <profile-name>

# Switch between profiles
minikube profile <profile-name>

# SSH and Filesystem Access
# ----------------------

# SSH into the Minikube VM
minikube ssh

# Run a command in the Minikube VM
minikube ssh "ls -la /var/lib/kubelet"

# Mount a local directory into Minikube
minikube mount <source-directory>:<target-directory>

# Copy files to Minikube
minikube cp <local-file> <profile-name>:<target-file>

# Copy files from Minikube
minikube cp <profile-name>:<source-file> <local-file>

# Networking
# --------

# Create a tunnel for services
minikube tunnel

# Access service using tunnel
# After starting the tunnel, you can access LoadBalancer services via their external IP

# Configure port forwarding
kubectl port-forward service/<service-name> 8080:80

# Logs and Troubleshooting
# ---------------------

# View logs
minikube logs

# View specific component logs
minikube logs --problems
minikube logs -f                      # Follow logs
minikube logs --node=minikube-m02     # Logs from specific node

# Update Minikube
minikube update-check
minikube update

# Update Kubernetes versions
minikube update-context

# Enable/disable update notifications
minikube config set WantUpdateNotification true
minikube config set WantUpdateNotification false

# Performance and Optimization
# -------------------------

# Cache Kubernetes images
minikube cache add <image-name>

# List cached images
minikube cache list

# Delete from cache
minikube cache delete <image-name>

# Advanced Operations
# ----------------

# Create a multi-node cluster
minikube start --nodes 3 -p multinode-demo

# Enable/disable experimental features
minikube config set EmbedCerts true

# Restart Kubernetes components
minikube kubectl -- -n kube-system rollout restart deployment coredns

# Set environment variables
minikube env
minikube env --shell powershell      # For PowerShell users

# Clean up and reset
# ---------------

# Delete all clusters
minikube delete --all

# Clean up Minikube cached images
minikube cache delete --all

# Reset Minikube to default state
minikube delete --purge

# Clean up local state
rm -rf ~/.minikube

# Working with kubectl
# -----------------

# Use minikube's built-in kubectl
minikube kubectl -- get pods
minikube kubectl -- get nodes
minikube kubectl -- get all --all-namespaces

# Create an alias for easier use
alias kubectl="minikube kubectl --"

# Get cluster-info
minikube kubectl -- cluster-info

# Example Applications
# ----------------

# Deploy a simple application
minikube kubectl -- create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.10
minikube kubectl -- expose deployment hello-minikube --type=NodePort --port=8080

# Check deployment and service
minikube kubectl -- get deployments
minikube kubectl -- get services

# Access the service
minikube service hello-minikube

# Extensions
# --------

# Generate completion script
minikube completion bash > ~/.minikube-completion
echo "source ~/.minikube-completion" >> ~/.bashrc

# Generate zsh completion
minikube completion zsh > "${fpath[1]}/_minikube"

# Minikube version information
minikube version --components