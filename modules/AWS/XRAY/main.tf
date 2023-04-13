resource "aws_xray_encryption_config" "encryption_config" {
  for_each = toset(keys({ for k, v in var.encryption_config : k => v }))
  type     = var.encryption_config[each.value]["type"]
  key_id   = var.encryption_config[each.value]["key_id"]
}

resource "aws_xray_group" "xray_group" {
  for_each          = var.xray_group
  filter_expression = each.value.filter_expression
  group_name        = each.key

  dynamic "insights_configuration" {
    for_each = each.value.insight_configuration
    content {
      insights_enabled      = insights_configuration.value.insights_enabled
      notifications_enabled = insights_configuration.value.notifications_enabled
    }
  }

  tags = each.value.tags

}

resource "aws_xray_sampling_rule" "sampling_rule" {
  for_each       = var.sampling_rule
  rule_name      = each.key
  fixed_rate     = each.value.fixed_rate
  host           = each.value.host
  http_method    = each.value.http_method
  priority       = each.value.priority
  reservoir_size = each.value.reservoir_size
  resource_arn   = each.value.resource_arn
  service_name   = each.value.service_name
  service_type   = each.value.service_type
  url_path       = each.value.url_path
  version        = each.value.version
  attributes     = each.value.attirbutes
  tags           = each.value.tags
}