output "endpoint" {
  value = try(
    oci_ai_language_endpoint.this
  )
}

output "model" {
  value = try(
    oci_ai_language_model.this
  )
}

output "project" {
  value = try(
    oci_ai_language_project.this
  )
}