variable "functions" {
  type = "list"
}

variable "alias" {
  type = "list"
}

variable "permission" {
  type = "list"
}

variable "role" {}

variable "event_source_mapping" {
  type = "list"
}

variable "event_source_arn" {}

variable "source_arn" {}

variable "layers" {
  type = "list"
}

variable "security_group_ids" {}

variable "subnet_id" {}