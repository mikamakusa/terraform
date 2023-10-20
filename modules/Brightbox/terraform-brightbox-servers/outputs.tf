output "volumes" {
  value = try(brightbox_volume.this)
}

output "servers" {
  value = try(brightbox_server.this)
}

output "load_balancer" {
  value = try(brightbox_load_balancer.this)
}

output "server_group" {
  value = try(brightbox_server_group.this)
}

output "server_group_membership" {
  value = try(brightbox_server_group_membership.this)
}