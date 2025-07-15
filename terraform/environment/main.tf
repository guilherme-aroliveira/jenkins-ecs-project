module "vpc" {
  source      = "../modules/vpc"
  environment = "dev"
}

module "ec2" {
  source         = "../modules/ec2"
  environment    = "dev"
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
}

module "cloudwatch" {
  source = "../modules/cloudwatch"
}

module "iam" {
  source = "../modules/iam"
}
