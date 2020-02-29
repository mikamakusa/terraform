output "id" {
  value = azurerm_key_vault_certificate.certificate.*.id
}

output "secret_id" {
  value = azurerm_key_vault_certificate.certificate.*.secret_id
}

output "version" {
  value = azurerm_key_vault_certificate.certificate.*.version
}

output "certificate_data" {
  value = azurerm_key_vault_certificate.certificate.*.certificate_data
}

output "thumbprint" {
  value = azurerm_key_vault_certificate.certificate.*.thumbprint
}