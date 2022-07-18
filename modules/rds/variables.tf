variable "db_sunet_group_name" {
  type        = string
  description = "terraform-db-subnet-group-name"
}

variable "db_sunet_group_ids" {
  type        = list(string)
  description = "terraform-db-subnet-ids"
}
