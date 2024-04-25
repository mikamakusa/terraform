output "bds_instance" {
  value = try(oci_bds_bds_instance.this)
}

output "bds_auto_scaling_configuration" {
  value = try(oci_bds_auto_scaling_configuration.this)
}

output "bds_instance_patch" {
  value = try(oci_bds_bds_instance_patch_action.this)
}

output "bds_metastore_config" {
  value = try(oci_bds_bds_instance_metastore_config.this)
}

output "bds_api_key" {
  value = try(oci_bds_bds_instance_api_key.this)
}