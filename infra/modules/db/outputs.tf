output "postgres_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "db_sg_id" {
  value = aws_security_group.db_sg.id
}
