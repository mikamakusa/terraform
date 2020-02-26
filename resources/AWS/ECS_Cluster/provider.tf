provider "aws" {}

terraform {
  backend "s3" {
    bucket = ""
    key    = ""
  }
}