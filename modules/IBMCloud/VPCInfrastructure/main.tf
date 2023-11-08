resource "ibm_is_vpc" "this" {
  count                       = length(var.vpc)
  name                        = lookup(var.vpc[count.index], "name")
  access_tags                 = lookup(var.vpc[count.index], "access_tags")
  address_prefix_management   = lookup(var.vpc[count.index], "address_prefix_management")
  classic_access              = lookup(var.vpc[count.index], "classic_access")
  default_network_acl_name    = lookup(var.vpc[count.index], "default_network_acl_name")
  default_routing_table_name  = lookup(var.vpc[count.index], "default_routing_table_name")
  default_security_group_name = lookup(var.vpc[count.index], "default_security_group_name")
  tags                        = lookup(var.vpc[count.index], "tags")

  dynamic "dns" {
    for_each = lookup(var.vpc[count.index], "dns") == null ? [] : ["dns"]
    content {
      enable_hub = lookup(dns.value, "enable_hub")
      type       = lookup(dns.value, "type")
      vpc_id     = lookup(dns.value, "vpc_id")
      vpc_crn    = lookup(dns.value, "vpc_crn")

      dynamic "resolver" {
        for_each = lookup(dns.value, "resolver") == null ? [] : ["resolver"]
        content {
          dynamic "manual_server" {
            for_each = lookup(resolver.value, "manual_server") == null ? [] : ["manual_server"]
            content {
              address       = lookup(manual_server.value, "address")
              zone_affinity = lookup(manual_server.value, "zone_affinity")
            }
          }
        }
      }
    }
  }
}

resource "ibm_is_vpc_address_prefix" "this" {
  count = length(var.vpc_address_prefix) == "0" ? "0" : (length(var.vpc) || data.ibm_is_vpc)
  cidr  = lookup(var.vpc_address_prefix[count.index], "cidr")
  name  = lookup(var.vpc_address_prefix[count.index], "name")
  vpc = try(
    data.ibm_is_vpc.this.id,
    element(ibm_is_vpc.this.*.id, lookup(var.vpc_address_prefix[count.index], "vpc"))
  )
  zone       = lookup(var.vpc_address_prefix[count.index], "zone")
  is_default = lookup(var.vpc_address_prefix[count.index], "is_default")
}

resource "ibm_is_vpc_routing_table" "this" {
  count = length(var.vpc_routing_table) == "0" ? "0" : (length(var.vpc) || data.ibm_is_vpc)
  vpc = try(
    data.ibm_is_vpc.this.id,
    element(ibm_is_vpc.this.*.id, lookup(var.vpc_routing_table[count.index], "vpc"))
  )
  accept_routes_from_resource_type = lookup(var.vpc_routing_table[count.index], "accept_routes_from_resource_type")
  name                             = lookup(var.vpc_routing_table[count.index], "name")
  route_direct_link_ingress        = lookup(var.vpc_routing_table[count.index], "route_direct_link_ingress")
  route_internet_ingress           = lookup(var.vpc_routing_table[count.index], "route_internet_ingress")
  route_transit_gateway_ingress    = lookup(var.vpc_routing_table[count.index], "route_transit_gateway_ingress")
  route_vpc_zone_ingress           = lookup(var.vpc_routing_table[count.index], "route_vpc_zone_ingress")
}

resource "ibm_is_vpc_routing_table_route" "this" {
  count       = length(var.vpc_routing_table_route) == "0" ? "0" : (length(var.vpc) || data.ibm_is_vpc) && (length(var.vpc_routing_table) || data.ibm_is_vpc_routing_table)
  destination = lookup(var.vpc_routing_table_route[count.index], "destination")
  next_hop    = lookup(var.vpc_routing_table_route[count.index], "next_hop")
  routing_table = try(
    data.ibm_is_vpc_routing_table.this.routing_table,
    element(ibm_is_vpc_routing_table.this.*.routing_table, lookup(var.vpc_routing_table[count.index], "routing_table"))
  )
  vpc = try(
    data.ibm_is_vpc.this.id,
    element(ibm_is_vpc.this.*.id, lookup(var.vpc_routing_table[count.index], "vpc"))
  )
  zone     = lookup(var.vpc_routing_table_route[count.index], "zone")
  name     = lookup(var.vpc_routing_table_route[count.index], "name")
  priority = lookup(var.vpc_routing_table_route[count.index], "priority")
}

resource "ibm_is_public_gateway" "this" {
  count = length(var.public_gateway) == "0" ? "0" : (length(var.vpc) || data.ibm_is_vpc)
  name  = lookup(var.public_gateway[count.index], "name")
  vpc = try(
    data.ibm_is_vpc.this.id,
    element(ibm_is_vpc.this.*.id, lookup(var.public_gateway[count.index], "vpc"))
  )
  zone        = lookup(var.public_gateway[count.index], "zone")
  access_tags = lookup(var.public_gateway[count.index], "access_tags")
  floating_ip = try(
    data.ibm_is_floating_ip.this.id,
    element(ibm_is_floating_ip.this.*.id, lookup(var.public_gateway[count.index], "floatting_ip"))
  )
  id   = lookup(var.public_gateway[count.index], "id")
  tags = lookup(var.public_gateway[count.index], "tags")
}

resource "ibm_is_network_acl" "this" {
  count       = length(var.network_acl) == "0" ? "0" : (length(var.vpc) || data.ibm_is_vpc)
  access_tags = lookup(var.network_acl[count.index], "access_tags")
  name        = lookup(var.network_acl[count.index], "name")
  tags        = lookup(var.network_acl[count.index], "tags")
  vpc = try(
    data.ibm_is_vpc.this.id,
    element(ibm_is_vpc.this.*.id, lookup(var.network_acl[count.index], "vpc"))
  )

  dynamic "rules" {
    for_each = lookup(var.network_acl[count.index], "rules") == null ? [] : ["rules"]
    content {
      action      = lookup(rules.value, "action")
      destination = lookup(rules.value, "destination")
      direction   = lookup(rules.value, "direction")
      name        = lookup(rules.value, "name")
      source      = lookup(rules.value, "source")

      dynamic "udp" {
        for_each = lookup(rules.value, "udp") == null ? [] : ["udp"]
        content {
          port_max        = lookup(udp.value, "port_max")
          port_min        = lookup(udp.value, "port_min")
          source_port_max = lookup(udp.value, "source_port_max")
          source_port_min = lookup(udp.value, "source_port_min")
        }
      }

      dynamic "tcp" {
        for_each = lookup(rules.value, "tcp") == null ? [] : ["tcp"]
        content {
          port_max        = lookup(tcp.value, "port_max")
          port_min        = lookup(tcp.value, "port_min")
          source_port_max = lookup(tcp.value, "source_port_max")
          source_port_min = lookup(tcp.value, "source_port_min")
        }
      }

      dynamic "icmp" {
        for_each = lookup(rules.value, "icmp") == null ? [] : ["icmp"]
        content {
          code = lookup(icmp.value, "code")
          type = lookup(icmp.value, "type")
        }
      }
    }
  }
}

resource "ibm_is_subnet" "this" {
  count = length(var.subnet) == "0" ? "0" : (length(var.vpc) || data.ibm_is_vpc)
  name  = lookup(var.subnet[count.index], "name")
  vpc = try(
    data.ibm_is_vpc.this.id,
    element(ibm_is_vpc.this.*.id, lookup(var.subnet[count.index], "vpc"))
  )
  zone                     = lookup(var.subnet[count.index], "zone")
  access_tags              = lookup(var.subnet[count.index], "access_tags")
  ip_version               = lookup(var.subnet[count.index], "ip_version")
  ipv4_cidr_block          = lookup(var.subnet[count.index], "ipv4_cidr_block")
  total_ipv4_address_count = lookup(var.subnet[count.index], "total_ipv4_address_count")
  public_gateway = try(
    data.ibm_is_public_gateway.this.id,
    element(ibm_is_public_gateway.this.*.id, lookup(var.subnet[count.index], "public_gateway"))
  )
  routing_table = try(
    data.ibm_is_vpc_routing_table.this.routing_table,
    element(ibm_is_vpc_routing_table.this.*.routing_table, lookup(var.subnet[count.index], "routing_table"))
  )
  network_acl = try(
    data.ibm_is_network_acl.this.id,
    element(ibm_is_network_acl.this.*.id, lookup(var.subnet[count.index], "network_acl"))
  )
  tags = lookup(var.subnet[count.index], "tags")
}

resource "ibm_is_subnet_network_acl_attachment" "this" {
  count = length(var.subnet_network_acl_attachment) == "0" ? "0" : (length(var.network_acl) || data.ibm_is_network_acl) && (length(var.subnet) || data.ibm_is_subnet)
  network_acl = try(
    data.ibm_is_network_acl.this.id,
    element(ibm_is_network_acl.this.*.id, lookup(var.subnet_network_acl_attachment[count.index], "network_acl"))
  )
  subnet = try(
    data.ibm_is_subnet.this.id,
    element(ibm_is_subnet.this.*.id, lookup(var.subnet_network_acl_attachment[count.index], "subnet"))
  )
}

