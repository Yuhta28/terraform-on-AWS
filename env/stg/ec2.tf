module "staging-ec2" {
  source                     = "../../modules/ec2"
  ec2_instance_type          = "t2.micro"
  ami                        = "ami-04204a8960917fd92"
  Tag_Name                   = "staging"
  key_name                   = "WindowsKey"
  terraform-public-subnet-id = [module.staging-vpc.terraform-public-subnet-id[0]]
#  terraform-public-subnet-id = ["a"]
  terraform-vpc-id           = module.staging-vpc.terraform-vpc-id
#  terraform-subnet-ids       = [module.staging-ec2.terraform-subnet-ids]
}