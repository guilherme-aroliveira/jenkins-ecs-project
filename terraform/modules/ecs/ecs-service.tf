resource "aws_ecs_service" "ecs_service_jenkins" {
  name                               = "jenkins-service"
  cluster                            = aws_ecs_cluster.ecs_cluster_jenkins.arn
  #task_definition                    = aws_ecs_task_definition.ecs_task.arn
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  propagate_tags                     = "NONE"
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 50
  health_check_grace_period_seconds  = 0
  desired_count                      = 1

  tags = merge(
    local.tags,
    {
      Name    = "jenkins-service"
      Product = "jenkins"
    }
  )

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [aws_security_group.sg_ecs_service.id]
    assign_public_ip = false
  }

  load_balancer {
    container_name   = "jenkins-controller"
    container_port   = 8080
    target_group_arn = var.jenkins_tg
  }

  enable_execute_command = true

  depends_on = [aws_ecs_cluster.ecs_cluster]
}
