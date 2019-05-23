variable "resource_group_name" {}
variable "location" {}
variable "tenant_id" {}
variable "object_id" {}
variable "prefix" {}

variable "keyvault" {
  type = "list"
}

variable "certificate_permissions" {}

variable "key_permissions" {}

variable "secret_permissions" {}

variable "storage_permissions" {}

variable "cert_import" {
  type = "list"
}

variable "cert_gen" {
  type = "list"
}

variable "key_usage" {}

variable "az_key" {
  type = "list"
}

variable "secret" {
  type = "list"
}