output "terraform-public-subnet-id" {
  value = aws_subnet.terraform-public-subnet["*"].id
  default = []
}

output "terraform-vpc-id" {
  value = aws_vpc.terraform-vpc.id
}