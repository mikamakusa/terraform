provider "openstack" {}

terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.52.1"
    }
  }
}