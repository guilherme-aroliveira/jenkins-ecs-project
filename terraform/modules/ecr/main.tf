resource "aws_ecr_repository" "ecr_repo" {
  name                 = toset(var.image_name)
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    local.tags,
    {
      Name = each.key
    }
  )
}

resource "aws_ecr_lifecycle_policy" "ecr_repo_lifecycle" {
  for_each = aws_ecr_repository.ecr_repo
  repository = each.value.name

  policy = jsonencode({
    rules = [
      {
        action = {
          type = "string"
        }
        description = "Expire unstagged images"
        rulePriprity = 1
        selection = {
          countNumber = 1
          countType = "sinceImagePushed"
          countUnit = "days"
          tagStatus = "untagged"
        }
      }
    ]
  })
}