output "address_group" {
  value = try(
    google_network_security_address_group.this.*.id,
    google_network_security_address_group.this.*.name,
    google_network_security_address_group.this.*.location,
    google_network_security_address_group.this.*.type,
    google_network_security_address_group_iam_binding.this.*.name,
    google_network_security_address_group_iam_binding.this.*.members,
    google_network_security_address_group_iam_binding.this.*.role
  )
}


output "authorization_policy" {
  value = try(
    google_network_security_authorization_policy.this.*.name,
    google_network_security_authorization_policy.this.*.rules,
    google_network_security_authorization_policy.this.*.action
  )
}

output "client_tls_policy" {
  value = try(
    google_network_security_client_tls_policy.this
  )
}

output "server_tls_policy" {
  value = try(
    google_network_security_server_tls_policy.this
  )
}

output "tls_inspection_policy" {
  value = try(
    google_network_security_tls_inspection_policy.this.*.name,
    google_network_security_tls_inspection_policy.this.*.exclude_public_ca_set,
    google_network_security_tls_inspection_policy.this.*.location,
    google_network_security_tls_inspection_policy.this.*.exclude_public_ca_set,
    google_network_security_tls_inspection_policy.this.*.ca_pool
  )
}

output "gateway_security_policy" {
  value = try(
    google_network_security_gateway_security_policy.this.*.name,
    google_network_security_gateway_security_policy.this.*.tls_inspection_policy,
    google_network_security_gateway_security_policy_rule.this.*.application_matcher,
    google_network_security_gateway_security_policy_rule.this.*.name,
    google_network_security_gateway_security_policy_rule.this.*.basic_profile,
    google_network_security_gateway_security_policy_rule.this.*.session_matcher,
    google_network_security_gateway_security_policy_rule.this.*.tls_inspection_enabled
  )
}