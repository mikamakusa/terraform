output "id" {
  value = digitalocean_container_registry.container_registry.*.id
}

output "name" {
  value = digitalocean_container_registry.container_registry.*.name
}

output "endpoint" {
  value = digitalocean_container_registry.container_registry.*.endpoint
}

output "server_url" {
  value = digitalocean_container_registry.container_registry.*.server_url
}