variable "cluster" {
  type = list
}

variable "vpc_security_group_ids" {}
variable "db_subnet_group_name" {}
variable "db_cluster_parameter_group_name" {}
variable "kms_key_id" {}
variable "iam_roles" {}