resource "ibm_is_subnet_public_gateway_attachment" "this" {
  count = length(var.subnet_public_gateway_attachment) == "0" ? "0" : (length(var.subnet) || data.ibm_is_subnet) && (length(var.public_gateway) || data.ibm_is_public_gateway)
  public_gateway = try(
    data.ibm_is_public_gateway.this.id,
    element(ibm_is_public_gateway.this.*.id, lookup(var.subnet_public_gateway_attachment[count.index], "public_gateway"))
  )
  subnet = try(
    data.ibm_is_subnet.this.id,
    element(ibm_is_subnet.this.*.id, lookup(var.subnet_public_gateway_attachment[count.index], "subnet"))
  )
}

resource "ibm_is_subnet_reserved_ip" "this" {
  count = length(var.subnet_reserved_ip) == "0" ? "0" : (length(var.subnet) || data.ibm_is_subnet)
  subnet = try(
    data.ibm_is_subnet.this.id,
    element(ibm_is_subnet.this.*.id, lookup(var.subnet_reserved_ip[count.index], "subnet"))
  )
  address     = lookup(var.subnet_reserved_ip[count.index], "address")
  auto_delete = lookup(var.subnet_reserved_ip[count.index], "auto_delete")
  name        = lookup(var.subnet_reserved_ip[count.index], "name")
  target      = lookup(var.subnet_reserved_ip[count.index], "target")
  target_crn  = lookup(var.subnet_reserved_ip[count.index], "target_crn")
}

resource "ibm_is_subnet_routing_table_attachment" "this" {
  count = length(var.subnet_routing_table_attachement) == "0" ? "0" : (length(var.network_acl) || data.ibm_is_network_acl) && (length(var.subnet) || data.ibm_is_subnet)
  routing_table = try(
    data.ibm_is_vpc_routing_table.this.routing_table,
    element(ibm_is_vpc_routing_table.this.*.routing_table, lookup(var.subnet_routing_table_attachement[count.index], "routing_table"))
  )
  subnet = try(
    data.ibm_is_subnet.this.id,
    element(ibm_is_subnet.this.*.id, lookup(var.subnet_routing_table_attachement[count.index], "subnet"))
  )
}

resource "ibm_is_ssh_key" "this" {
  count       = length(var.ssh_key)
  name        = lookup(var.ssh_key[count.index], "name")
  public_key  = lookup(var.ssh_key[count.index], "public_key")
  access_tags = lookup(var.ssh_key[count.index], "access_tags")
  type        = "rsa"
  tags        = lookup(var.ssh_key[count.index], "tags")
}

resource "ibm_is_backup_policy" "this" {
  count                = length(var.backup_policy)
  match_user_tags      = lookup(var.backup_policy[count.index], "match_user_tags")
  name                 = lookup(var.backup_policy[count.index], "name")
  match_resource_types = ["volume"]
}

resource "ibm_is_backup_policy_plan" "this" {
  count = length(var.backup_policy_plan) == "0" ? "0" : (length(var.backup_policy) || data.ibm_is_backup_policy)
  backup_policy_id = try(
    data.ibm_is_backup_policy.this.id,
    element(ibm_is_backup_policy.this.*.id, lookup(var.backup_policy_plan[count.index], "backup_policy_id"))
  )
  cron_spec        = lookup(var.backup_policy_plan[count.index], "cron_spec")
  active           = lookup(var.backup_policy_plan[count.index], "active")
  attach_user_tags = lookup(var.backup_policy_plan[count.index], "attach_user_tags")
  copy_user_tags   = lookup(var.backup_policy_plan[count.index], "copy_user_tags")
  name             = lookup(var.backup_policy_plan[count.index], "name")

  dynamic "clone_policy" {
    for_each = lookup(var.backup_policy_plan[count.index], "clone_policy") == null ? [] : ["clone_policy"]
    content {
      max_snapshots = lookup(clone_policy.value, "max_snapshots")
      zones         = lookup(clone_policy.value, "zones")
    }
  }

  dynamic "deletion_trigger" {
    for_each = lookup(var.backup_policy_plan[count.index], "deletion_trigger") == null ? [] : ["deletion_trigger"]
    content {
      delete_after      = lookup(deletion_trigger.value, "delete_after")
      delete_over_count = lookup(deletion_trigger.value, "delete_over_count")
    }
  }

  dynamic "remote_region_policy" {
    for_each = lookup(var.backup_policy_plan[count.index], "remote_region_policy") == null ? [] : ["remote_region_policy"]
    content {
      delete_over_account = lookup(remote_region_policy.value, "delete_over_account")
      encryption_key      = lookup(remote_region_policy.value, "encryption_key")
      region              = lookup(remote_region_policy.value, "region")
    }
  }
}

resource "ibm_is_image" "this" {
  count              = length(var.image)
  name               = lookup(var.image[count.index], "name")
  access_tags        = lookup(var.image[count.index], "access_tags")
  encrypted_data_key = lookup(var.image[count.index], "encrypted_data_key")
  encryption_key     = lookup(var.image[count.index], "encryption_key")
  href               = lookup(var.image[count.index], "href")
  operating_system   = lookup(var.image[count.index], "operating_system")
  source_volume      = lookup(var.image[count.index], "source_volume")
  tags               = lookup(var.image[count.index], "tags")
}

resource "ibm_is_bare_metal_server" "this" {
  count = length(var.bare_metal_server) == "0" ? "0" : (length(var.image) || data.ibm_is_image) && (length(var.ssh_key) || data.ibm_is_ssh_key)
  image = try(
    ibm_is_image.this.id,
    element(ibm_is_image.this.*.id, lookup(var.bare_metal_server[count.index], "image"))
  )
  keys = try(
    data.ibm_is_ssh_key.this.id,
    element(ibm_is_ssh_key.this.id, lookup(var.bare_metal_server[count.index], "keys"))
  )
  profile            = lookup(var.bare_metal_server[count.index], "profile")
  zone               = lookup(var.bare_metal_server[count.index], "zone")
  access_tags        = lookup(var.bare_metal_server[count.index], "access_tags")
  delete_type        = lookup(var.bare_metal_server[count.index], "delete_type")
  enable_secure_boot = lookup(var.bare_metal_server[count.index], "enable_secure_boot")
  name               = lookup(var.bare_metal_server[count.index], "name")
  user_data          = lookup(var.bare_metal_server[count.index], "user_data")
  vpc = try(
    data.ibm_is_vpc.this.id,
    element(ibm_is_vpc.this.*.id, lookup(var.bare_metal_server[count.index], "vpc"))
  )

  dynamic "trusted_platform_module" {
    for_each = lookup(var.bare_metal_server[count.index], "trusted_platform_module") == null ? [] : ["trusted_platform_module"]
    content {
      mode = lookup(trusted_platform_module.value, "mode")
    }
  }

  dynamic "network_interfaces" {
    for_each = lookup(var.bare_metal_server[count.index], "network_interfaces") == null ? [] : ["network_interfaces"]
    content {
      name = lookup(network_interfaces.value, "name")
      subnet = try(
        data.ibm_is_subnet.this.id,
        element(ibm_is_subnet.this.*.id, lookup(network_interfaces.value, "subnet"))
      )
      allow_ip_spoofing         = lookup(network_interfaces.value, "allow_ip_spoofing")
      allowed_vlans             = lookup(network_interfaces.value, "allowed_vlans")
      enable_infrastructure_nat = lookup(network_interfaces.value, "enable_infrastructure_nat")
      vlan                      = lookup(network_interfaces.value, "vlan")

      dynamic "primary_ip" {
        for_each = lookup(network_interfaces.value, "primary_ip") == null ? [] : ["primary_ip"]
        content {
          address     = lookup(primary_ip.value, "address")
          auto_delete = lookup(primary_ip.value, "auto_delete")
          name        = lookup(primary_ip.value, "name")
          reserved_ip = lookup(primary_ip.value, "reserved_ip")
        }
      }
    }
  }
  dynamic "primary_network_interface" {
    for_each = lookup(var.bare_metal_server[count.index], "primary_network_interface") == null ? [] : ["primary_network_interface"]
    content {
      subnet = try(
        data.ibm_is_subnet.this.id,
        element(ibm_is_subnet.this.*.id, lookup(primary_network_interface.value, "subnet"))
      )
      allow_ip_spoofing         = lookup(primary_network_interface.value, "allow_ip_spoofing")
      allowed_vlans             = lookup(primary_network_interface.value, "allowed_vlans")
      enable_infrastructure_nat = lookup(primary_network_interface.value, "enable_infrastructure_nat")
      name                      = lookup(primary_network_interface.value, "name")
      interface_type            = lookup(primary_network_interface.value, "interface_type")
      security_groups = try(
        data.ibm_is_security_group.this.name,
        element(ibm_is_security_group.this.*.id, lookup(var.bare_metal_server[count.index], "security_groups"))
      )

      dynamic "primary_ip" {
        for_each = lookup(primary_network_interface[count.index], "primary_ip")
        content {
          address     = lookup(primary_ip.value, "address")
          auto_delete = lookup(primary_ip.value, "auto_delete")
          reserved_ip = lookup(primary_ip.value, "reserved_ip")
          name        = lookup(primary_ip.value, "name")
        }
      }
    }
  }
}

