resource "aws_api_gateway_resource" "resource" {
  count       = length(var.resource)
  parent_id   = element(var.rest_api_root_resource_id, lookup(var.resource[count.index], "parent_id"))
  path_part   = lookup(var.resource[count.index], "path_part")
  rest_api_id = element(var.rest_api_id, lookup(var.resource[count.index], "rest_api_id"))
}