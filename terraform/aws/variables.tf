variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "vpc_id" {
  description = "VPC ID for ECS"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "image" {
  description = "Docker image for the app"
  type        = string
  default     = "docker.io/khaledgx96/node-hello:latest"
}

variable "new_relic_license_key" {
  description = "New Relic license (insert) key for APM & infra agent"
  type        = string
}
