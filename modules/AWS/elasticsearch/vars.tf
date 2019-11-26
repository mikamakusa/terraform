variable "region" {}
variable "account" {}
variable "domain_name" {}
variable "subnet_ids" {}
variable "kms_key_id" {}
variable "cloudwatch_log_group_arn" {}
variable "security_group_ids" {}
# ElasticSearch
variable "elasticsearch" {
  type = "list"
}
variable "es_policy" {
  type = "list"
}