data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_application_insights" "this" {
  name                = var.application_insights
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_eventhub" "this" {
  name                = var.event_hub_name
  namespace_name      = var.event_hub_namespace
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_key_vault" "this" {
  count               = var.keyvault_name == null ? 0 : 1
  name                = var.keyvault_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_key_vault_certificate" "this" {
  count        = var.keyvault_certificate_name == null ? 0 : 1
  key_vault_id = data.azurerm_key_vault.this.id
  name         = var.keyvault_certificate_name
}

data "azurerm_redis_cache" "this" {
  count               = var.redis_cache == null ? 0 : 1
  name                = var.redis_cache
  resource_group_name = data.azurerm_resource_group.this.name
}