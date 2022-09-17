variable "ec2_instance_type" {
  type        = string
  description = "Instance type"
}

variable "ap_ami_name" {
  type = string
}

variable "Tag_Name" {
  type        = string
  description = "Tag Name"
}

variable "terraform-public-subnet-id" {
  type        = list(string)
  description = "terraform-public-subnet-id"
}

variable "terraform-vpc-id" {
  type        = string
  description = "VPC ID"
}
