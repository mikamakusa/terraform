output "repository" {
  value = try(
    oci_artifacts_repository.this
  )
}

output "generic_artifact" {
  value = try(
    oci_artifacts_generic_artifact.this
  )
}

output "container_repository" {
  value = try(
    oci_artifacts_container_repository.this
  )
}

output "container_image_signature" {
  value = try(
    oci_artifacts_container_image_signature.this
  )
}

output "container_configuration" {
  value = try(oci_artifacts_container_configuration.this)
}