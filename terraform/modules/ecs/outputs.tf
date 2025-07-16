output "ecs_cluster_jenkins" {
  description = "ECS Jenkins cluster resource"
  value = aws_ecs_cluster.ecs_cluster_jenkins
}

output "ecs_service_jenkins" {
  description = "ECS Jenkins service resource"
  value = aws_ecs_service.ecs_service_jenkins
}

