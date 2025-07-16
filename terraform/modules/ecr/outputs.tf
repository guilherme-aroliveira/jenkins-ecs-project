output "ecr_uri" {
  description = "The ECR repo URI"
  value = [for ecr in aws_ecr_repository.ecr_repo.repository_url : ecr.id]
}