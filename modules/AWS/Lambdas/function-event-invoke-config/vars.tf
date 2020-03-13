variable "lambda_function_event_invoke_config" {
  type = "list"
}

variable "function_name" {}

variable "on_failure_sns_topic_arn" {}

variable "on_success_sns_topic_arn" {}