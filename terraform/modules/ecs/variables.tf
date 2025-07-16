## values from outputs
variable "vpc_id" {
  description = "ID of AWS VPC"
}

variable "public_subnets" {
  description = "IDs of the public subnets"
}

variable "private_subnets" {
  description = "IDs of the private subnets"
}

variable "ecs_jenkins_logs" {
  description = "Jenkins ECS cloudwatch log group"
}

variable "efs_jenkins" {
  description = "Jenkins EFS file system"
}

variable "efs_jenkins_access" {
  description = "Jenkins EFS access point"
}

variable "ecr_uri" {
  description = "The ECR repo URI"
}

variable "jenkins_tg" {
  description = "Jenkins target group"
}

variable "ecs_execution_role" {
  description = "ECS iam execution role"
}

variable "ecs_task_role" {
  description = "ECS iam task role"
}