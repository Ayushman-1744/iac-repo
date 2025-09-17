output "public_ips" {
  value = aws_instance.this[*].public_ip
}

output "instance_ids" {
  value = aws_instance.this[*].id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}
