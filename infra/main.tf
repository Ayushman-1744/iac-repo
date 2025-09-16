locals {
  project_name = var.project_name
  env          = var.env
}

###########################
# VPC Module
###########################
module "vpc" {
  source          = "./modules/vpc"
  project_name    = local.project_name
  environment     = local.env
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  allowed_ssh_cidr = var.allowed_ssh_cidr
}

###########################
# EC2 Module
###########################
module "ec2" {
  source          = "./modules/ec2"
  project_name    = local.project_name
  env             = local.env
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  key_name        = var.key_name
  allowed_ssh_cidr = var.allowed_ssh_cidr
  instance_type   = var.instance_type
}

###########################
# RDS Module
###########################
module "db" {
  source          = "./modules/db"
  project_name    = local.project_name
  env             = local.env
  vpc_id          = module.vpc.vpc_id
  public_subnets  = module.vpc.public_subnets
  private_subnets = []      # if no private subnets
  db_username     = var.db_username
  db_password     = var.db_password
  ec2_sg_id       = module.vpc.ec2_sg_id   # use SG created in VPC module
}
