# Map CIDRs to subnet IDs
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "cidr-block"
    values = var.private_subnet_cidrs
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "cidr-block"
    values = var.public_subnet_cidrs
  }
}

# EC2 Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_name}-${var.env}-ec2-sg"
  description = "Allow SSH and app traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.env}-ec2-sg"
  }
}

# DB Security Group
resource "aws_security_group" "db_sg" {
  name        = "${var.project_name}-${var.env}-db-sg"
  description = "Allow DB access from EC2"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.env}-db-sg"
  }
}

# DB Subnet Group
resource "aws_db_subnet_group" "default" {
  name       = "${var.project_name}-${var.env}-db-subnet-group"
  subnet_ids = length(data.aws_subnets.private.ids) > 0 ? data.aws_subnets.private.ids : data.aws_subnets.public.ids

  tags = {
    Name = "${var.project_name}-${var.env}-db-subnet-group"
  }
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

  tags = {
    Name = "${var.project_name}-${var.env}-rds"
  }
}
