variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "demo-project"
}

variable "key_name" {
  description = "EC2 key pair name (must exist in AWS)"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed for SSH (eg: your IP or 0.0.0.0/0)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "dbadmin"
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
  default     = "ChangeMe123!"  # override in tfvars for real run
}

variable "env" {
  description = "Environment name (dev | staging | prod)"
  type        = string
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
