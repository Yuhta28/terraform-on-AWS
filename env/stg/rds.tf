module "staging-rds" {
  source                      = "../../modules/rds"
  db_sunet_group_name         = "terraform-staging-db-subent"
  db_subnet_group_description = "DB Subnet Group for staging"
  db_sunet_group_ids          = [module.staging-vpc.terraform-private-subnet-a.id, module.staging-vpc.terraform-private-subnet-c.id]
  db_cluster_name             = "terraform-staging-aurora"
  db_cluster_instance         = "db.t3.small"
}