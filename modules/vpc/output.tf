output "terraform-public-subnet-id" {
#  value = aws_subnet.terraform-public-subnet["a"].id  
  value = aws_subnet.terraform-public-subnet.id  
}