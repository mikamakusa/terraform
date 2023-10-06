provider "google" {}

provider "google-beta" {}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.0.0"
    }
    google-beta = {
      source  = "hashicorp/google"
      version = "5.0.0"
    }
  }
  required_version = "1.5.7"
}