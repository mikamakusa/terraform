output "identity_provider" {
  value = try(
    azurerm_api_management_identity_provider_twitter.this,
    azurerm_api_management_identity_provider_microsoft.this,
    azurerm_api_management_identity_provider_google.this,
    azurerm_api_management_identity_provider_facebook.this,
    azurerm_api_management_identity_provider_aadb2c.this,
    azurerm_api_management_identity_provider_aad.this
  )
}

output "api_management" {
  value = try(azurerm_api_management.this)
}

output "api_management_api" {
  value = try(
    azurerm_api_management_api.this,
    azurerm_api_management_api_tag.this,
    azurerm_api_management_api_version_set.this,
    azurerm_api_management_api_tag_description.this,
    azurerm_api_management_api_schema.this,
    azurerm_api_management_api_operation_policy.this,
    azurerm_api_management_api_operation.this,
    azurerm_api_management_api_operation_tag.this,
    azurerm_api_management_api_diagnostic.this,
    azurerm_api_management_api_release.this,
    azurerm_api_management_api_policy.this
  )
}

output "api_management_logger" {
  value = try(azurerm_api_management_logger.this)
}

output "diagnostic" {
  value = try(azurerm_api_management_api_diagnostic.this)
}

output "operation" {
  value = try(
    azurerm_api_management_api_operation.this,
    azurerm_api_management_api_operation_tag.this,
    azurerm_api_management_api_operation_policy.this
  )
}