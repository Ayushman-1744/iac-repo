module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  env          = var.env
  vpc_cidr     = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  allowed_ssh_cidr     = var.allowed_ssh_cidr
}

module "ec2" {
  source           = "./modules/ec2"
  project_name     = var.project_name
  env              = var.env
  vpc_id           = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  instance_type    = var.instance_type
  key_name         = var.key_name
  allowed_ssh_cidr = var.allowed_ssh_cidr
}

module "db" {
  source = "./modules/db"

  project_name       = var.project_name
  env                = var.env
  vpc_id             = module.vpc.vpc_id
  db_username        = var.db_username
  db_password        = var.db_password

  # Use subnet IDs from VPC module outputs
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids

  # EC2 SG from EC2 module output
  ec2_sg_id          = module.ec2.ec2_sg_id
}

