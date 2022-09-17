# SSL証明書インポート
data "aws_acm_certificate" "yuta-aws" {
  domain = "yuta-aws.name"
}

# 作成済みのKeyPair
data "aws_key_pair" "terraform-key-pair" {
  key_name = "WindowsKey"
}

# 踏み台用の公式AMI
data "aws_ami" "terraform-ami-bastion" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name = "name"
    # 最新のARMプロセッサー Amazon Linux2 公式AMIを選択
    values = ["amzn2-ami-kernel-5.10-hvm-*-arm64-gp2"]
  }
}