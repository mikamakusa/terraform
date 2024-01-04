data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "this" {
  name = var.resource_group
}

data "azurerm_cognitive_account" "this" {
  count               = var.cognitive_account_name ? 1 : 0
  name                = var.cognitive_account_name
  resource_group_name = data.azurerm_resource_group.this.name
}