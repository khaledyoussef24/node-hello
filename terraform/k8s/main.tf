terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "app_image" {
  name = "${var.image_name}:${var.image_tag}"

  build {
    # from terraform/k8s → ../.. = node-hello/
    context    = "${path.module}/../.."
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "app" {
  name  = var.container_name
  image = docker_image.app_image.name

  ports {
    internal = var.container_port
    external = var.host_port
  }
}
