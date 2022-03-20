resource "aws_instance" "terraform-ec2" {
  ami                         = var.ami
  instance_type               = var.ec2_instance_type
  subnet_id                   = var.terraform-public-subnet-id[0]
  associate_public_ip_address = true
  key_name                    = var.key_name
  vpc_security_group_ids      = aws_security_group.terraform-ec2-sg-for-ssh.id
  tags = {
    Name      = "${var.Tag_Name}-ec2"
    Terraform = "True"
  }
}

resource "aws_security_group" "terraform-ec2-sg-for-ssh" {
  name        = "${var.Tag_Name}-SSH"
  description = "Security group for ${var.Tag_Name}-ec2"
  vpc_id      = var.terraform-vpc-id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["153.156.83.95/32"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name      = "${var.Tag_Name}-SSH"
    Terraform = "True"
  }
}
