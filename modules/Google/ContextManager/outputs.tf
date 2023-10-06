output "access_policy" {
  value = try(google_access_context_manager_access_policy.this)
}

output "access_level" {
  value = try(google_access_context_manager_access_level.this)
}

output "access_level_condition" {
  value = try(google_access_context_manager_access_level_condition.this)
}

output "authorized_orgs_desc" {
  value = try(google_access_context_manager_authorized_orgs_desc.this)
}

output "iam_binding" {
  value = try(google_access_context_manager_access_policy_iam_binding.this)
}

output "gcp_user_access_binding" {
  value = try(google_access_context_manager_gcp_user_access_binding.this)
}

output "service_perimeter" {
  value = try(google_access_context_manager_service_perimeter.this)
}

output "service_perimeter_resource" {
  value = try(google_access_context_manager_service_perimeter_resource.this)
}