resource "aws_security_group" "sg_efs_jenkins" {
  name   = "efs-jenkins-sg"
  vpc_id = aws_vpc.main_vpc.id

  tags = merge(
    local.tags,
    {
      Name = "efs-jenkins-sg"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "sg_ecs_jenkins_ingress" {
  security_group_id            = aws_security_group.sg_efs_jenkins.id
  referenced_security_group_id = aws_security_group.sg_ecs_service.id
  from_port                    = 2049
  to_port                      = 2049
  ip_protocol                  = "tcp"
}
