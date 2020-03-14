output "id" {
  value = azurerm_api_management_api.api_management_api.*.id
}

output "is_current" {
  value = azurerm_api_management_api.api_management_api.*.is_current
}

output "is_online" {
  value = azurerm_api_management_api.api_management_api.*.is_online
}