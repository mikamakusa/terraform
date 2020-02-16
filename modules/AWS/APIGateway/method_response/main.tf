resource "aws_api_gateway_method_response" "method_response" {
  count       = length(var.method_response)
  http_method = element(var.http_method, lookup(var.method_response[count.index], "http_method_id"))
  resource_id = element(var.api_resource_id, lookup(var.method_response[count.index], "resource_id"))
  rest_api_id = element(var.rest_api_id, lookup(var.method_response[count.index], "rest_api_id"))
  status_code = lookup(var.method_response[count.index], "status_code")
}