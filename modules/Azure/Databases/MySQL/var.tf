variable "mysql_sku" {
  type = "map"

  default = {}
}

variable "mysql_storage_profile" {
  type = "map"

  default = {}
}

variable "mysql_rg_name" {}
variable "mysql_rg_location" {}

variable "mysql_db" {
  type = "list"
}

variable "mysql_database" {
  type = "list"
}

variable "mysql_firewall" {
  type = "list"
}

variable "mysql_prefix" {}
variable "mysql_suffix" {}