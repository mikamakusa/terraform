variable "StorGateway" {
  type = "list"
}

variable "StorGatewayNFS" {
  type = "list"
}

variable "StorGatewaySMB" {
  type = "list"
}

variable "s3_bucket" {}

variable "iam" {}

variable "StorGatewayCache" {
  type = "list"
}

variable "local_disk" {
  type = "list"
}

variable "upload_buffer" {
  type = "list"
}

variable "working_storage" {
  type = "list"
}