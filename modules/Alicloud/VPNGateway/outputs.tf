output "vpn_gateway" {
  value = try(
    alicloud_vpn_gateway.this
  )
}

output "vpn_connection" {
  value = try(
    alicloud_vpn_connection
  )
}

output "customer_gateway" {
  value = try(
    alicloud_vpn_customer_gateway.this
  )
}

output "gateway_vpn_attachment" {
  value = try(
    alicloud_vpn_gateway_vpn_attachment.this
  )
}

output "gateway_vco_route" {
  value = try(
    alicloud_vpn_gateway_vco_route.this
  )
}

output "ssl_vpn" {
  value = try(
    alicloud_ssl_vpn_server.this,
    alicloud_ssl_vpn_client_cert.this
  )
}

output "route_entry" {
  value = try(
    alicloud_vpn_route_entry.this,
    alicloud_vpn_pbr_route_entry.this
  )
}

output "vpn_ipsec_server" {
  value = try(
    alicloud_vpn_ipsec_server.this
  )
}