variable "project_name" {}
variable "env" {}
variable "vpc_id" {}
variable "private_subnet_ids" { type = list(string) }
variable "db_username" {}
variable "db_password" {}
variable "ec2_sg_id" {}
