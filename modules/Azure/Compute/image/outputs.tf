output "id" {
  value = azurerm_image.image.*.id
}