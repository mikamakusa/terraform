resource "aws_api_gateway_base_path_mapping" "base_path_mapping" {
  count       = length(var.base_path_mapping)
  api_id      = element(var.rest_api_id, lookup(var.base_path_mapping[count.index], "api_id"))
  domain_name = element(var.domain_name, lookup(var.base_path_mapping[count.index], "domain_id"))
  stage_name  = element(var.stage_name, lookup(var.base_path_mapping[count.index], "stage_id"))
}