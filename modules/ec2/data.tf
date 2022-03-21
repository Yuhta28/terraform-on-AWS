data "aws_subnets" "terraform-subnets" {
    filter {
    name   = "vpc-id"
    values = [var.terraform-vpc-id]
  }
}

data "aws_subnet" "terraform-subnet" {
  for_each = toset(data.aws_subnets.terraform-subnets.ids)
  id       = each.value
}

output "terraform-subnet-ids" {
  value = toset(data.aws_subnet.terraform-subnet.ids)
}