output "ad_secret_backend" {
  value = try(
    vault_ad_secret_backend.this.*.backend
  )
}

output "ad_secret_role" {
  value = try(
    vault_ad_secret_role.this.*.role
  )
}
