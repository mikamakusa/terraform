resource "google_app_engine_application_url_dispatch_rules" "application_url_dispatch_rules" {
  count   = length(var.application_url_dispatch_rules)
  project = var.project

  dynamic "dispatch_rules" {
    for_each = lookup(var.application_url_dispatch_rules[count.index], "dispatch_rules")
    content {
      path    = lookup(dispatch_rules.value, "path")
      service = lookup(dispatch_rules.value, "service")
      domain  = lookup(dispatch_rules.value, "domain")
    }
  }
}
