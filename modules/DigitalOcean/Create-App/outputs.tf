#default_ingress - The default URL to access the app.
#live_url - The live URL of the app.
#active_deployment_id - The ID the app's currently active deployment.
#updated_at - The date and time of when the app was last updated.
#created_at - The date and time of when the app was created.

output "default_ingress" {
  value = digitalocean_app.app.*.default_ingress
}

output "live_url" {
  value = digitalocean_app.app.*.live_url
}

output "active_deployment_id" {
  value = digitalocean_app.app.*.active_deployment_id
}

output "updated_at" {
  value = digitalocean_app.app.*.updated_at
}

output "created_at" {
  value = digitalocean_app.app.*.created_at
}