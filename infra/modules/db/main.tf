# DB security group
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
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.project_name}-${var.env}-db-subnet-group"
  subnet_ids = var.private_subnets == [] ? var.public_subnets : var.private_subnets
  tags = { Name = "${var.project_name}-${var.env}-db-subnet-group" }
}

resource "aws_db_instance" "postgres" {
  identifier              = "${var.project_name}-${var.env}-db"
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "13.7"
  instance_class          = "db.t3.micro"
  db_name                    = var.db_name
  username                = var.db_username
  password                = var.db_password
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  publicly_accessible     = false
  multi_az                = false
  tags = { Name = "${var.project_name}-${var.env}-rds" }
}
