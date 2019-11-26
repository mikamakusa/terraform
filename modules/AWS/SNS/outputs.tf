output "sns_topic_arn" {
  value = aws_sns_topic.sns_topic.*.arn
}

output "sns_platform_application_arn" {
  value = aws_sns_platform_application.sns_platform_application.*.arn
}

output "sns_sms_preferences_id" {
  value = aws_sns_sms_preferences.sns_sms_preference.*.id
}

output "sns_topic_policy_arn" {
  value = aws_sns_topic_policy.sns_topic_policy.*.arn
}

output "sns_topic_subscription_arn" {
  value = aws_sns_topic_subscription.sns_topic_subscription.*.arn
}