output "db_instance_id" {
  value = aws_db_instance.postgres.id
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}
