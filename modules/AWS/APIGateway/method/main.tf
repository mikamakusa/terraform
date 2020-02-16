resource "aws_api_gateway_method" "api_method" {
  count                = length(var.method)
  authorization        = lookup(var.method[count.index], "authorization")
  http_method          = lookup(var.method[count.index], "http_method")
  resource_id          = element(var.resource_id, lookup(var.method[count.index], "resource_id"))
  rest_api_id          = element(var.rest_api_id, lookup(var.method[count.index], "rest_api_id"))
  authorizer_id        = lookup(var.method[count.index], "authorizer_id", null)
  authorization_scopes = [lookup(var.method[count.index], "authorizer_id") == "COGINTO_USER_POOLS" ? lookup(var.method[count.index], "authorization_scopes", null) : ""]
  api_key_required     = lookup(var.method[count.index], "api_key_required", null)
  request_models       = lookup(var.method[count.index], "request_models", null)
  request_parameters   = lookup(var.method[count.index], "request_parameters", null)
  request_validator_id = lookup(var.method[count.index], "request_validator_id", null)
}