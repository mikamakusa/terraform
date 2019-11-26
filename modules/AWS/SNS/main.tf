resource "aws_sns_topic" "sns_topic" {
  count                                    = length(var.sns_topic)
  name                                     = lookup(var.sns_topic[count.index], "name", null)
  display_name                             = lookup(var.sns_topic[count.index], "display_name", null)
  policy                                   = file(join(".", [join("/", [path.cwd, "policy", lookup(var.sns_topic[count.index], "policy", null)]), "json"]))
  delivery_policy                          = file(join(".", [join("/", [path.cwd, "policy", lookup(var.sns_topic[count.index], "delivery_policy", null)]), "json"]))
  application_success_feedback_role_arn    = lookup(var.sns_topic[count.index], "application_success_feedback_role_arn", null)
  application_success_feedback_sample_rate = lookup(var.sns_topic[count.index], "application_success_feedback_sample_rate", null)
  application_failure_feedback_role_arn    = lookup(var.sns_topic[count.index], "application_failure_feedback_role_arn", null)
  http_success_feedback_role_arn           = lookup(var.sns_topic[count.index], "http_success_feedback_role_arn", null)
  http_success_feedback_sample_rate        = lookup(var.sns_topic[count.index], "http_success_feedback_sample_rate", null)
  http_failure_feedback_role_arn           = lookup(var.sns_topic[count.index], "http_failure_feedback_role_arn", null)
  kms_master_key_id                        = element(var.kms_master_key_id, lookup(var.sns_topic[count.index], "kms_master_key_id", null))
  lambda_success_feedback_role_arn         = lookup(var.sns_topic[count.index], "lambda_success_feedback_role_arn", null)
  lambda_success_feedback_sample_rate      = lookup(var.sns_topic[count.index], "lambda_success_feedback_sample_rate", null)
  lambda_failure_feedback_role_arn         = lookup(var.sns_topic[count.index], "lambda_failure_feedback_role_arn", null)
  sqs_success_feedback_role_arn            = lookup(var.sns_topic[count.index], "sqs_success_feedback_role_arn", null)
  sqs_success_feedback_sample_rate         = lookup(var.sns_topic[count.index], "sqs_success_feedback_sample_rate", null)
  sqs_failure_feedback_role_arn            = lookup(var.sns_topic[count.index], "sqs_failure_feedback_role_arn", null)
  tags                                     = lookup(var.sns_topic[count.index], "tags", null)
}

resource "aws_sns_platform_application" "sns_platform_application" {
  count                            = length(var.sns_platform_application)
  name                             = lookup(var.sns_platform_application[count.index], "name")
  platform                         = lookup(var.sns_platform_application[count.index], "platform")
  platform_credential              = lookup(var.sns_platform_application[count.index], "platform_credential")
  event_endpoint_updated_topic_arn = lookup(var.sns_platform_application[count.index], "event_endpoint_updated_topic_arn", null)
  event_endpoint_deleted_topic_arn = lookup(var.sns_platform_application[count.index], "event_endpoint_deleted_topic_arn", null)
  event_endpoint_created_topic_arn = lookup(var.sns_platform_application[count.index], "event_endpoint_created_topic_arn", null)
  event_delivery_failure_topic_arn = lookup(var.sns_platform_application[count.index], "event_delivery_failure_topic_arn", null)
  failure_feedback_role_arn        = lookup(var.sns_platform_application[count.index], "failure_feedback_role_arn", null)
  platform_principal               = lookup(var.sns_platform_application[count.index], "platform_principal", null)
  success_feedback_role_arn        = lookup(var.sns_platform_application[count.index], "success_feedback_role_arn", null)
  success_feedback_sample_rate     = lookup(var.sns_platform_application[count.index], "success_feedback_sample_rate", null)
}

resource "aws_sns_sms_preferences" "sns_sms_preference" {
  count                                 = length(var.sns_sms_preference)
  monthly_spend_limit                   = lookup(var.sns_sms_preference[count.index], "monthly_spend_limit", null)
  default_sender_id                     = lookup(var.sns_sms_preference[count.index], "default_sender_id", null)
  default_sms_type                      = lookup(var.sns_sms_preference[count.index], "default_sms_type", null)
  delivery_status_iam_role_arn          = element(var.delivery_status_iam_role_arn, lookup(var.sns_sms_preference[count.index], "delivery_status_iam_role_arn", null))
  delivery_status_success_sampling_rate = lookup(var.sns_sms_preference[count.index], "delivery_status_success_sampling_rate", null)
  usage_report_s3_bucket                = element(var.usage_report_s3_bucket, lookup(var.sns_sms_preference[count.index], "usage_report_s3_bucket", null))
}

resource "aws_sns_topic_policy" "sns_topic_policy" {
  count  = length(var.sns_topic) == "0" ? "0" : length(var.sns_topic_policy)
  arn    = element(aws_sns_topic.sns_topic.*.arn, lookup(var.sns_topic_policy[count.index], "sns_topic_id"))
  policy = file(join(".", [join("/", [path.cwd, "policy", lookup(var.sns_topic_policy[count.index], "policy")]), "json"]))
}

resource "aws_sns_topic_subscription" "sns_topic_subscription" {
  count                           = length(var.sns_topic) == "0" ? "0" : length(var.sns_topic_subscription)
  endpoint                        = lookup(var.sns_topic_subscription[count.index], "endpoint")
  protocol                        = lookup(var.sns_topic_subscription[count.index], "protocol")
  topic_arn                       = element(aws_sns_topic.sns_topic.*.arn, lookup(var.sns_topic_subscription[count.index], "sns_topic_id"))
  endpoint_auto_confirms          = lookup(var.sns_topic_subscription[count.index], "endpoint_auto_confirms", null)
  confirmation_timeout_in_minutes = lookup(var.sns_topic_subscription[count.index], "confirmation_timeout_in_minutes", null)
  raw_message_delivery            = lookup(var.sns_topic_subscription[count.index], "raw_message_delivery", null)
  filter_policy                   = lookup(var.sns_topic_subscription[count.index], "filter_policy", null)
  delivery_policy                 = lookup(var.sns_topic_subscription[count.index], "delivery_policy", null)
}