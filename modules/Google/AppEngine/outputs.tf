output "application_id" {
  value = try(
    google_app_engine_application.this.*.id
  )
}

output "standard_app_version_version_id" {
  value = try(google_app_engine_standard_app_version.this.*.version_id)
}

output "standard_app_version_runtime" {
  value = try(google_app_engine_standard_app_version.this.*.runtime)
}

output "service_split_traffic" {
  value = try(google_app_engine_service_split_traffic.this)
}

output "service_network_settings" {
  value = try(google_app_engine_service_network_settings.this)
}

output "flexible_app_version_version_id" {
  value = try(google_app_engine_flexible_app_version.this.*.version_id)
}

output "flexible_app_version_version_runtime" {
  value = try(google_app_engine_flexible_app_version.this.*.runtime)
}

output "firewall_rules" {
  value = try(google_app_engine_firewall_rule.this)
}

output "domain_mapping" {
  value = try(google_app_engine_domain_mapping.this)
}

output "url_dispatch_rules" {
  value = try(google_app_engine_application_url_dispatch_rules.this)
}