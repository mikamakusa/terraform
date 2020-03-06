variable "vpc" {
  type = list
}

variable "subnets" {
  type = list
}

variable "eip" {
  type = list
}

variable "nat_gateway" {
  type = list
}

variable "internet_gateway" {
  type = list
}

variable "route_table" {
  type = list
}

variable "route_table_association" {
  type = list
}

variable "security_group" {
  type = list
}

variable "security_group_rules" {
  type = list
}