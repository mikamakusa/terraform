output "resource_group" {
  value = azurerm_resource_group.this
}

output "virtual_network" {
  value = azurerm_virtual_network.this
}

output "subnet" {
  value = azurerm_subnet.this
}

output "network_security_group" {
  value = azurerm_network_security_group.this
}

output "groups" {
  value = azuread_group.this
}

output "users" {
  value = azuread_user.this
}

output "adds" {
  value = azurerm_active_directory_domain_service.this
}