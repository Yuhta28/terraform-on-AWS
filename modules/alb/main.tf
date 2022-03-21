resource "aws_lb_target_group" "terraform-tg" {
    name = "${var.Tag_Name}-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = var.terraform-vpc-id
}