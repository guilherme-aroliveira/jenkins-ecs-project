output "efs_jenkins" {
  description = "Jenkins EFS file system"
  value = aws_efs_file_system.efs_jenkins
}

output "efs_jenkins_access" {
  description = "Jenkins EFS access point"
  value = aws_efs_access_point.efs_access_point_jenkins.id
}