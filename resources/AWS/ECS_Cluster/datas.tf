data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.bucket
    key    = "vpc.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "iam" {
  backend = "s3"

  config = {
    bucket = var.bucket
    key    = "iam.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "lb" {
  backend = "s3"

  config = {
    bucket = var.bucket
    key    = "lb.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "logs" {
  backend = "s3"

  config = {
    bucket = var.bucket
    key    = "cloudwatch.tfstate"
    region = var.region
  }
}