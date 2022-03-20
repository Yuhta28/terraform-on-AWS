module "staging-ec2" {
  source            = "../../modules/ec2"
  ec2_instance_type = "t2.micro"
  ami               = "ami-04204a8960917fd92"
  Tag_Name          = "staging"
  terraform-public-subnet-id = [module.staging-vpc.terraform-public-subnet-id]
}