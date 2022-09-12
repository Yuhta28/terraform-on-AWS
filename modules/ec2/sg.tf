resource "aws_security_group" "terraform-ec2-sg-for-fsx" {
  name        = "${var.Tag_Name}-fsx"
  description = "Security group for ${var.Tag_Name}-fsx"
  vpc_id      = var.terraform-vpc-id

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.terraform-alb-to-ec2.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name      = "${var.Tag_Name}-fsx"
  }
}