output "id" {
  value = azurerm_api_management_api_operation.operation.*.id
}