resource "aws_cloudwatch_log_group" "ecs_jenkins_log_group" {
  name              = "jenkins-ecs-logs"
  skip_destroy      = false
  log_group_class   = "STANDARD"
  retention_in_days = 3

  tags = merge(
    local.tags,
    {
      Name = "ecs-jenkins-log"
    }
  )
}
