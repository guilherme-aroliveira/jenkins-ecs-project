###############################
# create ecs execution role
###############################

resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    local.tags,
    {
      Name = "ecs-execution-role"
    }
  )
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_attach" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

###############################
# create ecs task role
###############################

resource "aws_iam_role" "ecs_task_role" {
  name = "jenkins-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(
    local.tags,
    {
      Name = "ecs-task-role"
    }
  )
}

##################################
# create ecs access policy
##################################

data "aws_iam_policy_document" "ecs_access" {
  statement {
    actions = [
      "ecs:RegisterTaskDefinition",
      "ecs:DeregisterTaskDefinition",
      "ecs:ListClusters",
      "ecs:ListTaskDefinitions",
      "ecs:DescribeContainerInstances",
      "ecs:DescribeTaskDefinition",
      "ecs:DescribeClusters",
      "ecs:ListTagsForResource"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "ecs:ListContainerInstances"
    ]
    resources = [
      "${var.ecs_cluster_jenkins}".arn
    ]
  }

  statement {
    actions = [
      "ecs:RunTask",
      "ecs:StopTask",
      "ecs:DescribeTasks"
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "ArnEquals"
      variable = "ecs:cluster"

      values = [
        "${var.ecs_cluster_jenkins}".arn
      ]
    }
  }
}

resource "aws_iam_policy" "iam_policy_ecs_access" {
  name   = "ecs-access"
  policy = data.aws_iam_policy_document.ecs_access.json

  tags = merge(
    local.tags,
    {
      Name = "ecs-access"
    }
  )
}

resource "aws_iam_role_policy_attachment" "iam_policy_ecs_access_attach" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.iam_policy_ecs_access.arn
}

data "aws_iam_policy_document" "iam_access" {
  statement {
    actions = [
      "iam:GetRole",
      "iam:PassRole"
    ]

    resources = [
      aws_iam_role.ecs_execution_role.arn,
      aws_iam_role.iam_role_jenkins_agent.arn
    ]
  }
}

##################################
# create ecs task access policy
##################################

resource "aws_iam_policy" "iam_access" {
  name   = "iam-access"
  policy = data.aws_iam_policy_document.iam_access.json
}

resource "aws_iam_role_policy_attachment" "iam_access" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.iam_access.arn
}

##################################
# create ecs jenkins agent role
##################################

resource "aws_iam_role" "iam_role_jenkins_agent" {
  name = "ecs-agent"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "jenkins_agent_admin_access" {
  role       = aws_iam_role.iam_role_jenkins_agent.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
