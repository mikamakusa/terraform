provider "brightbox" {}

terraform {
  required_providers {
    brightbox = {
      source  = "brightbox/brightbox"
      version = "3.4.3"
    }
  }
  required_version = "1.5.7"
}