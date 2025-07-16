output "ecs_jenkins_logs" {
  description = "Jenkins ECS cloudwatch log group"
  value       = aws_cloudwatch_log_group.ecs_jenkins_log_group.name
}
