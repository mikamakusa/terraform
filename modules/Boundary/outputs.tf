output "account_id" {
  value = try(
    boundary_account.this.*.id,
    boundary_account_password.this.*.id
  )
}

output "account_ldap_id" {
  value = try(
    boundary_account_ldap.this.*.id
  )
}

output "account_oidc_id" {
  value = try(
    boundary_account_oidc.this.*.id
  )
}

output "auth_method_id" {
  value = try(
    boundary_auth_method.this.*.id
  )
}

output "auth_method_ldap_id" {
  value = try(
    boundary_auth_method_ldap.this.*.id
  )
}

output "auth_method_password_id" {
  value = try(
    boundary_auth_method_password.this.*.id
  )
}

output "auth_method_oidc_id" {
  value = try(
    boundary_auth_method_oidc.this.*.id
  )
}

output "user_id" {
  value = try(
    boundary_user.this.*.id
  )
}

output "credential_library_vault_id" {
  value = try(
    boundary_credential_library_vault.this.*.id
  )
}

output "credential_store_static_id" {
  value = try(
    boundary_credential_store_static.this.*.id
  )
}

output "credential_username_password_this_id" {
  value = try(
    boundary_credential_username_password.this.*.id
  )
}

output "credential_store_vault_id" {
  value = try(
    boundary_credential_store_vault.this.*.id
  )
}

output "credential_ssh_private_key_id" {
  value = try(
    boundary_credential_ssh_private_key.this.*.id
  )
}

output "credential_library_vault_ssh_certificate_id" {
  value = try(
    boundary_credential_library_vault_ssh_certificate.this.*.id
  )
}

output "credential_json_id" {
  value = try(
    boundary_credential_json.this.*.id
  )
}

output "host_set_id" {
  value = try(
    boundary_host_set.this.*.id
  )
}

output "host_id" {
  value = try(
    boundary_host.this.*.id
  )
}

output "host_catalog_id" {
  value = try(
    boundary_host_catalog.this.*.id
  )
}

output "host_static_id" {
  value = try(
    boundary_host_static.this.*.id
  )
}

output "host_set_static_id" {
  value = try(
    boundary_host_set_static.this.*.id
  )
}

output "host_set_plugin_id" {
  value = try(
    boundary_host_set_plugin.this.*.id
  )
}

output "host_catalog_static_id" {
  value = try(
    boundary_host_catalog_static.this.*.id
  )
}

output "host_catalog_plugin_id" {
  value = try(
    boundary_host_catalog_plugin.this.*.id
  )
}