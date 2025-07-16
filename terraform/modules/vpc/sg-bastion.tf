## Create security group for the bastion host
resource "aws_security_group" "sg_bastion" {
  name        = "bastion-host-sg"
  description = "Security Group for the bastion host instance"
  vpc_id      = aws_vpc.main_vpc.id

  tags = merge(
    local.tags,
    {
      Name = "bastion-sg"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "sg_ssh_ingress_rule" {
  security_group_id = aws_security_group.sg_bastion.id
  description       = "Allow SSH connection to all"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"

  tags = merge(
    local.tags,
    {
      Name = "ingress-rule-ssh"
    }
  )
}

resource "aws_vpc_security_group_egress_rule" "sg_ssh_egress_rule" {
  security_group_id = aws_security_group.sg_bastion.id
  description       = "Allow all traffic"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = merge(
    local.tags,
    {
      Name = "egress-rule-all"
    }
  )
}