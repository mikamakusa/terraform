resource "google_cloud_run_domain_mapping" "domain_mapping" {
  count    = length(var.domain_mapping)
  location = var.location
  name     = lookup(var.domain_mapping[count.index], "name")
  project  = var.project

  dynamic "metadata" {
    for_each = lookup(var.domain_mapping[count.index], "metadata")
    content {
      namespace   = lookup(metadata.value, "namespace")
    }
  }

  dynamic "spec" {
    for_each = lookup(var.domain_mapping[count.index], "spec")
    content {
      route_name       = element(var.service, lookup(spec.value, "service_id"))
      force_override   = lookup(spec.value, "force_override", false)
      certificate_mode = lookup(spec.value, "certificate_mode", "NONE")
    }
  }

}
