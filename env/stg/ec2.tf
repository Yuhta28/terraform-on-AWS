module "staging-ec2" {
  source                     = "../../modules/ec2"
  ec2_instance_type          = "t3.small"
  ami                        = "ami-0b7546e839d7ace12"
  Tag_Name                   = "staging"
  key_name                   = "WindowsKey"
  terraform-public-subnet-id = [module.staging-vpc.terraform-public-subnet-id][0]
  terraform-vpc-id           = module.staging-vpc.terraform-vpc.id
}