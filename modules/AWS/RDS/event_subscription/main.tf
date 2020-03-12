resource "aws_db_event_subscription" "event_subscription" {
  count            = length(var.event_subscription)
  name             = lookup(var.event_subscription[count.index], "name")
  sns_topic        = element(var.sns_topic, lookup(var.event_subscription[count.index], "sns_topic_id"))
  source_ids       = element(var.source_ids, lookup(var.event_subscription[count.index], "source_ids"))
  source_type      = lookup(var.event_subscription[count.index], "source_type")
  event_categories = lookup(var.event_subscription[count.index], "event_categories")
  enabled          = lookup(var.event_subscription[count.index], "enabled")
  tags             = var.tags
}