output "terraform-public-subnet-id" {
  value       = toset([for subnet in aws_subnet.terraform-public-subnet : subnet.id])
  description = "Public Subnet ID"
}

output "terraform-private-subnet-id" {
  value       = toset([for subnet in aws_subnet.terraform-private-subnet : subnet.id])
  description = "Private Subnet ID"
}

output "terraform-public-subnet-a" {
  value       = aws_subnet.terraform-public-subnet["a"]
  description = "Public Subnet A"
}

output "terraform-public-subnet-c" {
  value       = aws_subnet.terraform-public-subnet["c"]
  description = "Public Subnet C"
}

output "terraform-private-subnet-a" {
  value       = aws_subnet.terraform-private-subnet["a"]
  description = "Private Subnet A"
}

output "terraform-private-subnet-c" {
  value       = aws_subnet.terraform-private-subnet["c"]
  description = "Private Subnet C"
}

output "terraform-vpc" {
  value       = aws_vpc.terraform-vpc
  description = "VPC"
}