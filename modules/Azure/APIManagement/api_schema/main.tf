resource "azurerm_api_management_api_schema" "api_schema" {
  count               = length(var.api_schema)
  api_management_name = element(var.api_management_name, lookup(var.api_schema[count.index], "api_management_id"))
  api_name            = element(var.api_name, lookup(var.api_schema[count.index], "api_management_id"))
  content_type        = lookup(var.api_schema[count.index], "content_type")
  resource_group_name = var.resource_group_name
  schema_id           = lookup(var.api_schema[count.index], "schema_id")
  value               = file(join("/", [path.cwd, "file", lookup(var.api_schema[count.index], "value")]))
}