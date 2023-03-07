variable "datastore" {
  type = string
}

variable "destination_file" {
  type = string
}

variable "source_file" {
  type = string
}

variable "source_datacenter" {
  type    = string
  default = null
}

variable "source_datastore" {
  type    = string
  default = null
}

variable "datacenter" {
  type    = string
  default = null
}

variable "create_directories" {
  type    = bool
  default = false
}