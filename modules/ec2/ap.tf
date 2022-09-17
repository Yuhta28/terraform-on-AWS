# WordPress APサーバー
resource "aws_instance" "terraform-ec2" {
  count         = 1
  ami           = var.ap_ami_name
  instance_type = var.ec2_instance_type
  subnet_id     = var.terraform-private-subnet-id[0]
  key_name      = data.aws_key_pair.terraform-key-pair.key_name
  vpc_security_group_ids = [
    aws_security_group.terraform-alb-to-ec2.id,
    aws_security_group.terraform-sg-attached-ap.id
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

##########################################################################
# WordPress APサーバーにアタッチするためのSecurity Groupを作成
resource "aws_security_group" "terraform-sg-attached-ap" {
  name        = "${var.Tag_Name}-ap"
  description = "Security group for ${var.Tag_Name}-ap"
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
    Name = "${var.Tag_Name}-ap"
  }
}
resource "aws_security_group_rule" "terraform-sg-rule-ec2-alb" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web_server_sg.id
  security_group_id        = aws_security_group.terraform-sg-attached-ap.id
  depends_on               = [aws_security_group.terraform-sg-attached-ap]
}
resource "aws_security_group_rule" "terraform-sg-rule-ap-bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.terraform-sg-attached-bastion.id
  security_group_id        = aws_security_group.terraform-sg-attached-ap.id
  depends_on               = [aws_security_group.terraform-sg-attached-ap, aws_security_group.terraform-sg-attached-bastion]
}
##########################################################################

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
