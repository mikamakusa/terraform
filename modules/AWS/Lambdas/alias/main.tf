resource "aws_lambda_alias" "alias" {
  count            = length(var.alias)
  function_name    = element(var.function_name, lookup(var.alias[count.index], "function_id"))
  function_version = lookup(var.alias[count.index], "function_version")
  name             = lookup(var.alias[count.index], "name")

  dynamic "routing_config" {
    for_each = lookup(var.alias[count.index], "routing_config") == "" ? null : [for i in lookup(var.alias[count.index], "routing_config") : {
      additional_version_weights = lookup(i, "additional_version_weights")
    }]
    content {
      dynamic "additional_version_weights" {
        for_each = routing_config.value.additional_version_weights
        content {
          variables = additional_version_weights.value
        }
      }
    }
  }
}