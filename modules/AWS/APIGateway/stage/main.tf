resource "aws_api_gateway_stage" "stage" {
  count         = length(var.stage)
  deployment_id = element(var.deployment_id, lookup(var.stage[count.index], "deployment_id"))
  rest_api_id   = element(var.rest_api_id, lookup(var.stage[count.index], "rest_api_id"))
  stage_name    = element(var.deployment_stage_name, lookup(var.stage[count.index], "deployment_id"))
}