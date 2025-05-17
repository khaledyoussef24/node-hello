output "container_id" {
  value = docker_container.app.id
}

output "local_url" {
  value = "http://localhost:${var.host_port}"
}
