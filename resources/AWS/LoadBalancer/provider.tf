provider "aws" {
  region  = "eu-west-3"
  profile = "default"
}

terraform {
  backend "s3" {
    bucket = "tests-tfstate"
    key    = "lb.tfstate"
    region = "eu-west-3"
  }
}