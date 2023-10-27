data "azurerm_resource_group" "this" {
  count = var.resource_group_name ? 1 : 0
  name  = var.resource_group_name
}

data "azurerm_user_assigned_identity" "this" {
  count               = var.user_assigned_identity_name ? 1 : 0
  name                = var.user_assigned_identity_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_role_definition" "this" {
  count = var.role_definition_name ? 1 : 0
  name  = var.role_definition_name
}

data "azurerm_management_group" "this" {
  count = var.management_group_name ? 1 : 0
  name  = var.management_group_name
}

data "azurerm_key_vault" "this" {
  count               = var.key_vault_name ? 1 : 0
  name                = var.key_vault_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_key_vault_secret" "this" {
  count        = var.vault_secret_name ? 1 : 0
  key_vault_id = data.azurerm_key_vault.this.id
  name         = var.vault_secret_name
}

data "azurerm_key_vault_key" "this" {
  count        = var.vault_key_name ? 1 : 0
  key_vault_id = data.azurerm_key_vault.this.id
  name         = var.vault_key_name
}

data "azurerm_client_config" "this" {}