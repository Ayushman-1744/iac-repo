output "public_ip" {
  value = aws_instance.this[*].public_ip
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}