resource "ibm_is_bare_metal_server_action" "this" {
  count  = length(var.bare_metal_server_action) == "0" ? "0" : (length(var.bare_metal_server) || data.ibm_is_bare_metal_server)
  action = lookup(var.bare_metal_server_action[count.index], "action")
  bare_metal_server = try(
    data.ibm_is_bare_metal_server.this.id,
    element(ibm_is_bare_metal_server.this.*.id, lookup(var.bare_metal_server_action[count.index], "bare_metal_server"))
  )
  stop_type = lookup(var.bare_metal_server_action[count.index], "stop_stype")
}

resource "ibm_is_bare_metal_server_disk" "this" {
  count = length(var.bare_metal_server_disk) == "0" ? "0" : (length(var.bare_metal_server) || data.ibm_is_bare_metal_server)
  bare_metal_server = try(
    data.ibm_is_bare_metal_server.this.id,
    element(ibm_is_bare_metal_server.this.*.id, lookup(var.bare_metal_server_disk[count.index], "bare_metal_server"))
  )
  disk = try(
    data.ibm_is_bare_metal_server.this.disks.0.id,
    element(ibm_is_bare_metal_server.this.*.disks.0.id, lookup(var.bare_metal_server_disk[count.index], "disk"))
  )
  name = lookup(var.bare_metal_server_disk[count.index], "name")
}

resource "ibm_is_bare_metal_server_network_interface" "this" {
  count = length(var.bare_metal_server_network_interface) == "0" ? "0" : (length(var.bare_metal_server) || data.ibm_is_bare_metal_server) && (length(var.subnet) || data.ibm_is_subnet)
  bare_metal_server = try(
    data.ibm_is_bare_metal_server.this.id,
    element(ibm_is_bare_metal_server.this.*.id, lookup(var.bare_metal_server_network_interface[count.index], "bare_metal_server"))
  )
  subnet = try(
    data.ibm_is_subnet.this.id,
    element(ibm_is_subnet.this.*.id, lookup(var.bare_metal_server_network_interface[count.index], "subnet"))
  )
  allowed_vlans             = lookup(var.bare_metal_server_network_interface[count.index], "allowed_vlans")
  enable_infrastructure_nat = lookup(var.bare_metal_server_network_interface[count.index], "enable_infrastructure_nat")
  hard_stop                 = lookup(var.bare_metal_server_network_interface[count.index], "hard_stop")
  interface_type            = lookup(var.bare_metal_server_network_interface[count.index], "interface_type")
  name                      = lookup(var.bare_metal_server_network_interface[count.index], "name")
  security_groups = try(
    data.ibm_is_security_group.this.name,
    element(ibm_is_security_group.this.*.id, lookup(var.bare_metal_server_network_interface[count.index], "security_groups"))
  )
  vlan = lookup(var.bare_metal_server_network_interface[count.index], "vlan")

  dynamic "primary_ip" {
    for_each = lookup(var.bare_metal_server_network_interface[count.index], "primary_ip") == null ? [] : ["primary_ip"]
    content {
      address     = lookup(primary_ip.value, "address")
      auto_delete = lookup(primary_ip.value, "auto_delete")
      name        = lookup(primary_ip.value, "name")
      reserved_ip = lookup(primary_ip.value, "reserved_ip")
    }
  }
}

resource "ibm_is_bare_metal_server_network_interface_allow_float" "this" {
  count = length(var.bare_metal_server_network_interface_allow_float) == "0" ? "0" : (length(var.bare_metal_server) || data.ibm_is_bare_metal_server) && (length(var.subnet) || data.ibm_is_subnet)
  bare_metal_server = try(
    data.ibm_is_bare_metal_server.this.id,
    element(ibm_is_bare_metal_server.this.*.id, lookup(var.bare_metal_server_network_interface_allow_float[count.index], "bare_metal_server"))
  )
  subnet = try(
    data.ibm_is_subnet.this.id,
    element(ibm_is_subnet.this.*.id, lookup(var.bare_metal_server_network_interface_allow_float[count.index], "subnet"))
  )
  vlan                      = lookup(var.bare_metal_server_network_interface_allow_float[count.index], "vlan")
  allow_ip_spoofing         = lookup(var.bare_metal_server_network_interface_allow_float[count.index], "allow_ip_spoofing")
  enable_infrastructure_nat = lookup(var.bare_metal_server_network_interface_allow_float[count.index], "enable_infrastructure_nat")
  name                      = lookup(var.bare_metal_server_network_interface_allow_float[count.index], "name")
  security_groups = try(
    data.ibm_is_security_group.this.name,
    element(ibm_is_security_group.this.*.id, lookup(var.bare_metal_server_network_interface_allow_float[count.index], "security_groups"))
  )

  dynamic "primary_ip" {
    for_each = lookup(var.bare_metal_server_network_interface_allow_float[count.index], "primary_ip") == null ? [] : ["primary_ip"]
    content {
      address     = lookup(primary_ip.value, "address")
      auto_delete = lookup(primary_ip.value, "auto_delete")
      name        = lookup(primary_ip.value, "name")
      reserved_ip = lookup(primary_ip.value, "reserved_ip")
    }
  }
}

resource "ibm_is_bare_metal_server_network_interface_floating_ip" "this" {
  count = length(var.bare_metal_server_network_interface_floating_ip) == "0" ? "0" : (length(var.bare_metal_server) || data.ibm_is_bare_metal_server) && (length(var.floating_ip) || data.ibm_is_floating_ip) && (length(var.bare_metal_server_network_interface) || data.ibm_is_bare_metal_server_network_interface)
  bare_metal_server = try(
    data.ibm_is_bare_metal_server.this.id,
    element(ibm_is_bare_metal_server.this.*.id, lookup(var.bare_metal_server_network_interface_floating_ip[count.index], "bare_metal_server"))
  )
  floating_ip = try(
    data.ibm_is_floating_ip.this.id,
    element(ibm_is_floating_ip.this.*.id, lookup(var.bare_metal_server_network_interface_floating_ip[count.index], "floating_ip"))
  )
  network_interface = try(
    data.ibm_is_bare_metal_server_network_interface.this.id,
    element(ibm_is_bare_metal_server_network_interface.this.*.id, lookup(var.bare_metal_server_network_interface_floating_ip[count.index], "network_interface"))
  )
}

resource "ibm_is_dedicated_host" "this" {
  count = length(var.dedicated_host)  == "0" ? "0" : (length(var.dedicated_host_group) || data.ibm_is_dedicated_host_group)
  host_group = try(
    data.ibm_is_dedicated_host_group.this.id,
    element(ibm_is_dedicated_host_group.this.*.id, lookup(var.dedicated_host[count.index], "host_group"))
  )
  profile                    = lookup(var.dedicated_host[count.index], "profile")
  access_tags                = lookup(var.dedicated_host[count.index], "access_tags")
  instance_placement_enabled = lookup(var.dedicated_host[count.index], "instance_placement_enabled")
  name                       = lookup(var.dedicated_host[count.index], "name")
}

resource "ibm_is_dedicated_host_disk_management" "this" {
  count = length(var.dedicated_host_disk_management)  == "0" ? "0" : (length(var.dedicated_host) || data.ibm_is_dedicated_host)
  dedicated_host = try(
    data.ibm_is_dedicated_host.this.id,
    element(ibm_is_dedicated_host.this.*.id, lookup(var.dedicated_host_disk_management[count.index], "dedicated_host"))
  )

  dynamic "disks" {
    for_each = lookup(var.dedicated_host_disk_management[count.index], "disks")
    content {
      id = try(
        data.ibm_is_dedicated_host.this.disks.0.id,
        element(ibm_is_dedicated_host.this.*.disks.0.id, lookup(var.dedicated_host_disk_management[count.index], id))
      )
      name = lookup(disks.value, "name")
    }
  }
}

resource "ibm_is_dedicated_host_group" "this" {
  count  = length(var.dedicated_host_group)
  class  = lookup(var.dedicated_host_group[count.index], "class")
  family = lookup(var.dedicated_host_group[count.index], "family")
  zone   = lookup(var.dedicated_host_group[count.index], "zone")
  name   = lookup(var.dedicated_host_group[count.index], "name")
}

resource "ibm_is_floating_ip" "this" {
  count       = length(var.floating_ip)
  name        = lookup(var.floating_ip[count.index], "name")
  access_tags = lookup(var.floating_ip[count.index], "access_tags")
  target      = lookup(var.floating_ip[count.index], "target")
  tags        = lookup(var.floating_ip[count.index], "tags")
  zone        = lookup(var.floating_ip[count.index], "zone")
}

resource "ibm_cos_bucket" "this" {
  count                = length(var.bucket)
  bucket_name          = lookup(var.bucket[count.index], "bucket_name")
  resource_instance_id = try(data.ibm_resource_instance.this.id)
  region_location      = lookup(var.bucket[count.index], "region_location")
  storage_class        = lookup(var.bucket[count.index], "storage_class")
}

