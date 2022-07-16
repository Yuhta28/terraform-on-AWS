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

resource "aws_lb_listener" "terraform-alb-listener" {
  load_balancer_arn = aws_lb.terraform-alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.terraform-tg.arn
    type             = "forward"
  }
}
resource "aws_lb_target_group" "terraform-tg" {
  name     = "${var.Tag_Name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.terraform-vpc-id
}

resource "aws_lb_target_group_attachment" "terraform-tg-attach" {
  target_group_arn = aws_lb_target_group.terraform-tg.arn
  target_id        = aws_instance.terraform-ec2.id
}