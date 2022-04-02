#resource "aws_instance" "terraform-ec2" {
#  ami                         = var.ami
#  instance_type               = var.ec2_instance_type
#  subnet_id                   = var.terraform-public-subnet-id[0]
#  associate_public_ip_address = true
#  key_name                    = var.key_name
#  vpc_security_group_ids = [
#    aws_security_group.terraform-ec2-sg-for-ssh.id
#  ]
#  tags = {
#    Name      = "${var.Tag_Name}-ec2"
#    Terraform = "True"
#  }
#}

resource "aws_security_group" "terraform-ec2-sg-for-ssh" {
  name        = "${var.Tag_Name}-SSH"
  description = "Security group for ${var.Tag_Name}-ec2"
  vpc_id      = var.terraform-vpc-id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.TF_VAR_homeIP]
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

#resource "aws_lb" "terraform-alb" {
#  name               = "${var.Tag_Name}-alb"
#  load_balancer_type = "application"
#  internal           = false
#  security_groups = [
#    aws_security_group.web_server_sg.id
#  ]
#  subnets = var.terraform-public-subnet-id
#  tags = {
#    Name      = "${var.Tag_Name}-alb"
#    Terraform = "True"
#  }
#}
#
#resource "aws_lb_listener" "terraform-alb-listener" {
#  load_balancer_arn = aws_lb.terraform-alb.arn
#  port              = 80
#  protocol          = "HTTP"
#  default_action {
#    target_group_arn = aws_lb_target_group.terraform-tg.arn
#    type             = "forward"
#  }
#}

#resource "aws_lb_target_group" "terraform-tg" {
#  name     = "${var.Tag_Name}-tg"
#  port     = 80
#  protocol = "HTTP"
#  vpc_id   = var.terraform-vpc-id
#}
#
#resource "aws_lb_target_group_attachment" "terraform-tg-attach" {
#  target_group_arn = aws_lb_target_group.terraform-tg.arn
#  target_id        = aws_instance.terraform-ec2.id
#}