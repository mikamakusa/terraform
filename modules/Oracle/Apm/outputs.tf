output "domain" {
  value = try(
    oci_apm_apm_domain.this.*.id,
    oci_apm_apm_domain.this.*.compartment_id,
    oci_apm_apm_domain.this.*.data_upload_endpoint,
    oci_apm_apm_domain.this.*.description,
    oci_apm_apm_domain.this.*.display_name,
    oci_apm_apm_domain.this.*.is_free_tier
  )
}

output "config" {
  value = try(
    oci_apm_config_config.this.*.id,
    oci_apm_config_config.this.*.display_name,
    oci_apm_config_config.this.*.description,
    oci_apm_config_config.this.*.apm_domain_id,
    oci_apm_config_config.this.*.rules,
    oci_apm_config_config.this.*.config_type,
    oci_apm_config_config.this.*.opc_dry_run
  )
}

output "dedicated_vantage_point" {
  value = try(
    oci_apm_synthetics_dedicated_vantage_point.this.*.id,
    oci_apm_synthetics_dedicated_vantage_point.this.*.display_name,
    oci_apm_synthetics_dedicated_vantage_point.this.*.apm_domain_id,
    oci_apm_synthetics_dedicated_vantage_point.this.*.dvp_stack_details
  )
}

output "synthetics_script" {
  value = try(
    oci_apm_synthetics_script.this.*.id,
    oci_apm_synthetics_script.this.*.content,
    oci_apm_synthetics_script.this.*.content_file_name,
    oci_apm_synthetics_script.this.*.content_size_in_bytes,
    oci_apm_synthetics_script.this.*.content_type
  )
}

output "synthetics_monitor" {
  value = try(
    oci_apm_synthetics_monitor.this.*.id,
    oci_apm_synthetics_monitor.this.*.availability_configuration,
    oci_apm_synthetics_monitor.this.*.batch_interval_in_seconds,
    oci_apm_synthetics_monitor.this.*.is_run_now,
    oci_apm_synthetics_monitor.this.*.is_run_once
  )
}