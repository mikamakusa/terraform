output "id" {
  value = azurerm_api_management.api_management.*.id
}

output "additional_location" {
  value = azurerm_api_management.api_management.*.additional_location
}

output "gateway_url" {
  value = azurerm_api_management.api_management.*.gateway_url
}

output "gateway_regional_url" {
  value = azurerm_api_management.api_management.*.gateway_regional_url
}

output "identity" {
  value = azurerm_api_management.api_management.*.identity
}

output "portal_url" {
  value = azurerm_api_management.api_management.*.portal_url
}

output "public_ip_addresses" {
  value = azurerm_api_management.api_management.*.public_ip_addresses
}

output "scm_url" {
  value = azurerm_api_management.api_management.*.scm_url
}