data "aws_subnets" "terraform-subnets" {
  filter {
    name   = "vpc-id"
    values = [var.terraform-vpc-id]
  }
}

data "aws_subnet" "terraform-subnet" {
  for_each = toset(data.aws_subnets.terraform-subnets.ids)
  id       = each.value
  filter {
    name   = "tag:Name"
    values = ["public"]
  }
}

output "terraform-subnet-ids" {
  value = [for s in data.aws_subnet.terraform-subnet : s.id]
}