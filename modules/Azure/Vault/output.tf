output "az_secret_value" {
  value = "${azurerm_key_vault_secret.az_secret.*.value}"
}

output "az_pub_key" {
  value = "${azurerm_key_vault_key.az_key.*.e}"
}

output "az_cert_gen_data" {
  value = "${azurerm_key_vault_certificate.az_cert_gen.*.certificate_data}"
}

output "az_cert_import_data" {
  value = "${azurerm_key_vault_certificate.az_cert_import.*.certificate_data}"
}