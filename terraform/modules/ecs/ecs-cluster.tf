resource "aws_ecs_cluster" "ecs_cluster_jenkins" {
  name = "jenkins-ecs-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      log_configuration {
        cloud_watch_log_group_name = var.ecs_jenkins_logs
      }
    }
  }

  tags = merge(
    local.tags,
    {
      Name = "jenkins-ecs-cluster"
    }
  )
}

resource "aws_ecs_cluster_capacity_providers" "ecs_cluster_jenkins_providers" {
  cluster_name       = aws_ecs_cluster.ecs_cluster_jenkins.name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    base              = 1
    capacity_provider = "FARGATE_SPOT"
    weight            = 100
  }
}
