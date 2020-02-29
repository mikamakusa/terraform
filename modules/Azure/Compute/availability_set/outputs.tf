output "id" {
  value = azurerm_availability_set.availability_set.*.id
}