provider "aws" {
  region = "ap-northeast-1"
}

provider "spacelift" {}

terraform {
  required_providers {
    spacelift = {
      source = "spacelift-io/spacelift"
    }
  }
}