data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_log_analytics_workspace" "this" {
  name                = var.log_analythics_workspace_name
  resource_group_name = data.azurerm_resource_group.this.name
}
