resource "aws_eip" "eip_bastion_host" {
  instance = aws_instance.bastion_host.id
  domain   = "vpc"

  tags = merge(
    local.tags,
    {
      Name = "eip-bastion-host"
    }
  )
}

resource "aws_eip_association" "eip_bastion_assoc" {
  instance_id   = aws_instance.bastion_host.id
  allocation_id = aws_eip.eip_bastion_host.id
}