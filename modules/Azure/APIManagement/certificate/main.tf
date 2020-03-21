resource "azurerm_api_management_certificate" "certificate" {
  count               = length(var.certificate)
  api_management_name = element(var.api_management_name, lookup(var.certificate[count.index], "api_management_id"))
  data                = filebase64sha256(lookup(var.certificate[count.index], "data"))
  name                = lookup(var.certificate[count.index], "name")
  resource_group_name = var.resource_group_name
  password            = lookup(var.certificate[count.index], "password")
}