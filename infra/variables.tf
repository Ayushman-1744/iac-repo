variable "aws_region" {}
variable "project_name" {}
variable "env" {}
variable "vpc_cidr" {}
variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }
variable "allowed_ssh_cidr" {}
variable "key_name" {}
variable "instance_type" {}
variable "db_username" {}
variable "db_password" {}