resource "ibm_is_flow_log" "this" {
  count = length(var.flow_log)  == "0" ? "0" : (length(var.bucket) || data.ibm_cos_bucket)
  name  = lookup(var.flow_log[count.index], "name")
  storage_bucket = try(
    data.ibm_cos_bucket.this.id,
    element(ibm_cos_bucket.this.*.id, lookup(var.flow_log[count.index], "storage_bucket"))
  )
  target      = lookup(var.flow_log[count.index], "target")
  access_tags = lookup(var.flow_log[count.index], "access_tags")
  active      = lookup(var.flow_log[count.index], "active")
  tags        = lookup(var.flow_log[count.index], "tags")
}

resource "ibm_is_ike_policy" "this" {
  count                    = length(var.ike_policy)
  authentication_algorithm = lookup(var.ike_policy[count.index], "authentication_algorithm")
  dh_group                 = lookup(var.ike_policy[count.index], "dh_group")
  encryption_algorithm     = lookup(var.ike_policy[count.index], "encryption_algorithm")
  name                     = lookup(var.ike_policy[count.index], "name")
  ike_version              = lookup(var.ike_policy[count.index], "ike_version")
  key_lifetime             = lookup(var.ike_policy[count.index], "key_lifetime")
}

resource "ibm_is_image" "this" {
  count              = length(var.image)
  name               = lookup(var.image[count.index], "name")
  access_tags        = lookup(var.image[count.index], "access_tags")
  encrypted_data_key = lookup(var.image[count.index], "encrypted_data_key")
  encryption_key     = lookup(var.image[count.index], "encryption_key")
  href               = lookup(var.image[count.index], "href")
  operating_system   = lookup(var.image[count.index], "operating_system")
  source_volume      = lookup(var.image[count.index], "source_volume")
  tags               = lookup(var.image[count.index], "tags")
}

resource "ibm_is_image_export_job" "this" {
  count = length(var.image_export_job)  == "0" ? "0" : (length(var.image) || data.ibm_is_image)
  image = try(
    data.ibm_is_image.this.id,
    element(ibm_is_image.this.*.id, lookup(var.image_export_job[count.index], "image"))
  )
  format = lookup(var.image_export_job[count.index], "format")
  name   = lookup(var.image_export_job[count.index], "name")

  dynamic "storage_bucket" {
    for_each = lookup(var.image_export_job[count.index], "storage_bucket") == null ? [] : ["storage_bucket"]
    content {
      name = lookup(storage_bucket.value, "name")
      crn  = lookup(storage_bucket.value, "crn")
    }
  }
}

resource "ibm_is_instance" "this" {
  count                            = length(var.instance)
  name                             = load_balancer(var.instance[count.index], "name")
  access_tags                      = load_balancer(var.instance[count.index], "access_tags")
  action                           = load_balancer(var.instance[count.index], "action")
  auto_delete_volume               = load_balancer(var.instance[count.index], "auto_delete_volume")
  availability_policy_host_failure = load_balancer(var.instance[count.index], "availability_policy_host_failure")
  dedicated_host = try(
    data.ibm_is_dedicated_host.this.id,
    element(ibm_is_dedicated_host.this.*.id, lookup(var.instance[count.index], "dedicated_host"))
  )
  dedicated_host_group = try(
    data.ibm_is_dedicated_host_group.this.id,
    element(ibm_is_dedicated_host_group.this.*.id, lookup(var.instance[count.index], "dedicated_host_group"))
  )
  default_trusted_profile_auto_link = load_balancer(var.instance[count.index], "default_trusted_profile_auto_link")
  default_trusted_profile_target    = load_balancer(var.instance[count.index], "default_trusted_profile_target")
  force_recovery_time               = load_balancer(var.instance[count.index], "force_recovery_time")
  image = try(
    data.ibm_is_image.this.id,
    element(ibm_is_image.this.*.id, lookup(var.instance[count.index], "image"))
  )
  keys = []
  placement_group = try(
    data.ibm_is_placement_group.this.id,
    element(ibm_is_placement_group.this.*.id, lookup(var.instance[count.index], "placement_group"))
  )
  profile = load_balancer(var.instance[count.index], "profile")
  instance_template = try(
    data.ibm_is_instance_template.this.id,
    element(ibm_is_instance_template.this.*.id, lookup(var.instance[count.index], "instance_template"))
  )
  tags                   = load_balancer(var.instance[count.index], "tags")
  total_volume_bandwidth = load_balancer(var.instance[count.index], "total_volume_bandwidth")
  user_data              = load_balancer(var.instance[count.index], "user_data")
  vpc = try(
    data.ibm_is_vpc.this.id,
    element(ibm_is_vpc.this.*.id, lookup(var.instance[count.index], "vpc"))
  )
  zone = lookup(var.instance[count.index], "zone")

  dynamic "primary_network_interface" {
    for_each = lookup(var.instance[count.index], "primary_network_interface") == null ? [] : ["primary_network_interface"]
    content {
      subnet = try(
        data.ibm_is_subnet.this.id,
        element(ibm_is_subnet.this.*.id, lookup(primary_network_interface.value, "subnet"))
      )
      allow_ip_spoofing = lookup(primary_network_interface.value, "allow_ip_spoofing")
      name              = lookup(primary_network_interface.value, "name")
      security_groups = try(
        data.ibm_is_security_group.this.name,
        element(ibm_is_security_group.this.*.id, lookup(primary_network_interface.value, "security_groups"))
      )

      dynamic "primary_ip" {
        for_each = lookup(primary_network_interface.value, "primary_ip")
        content {
          auto_delete = lookup(primary_ip.value, "auto_delete")
          address     = lookup(primary_ip.value, "address")
          name        = lookup(primary_ip.value, "name")
          reserved_ip = lookup(primary_ip.value, "reserved_ip")
        }
      }
    }
  }

  dynamic "network_interfaces" {
    for_each = lookup(var.instance[count.index], "network_interfaces") == null ? [] : ["network_interfaces"]
    content {
      subnet = try(
        data.ibm_is_subnet.this.id,
        element(ibm_is_subnet.this.*.id, lookup(network_interfaces.value, "subnet"))
      )
      allow_ip_spoofing = lookup(network_interfaces.value, "allow_ip_spoofing")
      name              = lookup(network_interfaces.value, "name")
      security_groups = try(
        data.ibm_is_security_group.this.name,
        element(ibm_is_security_group.this.*.id, lookup(network_interfaces.value, "security_groups"))
      )

      dynamic "primary_ip" {
        for_each = lookup(network_interfaces.value, "primary_ip")
        content {
          auto_delete = lookup(primary_ip.value, "auto_delete")
          address     = lookup(primary_ip.value, "address")
          name        = lookup(primary_ip.value, "name")
          reserved_ip = lookup(primary_ip.value, "reserved_ip")
        }
      }
    }
  }

  dynamic "metadata_service" {
    for_each = lookup(var.instance[count.index], "metadata_service") == null ? [] : ["metadata_service"]
    content {

      enabled            = lookup(metadata_service.value, "enabled")
      protocol           = lookup(metadata_service.value, "protocol")
      response_hop_limit = lookup(metadata_service.value, "response_hop_limit")
    }
  }

  dynamic "catalog_offering" {
    for_each = lookup(var.instance[count.index], "catalog_offering") == null ? [] : ["catalog_offering"]
    content {
      offering_crn = lookup(catalog_offering.value, "offering_crn")
      version_crn  = lookup(catalog_offering.value, "version_crn")
    }
  }

  dynamic "boot_volume" {
    for_each = lookup(var.instance[count.index], "boot_volume") == null ? [] : ["boot_volume"]
    content {
      auto_delete_volume = lookup(boot_volume.value, "auto_delete_volume")
      encryption         = lookup(boot_volume.value, "encryption")
      name               = lookup(boot_volume.value, "name")
      size               = lookup(boot_volume.value, "size")
      snapshot           = lookup(boot_volume.value, "snapshot")
      volume_id          = lookup(boot_volume.value, "volume_id")
      tags               = lookup(boot_volume.value, "tags")
    }
  }
}

resource "ibm_is_instance_action" "this" {
  count  = length(var.instance_action)  == "0" ? "0" : (length(var.instance) || data.ibm_is_instance)
  action = lookup(var.instance_action[count.index], "action")
  instance = try(
    data.ibm_is_instance.this.id,
    element(ibm_is_instance.this.*.id, lookup(var.instance_action[count.index], "instance"))
  )
  force_action = lookup(var.instance_action[count.index], "force_action")
}

resource "ibm_is_instance_disk_management" "this" {
  count = length(var.instance_disk_management)  == "0" ? "0" : (length(var.instance) || data.ibm_is_instance)
  instance = try(
    data.ibm_is_instance.this.id,
    element(ibm_is_instance.this.*.id, lookup(var.instance_disk_management[count.index], "instance"))
  )

  dynamic "disks" {
    for_each = lookup(var.instance_disk_management[count.index], "disks") == null ? [] : ["disks"]
    content {
      id = try(
        data.ibm_is_bare_metal_server.this.disks.0.id,
        element(ibm_is_bare_metal_server.this.*.disks.0.id, lookup(var.instance_disk_management[count.index], "disk"))
      )
      name = lookup(disks.value, "name")
    }
  }
}

