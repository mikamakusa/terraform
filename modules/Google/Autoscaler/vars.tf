variable "autoscaler" {
  type = "list"
}

variable "prefix" {}
variable "project" {}
variable "zone" {}

variable "network" {}
variable "subnetwork" {}

variable "template" {
  type = "list"
}

variable "instance_group_manager" {
  type = "list"
}

variable "target_pools" {}

variable "region" {}

variable "pool" {
  type = "list"
}
variable "kms_key_self_link" {}