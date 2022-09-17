##########################################################################
# 踏み台サーバーにアタッチするためのSecurity Groupを作成
resource "aws_security_group" "terraform-sg-attached-bastion" {
  name        = "${var.Tag_Name}-bastion"
  description = "Security group for ${var.Tag_Name}-bastion"
  vpc_id      = var.terraform-vpc-id
  # アウトバウンドルール
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  # インバウンドルールは自宅IPが動的に変わるため手動で設定
  tags = {
    Name = "${var.Tag_Name}-bastion"
  }
}
##########################################################################

##########################################################################
# 踏み台サーバーにアタッチするためのIAMロールを作成
resource "aws_iam_role" "terraform-iam-role-attached-bastion" {
  name = "${var.Tag_Name}-bastion"
  path = "/"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_instance_profile" "terraform-iam-instance-profile-attached-bastion" {
  name = aws_iam_role.terraform-iam-role-attached-bastion.name
  role = aws_iam_role.terraform-iam-role-attached-bastion.name
}
##########################################################################

resource "aws_instance" "terraform-bastion-ec2" {
  ami                    = data.aws_ami.terraform-ami-bastion.id
  iam_instance_profile   = aws_iam_role.terraform-iam-role-attached-bastion.name
  instance_type          = "t4g.small"
  subnet_id              = var.terraform-public-subnet-id[0]
  vpc_security_group_ids = [aws_security_group.terraform-sg-attached-bastion.id]
  key_name               = data.aws_key_pair.terraform-key-pair.key_name
  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true
    tags = {
      Name = "${var.Tag_Name}-bastion"
    }
  }
  tags = {
    "Name" = "${var.Tag_Name}-bastion"
  }
}