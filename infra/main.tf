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
  ec2_sg_id        = module.vpc.ec2_sg_id
}

module "db" {
  source = "./modules/db"

  project_name       = var.project_name
  env                = var.env
  vpc_id             = module.vpc.vpc_id
  db_username        = var.db_username
  db_password        = var.db_password
  private_subnet_ids = module.vpc.private_subnet_ids
  ec2_sg_id          = module.vpc.ec2_sg_id
}
