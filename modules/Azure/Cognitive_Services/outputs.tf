output "cognitive_account" {
  value = try(azurerm_cognitive_account.this)
}

output "cognitive_account_customer_managed_key" {
  value = try(azurerm_cognitive_account_customer_managed_key.this)
}

output "cognitive_deployment" {
  value = try(azurerm_cognitive_deployment.this)
}