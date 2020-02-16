resource "aws_api_gateway_integration" "integration" {
  count       = length(var.integration)
  http_method = element(var.http_method, lookup(var.integration[count.index], "http_method_id"))
  resource_id = element(var.api_resource_id, lookup(var.integration[count.index], "resource_id"))
  rest_api_id = element(var.rest_api_id, lookup(var.integration[count.index], "rest_api_id"))
  type        = lookup(var.integration[count.index], "type")
}