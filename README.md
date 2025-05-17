---

# Node-Hello DevOps Assignment

This repository demonstrates a CI/CD pipeline setup for a Node.js "Hello World" application.

## Project Overview

* Forked from a provided Node.js "Hello World" repository.
* Containerized using Docker.
* CI/CD pipeline implemented using GitHub Actions.
* Deployment using Terraform (Docker or AWS EKS).

## Prerequisites

* GitHub Account
* Docker & Docker Hub account
* Terraform
* Kubernetes (Kind) or AWS account (Free Tier)

## Project Structure

```sh
.
├── .github/workflows       # GitHub Actions CI/CD workflows
├── terraform               # Terraform Infrastructure as Code files
│   ├── aws                 # AWS EKS deployment Terraform configs
│   └── k8s                 # Local Kubernetes deployment Terraform configs
├── Dockerfile              # Dockerfile for Node.js application
├── index.js                # Application entry point
├── package.json            # Application dependencies
```

## CI/CD Pipeline

* **Linting:** ESLint configured to ensure code quality.
* **Docker Build:** Builds Docker image from the Dockerfile.
* **Docker Push:** Pushes Docker image to Docker Hub or GitHub Container Registry.

### Workflow Setup (GitHub Actions)

Ensure you have set GitHub secrets for:

* `DOCKERHUB_USERNAME`
* `DOCKERHUB_TOKEN`

These are required to push the Docker image to Docker Hub.

## Docker Usage

### Build and Run Locally

```sh
docker build -t node-hello .
docker run -p 8080:8080 node-hello
```

### Push to Docker Hub

```sh
docker login
docker tag node-hello YOUR_DOCKERHUB_USERNAME/node-hello:latest
docker push YOUR_DOCKERHUB_USERNAME/node-hello:latest
```

## Terraform Deployment

### Option 1: Local Kubernetes Deployment (Kind)

Navigate to local Kubernetes Terraform configuration:

```sh
cd terraform/k8s
terraform init
terraform apply
```

### Option 2: AWS EKS Deployment (Free Tier)

Navigate to AWS Terraform configuration:

```sh
cd terraform/aws
terraform init
terraform apply
```

Ensure AWS credentials (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`) are configured via the AWS CLI or environment variables.

## Assumptions & Notes

* Assumes familiarity with Docker, Terraform, and basic CI/CD concepts.
* Terraform configurations provided assume default setups.
* Docker Hub used as the primary registry, replace if using other providers.
* Local Kubernetes (Kind) or AWS Free Tier recommended for free resource utilization.
* Monitoring and logging setup (e.g., New Relic) went throught it but didnot work .

---
