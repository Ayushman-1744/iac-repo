# DB Security Group
resource "aws_security_group" "db_sg" {
  name        = "${var.project_name}-${var.env}-db-sg"
  description = "Allow DB access from EC2"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.ec2_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project_name}-${var.env}-db-sg" }
}

# DB Subnet Group
resource "aws_db_subnet_group" "default" {
  name       = "${var.project_name}-${var.env}-db-subnet-group"
  subnet_ids = length(var.private_subnet_ids) > 0 ? var.private_subnet_ids : var.public_subnet_ids

  tags = { Name = "${var.project_name}-${var.env}-db-subnet-group" }
}

# RDS Instance
resource "aws_db_instance" "postgres" {
  identifier              = "${var.project_name}-${var.env}-db"
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "15.3"
  instance_class          = "db.t3.micro"
  db_name                 = var.db_username
  username                = var.db_username
  password                = var.db_password
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  publicly_accessible     = false
  multi_az                = false

  tags = { Name = "${var.project_name}-${var.env}-rds" }
}
