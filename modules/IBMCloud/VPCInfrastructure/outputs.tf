output "vpn_security_policies" {
  value = try(
    ibm_is_ike_policy.this,
    ibm_is_ipsec_policy.this
  )
}

output "vpn_configuration" {
  value = try(
    ibm_is_vpn_server.this,
    ibm_is_vpn_server_client.this,
    ibm_is_vpn_server_route.this,
    ibm_is_vpn_gateway.this,
    ibm_is_vpn_gateway_connection.this
  )
}

output "instance" {
  value = try(
    ibm_is_instance.this,
    ibm_is_instance_group.this,
    ibm_is_instance_group_membership.this,
    ibm_is_instance_group_manager.this,
    ibm_is_instance_template.this,
    ibm_is_instance_network_interface.this,
    ibm_is_instance_volume_attachment.this,
    ibm_is_instance_network_interface_floating_ip.this,
    ibm_is_instance_group_manager_policy.this,
    ibm_is_instance_group_manager_action.this,
    ibm_is_instance_disk_management.this,
    ibm_is_instance_action.this
  )
}

output "image" {
  value = try(
    ibm_is_image.this,
    ibm_is_image_export_job.this
  )
}

output "bare_metal_server" {
  value = try(
    ibm_is_bare_metal_server.this,
    ibm_is_bare_metal_server_disk.this,
    ibm_is_bare_metal_server_action.this,
    ibm_is_bare_metal_server_network_interface.this,
    ibm_is_bare_metal_server_network_interface_allow_float.this,
    ibm_is_bare_metal_server_network_interface_floating_ip.this
  )
}

output "vpc_configuration" {
  value = try(
    ibm_is_vpc.this,
    ibm_is_vpc_routing_table.this,
    ibm_is_vpc_routing_table_route.this,
    ibm_is_vpc_address_prefix.this,
    ibm_is_subnet.this,
    ibm_is_subnet_reserved_ip.this,
    ibm_is_subnet_routing_table_attachment.this,
    ibm_is_subnet_public_gateway_attachment.this,
    ibm_is_subnet_network_acl_attachment.this,
    ibm_is_network_acl_rule.this,
    ibm_is_security_group.this,
    ibm_is_security_group_target.this,
    ibm_is_security_group_rule.this
  )
}