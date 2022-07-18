resource "aws_db_subnet_group" "terraform-db-subnet" {
  name       = var.db_sunet_group_name
  subnet_ids = [var.db_sunet_group_ids]

  tags = {
    Name      = var.db_sunet_group_name
    Terraform = "True"
  }
}