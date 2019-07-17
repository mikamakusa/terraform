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

variable "app_admin" {}
variable "ssh_key" {}

variable "instance_group_manager" {
  type = "list"
}

variable "target_pools" {}

variable "region" {}

variable "pool" {
  type = "list"
}
