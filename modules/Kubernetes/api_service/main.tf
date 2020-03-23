resource "kubernetes_api_service" "api_service" {
  count = length(var.api_service)

  dynamic "metadata" {
    for_each = [for i in lookup(var.api_service[count.index], "metadata") : {
      generate_name = i.generate_name
      name          = i.name
      annotations   = lookup(i, "annotations")
      labels        = lookup(i, "labels")
    }]
    content {
      annotations {
        variables = metadata.value.annotations
      }
      labels {
        variables = metadata.value.labels
      }
      generate_name = metadata.value.generate_name
      name          = metadata.value.name
    }
  }
  dynamic "spec" {
    for_each = [for i in lookup(var.api_service[count.index], "spec") : {
      group                    = i.group
      group_priority_minimum   = i.group_priority_minimum
      version                  = i.version
      version_priority         = i.version_priority
      ca_bundle                = i.ca_bundle
      insecure_skip_tls_verify = i.insecure_skip_tls_verify
      service                  = lookup(i, "service", null)
    }]
    content {
      group                    = spec.value.group
      group_priority_minimum   = spec.value.group_priority_minimum
      version                  = spec.value.version
      version_priority         = spec.value.version_priority
      ca_bundle                = spec.value.ca_bundle
      insecure_skip_tls_verify = spec.value.insecure_skip_tls_verify

      dynamic "service" {
        for_each = spec.value.service == null ? [] : [for i in spec.value.service : {
          name      = i.name
          namespace = i.namespace
        }]
        content {
          name      = service.value.name
          namespace = service.value.namespace
        }
      }
    }
  }
}