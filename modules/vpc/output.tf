output "terraform-public-subnet-id" {
  value = aws_subnet.terraform-public-subnet[each.key].id  
}