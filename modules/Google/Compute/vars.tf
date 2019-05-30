variable "project" {}
variable "zone" {}
variable "prefix" {}
variable "Linux_Vms" {
  type = "list"
}
variable "network" {}
variable "subnetwork" {}
variable "ssh_keys" {}
variable "app_admin" {}
variable "app_project" {}
variable "disk" {
  type = "list"
}