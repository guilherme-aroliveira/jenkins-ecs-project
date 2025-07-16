variable "environment" {
  description = "The environment name the application"
  type        = string
}

variable "image_name" {
  description = "value"
  type        = list(string)
  default = [ 
    "jenkins-controller",
    "jenkins-agent"
  ]
}
