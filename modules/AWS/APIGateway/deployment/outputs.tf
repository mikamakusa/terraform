output "deployment_id" {
  value = aws_api_gateway_deployment.deployment.*.id
}

output "deployment_stage_name" {
  value = aws_api_gateway_deployment.deployment.*.stage_name
}