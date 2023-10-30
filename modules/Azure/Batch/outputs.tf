output "batch_account" {
  value = try(
    azurerm_batch_account.this
  )
}

output "batch_application" {
  value = try(azurerm_batch_application.this)
}

output "batch_job" {
  value = try(
    azurerm_batch_job.this
  )
}

output "batch_certificate" {
  value = try(
    azurerm_batch_certificate.this
  )
}

output "batch_pool" {
  value = try(
    azurerm_batch_pool.this
  )
}