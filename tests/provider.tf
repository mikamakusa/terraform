provider "aws" {
  shared_credentials_file = "/Users/mickaeldangleterre/.aws/credentials"
  region                  = "eu-west-3"
  profile                 = "default"
}

/*terraform {
  backend "s3" {
    bucket = "test-perso"
    key    = "test.tfstate"
  }
}*/
