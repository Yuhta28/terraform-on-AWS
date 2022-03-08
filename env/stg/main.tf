provider "aws" {
  region = "ap-northeast-1"
}

#terraform {
#  backend "s3" {
#    bucket = "terraform-s3-yuta1993"
#    region = "ap-northeast-1"
#    key    = "stg/terraform.tfstate"
#  }
#}