output "root_resource_id" {
  value = aws_api_gateway_rest_api.rest_api.*.root_resource_id
}

output "id" {
  value = aws_api_gateway_rest_api.rest_api.*.id
}