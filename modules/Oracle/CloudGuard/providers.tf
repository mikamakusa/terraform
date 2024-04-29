terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
      version = "5.39.0"
    }
  }
  required_version = "1.7.4"
}

provider "oci" {}