variable "project_name" {
  type        = string
  description = "Project name prefix"
}

variable "env" {
  type        = string
  description = "Environment (dev, staging, prod)"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where DB will be deployed"
}

variable "db_username" {
  type        = string
  description = "DB master username"
}

variable "db_password" {
  type        = string
  description = "DB master password"
  sensitive   = true
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
  default     = []
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs (fallback if no private subnets)"
  default     = []
}

variable "ec2_sg_id" {
  type        = string
  description = "EC2 Security Group ID allowed to access the DB"
}
