data "ibm_resource_instance" "this" {
  count = var.resource_instance_name ? 1 : 0
  name  = var.resource_instance_name
}

data "ibm_is_vpc" "this" {
  count = var.vpc_name ? 1 : 0
  name  = var.vpc_name
}

data "ibm_is_vpc_routing_table" "this" {
  count = var.vpc_routing_table_name ? 1 : 0
  vpc   = data.ibm_is_vpc.this.id
  name  = var.vpc_routing_table_name
}

data "ibm_is_public_gateway" "this" {
  count = var.public_gateway_name ? 1 : 0
  name  = var.public_gateway_name
}

data "ibm_is_network_acl" "this" {
  count    = var.network_acl_name ? 1 : 0
  name     = var.network_acl_name
  vpc_name = data.ibm_is_vpc.this.name
}

data "ibm_is_floating_ip" "this" {
  count = var.floatting_ip_name ? 1 : 0
  name  = var.floatting_ip_name
}

data "ibm_is_subnet" "this" {
  count = var.subnet_name ? 1 : 0
  name  = var.subnet_name
}

data "ibm_is_backup_policy" "this" {
  count = var.backup_policy_name ? 1 : 0
  name  = var.backup_policy_name
}

data "ibm_is_image" "this" {
  count = var.image_name ? 1 : 0
  name  = var.image_name
}

data "ibm_is_ssh_key" "this" {
  count = length(var.ssh_key_name)
  name  = var.ssh_key_name
}

data "ibm_is_security_group" "this" {
  count = length(var.security_group_name)
  name  = var.security_group_name
}

data "ibm_is_bare_metal_server" "this" {
  count = var.bare_metal_server_name ? 1 : 0
  name  = var.bare_metal_server_name
}

data "ibm_is_bare_metal_server_network_interface" "this" {
  count             = var.bare_metal_server_network_interface_name ? 1 : 0
  bare_metal_server = data.ibm_is_bare_metal_server.this.id
  network_interface = var.bare_metal_server_network_interface_name
}

data "ibm_is_dedicated_host_group" "this" {
  count = var.dedicated_host_group_name ? 1 : 0
  name  = var.dedicated_host_group_name
}

data "ibm_is_dedicated_host" "this" {
  count      = var.dedicated_host_name ? 1 : 0
  host_group = data.ibm_is_dedicated_host_group.this.id
  name       = var.dedicated_host_name
}

data "ibm_cos_bucket" "this" {
  count                = var.bucket_name ? 1 : 0
  bucket_name          = var.bucket_name
  resource_instance_id = data.ibm_resource_instance.this.id
}

data "ibm_is_placement_group" "this" {
  count = var.placement_group_name ? 1 : 0
  name  = var.placement_group_name
}

data "ibm_is_instance_template" "this" {
  count = var.instance_template_name ? 1 : 0
  name  = var.instance_template_name
}

data "ibm_is_instance" "this" {
  count = var.instance_name ? 1 : 0
  name  = var.instance_name
}

data "ibm_is_lb" "this" {
  count = var.lb_name ? 1 : 0
  name  = var.lb_name
}

data "ibm_is_lb_pool" "this" {
  count = var.lb_pool_name ? 1 : 0
  lb    = data.ibm_is_lb.this.id
  name  = var.lb_pool_name
}

data "ibm_is_lb_listener" "this" {
  count       = var.lb_listener_id ? 1 : 0
  lb          = data.ibm_is_lb.this.id
  listener_id = var.lb_listener_id
}

data "ibm_is_instance_group" "this" {
  count = var.instance_group_name ? 1 : 0
  name  = var.instance_group_name
}

data "ibm_is_instance_group_manager" "this" {
  count          = var.instance_group_manager_name ? 1 : 0
  instance_group = data.ibm_is_instance_group.this.id
  name           = var.instance_group_manager_name
}

data "ibm_is_instance_group_membership" "this" {
  count          = var.instance_group_membership_name ? 1 : 0
  instance_group = data.ibm_is_instance_group.this.id
  name           = var.instance_group_membership_name
}

data "ibm_is_instance_group_memberships" "this" {
  instance_group = data.ibm_is_instance_group.this.id
}

data "ibm_is_volume" "this" {
  count = var.volume_name ? 1 : 0
  name  = var.volume_name
}

data "ibm_is_subnet_reserved_ip" "this" {
  count       = var.reserved_id ? 1 : 0
  reserved_ip = var.reserved_id
  subnet      = data.ibm_is_subnet.this.id
}

data "ibm_is_virtual_endpoint_gateway" "this" {
  count = var.virtual_endpoint_gateway_name ? 1 : 0
  name  = var.virtual_endpoint_gateway_name
}

data "ibm_is_vpn_server" "this" {
  count = var.vpn_server_name ? 1 : 0
  name  = var.vpn_server_name
}

data "ibm_is_vpn_gateway" "this" {
  count            = var.vpn_gateway_name ? 1 : 0
  vpn_gateway_name = var.vpn_gateway_name
}

data "ibm_is_ike_policy" "this" {
  count = var.ike_policy_name ? 1 : 0
  name  = var.ike_policy_name
}

data "ibm_is_ipsec_policy" "this" {
  count = var.ipsec_policy_name ? 1 : 0
  name  = var.ipsec_policy_name
}