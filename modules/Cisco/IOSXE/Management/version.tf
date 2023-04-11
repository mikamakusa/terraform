terraform {
  required_version = ">= 1.1.0"

  required_providers {
    iosxe = {
      source  = "netascode/iosxe"
      version = ">=0.1.13"
    }
  }
}