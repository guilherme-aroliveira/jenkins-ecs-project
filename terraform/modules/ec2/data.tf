data "aws_ami" "ami_debian" {
  most_recent = true
  owners      = ["136693071363"] # Debian's official AWS account ID

  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}