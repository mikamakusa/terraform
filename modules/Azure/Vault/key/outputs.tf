output "id" {
  value = azurerm_key_vault_key.key.*.id
}

output "version" {
  value = azurerm_key_vault_key.key.*.version
}

output "rsa_modulus" {
  value = azurerm_key_vault_key.key.*.n
}

output "rsa_public_exponent" {
  value = azurerm_key_vault_key.key.*.e
}

output "ec_x_component" {
  value = azurerm_key_vault_key.key.*.x
}

output "ec_y_component" {
  value = azurerm_key_vault_key.key.*.y
}