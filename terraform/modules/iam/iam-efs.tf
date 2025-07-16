##############################
# create EFS access policy
##############################

data "aws_iam_policy_document" "iam_efs_jenkins_policy" {
  statement {
    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite",
      "elasticfilesystem:DescribeFileSystems"
    ]

    effect = "Allow"

    resources = [
      "${var.efs_jenkins}".arn
    ]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["true"]
    }
  }
}

#################################
# create EFS access - ecs task
#################################


data "aws_iam_policy_document" "efs_access" {
  statement {
    actions = [
      "elasticfilesystem:ClientMount",
      "elasticfilesystem:ClientWrite"
    ]

    resources = [
      "${var.efs_jenkins}".arn
    ]
  }
}

resource "aws_iam_policy" "efs_access" {
  name   = "efs-access"
  policy = data.aws_iam_policy_document.efs_access.json
}

resource "aws_iam_role_policy_attachment" "efs_access_ecs_task" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.efs_access.arn
}