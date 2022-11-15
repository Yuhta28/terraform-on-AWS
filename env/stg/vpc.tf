module "staging-vpc" {
  source     = "../../modules/vpc"
  cidr_block = "192.168.0.0/16"
  Tag_Name   = "staging"
  public-AZ  = { a = "192.168.0.0/20", c = "192.168.16.0/20" }
  private-AZ = { a = "192.168.128.0/20", c = "192.168.144.0/20" }
  eip-NAT-AZ = ["a"]
}