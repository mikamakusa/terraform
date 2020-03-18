resource "aws_codepipeline_webhook" "webhook" {
  count           = length(var.webhook)
  authentication  = lookup(var.webhook[count.index], "authentication")
  name            = lookup(var.webhook[count.index], "name")
  target_action   = lookup(var.webhook[count.index], "target_action")
  target_pipeline = element(var.target_pipeline, lookup(var.webhook[count.index], "pipeline_id"))

  dynamic "filter" {
    for_each = lookup(var.webhook[count.index], "filter")
    content {
      json_path    = lookup(filter.value, "json_path")
      match_equals = lookup(filter.value, "match_equals")
    }
  }

  dynamic "authentication_configuration" {
    for_each = lookup(var.webhook[count.index], "authentication_configuration")
    content {
      secret_token     = lookup(authentication_configuration.value, "secret_token")
      allowed_ip_range = lookup(authentication_configuration.value, "allowed_ip_range")
    }
  }

  tags = var.tags
}