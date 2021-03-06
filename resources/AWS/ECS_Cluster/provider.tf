provider "aws" {
  region  = "eu-west-3"
  profile = "default"
}

terraform {
  backend "s3" {
    bucket = "tests-tfstate"
    key    = "ecs.tfstate"
    region = "eu-west-3"
  }
}