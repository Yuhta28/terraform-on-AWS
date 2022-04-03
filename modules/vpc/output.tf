output "terraform-public-subnet-id" {
  value       = toset([for subnet in aws_subnet.terraform-public-subnet : subnet.id])
  description = "Public Subnet ID"
}

output "terraform-vpc" {
  value       = aws_vpc.terraform-vpc
  description = "VPC"
}