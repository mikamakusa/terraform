resource "azurerm_api_management_api_operation_policy" "api_operation_policy" {
  count               = length(var.api_operation_policy)
  api_management_name = element(var.api_management_name, lookup(var.api_operation_policy[count.index], "api_management_id"))
  api_name            = element(var.api_name, lookup(var.api_operation_policy[count.index], "api_management_id"))
  operation_id        = element(var.operation_id, lookup(var.api_operation_policy[count.index], "operation_id"))
  resource_group_name = var.resource_group_name
  xml_content         = file(join("/", [path.cwd, "file", join(".", [lookup(var.api_operation_policy[count.index], "xml_content"), "xml"])]))
}