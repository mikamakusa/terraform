resource "aws_api_gateway_integration_response" "integration_response" {
  count               = length(var.integration_response)
  http_method         = element(var.http_method, lookup(var.integration_response[count.index], "http_method_id"))
  resource_id         = element(var.api_resource_id, lookup(var.integration_response[count.index], "resource_id"))
  rest_api_id         = element(var.rest_api_id, lookup(var.integration_response[count.index], "rest_api_id"))
  status_code         = element(var.status_code, lookup(var.integration_response[count.index], "http_method_id"))
  response_templates  = lookup(var.integration_response[count.index], "response_templates", null)
  response_parameters = lookup(var.integration_response[count.index], "response_parameters", null)
  content_handling    = lookup(var.integration_response[count.index], "content_handling", null)
}