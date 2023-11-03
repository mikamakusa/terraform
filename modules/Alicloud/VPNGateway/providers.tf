provider "alicloud" {}

terraform {
  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
      version = "1.211.2"
    }
  }
  required_version = "1.6.2"
}