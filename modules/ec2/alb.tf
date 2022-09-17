##########################################################################
# ALBにアタッチするためのSecurity Group
resource "aws_security_group" "web_server_sg" {
  name        = "web_server"
  description = "Allow http and https traffic."
  vpc_id      = var.terraform-vpc-id
  # アウトバウンドルール
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
##########################################################################

resource "aws_lb" "terraform-alb" {
  name               = "${var.Tag_Name}-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups = [
    aws_security_group.web_server_sg.id
  ]
  subnets = var.terraform-public-subnet-id
  tags = {
    Name      = "${var.Tag_Name}-alb"
    Terraform = "True"
  }
}

resource "aws_lb_listener" "terraform-alb-listener-http" {
  load_balancer_arn = aws_lb.terraform-alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "terraform-alb-listener-https" {
  load_balancer_arn = aws_lb.terraform-alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.yuta-aws.arn
  default_action {
    target_group_arn = aws_lb_target_group.terraform-http.arn
    type             = "forward"
  }
}

##########################################################################
# WordPress AP EC2アタッチ用Target Group
resource "aws_lb_target_group" "terraform-http" {
  name     = "${var.Tag_Name}-tg-http"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.terraform-vpc-id
}
resource "aws_lb_target_group_attachment" "terraform-tg-attach-http" {
  target_group_arn = aws_lb_target_group.terraform-http.arn
  target_id        = aws_instance.terraform-ap-ec2.id
  port             = 80
}
##########################################################################