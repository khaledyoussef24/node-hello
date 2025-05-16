variable "region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "image_name" {
  description = "Docker image (e.g., docker.io/USERNAME/node-hello:TAG)"
  type        = string
  default     = "docker.io/USERNAME/node-hello:latest"
}


variable "cpu" {
  description = "Fargate CPU units"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Fargate memory (MB)"
  type        = string
  default     = "512"
}
