terraform {
  required_version = ">= 0.12, < 0.13"

  required_providers {
    aws = "~> 2.0"
  }

  backend "s3" {
    bucket  = "app-com-terraform-state"
    key     = "app-com.tfstate"
    encrypt = true
    region  = "ap-southeast-1"
  }
}

provider "aws" {
  version = "~> 2.0"

  region  = var.aws_region
  profile = var.aws_profile
}

provider "aws" {
  version = "~> 2.0"

  region  = "us-east-1"
  profile = var.aws_profile

  alias = "us"
}

data "aws_availability_zones" "az" {
  state = "available"
}
