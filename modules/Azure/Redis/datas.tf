data "azurerm_client_config" "test" {}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_api_management" "this" {
  resource_group_name = data.azurerm_resource_group.this.name
  name = var.api_management_name
}