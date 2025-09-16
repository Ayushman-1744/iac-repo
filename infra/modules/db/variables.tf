variable "vpc_id" { type = string }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "project_name" { type = string }
variable "env" { type = string }
variable "db_username" { type = string }
variable "db_password" { type = string }
variable "db_name" { 
    type = string
    default = "appdb" 
    }
variable "ec2_sg_id" { type = string }
