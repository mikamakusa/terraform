resource "alicloud_vpc" "this" {
  count                = length(var.vpc)
  vpc_name             = lookup(var.vpc[count.index], "vpc_name")
  cidr_block           = lookup(var.vpc[count.index], "cidr_block")
  classic_link_enabled = lookup(var.vpc[count.index], "classic_link_enabled")
  description          = lookup(var.vpc[count.index], "description")
  dry_run              = lookup(var.vpc[count.index], "dry_run")
  enable_ipv6          = lookup(var.vpc[count.index], "enable_ipv6")
  ipv6_isp             = lookup(var.vpc[count.index], "ipv6_isp")
  resource_group_id    = lookup(var.vpc[count.index], "resource_group_id")
  tags = merge(
    var.tags,
    lookup(var.vpc[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
  user_cidrs = lookup(var.vpc[count.index], "user_cidrs")
}

resource "alicloud_vswitch" "this" {
  count                = length(var.vswitch)
  vswitch_name         = lookup(var.vswitch[count.index], "vswitch_name")
  cidr_block           = lookup(var.vswitch[count.index], "cidr_block")
  vpc_id               = var.vpcs ? data.alicloud_vpcs.this.vpcs.0.id : element(alicloud_vpc.this.*.id, lookup(var.vswitch[count.index], "vpc_id"))
  description          = lookup(var.vswitch[count.index], "description")
  zone_id              = data.alicloud_zones.this.zones.0.id
  enable_ipv6          = lookup(var.vswitch[count.index], "enable_ipv6")
  ipv6_cidr_block_mask = lookup(var.vswitch[count.index], "ipv6_cidr_block_mask")
  tags = merge(
    var.tags,
    lookup(var.vswitch[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "alicloud_cen_instance" "this" {
  count             = length(var.cen_instance)
  cen_instance_name = lookup(var.cen_instance[count.index], "cen_instance_name")
  name              = lookup(var.cen_instance[count.index], "name")
  description       = lookup(var.cen_instance[count.index], "description")
  tags              = merge(
    var.tags,
    lookup(var.cen_instance[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
  protection_level  = lookup(var.cen_instance[count.index], "protection_level")
}

resource "alicloud_cen_transit_router" "this" {
  count                      = length(var.cen_transit_router)
  cen_id                     = try(
    data.alicloud_cen_instances.this.instances.0.id,
    element(alicloud_cen_instance.this.*.id, lookup(var.cen_transit_router[count.index], "cen_id"))
  )
  transit_router_name        = lookup(var.cen_transit_router[count.index], "transit_router_name")
  transit_router_description = lookup(var.cen_transit_router[count.index], "transit_router_description")
  support_multicast          = lookup(var.cen_transit_router[count.index], "support_multicast")
  dry_run                    = lookup(var.cen_transit_router[count.index], "dry_run")
  tags                       = merge(
    var.tags,
    lookup(var.cen_transit_router[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "alicloud_cen_transit_router_cidr" "this" {
  count                    = length(var.cen_transit_router_cidr)
  cidr                     = lookup(var.cen_transit_router_cidr[count.index], "cidr")
  transit_router_id        = try(
    data.alicloud_cen_transit_routers.this.transit_routers.0.id,
    element(alicloud_cen_transit_router.this.*.id, lookup(var.cen_transit_router_cidr[count.index], "transit_router_id"))
  )
  transit_router_cidr_name = lookup(var.cen_transit_router_cidr[count.index], "transit_router_cidr_name")
  description              = lookup(var.cen_transit_router_cidr[count.index], "description")
  publish_cidr_route       = lookup(var.cen_transit_router_cidr[count.index], "publish_cidr_route")
}

resource "alicloud_cen_transit_router_vpn_attachment" "this" {
  count                                 = length(var.cen_transit_router_vpn_attachment)
  transit_router_id                     = try(
    data.alicloud_cen_transit_routers.this.transit_routers.0.id,
    element(alicloud_cen_transit_router.this.*.id, element(var.cen_transit_router_vpn_attachment[count.index], "transit_router_id"))
  )
  vpn_id                                = try(
    data.alicloud_vpn_gateway_vpn_attachments.this.attachments.0.id,
    element(alicloud_vpn_gateway_vpn_attachment.this.*.id, lookup(var.cen_transit_router_vpn_attachment[count.index], "vpn_id"))
  )
  auto_publish_route_enabled            = lookup(var.cen_transit_router_vpn_attachment[count.index], "auto_publish_route_enabled")
  cen_id                                = try(
    data.alicloud_cen_instances.this.instances.0.id,
    element(alicloud_cen_instance.this.*.id, lookup(var.cen_transit_router_vpn_attachment[count.index], "cen_id"))
  )
  transit_router_attachment_description = lookup(var.cen_transit_router_vpn_attachment[count.index], "transit_router_attachment_description")
  transit_router_attachment_name        = lookup(var.cen_transit_router_vpn_attachment[count.index], "transit_router_attachment_name")
  vpn_owner_id                          = lookup(var.cen_transit_router_vpn_attachment[count.index], "vpn_owner_id")
  tags                                  = merge(
    var.tags,
    lookup(var.cen_transit_router_vpn_attachment[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )

  dynamic "zone" {
    for_each = lookup(var.cen_transit_router_vpn_attachment[count.index], "zone") == null ? [] : ["zone"]
    content {
      zone_id = lookup(zone.value, "zone_id")
    }
  }
}

resource "alicloud_vpn_gateway" "this" {
  count                = length(var.gateway)
  bandwidth            = lookup(var.gateway[count.index], "bandwidth")
  vpc_id               = try(
    data.alicloud_vpcs.this.vpcs.0.id,
    element(alicloud_vpc.this.*.id, lookup(var.gateway[count.index], "vpc_id"))
  )
  instance_charge_type = lookup(var.gateway[count.index], "instance_charge_type")
  period               = lookup(var.gateway[count.index], "period")
  enable_ipsec         = lookup(var.gateway[count.index], "enable_ipsec")
  enable_ssl           = lookup(var.gateway[count.index], "enable_ssl")
  ssl_connections      = lookup(var.gateway[count.index], "ssl_connections")
  description          = lookup(var.gateway[count.index], "description")
  vswitch_id           = try(
    data.alicloud_vswitches.this.vswitches.0.id,
    element(alicloud_vswitch.this.*.id, lookup(var.gateway[count.index], "vswitch_id"))
  )
  tags                 = merge(
    var.tags,
    lookup(var.cen_transit_router_vpn_attachment[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
  auto_pay             = lookup(var.gateway[count.index], "auto_pay")
  auto_propagate       = lookup(var.gateway[count.index], "auto_propagate")
  network_type         = lookup(var.gateway[count.index], "network_type")
}

resource "alicloud_vpn_customer_gateway" "this" {
  count       = length(var.customer_gateway)
  ip_address  = lookup(var.customer_gateway[count.index], "ip_address")
  name        = lookup(var.customer_gateway[count.index], "name")
  description = lookup(var.customer_gateway[count.index], "description")
  asn         = lookup(var.customer_gateway[count.index], "asn")
}

resource "alicloud_vpn_gateway_vpn_attachment" "this" {
  count                = length(var.gateway_vpn_attachment)
  customer_gateway_id  = try(
    data.alicloud_vpn_customer_gateways.this.gateways.0.id,
    element(alicloud_vpn_customer_gateway.this.*.id, lookup(var.gateway_vpn_attachment[count.index], "customer_gateway_id"))
  )
  local_subnet         = lookup(var.gateway_vpn_attachment[count.index], "local_subnet")
  remote_subnet        = lookup(var.gateway_vpn_attachment[count.index], "remote_subnet")
  effect_immediately   = lookup(var.gateway_vpn_attachment[count.index], "effect_immediately")
  enable_dpd           = lookup(var.gateway_vpn_attachment[count.index], "enable_dpd")
  enable_nat_traversal = lookup(var.gateway_vpn_attachment[count.index], "enable_nat_traversal")
  network_type         = lookup(var.gateway_vpn_attachment[count.index], "network_type")
  vpn_attachment_name  = lookup(var.gateway_vpn_attachment[count.index], "vpn_attachment_name")

  dynamic "ike_config" {
    for_each = lookup(var.gateway_vpn_attachment[count.index], "ike_config") == null ? [] : ["ike_config"]
    content {
      psk           = lookup(ike_config.value, "psk")
      ike_version   = lookup(ike_config.value, "ike_version")
      ike_mode      = lookup(ike_config.value, "ike_mode")
      ike_enc_alg   = lookup(ike_config.value, "ike_enc_alg")
      ike_auth_alg  = lookup(ike_config.value, "ike_auth_alg")
      ike_pfs       = lookup(ike_config.value, "ike_pfs")
      ike_lifetime  = lookup(ike_config.value, "ike_lifetime")
      ike_local_id  = lookup(ike_config.value, "ike_local_id")
      ike_remote_id = lookup(ike_config.value, "ike_remote_id")
    }
  }

  dynamic "ipsec_config" {
    for_each = lookup(var.gateway_vpn_attachment[count.index], "ipsec_config") == null ? [] : ["ipsec_config"]
    content {
      ipsec_enc_alg  = lookup(ipsec_config.value, "ipsec_enc_alg")
      ipsec_auth_alg = lookup(ipsec_config.value, "ipsec_auth_alg")
      ipsec_pfs      = lookup(ipsec_config.value, "ipsec_pfs")
      ipsec_lifetime = lookup(ipsec_config.value, "ipsec_lifetime")
    }
  }

  dynamic "bgp_config" {
    for_each = lookup(var.gateway_vpn_attachment[count.index], "bgp_config") == null ? [] : ["bgp_config"]
    content {
      enable       = lookup(bgp_config.value, "enable")
      local_asn    = lookup(bgp_config.value, "local_asn")
      tunnel_cidr  = lookup(bgp_config.value, "tunnel_cidr")
      local_bgp_ip = lookup(bgp_config.value, "local_bgp_ip")
    }
  }

  dynamic "health_check_config" {
    for_each = lookup(var.gateway_vpn_attachment[count.index], "health_check_config") == null ? [] : ["health_check_config"]
    content {
      enable   = lookup(health_check_config.value, "enable")
      dip      = lookup(health_check_config.value, "dip")
      sip      = lookup(health_check_config.value, "sip")
      interval = lookup(health_check_config.value, "interval")
      retry    = lookup(health_check_config.value, "retry")
    }
  }
}

resource "alicloud_vpn_connection" "this" {
  count                = length(var.connection)
  customer_gateway_id  = try(
    data.alicloud_vpn_customer_gateways.this.gateways.0.id,
    element(alicloud_vpn_customer_gateway.this.*.id, lookup(var.connection[count.index], "customer_gateway_id"))
  )
  local_subnet         = lookup(var.connection[count.index], "local_subnet")
  remote_subnet        = lookup(var.connection[count.index], "remote_subnet")
  vpn_gateway_id       = try(
    data.alicloud_vpn_gateways.this.gateways.0.id,
    element(alicloud_vpn_gateway.this.*.id, lookup(var.connection[count.index], "vpn_gateway_id"))
  )
  effect_immediately   = lookup(var.connection[count.index], "effect_immediately")
  enable_dpd           = lookup(var.connection[count.index], "enable_dpd")
  enable_nat_traversal = lookup(var.connection[count.index], "enable_nat_traversal")


  dynamic "ike_config" {
    for_each = lookup(var.connection[count.index], "ike_config") == null ? [] : ["ike_config"]
    content {
      psk           = lookup(ike_config.value, "psk")
      ike_version   = lookup(ike_config.value, "ike_version")
      ike_mode      = lookup(ike_config.value, "ike_mode")
      ike_enc_alg   = lookup(ike_config.value, "ike_enc_alg")
      ike_auth_alg  = lookup(ike_config.value, "ike_auth_alg")
      ike_pfs       = lookup(ike_config.value, "ike_pfs")
      ike_lifetime  = lookup(ike_config.value, "ike_lifetime")
      ike_local_id  = lookup(ike_config.value, "ike_local_id")
      ike_remote_id = lookup(ike_config.value, "ike_remote_id")
    }
  }

  dynamic "ipsec_config" {
    for_each = lookup(var.connection[count.index], "ipsec_config") == null ? [] : ["ipsec_config"]
    content {
      ipsec_enc_alg  = lookup(ipsec_config.value, "ipsec_enc_alg")
      ipsec_auth_alg = lookup(ipsec_config.value, "ipsec_auth_alg")
      ipsec_pfs      = lookup(ipsec_config.value, "ipsec_pfs")
      ipsec_lifetime = lookup(ipsec_config.value, "ipsec_lifetime")
    }
  }

  dynamic "bgp_config" {
    for_each = lookup(var.connection[count.index], "bgp_config") == null ? [] : ["bgp_config"]
    content {
      enable       = lookup(bgp_config.value, "enable")
      local_asn    = lookup(bgp_config.value, "local_asn")
      tunnel_cidr  = lookup(bgp_config.value, "tunnel_cidr")
      local_bgp_ip = lookup(bgp_config.value, "local_bgp_ip")
    }
  }

  dynamic "health_check_config" {
    for_each = lookup(var.connection[count.index], "health_check_config") == null ? [] : ["health_check_config"]
    content {
      enable   = lookup(health_check_config.value, "enable")
      dip      = lookup(health_check_config.value, "dip")
      sip      = lookup(health_check_config.value, "sip")
      interval = lookup(health_check_config.value, "interval")
      retry    = lookup(health_check_config.value, "retry")
    }
  }
}

resource "alicloud_ssl_vpn_server" "this" {
  count          = length(var.ssl_vpn_server)
  client_ip_pool = lookup(var.ssl_vpn_server[count.index], "client_ip_pool")
  local_subnet   = lookup(var.ssl_vpn_server[count.index], "local_subnet")
  vpn_gateway_id = try(
    data.alicloud_vpn_gateways.this.gateways.0.id,
    element(alicloud_vpn_gateway.this.*.id, lookup(var.ssl_vpn_server[count.index], "vpn_gateway_id"))
  )
  name           = lookup(var.ssl_vpn_server[count.index], "name")
  protocol       = lookup(var.ssl_vpn_server[count.index], "protocol")
  cipher         = lookup(var.ssl_vpn_server[count.index], "cipher")
  port           = lookup(var.ssl_vpn_server[count.index], "port")
  compress       = lookup(var.ssl_vpn_server[count.index], "compress")
}

resource "alicloud_ssl_vpn_client_cert" "this" {
  count             = length(var.ssl_vpn_client_cert)
  ssl_vpn_server_id = try(
    data.alicloud_ssl_vpn_servers.this.servers.0.id,
    element(alicloud_ssl_vpn_server.this.*.id, lookup(var.ssl_vpn_client_cert[count.index], "ssl_vpn_server_id"))
  )
  name              = lookup(var.ssl_vpn_client_cert[count.index], "name")
}

resource "alicloud_vpn_gateway_vco_route" "this" {
  count             = length(var.gateway_vco_route)
  next_hop          = try(
    data.alicloud_cen_transit_router_vpn_attachments.this.attachments.0.vpn_id,
    element(alicloud_cen_transit_router_vpn_attachment.this.*.vpn_id, lookup(var.gateway_vco_route,[count.index], "vpn_id"))
  )
  route_dest        = lookup(var.gateway_vco_route[count.index], "route_dest")
  vpn_connection_id = try(
    data.alicloud_cen_transit_router_vpn_attachments.this.attachments.0.vpn_id,
    element(alicloud_cen_transit_router_vpn_attachment.this.*.vpn_id, lookup(var.gateway_vco_route,[count.index], "vpn_id"))
  )
  weight            = lookup(var.gateway_vco_route[count.index], "weight")
}

resource "alicloud_vpn_ipsec_server" "this" {
  count              = length(var.ipsec_server)
  client_ip_pool     = lookup(var.ipsec_server[count.index], "client_ip_pool")
  local_subnet       = lookup(var.ipsec_server[count.index], "local_subnet")
  vpn_gateway_id     = try(
    data.alicloud_vpn_gateways.this.gateways.0.id,
    element(alicloud_vpn_gateway.this.*.id, lookup(var.ipsec_server[count.index], "vpn_gateway_id"))
  )
  dry_run            = lookup(var.ipsec_server[count.index], "dry_run")
  effect_immediately = lookup(var.ipsec_server[count.index], "effect_immediately")
  ipsec_server_name  = lookup(var.ipsec_server[count.index], "ipsec_server_name")
  psk                = lookup(var.ipsec_server[count.index], "psk")
  psk_enabled        = lookup(var.ipsec_server[count.index], "psk_enabled")

  dynamic "ike_config" {
    for_each = lookup(var.ipsec_server[count.index], "ike_config") == null ? [] : ["ike_config"]
    content {
      psk           = lookup(ike_config.value, "psk")
      ike_version   = lookup(ike_config.value, "ike_version")
      ike_mode      = lookup(ike_config.value, "ike_mode")
      ike_enc_alg   = lookup(ike_config.value, "ike_enc_alg")
      ike_auth_alg  = lookup(ike_config.value, "ike_auth_alg")
      ike_pfs       = lookup(ike_config.value, "ike_pfs")
      ike_lifetime  = lookup(ike_config.value, "ike_lifetime")
      ike_local_id  = lookup(ike_config.value, "ike_local_id")
      ike_remote_id = lookup(ike_config.value, "ike_remote_id")
    }
  }

  dynamic "ipsec_config" {
    for_each = lookup(var.ipsec_server[count.index], "ipsec_config") == null ? [] : ["ipsec_config"]
    content {
      ipsec_enc_alg  = lookup(ipsec_config.value, "ipsec_enc_alg")
      ipsec_auth_alg = lookup(ipsec_config.value, "ipsec_auth_alg")
      ipsec_pfs      = lookup(ipsec_config.value, "ipsec_pfs")
      ipsec_lifetime = lookup(ipsec_config.value, "ipsec_lifetime")
    }
  }
}

resource "alicloud_vpn_pbr_route_entry" "this" {
  count          = length(var.pbr_route_entry)
  next_hop       = try(
    data.alicloud_vpn_connections.this.connections.0.id,
    element(alicloud_vpn_connection.this.*.id, lookup(var.pbr_route_entry[count.index], "connection_id"))
  )
  publish_vpc    = lookup(var.pbr_route_entry[count.index], "publish_vpc")
  route_dest     = lookup(var.pbr_route_entry[count.index], "route_dest")
  route_source   = lookup(var.pbr_route_entry[count.index], "route_source")
  vpn_gateway_id = try(
    data.alicloud_vpn_gateways.this.gateways.0.id,
    element(alicloud_vpn_gateway.this.*.id, lookup(var.pbr_route_entry[count.index], "vpn_gateway_id"))
  )
  weight         = lookup(var.pbr_route_entry[count.index], "weight")
}

resource "alicloud_vpn_route_entry" "this" {
  count          = length(var.route_entry)
  next_hop       = lookup(var.route_entry[count.index], "next_hop")
  publish_vpc    = lookup(var.route_entry[count.index], "publish_vpc")
  route_dest     = lookup(var.route_entry[count.index], "route_dest")
  vpn_gateway_id = try(
    data.alicloud_vpn_gateways.this.gateways.0.id,
    element(alicloud_vpn_gateway.this.*.id, lookup(var.route_entry[count.index], "vpn_gateway_id"))
  )
  weight         = lookup(var.route_entry[count.index], "weight")
}