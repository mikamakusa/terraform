output "registry_id" {
  value = azurerm_container_registry.registry.*.id
}

output "registry_name" {
  value = azurerm_container_registry.registry.*.name
}