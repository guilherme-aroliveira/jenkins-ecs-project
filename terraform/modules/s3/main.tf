# Create the S3 buckets for general S3 buckets for Waycarbon
resource "aws_s3_bucket" "s3_buckets" {
  for_each = toset(var.s3_buckets)

  bucket = each.key # The environment must be defined on the root module!!

  tags = merge(
    local.tags,
    {
      Name = "${each.key}-s3"
    }
  )
}

# Create versioning
resource "aws_s3_bucket_versioning" "s3_buckets_versioning" {
  for_each = aws_s3_bucket.s3_buckets

  bucket = aws_s3_bucket.s3_buckets[each.key].id

  versioning_configuration {
    status = "Enabled"
  }
}

# Define the access levels
resource "aws_s3_bucket_public_access_block" "s3_dev_buckets_access" {
  for_each = aws_s3_bucket.s3_buckets

  bucket = aws_s3_bucket.s3_buckets[each.key].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

## Define the bucket ownership
resource "aws_s3_bucket_ownership_controls" "s3_buckets_ownership" {
  for_each = aws_s3_bucket.s3_buckets

  bucket = aws_s3_bucket.s3_buckets[each.key].id

  rule {
    object_ownership = "ObjectWriter"
  }
}

## Create the S3 Bucket for bashtion-host ".pem"
resource "aws_s3_object" "s3_bastion_key" {
  bucket  = aws_s3_bucket.s3_buckets["ec2-ssh-keys"].id
  key     = "bastion-key.pem"
  content = var.ec2_rsa_key

  tags = merge(
    local.tags,
    {
      Name = "bastion-key"
    }
  )
}
