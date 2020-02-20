output "container_group_id" {
  value = azurerm_container_group.container_group.*.id
}

output "container_group_container" {
  value = azurerm_container_group.container_group.*.container
}

output "container_group_name" {
  value = azurerm_container_group.container_group.*.name
}