resource "ibm_is_instance_group" "this" {
  count = length(var.instance_group)  == "0" ? "0" : (length(var.instance_template) || data.ibm_is_instance_template)
  instance_template = try(
    data.ibm_is_instance_template.this.id,
    element(ibm_is_instance_template.this.*.id, lookup(var.instance_group[count.index], "instance_template"))
  )
  name = lookup(var.instance_group[count.index], "name")
  subnets = try(
    data.ibm_is_subnet.this.id,
    element(ibm_is_subnet.this.*.id, lookup(var.instance_group[count.index], "subnet"))
  )
  access_tags      = lookup(var.instance_group[count.index], "access_tags")
  application_port = lookup(var.instance_group[count.index], "application_port")
  load_balancer = try(
    data.ibm_is_lb.this.id,
    element(ibm_is_lb.this.*.id, lookup(var.instance_group[count.index], "load_balancer"))
  )
  load_balancer_pool = try(
    data.ibm_is_lb_pool.this.id,
    element(ibm_is_lb_pool.this.*.id, lookup(var.instance_group[count.index], "load_balancer_pool"))
  )
  instance_count = lookup(var.instance_group[count.index], "instance_count")
}

resource "ibm_is_instance_group_manager" "this" {
  count = length(var.instance_group_manager)  == "0" ? "0" : (length(var.instance_group) || data.ibm_is_instance_group)
  instance_group = try(
    data.ibm_is_instance_group.this.id,
    element(ibm_is_instance_group.this.*.id, lookup(var.instance_group_manager[count.index], "instance_group"))
  )
  aggregation_window   = lookup(var.instance_group_manager[count.index], "aggregation_window")
  cooldown             = lookup(var.instance_group_manager[count.index], "cooldown")
  enable_manager       = lookup(var.instance_group_manager[count.index], "enable_manager")
  manager_type         = lookup(var.instance_group_manager[count.index], "manager_type")
  max_membership_count = lookup(var.instance_group_manager[count.index], "max_membership_count")
  min_membership_count = lookup(var.instance_group_manager[count.index], "min_membership_count")
  name                 = lookup(var.instance_group_manager[count.index], "name")
}

resource "ibm_is_instance_group_manager_action" "this" {
  count = length(var.instance_group_manager_action) == "0" ? "0" : (length(var.instance_group) || data.ibm_is_instance_group) && (length(var.instance_group_manager) || data.ibm_is_instance_group_manager)
  instance_group = try(
    data.ibm_is_instance_group.this.id,
    element(ibm_is_instance_group.this.*.id, lookup(var.instance_group_manager_action[count.index], "instance_group"))
  )
  instance_group_manager = try(
    data.ibm_is_instance_group_manager.this.id,
    element(ibm_is_instance_group_manager.this.*.id, lookup(var.instance_group_manager_action[count.index], "instance_group_manager"))
  )
  membership_count     = lookup(var.instance_group_manager_action[count.index], "membership_count")
  max_membership_count = lookup(var.instance_group_manager_action[count.index], "max_membership_count")
  min_membership_count = lookup(var.instance_group_manager_action[count.index], "min_membership_count")
  name                 = lookup(var.instance_group_manager_action[count.index], "name")
  run_at               = lookup(var.instance_group_manager_action[count.index], "run_at")
  cron_spec            = lookup(var.instance_group_manager_action[count.index], "cron_spec")
  target_manager       = lookup(var.instance_group_manager_action[count.index], "target_manager")
}

resource "ibm_is_instance_group_manager_policy" "this" {
  count = length(var.instance_group_manager_policy) == "0" ? "0" : (length(var.instance_group) || data.ibm_is_instance_group) && (length(var.instance_group_manager) || data.ibm_is_instance_group_manager)
  instance_group = try(
    data.ibm_is_instance_group.this.id,
    element(ibm_is_instance_group.this.*.id, lookup(var.instance_group_manager_policy[count.index], "instance_group"))
  )
  instance_group_manager = try(
    data.ibm_is_instance_group_manager.this.id,
    element(ibm_is_instance_group_manager.this.*.id, lookup(var.instance_group_manager_policy[count.index], "instance_group_manager"))
  )
  metric_type  = lookup(var.instance_group_manager_policy[count.index], "metric_type")
  metric_value = lookup(var.instance_group_manager_policy[count.index], "metric_value")
  policy_type  = lookup(var.instance_group_manager_policy[count.index], "policy_type")
}

resource "ibm_is_instance_group_membership" "this" {
  count = length(var.instance_group_membership)  == "0" ? "0" : (length(var.instance_group) || data.ibm_is_instance_group)
  instance_group = try(
    data.ibm_is_instance_group.this.id,
    element(ibm_is_instance_group.this.*.id, lookup(var.instance_group_membership[count.index], "instance_group"))
  )
  instance_group_membership = data.ibm_is_instance_group_memberships.this.memberships.0.id
  name                      = lookup(var.instance_group_membership[count.index], "name")
  action_delete             = lookup(var.instance_group_membership[count.index], "action_delete")
}

resource "ibm_is_instance_network_interface" "this" {
  count = length(var.instance_network_interface)  == "0" ? "0" : (length(var.instance) || data.ibm_is_instance) && (length(var.subnet) || data.ibm_is_subnet)
  instance = try(
    data.ibm_is_instance.this.id,
    element(ibm_is_instance.this.*.id, lookup(var.instance_network_interface[count.index], "instance"))
  )
  name = lookup(var.instance_network_interface[count.index], "name")
  subnet = try(
    data.ibm_is_subnet.this.id,
    element(ibm_is_subnet.this.*.id, lookup(var.instance_network_interface[count.index], "subnet"))
  )
  floating_ip = try(
    data.ibm_is_floating_ip.this.id,
    element(ibm_is_floating_ip.this.*.id, lookup(var.instance_network_interface[count.index], "floating_ip"))
  )
  allow_ip_spoofing = lookup(var.instance_network_interface[count.index], "allow_ip_spoofing")
  security_groups = try(
    data.ibm_is_security_group.this.name,
    element(ibm_is_security_group.this.*.id, lookup(var.instance_network_interface[count.index], "security_groups"))
  )

  dynamic "primary_ip" {
    for_each = lookup(var.instance_network_interface[count.index], "primary_ip") == null ? [] : ["primary_ip"]
    content {
      address     = lookup(primary_ip.value, "address")
      auto_delete = lookup(primary_ip.value, "auto_delete")
      name        = lookup(primary_ip.value, "name")
      reserved_ip = lookup(primary_ip.value, "reserved_ip")
    }
  }
}

resource "ibm_is_instance_network_interface_floating_ip" "this" {
  count = length(var.instance_network_interface_floating_ip)  == "0" ? "0" : (length(var.instance) || data.ibm_is_instance) && (length(var.floating_ip) || data.ibm_is_floating_ip)
  floating_ip = try(
    data.ibm_is_floating_ip.this.id,
    element(ibm_is_floating_ip.this.*.id, lookup(var.instance_network_interface_floating_ip[count.index], "floatting_ip"))
  )
  instance = try(
    data.ibm_is_instance.this.id,
    element(ibm_is_instance.this.*.id, lookup(var.instance_network_interface_floating_ip[count.index], "instance"))
  )
  network_interface = try(
    data.ibm_is_instance.this.primary_network_interface[0].id,
    element(ibm_is_instance.this.*.primary_network_interface[0].id, lookup(var.instance_network_interface_floating_ip[count.index], "network_interface"))
  )
}

