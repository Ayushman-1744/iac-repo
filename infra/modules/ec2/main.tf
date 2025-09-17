# EC2 Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "${var.project_name}-${var.env}-ec2-sg"
  description = "Allow SSH"
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

  tags = { Name = "${var.project_name}-${var.env}-ec2-sg" }
}

# EC2 Instances
resource "aws_instance" "this" {
  count         = length(var.public_subnet_ids)
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = element(var.public_subnet_ids, count.index)
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = { Name = "${var.project_name}-${var.env}-ec2-${count.index}" }
}

# Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
