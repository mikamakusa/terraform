resource "aws_api_gateway_deployment" "deployment" {
  count       = length(var.deployment)
  rest_api_id = element(var.rest_api_id, lookup(var.deployment[count.index], "rest_api_id"))
  stage_name  = lookup(var.deployment[count.index], "stage_name")
}