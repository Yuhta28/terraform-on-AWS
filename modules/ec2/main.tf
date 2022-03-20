resource "aws_instance" "terraform-ec2" {
  ami           = var.ami
  instance_type = var.ec2_instance_type
  tags = {
    Name      = "${var.Tag_Name}-ec2"
    Terraform = "True"
  }

}