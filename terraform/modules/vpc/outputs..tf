output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main_vpc.id
}

output "vpc_cidr" {
  description = "CIDR Block of the AWS VPC"
  value       = aws_vpc.main_vpc.cidr_block
}

output "public_subnets" {
  description = "IDs of the public subnets"
  value       = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "private_subnets" {
  description = "IDs of the private subnets"
  value       = [for subnet in aws_subnet.private_subnets : subnet.id]
}

output "public_lb_sg" {
  description = "Public Load Balancer security group"
  value = aws_security_group.public_lb_sg.id
}

output "jenkins_efs_sg" {
  description = "Jenkins efs security group"
  value       = aws_security_group.sg_efs_jenkins.id
}

output "jenkins_service_sg" {
  description = "ECS Jenkins service security group"
  value = aws_security_group.sg_ecs_service
}

output "bastion_sg" {
  description = "Bastion Host Security Group"
  value       = aws_security_group.sg_bastion.id
}