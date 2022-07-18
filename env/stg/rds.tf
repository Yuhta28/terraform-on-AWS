module "staging-rds" {
  source              = "../../modules/rds"
  db_sunet_group_name = "terraform-staging-db-subent"
  db_sunet_group_ids  = [module.staging-vpc.terraform-private-subent-id]
}