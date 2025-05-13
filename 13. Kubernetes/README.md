# Kubernetes

## Overview
Kubernetes (K8s) is an open-source platform designed to automate deploying, scaling, and operating application containers. Originally developed by Google and now maintained by the Cloud Native Computing Foundation (CNCF), Kubernetes provides a framework to run distributed systems resiliently, allowing for scaling and failover of applications.

## Key Features
- **Container Orchestration**: Automates the deployment and scaling of containerized applications
- **Service Discovery and Load Balancing**: Exposes containers using DNS or IP addresses
- **Storage Orchestration**: Automatically mounts storage systems of your choice
- **Automated Rollouts and Rollbacks**: Changes to application configuration are rolled out progressively
- **Self-Healing**: Restarts containers that fail, replaces and reschedules containers when nodes die
- **Secret and Configuration Management**: Deploy and update secrets and application configuration without rebuilding container images
- **Horizontal Scaling**: Scale applications up and down with a simple command or automatically based on CPU usage
- **Batch Execution**: Manages batch and CI workloads, replacing containers that fail

## Core Components
- **Control Plane Components**:
  - kube-apiserver: The API server is the front end for the Kubernetes control plane
  - etcd: Consistent and highly-available key value store for all cluster data
  - kube-scheduler: Watches for newly created Pods with no assigned node, and selects a node for them to run on
  - kube-controller-manager: Runs controller processes
  - cloud-controller-manager: Links your cluster into your cloud provider's API

- **Node Components**:
  - kubelet: An agent that runs on each node in the cluster
  - kube-proxy: Maintains network rules on nodes
  - Container Runtime: Software responsible for running containers (Docker, containerd, etc.)

## Getting Started
1. **Prerequisites**:
   - Container runtime installed
   - kubectl command-line tool
   - kubeadm tool for cluster setup

2. **Installation Methods**:
   - kubeadm: Create production-ready clusters
   - Minikube: Local Kubernetes for testing and development
   - kind (Kubernetes IN Docker): Run Kubernetes clusters using Docker containers as nodes
   - k3s: Lightweight Kubernetes for edge, IoT, CI, development

3. **Basic Setup**:
   - Setup master node
   - Join worker nodes
   - Configure networking
   - Deploy applications

## Kubernetes Objects
- **Pods**: The smallest deployable units that can be created and managed
- **Services**: An abstract way to expose an application running on a set of Pods
- **Deployments**: Provides declarative updates for Pods and ReplicaSets
- **StatefulSets**: Manages the deployment and scaling of a set of Pods with unique identities
- **DaemonSets**: Ensures that all or some nodes run a copy of a Pod
- **Jobs**: Creates one or more Pods and ensures that a specified number successfully terminate
- **ConfigMaps and Secrets**: Decouple configuration from image content
- **Namespaces**: Virtual clusters backed by the same physical cluster

## Best Practices
- Use namespaces to organize resources
- Implement resource requests and limits
- Use liveness and readiness probes
- Practice Kubernetes security principles
- Employ proper logging and monitoring
- Use Helm for package management
- Implement GitOps workflow

## Resources
- [Official Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Kubernetes GitHub Repository](https://github.com/kubernetes/kubernetes)
- [Kubernetes Community](https://kubernetes.io/community/)
- [CNCF Landscape](https://landscape.cncf.io/)