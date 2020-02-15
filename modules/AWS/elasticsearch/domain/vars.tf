variable "elasticsearch" {
  type = "list"
}

variable "elasticsearch_security_group_ids" {
  default = []
}
variable "elasticsearch_subnet_ids" {
  default = []
}

variable "elasticsearch_kms_key_id" {}
variable "elasticsearch_cloudwatch_log_group_arn" {}