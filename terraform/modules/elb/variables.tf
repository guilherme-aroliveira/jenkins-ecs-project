variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "vpc_cidr" {
  description = "The VPC cidr block"
}

variable "public_subnets" {
  description = "Public subnet IDs"
}

### Values from outputs ###
variable "public_lb_sg" {
  description = "Public Load Balancer security group"
}