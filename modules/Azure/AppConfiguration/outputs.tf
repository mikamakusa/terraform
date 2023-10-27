output "app_configuration" {
  value = try(
    azurerm_app_configuration.this,
    azurerm_app_configuration_key.this,
    azurerm_app_configuration_feature.this
  )
}

output "resource_group" {
  value = try(
    azurerm_resource_group.this
  )
}

output "vault" {
  value = try(
    azurerm_key_vault.this,
    azurerm_key_vault_key.this,
    azurerm_key_vault_secret.this,
    azurerm_key_vault_access_policy.this
  )
}