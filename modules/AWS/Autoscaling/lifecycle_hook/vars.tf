variable "lifecycle_hook" {
  type = "list"
}

variable "autoscaling_group_name" {}
variable "notification_target_arn" {}
variable "role_arn" {}
variable "notification_metadata" {}