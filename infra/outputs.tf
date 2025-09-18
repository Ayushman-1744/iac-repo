output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "db_instance_id" {
  value = module.db.db_instance_id
}

output "db_security_group_id" {
  value = module.db.db_sg_id
}

output "ec2_sg_id" {
  value = module.ec2.ec2_sg_id
}