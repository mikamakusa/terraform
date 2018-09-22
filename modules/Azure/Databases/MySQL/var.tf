variable "mysql_server" {
  type = "list"
}

variable "administrator_login" {}

variable "administrator_login_password" {}

variable "mysql_resource_group_name" {}
variable "mysql_location" {}

variable "mysql_config" {
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