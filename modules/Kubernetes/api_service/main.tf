resource "kubernetes_api_service" "api_service" {
  count = length(var.api_service)
  dynamic "metadata" {
    for_each = lookup(var.api_service[count.index], "metadata")
    content {
      annotations {}
      labels {}
      generate_name = lookup(metadata.value, "generate_name")
      name          = lookup(metadata.value, "name")
    }
  }
  dynamic "spec" {
    for_each = lookup(var.api_service[count.index], "spec")
    content {
      group                    = lookup(spec.value.content, "group")
      group_priority_minimum   = lookup(spec.value.content, "group_priority_minimum")
      version                  = lookup(spec.value.content, "version")
      version_priority         = lookup(spec.value.content, "version_priority")
      ca_bundle                = lookup(spec.value.content, "ca_bundle")
      insecure_skip_tls_verify = lookup(spec.value.content, "insecure_skip_tls_verify")
      service {
        name      = lookup(spec.value.content, "name")
        namespace = lookup(spec.value.content, "namespace")
      }
    }
  }
}