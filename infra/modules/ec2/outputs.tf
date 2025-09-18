# Output the EC2 instance ID
output "instance_id" {
  value = aws_instance.this.id
}

# Output the EC2 security group ID (passed from VPC module)
output "ec2_sg_id" {
  value = var.ec2_sg_id
}
