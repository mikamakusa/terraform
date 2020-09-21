output "id" {
  value = google_deployment_manager_deployment.deployment.*.id
}

output "deployment_id" {
  value = google_deployment_manager_deployment.deployment.*.deployment_id
}

output "manifest" {
  value = google_deployment_manager_deployment.deployment.*.manifest
}

output "self_link" {
  value = google_deployment_manager_deployment.deployment.*.self_link
}
