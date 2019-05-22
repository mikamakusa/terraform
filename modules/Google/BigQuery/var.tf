variable "ggl_bq_dset" {
  type = "list"
}

variable "ggl_bq_table" {
  type = "list"
}

variable "labels" {
  type = "map"
  default = {}
}

variable "project" {}

variable "time_part" {
  type = "map"

  default = {}
}

variable "view" {
  type = "map"

  default = {}
}