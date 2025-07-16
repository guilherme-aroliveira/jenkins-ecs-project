resource "aws_efs_file_system" "efs_jenkins" {
  creation_token   = "jenkins-ecs-efs"
  encrypted        = true
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"

  tags = merge(
    local.tags,
    {
      Name = "jenkins-efs"
    }
  )
}

resource "aws_efs_mount_target" "efs_mount_target_jenkins" {
  for_each = toset(var.private_subnets)

  file_system_id  = aws_efs_file_system.efs_jenkins.id
  subnet_id       = each.value
  security_groups = var.jenkins_efs_sg
}

resource "aws_efs_access_point" "efs_access_point_jenkins" {
  file_system_id = aws_efs_file_system.efs_jenkins.id

  posix_user {
    gid = 1000
    uid = 1000
  }

  root_directory {
    path = "/home"

    creation_info {
      owner_gid   = 1000
      owner_uid   = 1000
      permissions = 755
    }
  }
}

resource "aws_efs_file_system_policy" "efs_jenkins_policy" {
  file_system_id = aws_efs_file_system.efs_jenkins.id
  policy         = "${var.iam_efs_jenkins_policy}".json
}