resource "ibm_is_instance_template" "this" {
  count = length(var.instance_template)  == "0" ? "0" : (length(var.ssh_key) || data.ibm_is_ssh_key) && (length(var.vpc) || data.ibm_is_vpc)
  keys = [try(
    data.ibm_is_ssh_key.this.id,
    element(ibm_is_ssh_key.this.*.id, lookup(var.instance_template[count.index], "keys"))
  )]
  profile = lookup(var.instance_template[count.index], "profile")
  vpc = try(
    data.ibm_is_vpc.this.id,
    element(ibm_is_vpc.this.*.id, lookup(var.instance_template[count.index], "vpc"))
  )
  zone                             = lookup(var.instance_template[count.index], "zone")
  availability_policy_host_failure = lookup(var.instance_template[count.index], "availability_policy_host_failure")
  dedicated_host = try(
    data.ibm_is_dedicated_host.this.id,
    element(ibm_is_dedicated_host.this.*.id, lookup(var.instance_template[count.index], "dedicated_host"))
  )
  dedicated_host_group = try(
    data.ibm_is_dedicated_host_group.this.id,
    element(ibm_is_dedicated_host_group.this.*.id, lookup(var.dedicated_host_group[count.index], "dedicated_host_group"))
  )
  default_trusted_profile_auto_link = lookup(var.instance_template[count.index], "default_trusted_profile_auto_link")
  default_trusted_profile_target    = lookup(var.instance_template[count.index], "default_trusted_profile_target")
  name                              = lookup(var.instance_template[count.index], "name")
  placement_group = try(
    data.ibm_is_placement_group.this.id,
    element(ibm_is_placement_group.this.*.id, lookup(var.instance_template[count.index], "placement_group"))
  )
  total_volume_bandwidth = lookup(var.instance_template[count.index], "total_volume_bandwidth")
  user_data              = lookup(var.instance_template[count.index], "user_data")

  dynamic "boot_volume" {
    for_each = lookup(var.instance_template[count.index], "boot_volume") == null ? [] : ["boot_volume"]
    content {
      delete_volume_on_instance_delete = lookup(boot_volume.value, "delete_volume_on_instance_delete")
      encryption                       = lookup(boot_volume.value, "encryption")
      name                             = lookup(boot_volume.value, "name")
      tags                             = lookup(boot_volume.value, "tags")
    }
  }

  dynamic "catalog_offering" {
    for_each = lookup(var.instance_template[count.index], "catalog_offering") == null ? [] : ["catalog_offering"]
    content {
      offering_crn = lookup(catalog_offering.value, "offering_crn")
      version_crn  = lookup(catalog_offering.value, "version_crn")
    }
  }

  dynamic "metadata_service" {
    for_each = lookup(var.instance_template[count.index], "metadata_service") == null ? [] : ["metadata_service"]
    content {
      enabled            = lookup(metadata_service.value, "enabled")
      protocol           = lookup(metadata_service.value, "protocol")
      response_hop_limit = lookup(metadata_service.value, "response_hop_limit")
    }
  }

  dynamic "network_interfaces" {
    for_each = lookup(var.instance_template[count.index], "network_interfaces") == null ? [] : ["network_interfaces"]
    content {
      subnet = try(
        data.ibm_is_subnet.this.id,
        element(ibm_is_subnet.this.*.id, lookup(network_interfaces.value, "subnet"))
      )
      allow_ip_spoofing = lookup(network_interfaces.value, "allow_ip_spoofing")
      name              = lookup(network_interfaces.value, "name")
      security_groups = try(
        data.ibm_is_security_group.this.id,
        element(ibm_is_security_group.this.*.id, lookup(network_interfaces.value, "security_groups"))
      )

      dynamic "primary_ip" {
        for_each = lookup(network_interfaces.value, "primary_ip") == null ? [] : ["primary_ip"]
        content {
          address     = lookup(primary_ip.value, "address")
          auto_delete = lookup(primary_ip.value, "auto_delete")
          name        = lookup(primary_ip.value, "name")
          reserved_ip = lookup(primary_ip.value, "reserved_ip")
        }
      }
    }
  }

  dynamic "primary_network_interface" {
    for_each = lookup(var.instance_template[count.index], "primary_network_interface") == null ? [] : ["primary_network_interface"]
    content {
      subnet = try(
        data.ibm_is_subnet.this.id,
        element(ibm_is_subnet.this.*.id, lookup(primary_network_interface.value, "subnet"))
      )
      allow_ip_spoofing = lookup(primary_network_interface.value, "allow_ip_spoofing")
      name              = lookup(primary_network_interface.value, "name")
      security_groups = try(
        data.ibm_is_security_group.this.id,
        element(ibm_is_security_group.this.*.id, lookup(primary_network_interface.value, "security_groups"))
      )

      dynamic "primary_ip" {
        for_each = lookup(primary_network_interface.value, "primary_ip") == null ? [] : ["primary_ip"]
        content {
          address     = lookup(primary_ip.value, "address")
          auto_delete = lookup(primary_ip.value, "auto_delete")
          name        = lookup(primary_ip.value, "name")
          reserved_ip = lookup(primary_ip.value, "reserved_ip")
        }
      }
    }
  }

  dynamic "volume_attachments" {
    for_each = lookup(var.instance_template[count.index], "volume_attachments") == null ? [] : ["volume_attachments"]
    content {
      delete_volume_on_instance_delete = lookup(volume_attachments.value, "delete_volume_on_instance_delete")
      name                             = lookup(volume_attachments.value, "name")
      volume = try(
        data.ibm_is_volume.this.id,
        element(ibm_is_volume.this.*.id, lookup(volume_attachments.value, "volume"))
      )

      dynamic "volume_prototype" {
        for_each = lookup(volume_attachments.value, "volume_prototype") == null ? [] : ["volume_prototype"]
        content {
          capacity       = lookup(volume_prototype.value, "capacity")
          profile        = lookup(volume_prototype.value, "profile")
          encryption_key = lookup(volume_prototype.value, "encryption_key")
          iops           = lookup(volume_prototype.value, "iops")
          tags           = lookup(volume_prototype.value, "tags")
        }
      }
    }
  }
}

resource "ibm_is_instance_volume_attachment" "this" {
  count = length(var.instance_volume_attachment)  == "0" ? "0" : (length(var.instance) || data.ibm_is_instance)
  instance = try(
    data.ibm_is_instance.this.id,
    element(ibm_is_instance.this.*.id, lookup(var.instance_volume_attachment[count.index], "instance"))
  )
  capacity                           = lookup(var.instance_volume_attachment[count.index], "capacity")
  delete_volume_on_attachment_delete = lookup(var.instance_volume_attachment[count.index], "delete_volume_on_attachment_delete")
  delete_volume_on_instance_delete   = lookup(var.instance_volume_attachment[count.index], "delete_volume_on_instance_delete")
  encryption_key                     = lookup(var.instance_volume_attachment[count.index], "encryption_key")
  iops                               = lookup(var.instance_volume_attachment[count.index], "iops")
  id                                 = lookup(var.instance_volume_attachment[count.index], "id")
  name                               = lookup(var.instance_volume_attachment[count.index], "name")
  profile                            = lookup(var.instance_volume_attachment[count.index], "profile")
  snapshot                           = lookup(var.instance_volume_attachment[count.index], "snapshot")
  volume = try(
    data.ibm_is_volume.this.id,
    element(ibm_is_volume.this.*.id, lookup(var.instance_volume_attachment[count.index], "volume"))
  )
  volume_name = lookup(var.instance_volume_attachment[count.index], "volume_name")
  tags        = lookup(var.instance_volume_attachment[count.index], "tags")
}

resource "ibm_is_ipsec_policy" "this" {
  count                    = length(var.ipsec_policy)
  authentication_algorithm = lookup(var.ipsec_policy[count.index], "authentication_algorithm")
  encryption_algorithm     = lookup(var.ipsec_policy[count.index], "encryption_algorithm")
  name                     = lookup(var.ipsec_policy[count.index], "name")
  pfs                      = lookup(var.ipsec_policy[count.index], "pfs")
  key_lifetime             = lookup(var.ipsec_policy[count.index], "key_lifetime")
}

resource "ibm_is_lb" "this" {
  count = length(var.lb)  == "0" ? "0" : (length(var.subnet) || data.ibm_is_subnet) && (length(var.security_group) || data.ibm_is_security_group)
  name  = lookup(var.lb[count.index], "name")
  subnets = [try(
    data.ibm_is_subnet.this.id,
    element(ibm_is_subnet.this.*.id, lookup(var.instance_template[count.index], "subnet"))
  )]
  access_tags = lookup(var.lb[count.index], "access_tags")
  logging     = lookup(var.lb[count.index], "logging")
  profile     = lookup(var.lb[count.index], "profile")
  route_mode  = lookup(var.lb[count.index], "route_mode")
  security_groups = [try(
    data.ibm_is_security_group.this.id,
    element(ibm_is_security_group.this.*.id, lookup(var.instance_template[count.index], "security_groups"))
  )]
  tags = lookup(var.lb[count.index], "tags")
  type = lookup(var.lb[count.index], "type")

  dynamic "dns" {
    for_each = lookup(var.lb[count.index], "dns") == null ? [] : ["dns"]
    content {
      instance_crn = lookup(dns.value, "instance_crn")
      zone_id      = lookup(dns.value, "zone_id")
    }
  }
}

resource "ibm_is_lb_listener" "this" {
  count = length(var.lb_listener) == "0" ? "0" : (length(var.lb) || data.ibm_is_lb)
  lb = try(
    data.ibm_is_lb.this.id,
    element(ibm_is_lb.this.*.id, lookup(var.lb_listener[count.index], "lb"))
  )
  protocol = lookup(var.lb_listener[count.index], "protocol")
  port     = lookup(var.lb_listener[count.index], "port")
  port_min = lookup(var.lb_listener[count.index], "port_min")
  port_max = lookup(var.lb_listener[count.index], "port_max")
  default_pool = try(
    data.ibm_is_lb_pool.this.id,
    element(ibm_is_lb_pool.this.*.id, lookup(var.lb_listener[count.index], "default_pool"))
  )
  certificate_instance       = lookup(var.lb_listener[count.index], "certificate_instance")
  connection_limit           = lookup(var.lb_listener[count.index], "connection_limit")
  idle_connection_timeout    = lookup(var.lb_listener[count.index], "idle_connection_timeout")
  https_redirect_listener    = element(ibm_is_lb_listener.this.*.id, lookup(var.lb_listener[count.index], "https_redirect_listener"))
  https_redirect_status_code = lookup(var.lb_listener[count.index], "https_redirect_status_code")
  https_redirect_uri         = lookup(var.lb_listener[count.index], "https_redirect_uri")
  accept_proxy_protocol      = lookup(var.lb_listener[count.index], "accept_proxy_protocol")
}

