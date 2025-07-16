variable "image_name" {
  description = "List of ECR repositories"
  type        = list(string)
  default = [
    "jenkins-controller",
    "jenkins-agent"
  ]
}
