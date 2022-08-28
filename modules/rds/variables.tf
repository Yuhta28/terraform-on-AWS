variable "Tag_Name" {
  type    = string
  default = "staging"
}

variable "db_subnet_group_name" {
  type        = string
  description = "terraform-db-subnet-group-name"
}

variable "db_subnet_group_ids" {
  type        = list(string)
  description = "terraform-db-subnet-ids"
}

variable "terraform-vpc-id" {
  type        = string
  description = "VPC ID"
}

variable "ec2_to_db_security_groups_id" {
  type        = list(string)
  description = "source security_gruops for ec2 to db"
}

variable "db_subnet_group_description" {
  type        = string
  description = "terraform-db-subnet-description"
}

variable "aurora_cluster_parameter_group_name" {
  type        = string
  description = "terraform-aurora-cluster-parameter-group"
}

variable "aurora_instance_parameter_group_name" {
  type        = string
  description = "terraform-aurora-instance-parameter-group"
}

variable "db_cluster_name" {
  type        = string
  description = "terraform-db-cluster-name"
}

variable "db_cluster_instance" {
  type        = string
  description = "terraform-db-instance-type"
}