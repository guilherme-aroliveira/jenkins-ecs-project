/*resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "jenkins-ecs"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = var.ecs_execution_role
  task_role_arn            = var.ecs_task_role


  container_definitions = templatefile("${path.module}/tasks/jenkins.json", {
    container_name          = "jenkins-controller",
    container_image         = "${var.ecr_uri}:jenkins-controller"
    source_volume           = "home",
    awslogs_group           = "${var.ecs_jenkins_logs}",
    awslogs_region          = "${data.aws_region.current.name}"
    }
  )

  skip_destroy = false

  tags = merge(
    local.tags,
    {
      Name    = "ecs-jenkins-app"
      Product = "jenkins"
    }
  )

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }

  volume {
    name = "home"

    efs_volume_configuration {
      file_system_id     = var.efs_jenkins
      transit_encryption = "ENABLED"

      authorization_config {
        access_point_id = var.efs_jenkins_access
        iam             = "ENABLED"
      }
    }
  }
}*/
