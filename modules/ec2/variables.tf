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
  description = "terraform-public-subnet-id"
}

variable "terraform-vpc-id" {
  description = "terraform-vpc-id"
}
