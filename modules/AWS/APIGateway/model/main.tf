resource "aws_api_gateway_model" "gateway_model" {
  count        = length(var.gateway_model)
  content_type = lookup(var.gateway_model[count.index], "content_type")
  name         = lookup(var.gateway_model[count.index], "name")
  rest_api_id  = element(var.rest_api_id, lookup(var.gateway_model[count.index], "rest_api_id"))
  schema       = file(join(".", [join("/", [path.cwd, lookup(var.gateway_model[count.index], "schema")]), ".json"]))
}
