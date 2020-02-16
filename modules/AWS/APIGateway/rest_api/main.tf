resource "aws_api_gateway_rest_api" "rest_api" {
  count = length(var.rest_api)
  name  = lookup(var.rest_api[count.index], "name")

  dynamic "endpoint_configuration" {
    for_each = lookup(var.rest_api[count.index], "endpoint_configuration")
    content {
      types = [lookup(endpoint_configuration.value, "types")]
    }
  }

  binary_media_types       = [lookup(var.rest_api[count.index], "binary_medium_types", null)]
  minimum_compression_size = lookup(var.rest_api[count.index], "minimum_compression_size", null)
  body                     = lookup(var.rest_api[count.index], "body", null)
  policy                   = lookup(var.rest_api[count.index], "policy", null)
  api_key_source           = lookup(var.rest_api[count.index], "api_key_source", null)
}