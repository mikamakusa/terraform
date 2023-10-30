data "azurerm_resource_group" "this" {
  count = var.resource_group_name ? 1 : 0
  name  = var.resource_group_name
}

data "azurerm_storage_account" "this" {
  count               = var.storage_account_name ? 1 : 0
  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_batch_account" "this" {
  count               = var.batch_account_name ? 1 : 0
  name                = var.batch_account_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_user_assigned_identity" "this" {
  count               = var.user_assigned_identity_name ? 1 : 0
  name                = var.user_assigned_identity_name
  resource_group_name = data.azurerm_resource_group.this.name
}