output "id" {
  value = azurerm_virtual_network.virtual_network.*.id
}

output "address_space" {
  value = azurerm_virtual_network.virtual_network.*.address_space
}

output "subnet" {
  value = azurerm_virtual_network.virtual_network.*.subnet
}