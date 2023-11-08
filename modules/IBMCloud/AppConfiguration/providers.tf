provider "ibm" {}

terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.59.0"
    }
  }
  required_version = "1.6.2"
}