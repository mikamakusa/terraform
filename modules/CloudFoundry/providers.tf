terraform {
  required_providers {
    cloudfoundry = {
      source = "cloudfoundry-community/cloudfoundry"
      version = "0.51.3"
    }
  }
  required_version = "1.6.4"
}

provider "cloudfoundry" {
  # Configuration options
}