resource "aws_db_subnet_group" "terraform-db-subnet" {
  name        = var.db_sunet_group_name
  subnet_ids  = var.db_sunet_group_ids
  description = var.db_subnet_group_description

  tags = {
    Name      = var.db_sunet_group_name
    Terraform = "True"
  }
}

resource "aws_rds_cluster" "terraform-aurora-cluster" {
  cluster_identifier = var.db_cluster_name
  engine = "aurora-mysql"
  db_subnet_group_name = aws_db_subnet_group.terraform-db-subnet.name
  database_name = "wordpress-db"
  master_username = "bar"
  master_password = "barbut8chars"
  tags = {
    Terraform = "True"
  }
}

resource "aws_rds_cluster_instance" "terraform-aurora-cluster-instance" {
  count = 1
  identifier = "${var.db_cluster_name}-instance"
  cluster_identifier = aws_rds_cluster.terraform-aurora-cluster.id
  instance_class = var.db_cluster_instance
  db_subnet_group_name = aws_db_subnet_group.terraform-db-subnet.name
  tags = {
    Terraform = "True"
  }
}