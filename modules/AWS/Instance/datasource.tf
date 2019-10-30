data "terraform_remote_state" "vpc" {
  backend = "s3"

  config {
    bucket = ""
    key = ""
  }
}

data "terraform_remote_state" "security_groups" {
  backend = "s3"

  config {
    bucket  = ""
    key     = ""
  }
}