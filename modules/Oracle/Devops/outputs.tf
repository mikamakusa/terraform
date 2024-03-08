output "build" {
  value = try(
    oci_devops_build_pipeline_stage.this,
    oci_devops_build_pipeline.this,
    oci_devops_build_run.this
  )
}

output "project" {
  value = try(
    oci_devops_project.this
  )
}

output "repository" {
  value = try(
    oci_devops_repository.this,
    oci_devops_repository_ref.this,
    oci_devops_repository_mirror.this
  )
}

output "deployment" {
  value = try(
    oci_devops_deployment.this,
    oci_devops_deploy_pipeline.this,
    oci_devops_deploy_stage.this,
    oci_devops_deploy_environment.this,
    oci_devops_deploy_artifact.this
  )
}

output "trigger" {
  value = try(
    oci_devops_trigger.this
  )
}

output "connection" {
  value = try(
    oci_devops_connection.this
  )
}