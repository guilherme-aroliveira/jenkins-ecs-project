module "iam" {
  source              = "../modules/iam"
  ecs_cluster_jenkins = module.ecs.ecs_cluster_jenkins
  ecs_service_jenkins = module.ecs.ecs_service_jenkins
  efs_jenkins         = module.efs.efs_jenkins
}

module "cloudwatch" {
  source = "../modules/cloudwatch"
}

module "vpc" {
  source = "../modules/vpc"
}

module "ec2" {
  source         = "../modules/ec2"
  vpc_id         = module.vpc.vpc_id
  vpc_cidr       = module.vpc.vpc_cidr
  public_subnets = module.vpc.public_subnets
}

module "ecr" {
  source      = "../modules/ecr"
  environment = "dev"
}

module "ecs" {
  source             = "../modules/ecs"
  vpc_id             = module.vpc.vpc_id
  public_subnets     = module.vpc.public_subnets
  private_subnets    = module.vpc.private_subnets
  jenkins_service_sg = module.ec2.jenkins_service_sg
  jenkins_tg         = module.ec2.jenkins_tg
  ecr_uri            = module.ecr.ecr_uri
  ecs_jenkins_logs   = module.cloudwatch.ecs_jenkins_logs
  ecs_execution_role = module.iam.ecs_execution_role
  ecs_task_role      = module.iam.ecs_task_role
  efs_jenkins        = module.efs.efs_jenkins
  efs_jenkins_access = module.efs.efs_jenkins_access
}

module "efs" {
  source                 = "../modules/efs"
  private_subnets        = module.vpc.private_subnets
  iam_efs_jenkins_policy = module.iam.iam_efs_jenkins_policy
  jenkins_efs_sg         = module.ec2.jenkins_efs_sg
}
