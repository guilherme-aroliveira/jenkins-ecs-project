## Create an EC2 instance for the bastion host
resource "aws_instance" "bastion_host" {
  ami                    = data.aws_ami.ami_debian.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.rsa_key_bastion.key_name
  vpc_security_group_ids = var.bastion_sg
  subnet_id              = var.public_subnets[0]
  ebs_optimized          = true

  tags = merge(
    local.tags,
    {
      Name = "bastion-host"
    }
  )

  volume_tags = merge(
    local.tags,
    {
      Name = "bastion-ebs"
    }
  )

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 10
    volume_type           = "gp3"
  }

  lifecycle {
    ignore_changes = [ami]
  }
}
