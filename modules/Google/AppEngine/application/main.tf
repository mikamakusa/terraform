resource "google_app_engine_application" "application" {
  count          = length(var.application)
  project        = var.project
  location_id    = lookup(var.application[count.index], "location_id")
  auth_domain    = lookup(var.application[count.index], "auth_domain", null)
  serving_status = lookup(var.application[count.index], "serving_status", null)

  dynamic "feature_settings" {
    for_each = lookup(var.application[count.index], "feature_setting")
    content {
      split_health_checks = lookup(feature_settings.value, "split_health_checks", false)
    }
  }

  dynamic "iap" {
    for_each = lookup(var.application[count.index], "iap")
    content {
      oauth2_client_id     = lookup(iap.value, "oauth2_client_id")
      oauth2_client_secret = lookup(iap.value, "oauth2_client_secret")
    }
  }
}
