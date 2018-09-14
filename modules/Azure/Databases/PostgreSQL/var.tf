variable "pgsql_sku" {
  type = "map"
  default = {}
}

variable "pgsql_storage_profile" {
  type = "map"
  default = {}
}

variable "pgsql_location" {}
variable "pgsql_rg" {}

variable "pgsql_db" {
  type = "list"
}

variable "pgsql_prefix" {}
variable "pgsql_suffix" {}

variable "pgsql_db_firewall" {
  type = "list"
}

variable "pgsql_vnet_rules" {
  type = "list"
}

variable "subnets_ids" {
  type = "list"
}