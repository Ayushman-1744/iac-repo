output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "public_subnets" {
  description = "Public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "ec2_sg_id" {
  description = "Security Group ID for EC2"
  value       = aws_security_group.ec2_sg.id
}
