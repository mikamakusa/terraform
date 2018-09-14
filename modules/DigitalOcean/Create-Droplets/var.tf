variable "droplets" {
  type = "list"
}

variable "droplets_tags" {
  type = "map"

  default = {}
}

variable "volume_ids" {
  type = "list"
}