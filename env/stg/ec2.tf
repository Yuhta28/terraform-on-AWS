module "staging-ec2" {
  source                     = "../../modules/ec2"
  ec2_instance_type          = "t4g.small"
  ap_ami_name                = "ami-09b4241c3ccbe9b01"
  Tag_Name                   = "staging"
  terraform-public-subnet-id = [module.staging-vpc.terraform-public-subnet-id][0]
  terraform-private-subnet-id = [module.staging-vpc.terraform-private-subnet-a.id, module.staging-vpc.terraform-private-subnet-c.id, module.staging-vpc.terraform-private-subnet-d.id]
  terraform-vpc-id           = module.staging-vpc.terraform-vpc.id
}