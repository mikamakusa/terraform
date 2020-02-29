output "vault_uri" {
  value = azurerm_key_vault.key_vault.*.vault_uri
}

output "id" {
  value = azurerm_key_vault.key_vault.*.id
}