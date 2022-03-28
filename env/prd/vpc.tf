module "production-vpc" {
  source     = "../../modules/vpc"
  cidr_block = "10.0.0.0/16"
  Tag_Name   = "production"
  public-AZ  = { a = "10.0.0.0/20", c = "10.0.16.0/20", d = "10.0.32.0/20" }
  private-AZ = { a = "10.0.128.0/20", c = "10.0.144.0/20", d = "10.0.160.0/20" }
  eip-NAT-AZ = ["a", "c", "d"]
}