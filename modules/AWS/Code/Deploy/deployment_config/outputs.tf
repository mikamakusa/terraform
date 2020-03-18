output "id" {
  value = aws_codedeploy_deployment_config.deployment_config.*.id
}

output "deployment_config_id" {
  value = aws_codedeploy_deployment_config.deployment_config.*.deployment_config_id
}