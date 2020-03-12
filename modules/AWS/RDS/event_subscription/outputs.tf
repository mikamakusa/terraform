output "id" {
  value = aws_db_event_subscription.event_subscription.*.id
}

output "arn" {
  value = aws_db_event_subscription.event_subscription.*.arn
}
