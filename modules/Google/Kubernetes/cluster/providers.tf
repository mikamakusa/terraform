provider "google" {}

provider "google-beta" {}

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.17.0"
    }
  }
}