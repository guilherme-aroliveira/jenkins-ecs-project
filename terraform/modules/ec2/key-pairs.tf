## Genrates a private key
resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

## Create a key pair for the bastion-host 
resource "aws_key_pair" "rsa_key_bastion" {
  key_name   = "bastion-host-key"
  public_key = tls_private_key.rsa_key.public_key_openssh

  tags = merge(
    local.tags,
    {
      Name = "bastion-host-key"
    }
  )
}