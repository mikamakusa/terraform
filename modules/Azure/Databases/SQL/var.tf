variable "sql_rg_name" {}
variable "sql_location" {}
variable "sqlserver" {
  type = "list"
}
variable "sql_tags" {
  type = "list"
}

variable "sql_database" {
  type = "list"
}

variable "sql_firewall" {
  type = "list"
}

variable "sql_vnet_rule" {
  type = "list"
}

variable "subnets_ids" {}