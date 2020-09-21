resource "google_app_engine_domain_mapping" "domain_mapping" {
  count             = length(var.domain_mapping)
  domain_name       = lookup(var.domain_mapping[count.index], "domain_name")
  project           = var.project
  override_strategy = lookup(var.domain_mapping[count.index], "override_strategy", "OVERRIDE")

  dynamic "ssl_settings" {
    for_each = lookup(var.domain_mapping[count.index], "ssl_settings")
    content {
      certificate_id      = lookup(ssl_settings.value, "certificate_id")
      ssl_management_type = lookup(ssl_settings.value, "ssl_management_type", "AUTOMATIC")
    }
  }
}
