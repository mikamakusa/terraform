terraform {
  required_version = ">= 1.1.0"

  required_providers {
    iosxe = {
      source  = "netascode/iosxe"
      version = ">=0.1.13"
    }
    utils = {
      source  = "netascode/utils"
      version = ">= 0.2.4"
    }
  }
}