output "public_lb" {
  description = "Public Load Balancer"
  value = aws_lb.public_lb
}

output "jenkins_tg" {
  description = "Jenkins target group"
  value = aws_lb_target_group.lb_tg_jenkins.arn
}