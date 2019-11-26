variable "sns_topic" {
  type = "list"
}

variable "sns_platform_application" {
  type = "list"
}

variable "sns_sms_preference" {
  type = "list"
}

variable "sns_topic_policy" {
  type = "list"
}

variable "sns_topic_subscription" {
  type = "list"
}

variable "delivery_status_iam_role_arn" {}

variable "usage_report_s3_bucket" {}

variable "kms_master_key_id" {}