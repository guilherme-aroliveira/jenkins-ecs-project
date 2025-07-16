output "fargate_role" {
  description = "The fargate service iam role"
  value       = aws_iam_role.iam_fargate_role.arn
}

output "iam_efs_jenkins_policy" {
  description = "Jenkins efs policy document"
  value       = data.aws_iam_policy_document.iam_efs_jenkins_policy
}

output "ecs_execution_role" {
  description = "ECS iam execution role"
  value = aws_iam_role.ecs_execution_role.arn
}

output "ecs_task_role" {
  description = "ECS iam task role"
  value = aws_iam_role.ecs_task_role.arn
}