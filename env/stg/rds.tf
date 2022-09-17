module "staging-rds" {
  source                               = "../../modules/rds"
  terraform-vpc-id                     = module.staging-vpc.terraform-vpc.id
  ec2_to_db_security_groups_id         = [module.staging-ec2.sg-for-alb-to-ec2.id]
  db_subnet_group_name                 = "terraform-staging-db-subent"
  db_subnet_group_description          = "DB Subnet Group for staging"
  db_subnet_group_ids                  = [module.staging-vpc.terraform-private-subnet-a.id, module.staging-vpc.terraform-private-subnet-c.id]
  aurora_cluster_parameter_group_name  = "terraform-aurora-mysql57"
  aurora_instance_parameter_group_name = "terraform-mysql57"
  db_cluster_name                      = "terraform-staging-aurora"
  db_cluster_instance                  = "db.t3.small"
  Tag_Name                             = "staging"
}