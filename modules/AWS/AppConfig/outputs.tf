output "application_id" {
  value = try(aws_appconfig_application.this.*.id)
}

output "configuration_profile_id" {
  value = try(aws_appconfig_configuration_profile.this.*.id)
}

output "extension_id" {
  value = try(aws_appconfig_extension.this.*.id)
}

output "environment_id" {
  value = try(aws_appconfig_environment.this.*.id)
}

output "deployment" {
  value = try(aws_appconfig_deployment.this, aws_appconfig_deployment_strategy.this)
}
