variable "instance" {
  type = list
}

variable "db_subnet_group_name" {}
variable "kms_key_id" {}
variable "monitoring_role_arn" {}
variable "option_group_name" {}
variable "parameter_group_name" {}
variable "vpc_security_group_ids" {}
variable "performance_insights_kms_key_id" {}
variable "domain_iam_role_name" {}