resource "aws_instance" "terraform-ec2" {
  ami           = var.ami
  instance_type = var.ec2_instance_type
  subnet_id = [ module.staging-vpc.aws_subnet.terraform-public-subnet[0].id ]
  tags = {
    Name      = "${var.Tag_Name}-ec2"
    Terraform = "True"
  }

}