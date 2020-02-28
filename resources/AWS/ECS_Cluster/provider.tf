provider "aws" {}

terraform {
  backend "s3" {
    bucket = "tf-jparnaudeau-demo-heuler-hermes"
    key    = "tf-demo.tfstate"
    region = "eu-west-1"
  }
}