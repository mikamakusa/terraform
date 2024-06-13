terraform {
  required_providers {
    cloudfoundry = {
      source = "cloudfoundry-community/cloudfoundry"
      version = "0.53.1"
    }
  }
  required_version = "1.6.4"
}

provider "cloudfoundry" {
  # Configuration options
}