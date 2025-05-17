# Node-Hello DevOps Hiring Assignment

This repository demonstrates a DevOps CI/CD pipeline setup for a simple Node.js "Hello World" application, including Docker containerization, GitHub Actions workflows, and deployment via Terraform.

## Overview

- Simple Node.js application serving HTTP on port `3000`
- Docker containerization
- GitHub Actions CI/CD pipeline
- Deployment using Terraform (Local Kubernetes with Kind, AWS EKS)

---

## Prerequisites

Ensure you have the following installed:

- Git & GitHub account
- Node.js & npm
- Docker & Docker Hub account
- Terraform (v1.0+)
- Kubernetes CLI (`kubectl`)
- Kind (for local Kubernetes) or AWS CLI (for AWS EKS)

---

## Project Structure

```sh
.
├── .github/workflows       # GitHub Actions CI/CD workflows
├── terraform               # Terraform configuration files
│   ├── aws                 # AWS EKS deployment configs
│   └── k8s                 # Local Kubernetes (Kind) deployment configs
├── Dockerfile              # Dockerfile for the Node.js application
├── index.js                # Application entry point
└── package.json            # Dependencies & scripts
```

---

## CI/CD Pipeline (GitHub Actions)

Automated workflow (`.github/workflows/ci.yml`) covers:

- **Linting:** Ensures code quality (`npm ci && npm run lint`)
- **Building:** Docker image creation
- **Pushing:** Docker image upload to Docker Hub

**Required GitHub Secrets:**

- `DOCKERHUB_USERNAME`
- `DOCKERHUB_TOKEN`

---

## Docker Setup

### Run Locally

```bash
git clone https://github.com/khaledyoussef24/node-hello.git
cd node-hello

# Build Docker image
docker build -t node-hello:local .

# Run Docker container
docker run --rm -p 3000:3000 node-hello:local

# Test by visiting: http://localhost:3000
```

### Push to Docker Hub

```bash
docker login

docker tag node-hello:local khaledgx96/node-hello:latest
docker push khaledgx96/node-hello:latest
```

---

## Terraform Deployment

### Option 1: Local Kubernetes with Kind

Navigate to Terraform local Kubernetes configuration:

```bash
cd terraform/k8s
terraform init
terraform apply
```

This automatically:

- Creates a local Kubernetes cluster (`kind`)
- Deploys the application container into the cluster

Verify deployment:

```bash
kubectl get pods,svc
```

### Option 2: AWS EKS Deployment

Navigate to Terraform AWS configuration:

```bash
cd terraform/aws
terraform init
terraform apply
```

This automatically:

- Sets up AWS infrastructure (EKS, VPC, Node Groups)
- Deploys application container to the EKS cluster

Configure `kubectl`:

```bash
aws eks update-kubeconfig --region <AWS_REGION> --name <CLUSTER_NAME>

kubectl get deployments,svc
```

---

## Assumptions

- Docker Hub as container registry
- Default Kubernetes namespace (`default`)
- AWS region (`us-west-2`) unless otherwise configured

---
