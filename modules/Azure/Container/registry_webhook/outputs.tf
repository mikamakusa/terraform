output "registry_webhook_id" {
  value = azurerm_container_registry_webhook.registry_webhook.*.id
}