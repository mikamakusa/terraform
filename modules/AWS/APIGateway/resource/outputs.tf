output "resource_id" {
  value = aws_api_gateway_resource.resource.*.id
}

output "path_part" {
  value = aws_api_gateway_resource.resource.*.path_part
}