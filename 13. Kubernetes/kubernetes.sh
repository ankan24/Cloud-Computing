#!/bin/bash
# Kubernetes Commands Reference

# Prerequisites Installation
# -------------------------

# Install Docker
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker

# Install kubelet, kubeadm, kubectl
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Cluster Setup
# ------------

# Initialize control plane node (master)
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# Set up kubectl for the current user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install a pod network add-on (Calico example)
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

# Generate join command for worker nodes
kubeadm token create --print-join-command

# Join a worker node to the cluster (run on worker node)
# sudo kubeadm join <control-plane-host>:<control-plane-port> --token <token> --discovery-token-ca-cert-hash sha256:<hash>

# Verify cluster status
kubectl get nodes
kubectl cluster-info

# Cluster Management
# -----------------

# Basic kubectl commands
kubectl get nodes                     # List all nodes
kubectl get pods                      # List all pods in current namespace
kubectl get pods -A                   # List all pods in all namespaces
kubectl get pods -o wide              # List all pods with more details
kubectl get services                  # List all services
kubectl get deployments               # List all deployments
kubectl get namespaces                # List all namespaces
kubectl get all                       # List all resources in current namespace
kubectl get all -n <namespace>        # List all resources in specific namespace

# Namespaces
kubectl create namespace <name>       # Create a namespace
kubectl config set-context --current --namespace=<name>  # Set default namespace

# Describe resources
kubectl describe node <node-name>     # Show detailed info about a node
kubectl describe pod <pod-name>       # Show detailed info about a pod
kubectl describe service <svc-name>   # Show detailed info about a service

# Logs and debugging
kubectl logs <pod-name>               # Get logs from a pod
kubectl logs <pod-name> -c <container-name>  # Get logs from specific container in a pod
kubectl logs -f <pod-name>            # Stream logs from a pod
kubectl exec -it <pod-name> -- /bin/bash  # Get shell into a pod
kubectl port-forward <pod-name> 8080:80   # Forward local port to pod port

# Resource Management
# ------------------

# Create resources declaratively
kubectl apply -f <file-or-directory>  # Create or update resources from file or directory
kubectl delete -f <file-or-directory> # Delete resources from file or directory

# Create resources imperatively
kubectl create deployment <name> --image=<image>  # Create a deployment
kubectl expose deployment <name> --port=<port> --type=NodePort  # Expose a deployment as a service
kubectl scale deployment <name> --replicas=<count>  # Scale a deployment

# Deployments Management
# ---------------------

# Rollout commands
kubectl rollout status deployment/<name>  # Check rollout status
kubectl rollout history deployment/<name> # View rollout history
kubectl rollout undo deployment/<name>    # Rollback to previous version
kubectl rollout restart deployment/<name> # Restart a deployment

# Configurations
# -------------

# ConfigMaps
kubectl create configmap <name> --from-file=<path>  # Create ConfigMap from file
kubectl create configmap <name> --from-literal=key1=value1 --from-literal=key2=value2  # Create ConfigMap from literals

# Secrets
kubectl create secret generic <name> --from-file=<path>  # Create Secret from file
kubectl create secret generic <name> --from-literal=key1=value1  # Create Secret from literals
kubectl create secret tls <name> --cert=<cert-file> --key=<key-file>  # Create TLS Secret

# Resource Quotas and Limits
kubectl create quota <name> --hard=cpu=1,memory=1G,pods=10  # Create ResourceQuota

# RBAC
kubectl create role <name> --verb=get,list,watch --resource=pods  # Create Role
kubectl create rolebinding <name> --role=<role-name> --user=<user>  # Create RoleBinding
kubectl create clusterrole <name> --verb=get,list,watch --resource=pods  # Create ClusterRole
kubectl create clusterrolebinding <name> --clusterrole=<role-name> --user=<user>  # Create ClusterRoleBinding

# Storage
# -------

# PersistentVolumes and PersistentVolumeClaims
kubectl get pv                        # List PersistentVolumes
kubectl get pvc                       # List PersistentVolumeClaims
kubectl describe pv <pv-name>         # Describe PersistentVolume
kubectl describe pvc <pvc-name>       # Describe PersistentVolumeClaim

# StorageClasses
kubectl get storageclass              # List StorageClasses
kubectl describe storageclass <name>  # Describe StorageClass

# Advanced Operations
# -----------------

# Taints and Tolerations
kubectl taint nodes <node-name> key=value:NoSchedule  # Add taint to node
kubectl taint nodes <node-name> key:NoSchedule-       # Remove taint from node

# Node Maintenance
kubectl cordon <node-name>            # Mark node as unschedulable
kubectl drain <node-name> --ignore-daemonsets  # Drain node for maintenance
kubectl uncordon <node-name>          # Mark node as schedulable

# Labels and Selectors
kubectl label nodes <node-name> gpu=true  # Add label to node
kubectl label pods <pod-name> environment=prod  # Add label to pod
kubectl get pods -l environment=prod  # Get pods with specific label

# Cluster Administration
# --------------------

# Upgrade kubeadm cluster
sudo apt-mark unhold kubeadm && sudo apt-get update && sudo apt-get install -y kubeadm && sudo apt-mark hold kubeadm
sudo kubeadm upgrade plan
sudo kubeadm upgrade apply v1.xx.x    # Replace with target version
sudo apt-mark unhold kubelet kubectl && sudo apt-get update && sudo apt-get install -y kubelet kubectl && sudo apt-mark hold kubelet kubectl
sudo systemctl daemon-reload
sudo systemctl restart kubelet

# Backup etcd
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  snapshot save /backup/etcd-snapshot.db

# Restore etcd
ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  snapshot restore /backup/etcd-snapshot.db

# Metrics and Monitoring
# --------------------

# Install Metrics Server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# View metrics
kubectl top nodes                     # Show node resource usage
kubectl top pods                      # Show pod resource usage
kubectl top pods -n <namespace>       # Show pod resource usage in specific namespace

# Common Addons Installation
# ------------------------

# Dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml

# Create admin user for Dashboard
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
EOF

# Get Dashboard token
kubectl -n kubernetes-dashboard create token admin-user

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install Prometheus using Helm
kubectl create namespace monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus --namespace monitoring

# Install Ingress NGINX Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/cloud/deploy.yaml

# Demo Applications
# ---------------

# Deploy NGINX
kubectl create deployment nginx --image=nginx
kubectl expose deployment nginx --port=80 --type=NodePort

# Deploy simple guestbook application
kubectl apply -f https://raw.githubusercontent.com/kubernetes/examples/master/guestbook/all-in-one/guestbook-all-in-one.yaml

# Troubleshooting
# --------------

# Check cluster component status
kubectl get componentstatuses

# Get events
kubectl get events
kubectl get events --sort-by='.metadata.creationTimestamp'

# Check API server health
kubectl get --raw='/healthz?verbose'

# Check pod status
kubectl get pods -o wide

# Check node conditions
kubectl describe nodes | grep Conditions -A 5

# View pod logs in init containers
kubectl logs <pod-name> -c <init-container-name>

# Check pod networking
kubectl exec <pod-name> -- ping <ip-address>
kubectl exec <pod-name> -- curl -v <service-name>

# Check DNS resolution
kubectl exec <pod-name> -- nslookup kubernetes.default

# Clean up
# -------

# Delete resources
kubectl delete all --all              # Delete all resources in current namespace (not recommended for production)
kubectl delete all --all -n <namespace>  # Delete all resources in specific namespace
kubectl delete namespace <namespace>  # Delete namespace and all its resources

# Reset a node (run on node to remove from cluster)
sudo kubeadm reset