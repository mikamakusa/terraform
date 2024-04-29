output "cloud_guard_configuration" {
  value = try(oci_cloud_guard_cloud_guard_configuration.this)
}

output "data_mask_rule" {
  value = try(oci_cloud_guard_data_mask_rule.this,)
}

output "data_source" {
  value = try(oci_cloud_guard_data_source.this)
}

output "recipe" {
  value = try(oci_cloud_guard_detector_recipe.this,oci_cloud_guard_responder_recipe.this,oci_cloud_guard_security_recipe.this)
}

output "managed_list" {
  value = try(oci_cloud_guard_managed_list.this)
}

output "security_zone" {
  value = try(oci_cloud_guard_security_zone.this)
}

output "target" {
  value = try(oci_cloud_guard_target.this)
}