output "terraform-public-subnet-id" {
  value = aws_subnet.terraform-public-subnet[0].id  
}