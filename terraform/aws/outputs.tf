output "cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.hello.name
}

output "service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.hello.name
}
