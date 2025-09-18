variable "project_name" {}
variable "env" {}
variable "vpc_id" {}
variable "public_subnet_ids" { type = list(string) }
variable "instance_type" {}
variable "key_name" {}
variable "ec2_sg_id" {}
