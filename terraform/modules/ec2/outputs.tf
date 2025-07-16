output "public_lb" {
  description = "Public Load Balancer"
  value       = aws_lb.public_lb
}

output "jenkins_tg" {
  description = "Jenkins target group"
  value       = aws_lb_target_group.lb_tg_jenkins.arn
}

output "jenkins_efs_sg" {
  description = "Jenkins efs security group"
  value       = aws_security_group.sg_efs_jenkins.id
}

output "jenkins_service_sg" {
  description = "ECS Jenkins service security group"
  value = aws_security_group.sg_ecs_service
}
