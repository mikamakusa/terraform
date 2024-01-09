data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_key_vault" "this" {
  count               = var.keyvault_name == null ? 0 : 1
  name                = var.keyvault_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_key_vault_key" "this" {
  count        = var.keyvault_key_name == null ? 0 : 1
  key_vault_id = data.azurerm_key_vault.this.id
  name         = var.keyvault_key_name
}

data "azurerm_shared_image_gallery" "this" {
  count               = var.image_gallery == null ? 0 : 1
  name                = var.image_gallery
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_storage_account" "this" {
  count               = var.storage_account == null ? 0 : 1
  name                = var.storage_account
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_storage_container" "this" {
  count                = var.storage_account_container == null ? 0 : 1 && var.storage_account != null
  name                 = var.storage_account_container
  storage_account_name = data.azurerm_storage_account.this.name
}

data "azurerm_storage_blob" "this" {
  count                  = var.blob_name == null ? 0 : 1 && var.storage_account != null && var.storage_account_container != null
  name                   = var.blob_name
  storage_account_name   = data.azurerm_storage_account.this.name
  storage_container_name = data.azurerm_storage_container.this.name
}