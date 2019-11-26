variable "iam_role" {}
variable "kms_key" {}
variable "vpc_id" {}
variable "sns_neptune" {}

variable "neptune" {
  type = "list"
}

variable "neptune_subnet_group" {
  type = "list"
}

variable "neptune_param_group" {
  type = "list"
}

variable "neptune_cluster_instance" {
  type = "list"
}

variable "neptune_snapshot" {
  type = "list"
}

variable "neptune_events" {
  type = "list"
}

variable "cluster_ParamGroup" {
  type = "list"
}