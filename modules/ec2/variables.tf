variable "ec2_instance_type" {
  type        = string
  description = "Instance type"
}

variable "ami" {
  type        = string
  description = "ami id"
}

variable "Tag_Name" {
  type        = string
  description = "Tag Name"
}

variable "key_name" {
  type        = string
  description = "Tag Name"
}

variable "terraform-public-subnet-id" {
  type = map(string)
  description = "terraform-public-subnet-id"
}

variable "terraform-vpc-id" {
  description = "terraform-vpc-id"
}

#variable "terraform-subnet-ids" {
#  description = "terraform-subnet-ids"
#}