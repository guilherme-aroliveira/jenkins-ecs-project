#### Security Groups ####

# Create the load balancer security group
resource "aws_security_group" "public_lb_sg" {
  name        = "public-lb-sg"
  description = "Security Group for LB to traffic for ECS Cluster"
  vpc_id      = aws_vpc.main_vpc.id

  tags = merge(
    local.tags,
    {
      Name = "public-lb-sg"
    }
  )
}

resource "aws_vpc_security_group_egress_rule" "ecs_lb_sg_egress" {
  security_group_id = aws_security_group.public_lb_sg.id

  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 8080
  to_port     = 8080

  tags = merge(
    local.tags,
    {
      Name = "ecs-public-lb-sg"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "ecs_lb_sg_ingress" {
  security_group_id = aws_security_group.public_lb_sg.id

  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80


  tags = merge(
    local.tags,
    {
      Name = "ecs-public-lb-sg"
    }
  )
}
