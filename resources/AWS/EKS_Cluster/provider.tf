provider "aws" {}

terraform {
  backend "s3" {
    bucket = ""
    key    = "tf-demo.tfstate"
    region = "eu-west-1"
  }
}