variable "project_name" {}
variable "env" {}
variable "vpc_cidr" {}
variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }
variable "allowed_ssh_cidr" { default = "0.0.0.0/0" }
