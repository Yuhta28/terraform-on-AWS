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
#resource "aws_lb_listener" "terraform-alb-listener-http" {
#  load_balancer_arn = aws_lb.terraform-alb.arn
#  port              = 80
#  protocol          = "HTTP"
#  default_action {
#    type = "redirect"
#
#    redirect {
#      port        = "443"
#      protocol    = "HTTPS"
#      status_code = "HTTP_301"
#    }
#  }
#}
#
#resource "aws_lb_target_group" "terraform-http" {
#  name     = "${var.Tag_Name}-tg-http"
#  port     = 80
#  protocol = "HTTP"
#  vpc_id   = var.terraform-vpc-id
#}
#
#resource "aws_lb_target_group_attachment" "terraform-tg-attach-http" {
#  target_group_arn = aws_lb_target_group.terraform-http.arn
#  target_id        = aws_instance.terraform-ec2[0].id
#  port             = 80
#}
#
#resource "aws_lb_target_group_attachment" "terraform-tg-attach-http2" {
#  target_group_arn = aws_lb_target_group.terraform-http.arn
#  target_id        = aws_instance.terraform-ec2[1].id
#  port             = 80
#}
#
#data "aws_acm_certificate" "yuta-aws" {
#  domain = "yuta-aws.name"
#}
#
#resource "aws_lb_listener" "terraform-alb-listener-https" {
#  load_balancer_arn = aws_lb.terraform-alb.arn
#  port              = 443
#  protocol          = "HTTPS"
#  ssl_policy        = "ELBSecurityPolicy-2016-08"
#  certificate_arn   = data.aws_acm_certificate.yuta-aws.arn
#  default_action {
#    target_group_arn = aws_lb_target_group.terraform-http.arn
#    type             = "forward"
#  }
#}
#