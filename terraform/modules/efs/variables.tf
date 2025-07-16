variable "private_subnets" {
  description = "IDs of the private subnets"
}

variable "iam_efs_jenkins_policy" {
  description = "Jenkins efs policy document"
}

variable "jenkins_efs_sg" {
  description = "Jenkins efs security group"
}
