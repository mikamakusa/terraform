output "id" {
  value = azurerm_api_management_api_operation_policy.api_operation_policy.*.id
}