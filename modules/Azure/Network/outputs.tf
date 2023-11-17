output "application_gateway" {
  value = try(
    azurerm_application_gateway.this
  )
}

output "application_security_group" {
  value = try(
    azurerm_application_security_group.this
  )
}

output "bastion_host" {
  value = try(
    azurerm_bastion_host.this
  )
}

output "express_route" {
  value = try(
    azurerm_express_route_port.this,
    azurerm_express_route_circuit.this,
    azurerm_express_route_circuit_peering.this,
    azurerm_express_route_gateway.this,
    azurerm_traffic_manager_external_endpoint.this,
    azurerm_express_route_port_authorization.this,
    azurerm_express_route_connection.this,
    azurerm_express_route_circuit_connection.this,
    azurerm_express_route_circuit_authorization.this
  )
}

output "firewall" {
  value = try(
    azurerm_firewall.this,
    azurerm_firewall_policy_rule_collection_group.this,
    azurerm_firewall_network_rule_collection.this,
    azurerm_firewall_policy.this,
    azurerm_firewall_nat_rule_collection.this,
    azurerm_firewall_application_rule_collection.this
  )
}

output "frontdoor" {
  value = try(
    azurerm_frontdoor.this,
    azurerm_frontdoor_rules_engine.this,
    azurerm_frontdoor_firewall_policy.this,
    azurerm_frontdoor_custom_https_configuration.this
  )
}

output "ip" {
  value = try(
    azurerm_public_ip.this,
    azurerm_ip_group.this,
    azurerm_public_ip_prefix.this,
    azurerm_ip_group_cidr.this
  )
}

output "network_interface" {
  value = try(
    azurerm_network_interface_application_gateway_backend_address_pool_association.this,
    azurerm_network_interface.this,
    azurerm_network_interface_application_security_group_association.this,
    azurerm_network_interface_backend_address_pool_association.this,
    azurerm_network_interface_nat_rule_association.this,
    azurerm_network_interface_security_group_association.this
  )
}

output "nat_gateway" {
  value = try(
    azurerm_nat_gateway.this,
    azurerm_nat_gateway_public_ip_prefix_association.this,
    azurerm_nat_gateway_public_ip_association.this
  )
}

output "network_manager" {
  value = try(
    azurerm_network_manager.this,
    azurerm_network_manager_connectivity_configuration.this,
    azurerm_network_manager_network_group.this,
    azurerm_network_manager_security_admin_configuration.this,
    azurerm_network_manager_admin_rule_collection.this,
    azurerm_network_manager_subscription_connection.this,
    azurerm_network_manager_static_member.this,
    azurerm_network_manager_scope_connection.this,
    azurerm_network_manager_management_group_connection.this,
    azurerm_network_manager_deployment.this
  )
}

output "route" {
  value = try(
    azurerm_route.this,
    azurerm_route_table.this,
    azurerm_route_map.this,
    azurerm_route_filter.this,
    azurerm_route_server.this,
    azurerm_route_server_bgp_connection.this
  )
}

output "traffic_manager" {
  value = try(
    azurerm_traffic_manager_profile.this,
    azurerm_traffic_manager_external_endpoint.this,
    azurerm_traffic_manager_nested_endpoint.this,
    azurerm_traffic_manager_azure_endpoint.this
  )
}

output "virtual_hub" {
  value = try(
    azurerm_virtual_hub.this,
    azurerm_virtual_hub_route_table.this,
    azurerm_virtual_hub_connection.this,
    azurerm_virtual_hub_security_partner_provider.this,
    azurerm_virtual_hub_route_table_route.this,
    azurerm_virtual_hub_ip.this,
    azurerm_virtual_hub_bgp_connection.this
  )
}

output "vpn" {
  value = try(
    azurerm_vpn_site.this,
    azurerm_vpn_server_configuration.this,
    azurerm_vpn_gateway_nat_rule.this,
    azurerm_vpn_server_configuration_policy_group.this,
    azurerm_vpn_gateway_connection.this,
    azurerm_point_to_site_vpn_gateway.this
  )
}