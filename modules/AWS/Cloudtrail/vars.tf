variable "cloudtrail" {
  type = "list"
}

variable "sns_topic_name" {}
variable "cloud_watch_logs_group_arn" {}
variable "cloud_watch_logs_role_arn" {}
variable "kms_key_id" {}