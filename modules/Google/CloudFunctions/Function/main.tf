resource "google_cloudfunctions_function" "function" {
  count                         = length(var.function)
  name                          = lookup(var.function[count.index], "name")
  region                        = lookup(var.function[count.index], "region")
  project                       = var.project_id
  description                   = lookup(var.function[count.index], "description", null)
  runtime                       = lookup(var.function[count.index], "runtime")
  available_memory_mb           = lookup(var.function[count.index], "available_memory_mb", null)
  timeout                       = lookup(var.function[count.index], "timeout", null)
  entry_point                   = lookup(var.function[count.index], "entry_point", null)
  trigger_http                  = lookup(var.function[count.index], "trigger_http", null)
  ingress_settings              = lookup(var.function[count.index], "ingress_settings", null)
  labels                        = lookup(var.function[count.index], "labels", null)
  service_account_email         = lookup(var.function[count.index], "service_account_email", null)
  environment_variables         = lookup(var.function[count.index], "environment_variables", null)
  vpc_connector                 = lookup(var.function[count.index], "vpc_connector", null)
  vpc_connector_egress_settings = lookup(var.function[count.index], "vpc_connector_egress_settings", null)
  source_archive_bucket         = lookup(var.function[count.index], "source_archive_bucket", null)
  source_archive_object         = lookup(var.function[count.index], "source_archive_object", null)
  max_instances                 = lookup(var.function[count.index], "max_instances", null)

  dynamic "event_trigger" {
    for_each = [for i in lookup(var.function[count.index], "event_trigger") : {
      event_type = i.event_type
      resource   = i.resource
    }]
    content {
      event_type = join("/", ["providers", join(".", ["cloud", event_trigger.value.event_type])])
      resource   = join("/", ["projects", var.project_id, event_trigger.value.resource])
    }
  }

  dynamic "source_repository" {
    for_each = [for i in lookup(var.function[count.index], "source_repository") : {
      url = i.url
    }]
    content {
      url = source_repository.value.url
    }
  }
}
