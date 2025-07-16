### ECS security group for Jenkins controller

resource "aws_security_group" "sg_ecs_service" {
  name   = "ecs-jenkins-controller-sg"
  vpc_id = var.vpc_id

  tags = merge(
    local.tags,
    {
      Name = "ecs-jenkins-controller-sg"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "sg_jenkins_controller_ingress" {
  security_group_id            = aws_security_group.sg_ecs_service.id
  referenced_security_group_id = aws_security_group.public_sg.id
  from_port                    = 8080
  to_port                      = 8080
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "sg_jenkins_controller_egress" {
  security_group_id = aws_security_group.sg_ecs_service.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  to_port           = 65535
  ip_protocol       = "tcp"
}


### ECS security group for Jenkins agents

resource "aws_security_group" "sg_ecs_jenkins_agent" {
  name   = "ecs-jenkins-agents-sg"
  vpc_id = var.vpc_id

  tags = merge(
    local.tags,
    {
      Name = "ecs-jenkins-agents-sg"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "sg_jenkins_agent_ingress" {
  security_group_id            = aws_security_group.sg_ecs_jenkins_agent.id
  referenced_security_group_id = aws_security_group.sg_ecs_service.id
  from_port                    = 50000
  to_port                      = 50000
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "sg_jenkins_agent_egress" {
  security_group_id = aws_security_group.sg_ecs_jenkins_agent.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  to_port           = 65535
  ip_protocol       = "tcp"
}

