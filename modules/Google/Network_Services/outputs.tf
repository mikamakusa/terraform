output "edge_cache" {
  value = try(
    google_network_services_edge_cache_keyset.this,
    google_network_services_edge_cache_service.this,
    google_network_services_edge_cache_origin.this
  )
}

output "endpoint_policy" {
  value = try(
    google_network_services_endpoint_policy.this
  )
}

output "gateway" {
  value = try(
    google_network_services_gateway.this
  )
}

output "routes" {
  value = try(
    google_network_services_tls_route.this,
    google_network_services_tcp_route.this,
    google_network_services_http_route.this,
    google_network_services_grpc_route.this
  )
}

output "mesh" {
  value = try(
    google_network_services_mesh.this
  )
}

output "binding" {
  value = try(
    google_network_services_service_binding.this
  )
}