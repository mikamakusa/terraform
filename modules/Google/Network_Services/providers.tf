terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.17.0"
    }
  }
  required_version = "1.7.4"
}

provider "google" {}
provider "google-beta" {}