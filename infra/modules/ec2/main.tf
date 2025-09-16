# Security group for EC2
resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_name}-${var.env}-ec2-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# EC2 instance
resource "aws_instance" "app" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = element(var.public_subnets, 0)
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.project_name}-${var.env}-ec2"
  }

  # Simple user_data to install nginx
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "<h1>${var.project_name} - ${var.env} - Deployed via Terraform</h1>" > /usr/share/nginx/html/index.html
              EOF
}
