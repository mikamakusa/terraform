output "roles" {
  value = try(alicloud_ram_role.this)
}

output "policies" {
  value = try(alicloud_ram_policy.this)
}

output "policies_attachment" {
  value = try(alicloud_ram_role_policy_attachment.this)
}

output "log_projects" {
  value = try(alicloud_log_project.this)
}

output "mns_topics" {
  value = try(alicloud_mns_topic.this)
}

output "actiontrails" {
  value = try(alicloud_actiontrail.this)
}

output "global_events_storage_regions" {
  value = try(alicloud_actiontrail_global_events_storage_region.this)
}

output "history_delivery_jons" {
  value = try(alicloud_actiontrail_history_delivery_job.this)
}

output "actiontrail_trails" {
  value = try(alicloud_actiontrail_trail.this)
}