variable "s3_buckets" {
  description = "List of s3 buckets"
  type        = list(string)
  default = [
    "ec2-ssh-keys"
  ]
}

variable "ec2_rsa_key" {
  description = "The (.pem file) for ec2 instance"
}
