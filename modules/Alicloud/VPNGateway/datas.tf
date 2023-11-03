data "alicloud_zones" "this" {
  count                       = var.available_resource_creation ? 1 : 0
  available_resource_creation = var.available_resource_creation
}

data "alicloud_vpcs" "this" {
  count      = var.vpcs ? 1 : 0
  name_regex = var.vpcs
}

data "alicloud_vswitches" "this" {
  count      = var.vswitches ? 1 : 0
  name_regex = var.vswitches
}

data "alicloud_cen_transit_router_available_resources" "this" {}

data "alicloud_vpn_gateways" "this" {
  count      = var.vpn_gateways_name ? 1 : 0
  name_regex = var.vpn_gateways_name
}

data "alicloud_vpn_gateway_vpn_attachments" "this" {
  count      = var.vpn_gateway_vpn_attachments_name ? 1 : 0
  name_regex = var.vpn_customer_gateways_name
  vpn_gateway_id = data.alicloud_vpn_gateways.this.gateways.0.id
  depends_on = [
    data.alicloud_vpn_gateways.this
  ]
}

data "alicloud_cen_instances" "this" {
  count      = var.cen_instances_name ? 1 : 0
  name_regex = var.cen_instances_name
}

data "alicloud_cen_transit_routers" "this" {
  count      = var.cen_transit_routers_name ? 1 : 0
  name_regex = var.cen_transit_routers_name
  cen_id     = data.alicloud_cen_instances.this.instances.0.id
  depends_on = [
    data.alicloud_cen_instances.this
  ]
}

data "alicloud_cen_transit_router_vpn_attachments" "this" {
  count      = var.cen_transit_router_vpn_attachments_name ? 1 : 0
  cen_id     = data.alicloud_cen_instances.this.instances.0.id
  name_regex = var.cen_transit_router_vpn_attachments_name
  depends_on = [
    data.alicloud_cen_instances.this,
    data.alicloud_cen_transit_routers.this
  ]
}

data "alicloud_vpn_customer_gateways" "this" {
  count      = var.vpn_customer_gateways_name ? 1 : 0
  name_regex = var.vpn_customer_gateways_name
}

data "alicloud_ssl_vpn_servers" "this" {
  count          = var.ssl_vpn_servers_name ? 1 : 0
  name_regex     = var.ssl_vpn_servers_name
  vpn_gateway_id = data.alicloud_vpn_gateways.this.gateways.0.id
  depends_on = [
    data.alicloud_vpn_gateways.this
  ]
}

data "alicloud_vpn_connections" "this" {
  count          = var.vpn_connections_name ? 1 : 0
  name_regex     = var.vpn_connections_name
  vpn_gateway_id = data.alicloud_vpn_gateways.this.gateways.0.id
  depends_on = [
    data.alicloud_vpn_gateways.this
  ]
}