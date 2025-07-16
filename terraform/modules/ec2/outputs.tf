output "ec2_rsa_key" {
  description = "The private key (.pem file) for ec2 instances"
  value       = tls_private_key.rsa_key.private_key_pem
}
