terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.42.0"
    }
  }
  required_version = "1.7.5"
}

provider "aws" {}