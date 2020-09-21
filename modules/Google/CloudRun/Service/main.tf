resource "google_cloud_run_service" "service" {
  count                      = length(var.service)
  location                   = var.location
  project                    = var.project
  name                       = lookup(var.service[count.index], "name")
  autogenerate_revision_name = lookup(var.service[count.index], "autogenerate_revision_name", false)

  dynamic "template" {
    for_each = [for i in lookup(var.service[count.index], "template") : {
      metadata = lookup(i, "metadata", null)
      spec     = lookup(i, "spec", null)
    }]
    content {
      dynamic "metadata" {
        for_each = template.value.metadata == null ? [] : [for m in template.value.metadata : {
          name        = m.name
          labels      = m.labels
          annotations = m.annotations
        }]
        content {
          name        = metadata.value.name
          labels      = metadata.value.labels
          annotations = metadata.value.annotations
        }
      }
      dynamic "spec" {
        for_each = template.value.spec == null ? [] : [for i in template.value.spec : {
          containers = lookup(i, "containers", null)
        }]
        content {
          dynamic "containers" {
            for_each = spec.value.containers == null ? [] : [for i in spec.value.containers : {
              image     = i.image
              args      = i.args
              command   = i.command
              env       = lookup(i, "env", null)
              resources = lookup(i, "resources", null)
            }]
            content {
              image   = containers.value.image
              args    = containers.value.args
              command = containers.value.command
              dynamic "env" {
                for_each = containers.value.env == null ? [] : [for i in containers.value.env : {
                  name  = i.name
                  value = i.value
                }]
                content {
                  name  = env.value.name
                  value = env.value.value
                }
              }

              dynamic "resources" {
                for_each = containers.value.resources == null ? [] : [for i in containers.value.resources : {
                  limits   = i.limits
                  requests = i.requests
                }]
                content {
                  limits   = resources.value.limits
                  requests = resources.value.requests
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "traffic" {
    for_each = lookup(var.service[count.index], "traffic")
    content {
      percent         = lookup(traffic.value, "percent")
      revision_name   = lookup(traffic.value, "revision_name", null)
      latest_revision = lookup(traffic.value, "latest_revision", false)
    }
  }
}
