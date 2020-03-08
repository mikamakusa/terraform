provider "aws" {}

terraform {
  backend "s3" {
    bucket = "tf12-tests"
    key    = "EKS/tf-demo.tfstate"
    region = "eu-west-1"
  }
}