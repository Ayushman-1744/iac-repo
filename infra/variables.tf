variable "region" {
  default = "ap-south-1"
}

variable "project_name" {
  default = "demo-project"
}

variable "env" {
  default = "dev"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}

variable "allowed_ssh_cidr" {
  default = "0.0.0.0/0"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  description = "EC2 key pair name"
}

variable "db_username" {
  default = "postgres"
}

variable "db_password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}
