variable "cluster_instance" {
  type = list
}

variable "db_subnet_group_name" {}
variable "db_parameter_group_name" {}
variable "monitoring_role_arn" {}
variable "performance_insights_kms_key_id" {}
variable "tags" {
  type = map
}