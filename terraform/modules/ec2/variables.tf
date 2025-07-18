### Values from outputs ###

variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "vpc_cidr" {
  description = "The VPC cidr block"
}

variable "public_subnets" {
  description = "Public subnet IDs"
}

variable "bastion_sg" {
  description = "Bastion Host Security Group"
}