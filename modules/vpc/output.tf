output "terraform-public-subnet-id" {
  value = module.staging-vpc.aws_subnet.terraform-public-subnet[0].id  
}