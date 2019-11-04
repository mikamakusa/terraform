variable "access_key" {}
variable "secret_key" {}
variable "aws_vpc" {
  type = "list"
}
variable "endpoint" {
  type = "list"
}
variable "internet_gateway" {
  type = "list"
}
variable "route" {
  type = "list"
}
variable "route_table" {
  type = "list"
}
variable "route_table_association" {
  type = "list"
}
variable "region" {
  default = "eu-west-3"
}
variable "default_sg" {
  type = "list"
}

variable "eip" {
  type = "list"
}

variable "nat_gw" {
  type = "list"
}

variable "subnet" {
  type = "list"
}