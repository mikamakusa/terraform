terraform {
  required_providers {
    boundary = {
      source = "hashicorp/boundary"
      version = "1.1.15"
    }
  }
}

provider "boundary" {
  # Configuration options
}