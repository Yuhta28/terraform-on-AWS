provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_security_group" "terraform-test" {
  name        = "debug-test-sg"
  description = "Allow http and https traffic."
  vpc_id      = "vpc-08a74159dc7faf88e"
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.homeIP]
 }
}