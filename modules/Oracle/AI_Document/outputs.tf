output "model" {
  value = try(
    oci_ai_document_model.this
  )
}

output "processor_job" {
  value = try(
    oci_ai_document_processor_job.this
  )
}

output "project" {
  value = try(
    oci_ai_document_project.this
  )
}