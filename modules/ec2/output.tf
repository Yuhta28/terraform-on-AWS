output "sg-for-alb-to-ec2" {
  value = aws_security_group.terraform-alb-to-ec2
}

output "terraform-alb" {
  value = aws_lb.terraform-alb
}