variable "project_name" {}
variable "env" {}
variable "vpc_id" {}
variable "db_username" {}
variable "db_password" {}
variable "private_subnet_cidrs" { type = list(string) }
variable "public_subnet_cidrs"  { type = list(string) }
variable "allowed_ssh_cidr" { type = string }