resource "ibm_is_lb_listener_policy" "this" {
  count  = length(var.lb_listener_policy) == "0" ? "0" : (length(var.lb) || data.ibm_is_lb) && (length(var.lb_listener) || data.ibm_is_lb_listener)
  action = lookup(var.lb_listener_policy[count.index], "action")
  lb = try(
    data.ibm_is_lb.this.id,
    element(ibm_is_lb.this.*.id, lookup(var.lb_listener_policy[count.index], "lb"))
  )
  listener = try(
    data.ibm_is_lb_listener.this.id,
    element(ibm_is_lb_listener.this.*.id, lookup(var.lb_listener_policy[count.index], "listener"))
  )
  priority = lookup(var.lb_listener_policy[count.index], "priority")
  name     = lookup(var.lb_listener_policy[count.index], "name")
  target_id = try(
    data.ibm_is_lb_pool.this.id,
    element(ibm_is_lb_pool.this.*.id, lookup(var.lb_listener_policy[count.index], "target_id"))
  )
  target_url              = lookup(var.lb_listener_policy[count.index], "target_url")
  target_http_status_code = lookup(var.lb_listener_policy[count.index], "target_http_status_code")
  target_https_redirect_listener = try(
    data.ibm_is_lb_listener.this.id,
    element(ibm_is_lb_listener.this.*.id, lookup(var.lb_listener_policy[count.index], "target_https_redirect_listener"))
  )
  target_https_redirect_uri         = lookup(var.lb_listener_policy[count.index], "target_https_redirect_uri")
  target_https_redirect_status_code = lookup(var.lb_listener_policy[count.index], "target_https_redirect_status_code")

  dynamic "rules" {
    for_each = lookup(var.lb_listener_policy[count.index], "rules") == null ? [] : ["rules"]
    content {
      condition = lookup(rules.value, "condition")
      type      = lookup(rules.value, "type")
      value     = lookup(rules.value, "value")
      field     = lookup(rules.value, "field")
    }
  }
}

resource "ibm_is_lb_listener_policy_rule" "this" {
  count     = length(var.lb_listener_policy_rule) == "0" ? "0" : (length(var.lb) || data.ibm_is_lb) && (length(var.lb_listener) || data.ibm_is_lb_listener)
  condition = lookup(var.lb_listener_policy_rule[count.index], "condition")
  lb = try(
    data.ibm_is_lb.this.id,
    element(ibm_is_lb.this.*.id, lookup(var.lb_listener_policy_rule[count.index], "lb"))
  )
  listener = try(
    data.ibm_is_lb_listener.this.id,
    element(ibm_is_lb_listener.this.*.id, lookup(var.lb_listener_policy_rule[count.index], "listener"))
  )
  policy = lookup(var.lb_listener_policy_rule[count.index], "policy")
  type   = lookup(var.lb_listener_policy_rule[count.index], "type")
  value  = lookup(var.lb_listener_policy_rule[count.index], "value")
  field  = lookup(var.lb_listener_policy_rule[count.index], "field")
}

resource "ibm_is_lb_pool" "this" {
  count          = length(var.lb_pool) == "0" ? "0" : (length(var.lb) || data.ibm_is_lb)
  algorithm      = lookup(var.lb_pool[count.index], "algorithm")
  health_delay   = lookup(var.lb_pool[count.index], "health_delay")
  health_retries = lookup(var.lb_pool[count.index], "health_retries")
  health_timeout = lookup(var.lb_pool[count.index], "health_timeout")
  health_type    = lookup(var.lb_pool[count.index], "health_type")
  lb = try(
    data.ibm_is_lb.this.id,
    element(ibm_is_lb.this.*.id, lookup(var.lb_pool[count.index], "lb"))
  )
  name                                = lookup(var.lb_pool[count.index], "name")
  protocol                            = lookup(var.lb_pool[count.index], "protocol")
  health_monitor_url                  = lookup(var.lb_pool[count.index], "health_monitor_url")
  health_monitor_port                 = lookup(var.lb_pool[count.index], "health_monitor_port")
  proxy_protocol                      = lookup(var.lb_pool[count.index], "proxy_protocol")
  session_persistence_type            = lookup(var.lb_pool[count.index], "session_persistence_type")
  session_persistence_app_cookie_name = lookup(var.lb_pool[count.index], "session_persistence_app_cookie_name")
}

resource "ibm_is_lb_pool_member" "this" {
  count = length(var.lb_pool_member)  == "0" ? "0" : (length(var.lb) || data.ibm_is_lb) && (length(var.lb_pool) || data.ibm_is_lb_pool)
  lb = try(
    data.ibm_is_lb.this.id,
    element(ibm_is_lb.this.*.id, lookup(var.lb_pool_member[count.index], "lb"))
  )
  pool = try(
    data.ibm_is_lb_pool.this.id,
    element(ibm_is_lb_pool.this.*.id, lookup(var.lb_pool_member[count.index], "pool"))
  )
  port           = lookup(var.lb_pool_member[count.index], "port")
  target_address = lookup(var.lb_pool_member[count.index], "target_address")
  target_id      = element(ibm_is_instance.this.*.id, lookup(var.lb_pool_member[count.index], "target_id"))
  weight         = lookup(var.lb_pool_member[count.index], "weight")
}

resource "ibm_is_network_acl_rule" "this" {
  count       = length(var.network_acl_rule)  == "0" ? "0" : (length(var.network_acl) || data.ibm_is_network_acl)
  action      = lookup(var.network_acl_rule[count.index], "action")
  destination = lookup(var.network_acl_rule[count.index], "destination")
  direction   = lookup(var.network_acl_rule[count.index], "direction")
  network_acl = try(
    data.ibm_is_network_acl.this.id,
    element(ibm_is_network_acl.this.*.id, lookup(var.network_acl_rule[count.index], "network_acl"))
  )
  source = lookup(var.network_acl_rule[count.index], "source")
  before = lookup(var.network_acl_rule[count.index], "before")

  dynamic "icmp" {
    for_each = lookup(var.network_acl_rule[count.index], "icmp") == null ? [] : ["icmp"]
    content {
      code = lookup(icmp.value, "code")
      type = lookup(icmp.value, "type")
    }
  }

  dynamic "tcp" {
    for_each = lookup(var.network_acl_rule[count.index], "tcp") == null ? [] : ["tcp"]
    content {
      port_max        = lookup(tcp.value, "port_max")
      port_min        = lookup(tcp.value, "port_min")
      source_port_max = lookup(tcp.value, "source_port_max")
      source_port_min = lookup(tcp.value, "source_port_min")
    }
  }

  dynamic "udp" {
    for_each = lookup(var.network_acl_rule[count.index], "udp") == null ? [] : ["udp"]
    content {
      port_max        = lookup(udp.value, "port_max")
      port_min        = lookup(udp.value, "port_min")
      source_port_max = lookup(udp.value, "source_port_max")
      source_port_min = lookup(udp.value, "source_port_min")
    }
  }
}

resource "ibm_is_placement_group" "this" {
  count       = length(var.placement_group)
  name        = lookup(var.placement_group[count.index], "name")
  strategy    = lookup(var.placement_group[count.index], "strategy")
  access_tags = lookup(var.placement_group[count.index], "access_tags")
  tags        = lookup(var.placement_group[count.index], "tags")
}

resource "ibm_is_security_group" "this" {
  count = length(var.security_group) == "0" ? "0" : (length(var.vpc) || data.ibm_is_vpc)
  vpc = try(
    data.ibm_is_vpc.this.id,
    element(ibm_is_vpc.this.*.id, lookup(var.security_group[count.index], "vpc"))
  )
  name        = lookup(var.security_group[count.index], "name")
  access_tags = lookup(var.security_group[count.index], "access_tags")
  tags        = lookup(var.security_group[count.index], "tags")
}

resource "ibm_is_security_group_rule" "this" {
  count     = length(var.security_group_rule) == "0" ? "0" : (length(var.security_group) || data.ibm_is_security_group)
  direction = lookup(var.security_group_rule[count.index], "direction")
  group = try(
    data.ibm_is_security_group.this.id,
    element(ibm_is_security_group.this.*.id, lookup(var.security_group_rule[count.index], "group"))
  )
  ip_version = lookup(var.security_group_rule[count.index], "ip_version")
  remote     = lookup(var.security_group_rule[count.index], "remote")

  dynamic "icmp" {
    for_each = lookup(var.security_group_rule[count.index], "icmp") == null ? [] : ["icmp"]
    content {
      type = lookup(icmp.value, "type")
      code = lookup(icmp.value, "code")
    }
  }

  dynamic "tcp" {
    for_each = lookup(var.security_group_rule[count.index], "tcp") == null ? [] : ["tcp"]
    content {
      port_max = lookup(tcp.value, "port_max")
      port_min = lookup(tcp.value, "port_min")
    }
  }

  dynamic "udp" {
    for_each = lookup(var.security_group_rule[count.index], "udp") == null ? [] : ["udp"]
    content {
      port_max = lookup(udp.value, "port_max")
      port_min = lookup(udp.value, "port_min")
    }
  }
}

