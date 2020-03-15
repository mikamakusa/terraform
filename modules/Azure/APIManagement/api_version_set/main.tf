resource "azurerm_api_management_api_version_set" "api_version_set" {
  count               = length(var.api_version_set)
  api_management_name = element(var.api_management_name, lookup(var.api_version_set[count.index], "api_management_id"))
  display_name        = lookup(var.api_version_set[count.index], "display_name")
  name                = lookup(var.api_version_set[count.index], "name")
  resource_group_name = var.resource_group_name
  versioning_scheme   = lookup(var.api_version_set[count.index], "versioning_scheme")
  description         = lookup(var.api_version_set[count.index], "description")
  version_header_name = lookup(var.api_version_set[count.index], "version_header_name")
  version_query_name  = lookup(var.api_version_set[count.index], "version_header_name") != null ? lookup(var.api_version_set[count.index], "version_query_name") : null
}