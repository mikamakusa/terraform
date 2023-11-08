output "app_config_environment" {
  value = try(
    ibm_app_config_environment.this
  )
}

output "app_config_collection" {
  value = try(
    ibm_app_config_collection.this
  )
}

output "app_config_snapshot" {
  value = try(
    ibm_app_config_snapshot.this
  )
}

output "app_config_segment" {
  value = try(
    ibm_app_config_segment.this
  )
}

output "app_config_property" {
  value = try(
    ibm_app_config_property.this
  )
}

output "app_config_feature" {
  value = try(
    ibm_app_config_feature.this
  )
}