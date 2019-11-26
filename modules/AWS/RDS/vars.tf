variable "db_instance" {
  type = "list"
}

variable "option_group" {
  type = "list"
}

variable "parameter_group" {
  type = "list"
}

variable "security_group_id" {}

variable "domain_iam_role" {}

variable "kms_key" {}

variable "monitoring_role" {}

variable "db_subnet" {
  type = "list"
}

variable "subnet_id" {}