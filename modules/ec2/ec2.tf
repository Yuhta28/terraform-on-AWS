resource "aws_instance" "terraform-ec2" {
  count = 2
  ami                         = var.ami
  instance_type               = var.ec2_instance_type
  subnet_id                   = var.terraform-public-subnet-id[0]
  associate_public_ip_address = true
  key_name                    = var.key_name
  vpc_security_group_ids = [
    aws_security_group.terraform-ec2-sg-for-ssh.id,
    aws_security_group.terraform-alb-to-ec2.id
  ]
  root_block_device {
    volume_type = "gp3"
    volume_size = "30"
    tags = {
      Name      = "${var.Tag_Name}-ebs"
      Terraform = "True"
    }
  }
  tags = {
    Name      = "${var.Tag_Name}-ec2"
    Terraform = "True"
  }
}

resource "aws_security_group" "terraform-ec2-sg-for-ssh" {
  name        = "${var.Tag_Name}-ssh"
  description = "Security group for ${var.Tag_Name}-ssh"
  vpc_id      = var.terraform-vpc-id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name      = "${var.Tag_Name}-ssh"
    Terraform = "True"
  }
}

resource "aws_security_group" "terraform-alb-to-ec2" {
  name        = "${var.Tag_Name}-alb-to-ec2"
  description = "Security group for ${var.Tag_Name}-ec2 connected ALB"
  vpc_id      = var.terraform-vpc-id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.web_server_sg.id]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name      = "${var.Tag_Name}-alb-to-ec2"
    Terraform = "True"
  }
}

resource "aws_security_group" "web_server_sg" {
  name        = "web_server"
  description = "Allow http and https traffic."
  vpc_id      = var.terraform-vpc-id
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    "Name" = "web_server-${var.Tag_Name}"
  }
}

resource "aws_security_group_rule" "inbound_http" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.web_server_sg.id
}

resource "aws_security_group_rule" "inbound_https" {
  type      = "ingress"
  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.web_server_sg.id
}