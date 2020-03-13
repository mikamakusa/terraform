resource "aws_appsync_resolver" "resolver" {
  count             = length(var.resolver)
  api_id            = element(var.api_id, lookup(var.resolver[count.index], "api_id"))
  field             = lookup(var.resolver[count.index], "field")
  request_template  = lookup(var.resolver[count.index], "request_template")
  response_template = lookup(var.resolver[count.index], "response_template")
  type              = lookup(var.resolver[count.index], "type")
  kind              = lookup(var.resolver[count.index], "kind")

  dynamic "pipeline_config" {
    for_each = lookup(var.resolver[count.index], "pipeline_config")
    content {
      functions = element(var.functions, lookup(pipeline_config.value, "function_ids"))
    }
  }
}