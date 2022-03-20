#variable "terraform-public-subnet-id" {}

resource "aws_instance" "terraform-ec2" {
  ami           = var.ami
  instance_type = var.ec2_instance_type
  subnet_id = var.terraform-public-subnet-id[0]
  tags = {
    Name      = "${var.Tag_Name}-ec2"
    Terraform = "True"
  }

}