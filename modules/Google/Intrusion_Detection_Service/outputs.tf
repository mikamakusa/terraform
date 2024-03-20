output "ids_endpoint_name" {
  value = try(
    google_cloud_ids_endpoint.this.*.name
  )
}

output "ids_endpoint_network" {
  value = try(google_cloud_ids_endpoint.this.*.network)
}

output "ids_endpoint_threat_exceptions" {
  value = try(google_cloud_ids_endpoint.this.*.threat_exceptions)
}

output "global_address_name" {
  value = try(
    google_compute_global_address.this.*.name
  )
}

output "networking_connection_id" {
  value = try(
    google_service_networking_connection.this.*.id
  )
}