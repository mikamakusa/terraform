resource "google_deployment_manager_deployment" "deployment" {
  count         = length(var.deployment)
  name          = lookup(var.deployment[count.index], "name")
  description   = lookup(var.deployment[count.index], "description", null)
  create_policy = lookup(var.deployment[count.index], "create_policy", null)
  delete_policy = lookup(var.deployment[count.index], "delete_policy", null)
  preview       = lookup(var.deployment[count.index], "preview", false)
  project       = var.project

  dynamic "labels" {
    for_each = lookup(var.deployment[count.index], "labels")
    content {
      key   = lookup(labels.value, "key")
      value = lookup(labels.value, "value")
    }
  }

  dynamic "target" {
    for_each = [for t in lookup(var.deployment[count.index], "target") : {
      imports = lookup(t, "imports")
      config  = lookup(t, "config")
    }]
    content {
      dynamic "imports" {
        for_each = target.value.imports == null ? [] : [for i in target.value.imports : {
          name = i.name
          content = i.content
        }]
        content {
          name = imports.value.name
          content = element(var.content, imports.value.content)
        }
      }
      dynamic "config" {
        for_each = target.value.config == null ? [] : [for c in target.value.config : {
          content = c.content
        }]
        content {
          content = element(var.content, config.value.content)
        }
      }
    }
  }
}
