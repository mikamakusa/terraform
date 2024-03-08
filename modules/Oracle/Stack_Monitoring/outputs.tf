output "metric_extension" {
  value = try(
    oci_stack_monitoring_metric_extension.this,
    oci_stack_monitoring_metric_extensions_test_management.this,
    oci_stack_monitoring_metric_extension_metric_extension_on_given_resources_management.this
  )
}

output "monitored_resources" {
  value = try(
    oci_stack_monitoring_monitored_resources_search_association.this,
    oci_stack_monitoring_monitored_resources_search.this,
    oci_stack_monitoring_monitored_resource.this,
    oci_stack_monitoring_monitored_resources_list_member.this,
    oci_stack_monitoring_monitored_resources_associate_monitored_resource.this,
    oci_stack_monitoring_monitored_resource_type.this,
    oci_stack_monitoring_monitored_resource_task.this
  )
}

output "baselineable_metric" {
  value = try(
    oci_stack_monitoring_baselineable_metric.this
  )
}

output "discovery_job" {
  value = try(
    oci_stack_monitoring_discovery_job.this
  )
}

output "monitoring_config" {
  value = try(
    oci_stack_monitoring_config.this
  )
}