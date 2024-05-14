terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.54.1"
    }
  }
  required_version = "1.8.3"
}

provider "openstack" {}