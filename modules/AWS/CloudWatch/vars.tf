variable "log_group" {
  type = "list"
}

variable "log_resource_policy" {
  type = "list"
}

variable "dashboard" {
  type = "list"
}

variable "event_permission" {
  type = "list"
}

variable "event_rule" {
  type = "list"
}

variable "event_target" {
  type = "list"
}

variable "log_destination" {
  type = "list"
}

variable "destination_policy" {
  type = "list"
}

variable "metric_filter" {
  type = "list"
}

variable "log_stream" {
  type = "list"
}

variable "subscription_filter" {
  type = "list"
}

variable "metric_alarm" {
  type = "list"
}

variable "kms_key_id" {}

variable "policy_document" {}

variable "iam_role_id" {}

variable "arn" {}

variable "ecs_arn" {}
variable "batch_arn" {}
variable "sqs_id" {}