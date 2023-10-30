data "azuread_service_principal" "this" {
  display_name = var.service_principal
}

data "azurerm_resource_group" "this" {
  count = var.resource_group_name ? 1 : 0
  name  = var.resource_group_name
}

data "azurerm_role_definition" "this" {
  count = var.role_assignment_name ? 1 : 0
  name  = var.role_assignment_name
}

data "azurerm_virtual_desktop_host_pool" "this" {
  count               = var.host_pool_name ? 1 : 0
  name                = var.host_pool_name
  resource_group_name = data.azurerm_resource_group.this.name
}