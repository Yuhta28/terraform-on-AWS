resource "aws_instance" "terraform-ec2" {
    ami = "ami-04204a8960917fd92"
    instance_type = "t2.micro"
    Tags = {
        Name = "terraform-ec2"
    }
  
}