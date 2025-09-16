variable "project_name" {
  description = "Project name prefix for resources"
  type        = string
}

variable "env" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EC2 instances will be deployed"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs or CIDRs to deploy EC2 instances"
  type        = list(string)
}

variable "key_name" {
  description = "SSH key pair name for EC2 instance access"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into EC2"
  type        = string
}
