terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "4.2.0"
    }
  }
}

provider "vault" {
  # Configuration options
}