resource "ibm_is_security_group_target" "this" {
  count = length(var.security_group_target) == "0" ? "0" : (length(var.security_group) || data.ibm_is_security_group) && (length(var.lb) || data.ibm_is_lb)
  security_group = try(
    data.ibm_is_security_group.this.id,
    element(ibm_is_security_group.this.*.id, lookup(var.security_group_target[count.index], "security_group"))
  )
  target = try(
    data.ibm_is_lb.this.id,
    element(ibm_is_lb.this.*.id, lookup(var.security_group_target[count.index], "target"))
  )
}

resource "ibm_is_virtual_endpoint_gateway" "this" {
  count = length(var.virtual_endpoint_gateway) == "0" ? "0" : (length(var.vpc) || data.ibm_is_vpc)
  name  = lookup(var.virtual_endpoint_gateway[count.index], "name")
  vpc = try(
    data.ibm_is_vpc.this.id,
    element(ibm_is_vpc.this.*.id, lookup(var.virtual_endpoint_gateway[count.index], "vpc"))
  )
  access_tags = lookup(var.virtual_endpoint_gateway[count.index], "access_tags")
  security_groups = [try(
    data.ibm_is_security_group.this.id,
    element(ibm_is_security_group.this.*.id, lookup(var.virtual_endpoint_gateway[count.index], "security_groups"))
  )]
  tags = lookup(var.virtual_endpoint_gateway[count.index], "tags")

  dynamic "ips" {
    for_each = lookup(var.virtual_endpoint_gateway[count.index], "ips") == null ? [] : ["ips"]
    content {
      id   = lookup(ips.value, "id")
      name = lookup(ips.value, "name")
      subnet = try(
        data.ibm_is_subnet.this.id,
        element(ibm_is_subnet.this.*.id, lookup(ips.value, "subnet"))
      )
    }
  }

  dynamic "target" {
    for_each = lookup(var.virtual_endpoint_gateway[count.index], "target") == null ? [] : ["target"]
    content {
      resource_type = lookup(target.value, "resource_type")
      crn           = lookup(target.value, "crn")
      name          = lookup(target.value, "name")
    }
  }
}

resource "ibm_is_virtual_endpoint_gateway_ip" "this" {
  count = length(var.virtual_endpoint_gateway_ip) == "0" ? "0" : (length(var.virtual_endpoint_gateway) || data.ibm_is_virtual_endpoint_gateway) && (length(var.subnet_reserved_ip) || data.ibm_is_subnet_reserved_ip)
  gateway = try(
    data.ibm_is_virtual_endpoint_gateway.this.id,
    element(ibm_is_virtual_endpoint_gateway.this.*.id, lookup(var.virtual_endpoint_gateway_ip[count.index], "gateway"))
  )
  reserved_ip = try(
    data.ibm_is_subnet_reserved_ip.this.id,
    element(ibm_is_subnet_reserved_ip.this.*.id, lookup(var.virtual_endpoint_gateway_ip[count.index], "reserved_ip"))
  )
}

resource "ibm_is_volume" "this" {
  count                = length(var.volume)
  name                 = lookup(var.volume[count.index], "name")
  profile              = lookup(var.volume[count.index], "profile")
  zone                 = lookup(var.volume[count.index], "zone")
  access_tags          = lookup(var.volume[count.index], "access_tags")
  capacity             = lookup(var.volume[count.index], "capacity")
  delete_all_snapshots = lookup(var.volume[count.index], "delete_all_snapshots")
  encryption_key       = lookup(var.volume[count.index], "encryption_key")
  iops                 = lookup(var.volume[count.index], "iops")
  source_snapshot      = lookup(var.volume[count.index], "source_snapshot")
  tags                 = lookup(var.volume[count.index], "tags")
}

resource "ibm_is_vpn_server" "this" {
  count           = length(var.vpn_server) == "0" ? "0" : (length(var.subnet) || data.ibm_is_subnet)
  certificate_crn = lookup(var.vpn_server[count.index], "certificate_crn")
  client_ip_pool  = lookup(var.vpn_server[count.index], "client_ip_pool")
  subnets = [try(
    data.ibm_is_subnet.this.id,
    element(ibm_is_subnet.this.*.id, lookup(var.vpn_server[count.index], "subnets"))
  )]
  access_tags            = lookup(var.vpn_server[count.index], "access_tags")
  client_dns_server_ips  = lookup(var.vpn_server[count.index], "client_dns_server_ips")
  client_idle_timeout    = lookup(var.vpn_server[count.index], "client_idle_timeout")
  enable_split_tunneling = lookup(var.vpn_server[count.index], "enable_split_tunneling")
  name                   = lookup(var.vpn_server[count.index], "name")
  port                   = lookup(var.vpn_server[count.index], "port")
  protocol               = lookup(var.vpn_server[count.index], "protocol")
  security_groups = [try(
    data.ibm_is_security_group.this.id,
    element(ibm_is_security_group.this.*.id, lookup(var.vpn_server[count.index], "security_groups"))
  )]

  dynamic "client_authentication" {
    for_each = lookup(var.vpn_server[count.index], "client_authentication") == null ? [] : ["client_authentication"]
    content {
      method            = lookup(client_authentication.value, "method")
      identity_provider = lookup(client_authentication.value, "identity_provider")
      client_ca_crn     = lookup(client_authentication.value, "client_ca_crn")
    }
  }
}

resource "ibm_is_vpn_server_client" "this" {
  count      = length(var.vpn_server_client) == "0" ? "0" : (length(var.vpn_server) || data.ibm_is_vpn_server)
  vpn_client = lookup(var.vpn_server_client[count.index], "vpn_client")
  vpn_server = try(
    data.ibm_is_vpn_server.this.id,
    element(ibm_is_vpn_server.this.*.id, lookup(var.vpn_server_client[count.index], "vpn_server"))
  )
  delete = lookup(var.vpn_server_client[count.index], "delete")
}

resource "ibm_is_vpn_server_route" "this" {
  count       = length(var.vpn_server_route) == "0" ? "0" : (length(var.vpn_server) || data.ibm_is_vpn_server)
  destination = lookup(var.vpn_server_route[count.index], "destination")
  vpn_server = try(
    data.ibm_is_vpn_server.this.id,
    element(ibm_is_vpn_server.this.*.id, lookup(var.vpn_server_route[count.index], "vpn_server"))
  )
  action = lookup(var.vpn_server_route[count.index], "action")
  name   = lookup(var.vpn_server_route[count.index], "name")
}

resource "ibm_is_vpn_gateway" "this" {
  count = length(var.vpn_gateway) == "0" ? "0" : (length(var.subnet) || data.ibm_is_subnet)
  name  = lookup(var.vpn_gateway[count.index], "name")
  subnet = try(
    data.ibm_is_subnet.this.id,
    element(ibm_is_subnet.this.*.id, lookup(var.vpn_gateway[count.index], "subnet"))
  )
  mode        = lookup(var.vpn_gateway[count.index], "mode")
  tags        = lookup(var.vpn_gateway[count.index], "tags")
  access_tags = lookup(var.vpn_gateway[count.index], "access_tags")
}

resource "ibm_is_vpn_gateway_connection" "this" {
  count         = length(var.vpn_gateway_connection) == "0" ? "0" : (length(var.vpn_gateway) || data.ibm_is_vpn_gateway)
  name          = lookup(var.vpn_gateway_connection[count.index], "name")
  peer_address  = lookup(var.vpn_gateway_connection[count.index], "peer_address")
  preshared_key = lookup(var.vpn_gateway_connection[count.index], "preshared_key")
  vpn_gateway = try(
    data.ibm_is_vpn_gateway.this.id,
    element(ibm_is_vpn_gateway.this.*.id, lookup(var.vpn_gateway_connection[count.index], "vpn_gateway"))
  )
  action         = lookup(var.vpn_gateway_connection[count.index], "action")
  admin_state_up = lookup(var.vpn_gateway_connection[count.index], "admin_state_up")
  ike_policy = try(
    data.ibm_is_ike_policy.this.id,
    element(ibm_is_ike_policy.this.*.id, lookup(var.vpn_gateway_connection[count.index], "ike_policy"))
  )
  interval = lookup(var.vpn_gateway_connection[count.index], "interval")
  ipsec_policy = try(
    data.ibm_is_ipsec_policy.this.id,
    element(ibm_is_ipsec_policy.this.*.id, lookup(var.vpn_gateway_connection[count.index], "ipsec_policy"))
  )
  local_cidrs = lookup(var.vpn_gateway_connection[count.index], "local_cidrs")
  peer_cidrs  = lookup(var.vpn_gateway_connection[count.index], "peer_cidrs")
  timeout     = lookup(var.vpn_gateway_connection[count.index], "timeout")
}