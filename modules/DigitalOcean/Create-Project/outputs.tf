output "project_id" {
  value = digitalocean_project.project.*.id
}

output "project_owner_id" {
  value = digitalocean_project.project.*.owner_id
}

output "project_owner_uuid" {
  value = digitalocean_project.project.*.owner_uuid
}

output "project_created_at" {
  value = digitalocean_project.project.*.created_at
}

output "project_updated_at" {
  value = digitalocean_project.project.*.updated_at
}