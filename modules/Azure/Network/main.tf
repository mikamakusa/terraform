resource "azurerm_application_gateway" "this" {
  count = length(var.application_gateway)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.application_gateway[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  firewall_policy_id = try(
    element(azure, lookup(var.application_gateway[count.index], "firewall_policy_id"))
  )
  fips_enabled                      = lookup(var.application_gateway[count.index], "fips_enabled")
  enable_http2                      = lookup(var.application_gateway[count.index], "enable_http2")
  force_firewall_policy_association = lookup(var.application_gateway[count.index], "force_firewall_policy_association")
  zones                             = lookup(var.application_gateway[count.index], "zones")
  tags = merge(
    var.tags,
    lookup(var.application_gateway[count.index], "tags")
  )

  dynamic "authentication_certificate" {
    for_each = lookup(var.application_gateway[count.index], "authentication_certificate") == null ? [] : ["authentication_certificate"]
    content {
      data = lookup(authentication_certificate.value, "data")
      name = lookup(authentication_certificate.value, "name")
    }
  }

  dynamic "trusted_root_certificate" {
    for_each = lookup(var.application_gateway[count.index], "trusted_root_certificate") == null ? [] : ["trusted_root_certificate"]
    content {
      name                = lookup(trusted_root_certificate.value, "name")
      data                = lookup(trusted_root_certificate.value, "data")
      key_vault_secret_id = lookup(trusted_root_certificate.value, "key_vault_secret_id")
    }
  }

  dynamic "backend_address_pool" {
    for_each = lookup(var.application_gateway[count.index], "backend_address_pool") == null ? [] : ["backend_address_pool"]
    content {
      name         = lookup(backend_address_pool.value, "name")
      fqdns        = lookup(backend_address_pool.value, "fqdns")
      ip_addresses = lookup(backend_address_pool.value, "ip_addresses")
    }
  }

  dynamic "backend_http_settings" {
    for_each = lookup(var.application_gateway[count.index], "backend_http_settings") == null ? [] : ["backend_http_settings"]
    content {
      cookie_based_affinity               = lookup(backend_http_settings.value, "cookie_based_affinity")
      name                                = lookup(backend_http_settings.value, "name")
      port                                = lookup(backend_http_settings.value, "port")
      protocol                            = lookup(backend_http_settings.value, "protocol")
      probe_name                          = lookup(backend_http_settings.value, "probe_name")
      request_timeout                     = lookup(backend_http_settings.value, "request_timeout")
      host_name                           = lookup(backend_http_settings.value, "host_name")
      pick_host_name_from_backend_address = lookup(backend_http_settings.value, "pick_host_name_from_backend_address")
      affinity_cookie_name                = lookup(backend_http_settings.value, "affinity_cookie_name")
      trusted_root_certificate_names      = lookup(backend_http_settings.value, "trusted_root_certificate_names")

      dynamic "authentication_certificate" {
        for_each = lookup(backend_http_settings.value, "authentication_certificate") == null ? [] : ["authentication_certificate"]
        content {
          name = lookup(authentication_certificate.value, "name")
        }
      }

      dynamic "connection_draining" {
        for_each = lookup(backend_http_settings.value, "connection_draining") == null ? [] : ["connection_draining"]
        content {
          drain_timeout_sec = lookup(connection_draining.value, "drain_timeout_sec")
          enabled           = lookup(connection_draining.value, "enabled")
        }
      }
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = lookup(var.application_gateway[count.index], "frontend_ip_configuration") == null ? [] : ["frontend_ip_configuration"]
    content {
      name = lookup(frontend_ip_configuration.value, "name")
    }
  }

  dynamic "frontend_port" {
    for_each = lookup(var.application_gateway[count.index], "frontend_port") == null ? [] : ["frontend_port"]
    content {
      name = lookup(frontend_port.value, "name")
      port = lookup(frontend_port.value, "port")
    }
  }

  dynamic "gateway_ip_configuration" {
    for_each = lookup(var.application_gateway[count.index], "gateway_ip_configuration") == null ? [] : ["gateway_ip_configuration"]
    content {
      name = lookup(gateway_ip_configuration.value, "name")
      subnet_id = try(
        element(azurerm_subnet.this.*.id, lookup(gateway_ip_configuration.value, "subnet_id"))
      )
    }
  }

  dynamic "http_listener" {
    for_each = lookup(var.application_gateway[count.index], "http_listener") == null ? [] : ["http_listener"]
    content {
      frontend_ip_configuration_name = lookup(http_listener.value, "frontend_ip_configuration_name")
      frontend_port_name             = lookup(http_listener.value, "frontend_port_name")
      name                           = lookup(http_listener.value, "name")
      protocol                       = lookup(http_listener.value, "protocol")
    }
  }

  dynamic "identity" {
    for_each = lookup(var.application_gateway[count.index], "identity") == null ? [] : ["identity"]
    content {
      identity_ids = lookup(identity.value, "identity_ids")
      type         = lookup(identity.value, "type")
    }
  }

  dynamic "private_link_configuration" {
    for_each = lookup(var.application_gateway[count.index], "private_link_configuration") == null ? [] : ["private_link_configuration"]
    content {
      name = lookup(private_link_configuration.value, "name")

      dynamic "ip_configuration" {
        for_each = lookup(private_link_configuration.value, "ip_configuration") == null ? [] : ["ip_configuration"]
        content {
          name                          = lookup(ip_configuration.value, "name")
          primary                       = lookup(ip_configuration.value, "primary")
          private_ip_address_allocation = lookup(ip_configuration.value, "private_ip_address_allocation")
          subnet_id = try(
            element(azurerm_subnet.this.*.id, lookup(ip_configuration.value, "subnet_id"))
          )
          private_ip_address = lookup(ip_configuration.value, "private_ip_address")
        }
      }
    }
  }

  dynamic "redirect_configuration" {
    for_each = lookup(var.application_gateway[count.index], "redirect_configuration") == null ? [] : ["redirect_configuration"]
    content {
      name          = lookup(redirect_configuration.value, "name")
      redirect_type = lookup(redirect_configuration.value, "redirect_type")
    }
  }

  dynamic "rewrite_rule_set" {
    for_each = lookup(var.application_gateway[count.index], "rewrite_rule_set") == null ? [] : ["rewrite_rule_set"]
    content {
      name = lookup(rewrite_rule_set.value, "name")
    }
  }

  dynamic "url_path_map" {
    for_each = lookup(var.application_gateway[count.index], "url_path_map") == null ? [] : ["url_path_map"]
    content {
      name                                = lookup(url_path_map.value, "name")
      default_backend_address_pool_name   = lookup(url_path_map.value, "default_backend_address_pool_name")
      default_backend_http_settings_name  = lookup(url_path_map.value, "default_backend_http_settings_name")
      default_redirect_configuration_name = lookup(url_path_map.value, "default_redirect_configuration_name")
      default_rewrite_rule_set_name       = lookup(url_path_map.value, "default_rewrite_rule_set_name")

      dynamic "path_rule" {
        for_each = lookup(url_path_map.value, "path_rule") == null ? [] : ["path_rule"]
        content {
          name  = lookup(path_rule.value, "name")
          paths = lookup(path_rule.value, "paths")
        }
      }
    }
  }

  dynamic "trusted_client_certificate" {
    for_each = lookup(var.application_gateway[count.index], "trusted_client_certificate") == null ? [] : ["trusted_client_certificate"]
    content {
      data = lookup(trusted_client_certificate.value, "data")
      name = lookup(trusted_client_certificate.value, "name")
    }
  }

  dynamic "ssl_profile" {
    for_each = lookup(var.application_gateway[count.index], "ssl_profile") == null ? [] : ["ssl_profile"]
    content {
      name                                 = lookup(ssl_profile.value, "name")
      trusted_client_certificate_names     = lookup(ssl_profile.value, "trusted_client_certificate_names")
      verify_client_cert_issuer_dn         = lookup(ssl_profile.value, "verify_client_cert_issuer_dn")
      verify_client_certificate_revocation = lookup(ssl_profile.value, "verify_client_certificate_revocation")

      dynamic "ssl_policy" {
        for_each = lookup(ssl_profile.value, "ssl_policy") == null ? [] : ["ssl_policy"]
        content {
          disabled_protocols   = lookup(ssl_policy.value, "disabled_protocols")
          policy_name          = lookup(ssl_policy.value, "policy_name")
          policy_type          = lookup(ssl_policy.value, "policy_type")
          cipher_suites        = lookup(ssl_policy.value, "cipher_suites")
          min_protocol_version = lookup(ssl_policy.value, "min_protocol_version")
        }
      }
    }
  }

  dynamic "waf_configuration" {
    for_each = lookup(var.application_gateway[count.index], "waf_configuration") == null ? [] : ["waf_configuration"]
    content {
      enabled                  = lookup(waf_configuration.value, "enabled")
      firewall_mode            = lookup(waf_configuration.value, "firewall_mode")
      rule_set_version         = lookup(waf_configuration.value, "rule_set_version")
      rule_set_type            = lookup(waf_configuration.value, "rule_set_type")
      file_upload_limit_mb     = lookup(waf_configuration.value, "file_upload_limit_mb")
      request_body_check       = lookup(waf_configuration.value, "request_body_check")
      max_request_body_size_kb = lookup(waf_configuration.value, "max_request_body_size_kb")

      dynamic "exclusion" {
        for_each = lookup(waf_configuration.value, "exclusion") == null ? [] : ["exclusion"]
        content {
          match_variable          = lookup(exclusion.value, "match_variable")
          selector_match_operator = lookup(exclusion.value, "selector_match_operator")
          selector                = lookup(exclusion.value, "selector")
        }
      }

      dynamic "disabled_rule_group" {
        for_each = lookup(waf_configuration.value, "disabled_rule_group") == null ? [] : ["disabled_rule_group"]
        content {
          rule_group_name = lookup(disabled_rule_group.value, "rule_group_name")
          rules           = lookup(disabled_rule_group.value, "rules")
        }
      }
    }
  }

  dynamic "custom_error_configuration" {
    for_each = lookup(var.application_gateway[count.index], "custom_error_configuration") == null ? [] : ["custom_error_configuration"]
    content {
      custom_error_page_url = lookup(custom_error_configuration.value, "custom_error_page_url")
      status_code           = lookup(custom_error_configuration.value, "status_code")
    }
  }

  dynamic "redirect_configuration" {
    for_each = lookup(var.application_gateway[count.index], "redirect_configuration") == null ? [] : ["redirect_configuration"]
    content {
      name                 = lookup(redirect_configuration.value, "name")
      redirect_type        = lookup(redirect_configuration.value, "redirect_type")
      target_listener_name = lookup(redirect_configuration.value, "target_listener_name")
      target_url           = lookup(redirect_configuration.value, "target_url")
      include_path         = lookup(redirect_configuration.value, "include_path")
      include_query_string = lookup(redirect_configuration.value, "include_query_string")
    }
  }

  dynamic "autoscale_configuration" {
    for_each = lookup(var.application_gateway[count.index], "autoscale_configuration") == null ? [] : ["autoscale_configuration"]
    content {
      min_capacity = lookup(autoscale_configuration.value, "min_capacity")
      max_capacity = lookup(autoscale_configuration.value, "max_capacity")
    }
  }

  dynamic "rewrite_rule_set" {
    for_each = lookup(var.application_gateway[count.index], "rewrite_rule_set") == null ? [] : ["rewrite_rule_set"]
    content {
      name = lookup(rewrite_rule_set.value, "name")

      dynamic "rewrite_rule" {
        for_each = lookup(rewrite_rule_set.value, "rewrite_rule") == null ? [] : ["rewrite_rule"]
        content {
          name          = lookup(rewrite_rule.value, "name")
          rule_sequence = lookup(rewrite_rule.value, "rule_sequence")

          dynamic "condition" {
            for_each = lookup(rewrite_rule.value, "condition") == null ? [] : ["condition"]
            content {
              pattern     = lookup(condition.value, "pattern")
              variable    = lookup(condition.value, "variable")
              ignore_case = lookup(condition.value, "ignore_case")
              negate      = lookup(condition.value, "negate")
            }
          }

          dynamic "request_header_configuration" {
            for_each = lookup(rewrite_rule.value, "request_header_configuration") == null ? [] : ["request_header_configuration"]
            content {
              header_name  = lookup(request_header_configuration.value, "header_name")
              header_value = lookup(request_header_configuration.value, "header_value")
            }
          }

          dynamic "response_header_configuration" {
            for_each = lookup(rewrite_rule.value, "response_header_configuration") == null ? [] : ["response_header_configuration"]
            content {
              header_name  = lookup(response_header_configuration.value, "header_name")
              header_value = lookup(response_header_configuration.value, "header_value")
            }
          }

          dynamic "url" {
            for_each = lookup(rewrite_rule.value, "url") == null ? [] : ["url"]
            content {
              query_string = lookup(url.value, "query_string")
              path         = lookup(url.value, "path")
              components   = lookup(url.value, "components")
              reroute      = lookup(url.value, "reroute")
            }
          }
        }
      }
    }
  }

  dynamic "ssl_policy" {
    for_each = lookup(var.application_gateway[count.index], "ssl_policy") == null ? [] : ["ssl_policy"]
    content {
      disabled_protocols   = lookup(ssl_policy.value, "disabled_protocols")
      policy_name          = lookup(ssl_policy.value, "policy_name")
      policy_type          = lookup(ssl_policy.value, "policy_type")
      cipher_suites        = lookup(ssl_policy.value, "cipher_suites")
      min_protocol_version = lookup(ssl_policy.value, "min_protocol_version")
    }
  }

  dynamic "ssl_certificate" {
    for_each = lookup(var.application_gateway[count.index], "ssl_certificate") == null ? [] : ["ssl_certificate"]
    content {
      name                = lookup(ssl_certificate.value, "name")
      data                = lookup(ssl_certificate.value, "data")
      key_vault_secret_id = lookup(ssl_certificate.value, "key_vault_secret_id")
      password            = lookup(ssl_certificate.value, "password")
    }
  }

  dynamic "global" {
    for_each = lookup(var.application_gateway[count.index], "global") == null ? [] : ["global"]
    content {
      request_buffering_enabled  = lookup(global.value, "request_buffering_enabled")
      response_buffering_enabled = lookup(global.value, "response_buffering_enabled")
    }
  }

  dynamic "probe" {
    for_each = lookup(var.application_gateway[count.index], "probe") == null ? [] : ["probe"]
    content {
      interval            = lookup(probe.value, "interval")
      name                = lookup(probe.value, "name")
      path                = lookup(probe.value, "path")
      protocol            = lookup(probe.value, "protocol")
      timeout             = lookup(probe.value, "timeout")
      unhealthy_threshold = lookup(probe.value, "unhealthy_threshold")
    }
  }

  dynamic "request_routing_rule" {
    for_each = lookup(var.application_gateway[count.index], "request_routing_rule") == null ? [] : ["request_routing_rule"]
    content {
      http_listener_name = lookup(request_routing_rule.value, "http_listener_name")
      name               = lookup(request_routing_rule.value, "name")
      rule_type          = lookup(request_routing_rule.value, "rule_type")
    }
  }

  dynamic "sku" {
    for_each = lookup(var.application_gateway[count.index], "sku") == null ? [] : ["sku"]
    content {
      name     = lookup(sku.value, "name")
      tier     = lookup(sku.value, "tier")
      capacity = lookup(sku.value, "capacity")
    }
  }
}

resource "azurerm_application_security_group" "this" {
  count = length(var.application_security_group)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.application_security_group[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  tags = merge(
    var.tags,
    lookup(var.application_security_group[count.index], "tags")
  )
}

resource "azurerm_bastion_host" "this" {
  count = length(var.bastion_host)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.bastion_host[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  copy_paste_enabled     = lookup(var.bastion_host[count.index], "copy_paste_enabled")
  file_copy_enabled      = lookup(var.bastion_host[count.index], "file_copy_enabled")
  ip_connect_enabled     = lookup(var.bastion_host[count.index], "ip_connect_enabled")
  sku                    = lookup(var.bastion_host[count.index], "sku")
  scale_units            = lookup(var.bastion_host[count.index], "scale_units")
  shareable_link_enabled = lookup(var.bastion_host[count.index], "shareable_link_enabled")
  tunneling_enabled      = lookup(var.bastion_host[count.index], "tunneling_enabled")
  tags = merge(
    var.tags,
    location(var.bastion_host[count.index], tags)
  )

  dynamic "ip_configuration" {
    for_each = lookup(var.bastion_host[count.index], "ip_configuration") == null ? [] : ["ip_configuration"]
    content {
      name = lookup(ip_configuration.value, "name")
      public_ip_address_id = try(
        element(azurerm_public_ip.this.*.id, lookup(ip_configuration.value, "public_ip_address_id"))
      )
      subnet_id = try(
        element(azurerm_subnet.this.*.id, lookup(ip_configuration.value, "subnet_id"))
      )
    }
  }
}

resource "azurerm_express_route_circuit" "this" {
  count = length(var.express_route_circuit)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.express_route_circuit[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  service_provider_name    = lookup(var.express_route_circuit[count.index], "service_provider_name")
  peering_location         = lookup(var.express_route_circuit[count.index], "peering_location")
  bandwidth_in_mbps        = lookup(var.express_route_circuit[count.index], "bandwidth_in_mbps")
  allow_classic_operations = lookup(var.express_route_circuit[count.index], "allow_classic_operations")
  express_route_port_id = try(
    element(azurerm_express_route_port.this.*.id, lookup(var.express_route_circuit[count.index], "express_route_port_id"))
  )
  bandwidth_in_gbps = lookup(var.express_route_circuit[count.index], "bandwidth_in_gbps")
  authorization_key = lookup(var.express_route_circuit[count.index], "authorization_key")
  tags = merge(
    var.tags,
    location(var.express_route_circuit[count.index], "tags")
  )

  dynamic "sku" {
    for_each = lookup(var.express_route_circuit[count.index], "sku") == null ? [] : ["sku"]
    content {
      family = lookup(sku.value, "family")
      tier   = lookup(sku.value, "tier")
    }
  }
}

resource "azurerm_express_route_circuit_authorization" "this" {
  count = length(var.express_route_circuit_authorization) == "0" ? "0" : length(var.express_route_circuit)
  express_route_circuit_name = try(
    element(azurerm_express_route_circuit.this.*.name, lookup(var.express_route_circuit_authorization[count.index], "express_route_circuit_id"))
  )
  name = lookup(var.express_route_circuit_authorization[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
}

resource "azurerm_express_route_circuit_connection" "this" {
  count               = length(var.express_route_circuit_connection) == "0" ? "0" : (length(var.express_route_circuit_peering))
  address_prefix_ipv4 = lookup(var.express_route_circuit_connection[count.index], "address_prefix_ipv4")
  name                = lookup(var.express_route_circuit_connection[count.index], "name")
  peer_peering_id = try(
    element(azurerm_express_route_circuit_peering.this.*.id, lookup(var.express_route_circuit_connection[count.index], "peer_peering_id"))
  )
  peering_id = try(
    element(azurerm_express_route_circuit_peering.this.*.id, lookup(var.express_route_circuit_connection[count.index], "peering_id"))
  )
  authorization_key   = lookup(var.express_route_circuit_connection[count.index], "authorization_key")
  address_prefix_ipv6 = lookup(var.express_route_circuit_connection[count.index], "address_prefix_ipv6")
}

resource "azurerm_express_route_circuit_peering" "this" {
  count = length(var.express_route_circuit_peering) == "0" ? "0" : length(var.express_route_circuit)
  express_route_circuit_name = try(
    element(azurerm_express_route_circuit.this.*.name, lookup(var.express_route_circuit_peering[count.index], "express_route_circuit_id"))
  )
  peering_type = lookup(var.express_route_circuit_peering[count.index], "peering_type")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  vlan_id                       = lookup(var.express_route_circuit_peering[count.index], "vlan_id")
  primary_peer_address_prefix   = lookup(var.express_route_circuit_peering[count.index], "primary_peer_address_prefix")
  secondary_peer_address_prefix = lookup(var.express_route_circuit_peering[count.index], "secondary_peer_address_prefix")
  ipv4_enabled                  = lookup(var.express_route_circuit_peering[count.index], "ipv4_enabled")
  shared_key                    = lookup(var.express_route_circuit_peering[count.index], "shared_key")
  peer_asn                      = lookup(var.express_route_circuit_peering[count.index], "peer_asn")
  route_filter_id = try(
    element(azurerm_route_filter.this.*.id, lookup(var.express_route_circuit_peering[count.index], "route_filter_id"))
  )

  dynamic "microsoft_peering_config" {
    for_each = lookup(var.express_route_circuit_peering[count.index], "microsoft_peering_config") == null ? [] : ["microsoft_peering_config"]
    content {
      advertised_public_prefixes = lookup(microsoft_peering_config.value, "advertised_public_prefixes")
      customer_asn               = lookup(microsoft_peering_config.value, "customer_asn")
      routing_registry_name      = lookup(microsoft_peering_config.value, "routing_registry_name")
      advertised_communities     = lookup(microsoft_peering_config.value, "advertised_communities")
    }
  }

  dynamic "ipv6" {
    for_each = lookup(var.express_route_circuit_peering[count.index], "ipv6") == null ? [] : ["ipv6"]
    content {
      primary_peer_address_prefix   = lookup(ipv6.value, "primary_peer_address_prefix")
      secondary_peer_address_prefix = lookup(ipv6.value, "secondary_peer_address_prefix")
      enabled                       = lookup(ipv6.value, "enabled")
      route_filter_id = try(
        element(azurerm_route_filter.this.*.id, lookup(ipv6.value, "route_filter_id"))
      )

      dynamic "microsoft_peering" {
        for_each = lookup(ipv6.value, "microsoft_peering") == null ? [] : ["microsoft_peering"]
        content {
          advertised_public_prefixes = lookup(microsoft_peering.value, "advertised_public_prefixes")
          customer_asn               = lookup(microsoft_peering.value, "customer_asn")
          routing_registry_name      = lookup(microsoft_peering.value, "routing_registry_name")
          advertised_communities     = lookup(microsoft_peering.value, "advertised_communities")
        }
      }
    }
  }
}

resource "azurerm_express_route_connection" "this" {
  count = length(var.express_route_connection) == "0" ? "0" : (length(var.express_route_circuit) && length(var.express_route_gateway))
  express_route_circuit_peering_id = try(
    element(azurerm_express_route_circuit_peering.this.*.id, lookup(var.express_route_connection[count.index], "express_route_circuit_peering_id"))
  )
  express_route_gateway_id = try(
    element(azurerm_express_route_gateway.this.*.id, lookup(var.express_route_connection[count.index], "express_route_gateway_id"))
  )
  name                                 = lookup(var.express_route_connection[count.index], "name")
  authorization_key                    = lookup(var.express_route_connection[count.index], "authorization_key")
  enable_internet_security             = lookup(var.express_route_connection[count.index], "enable_internet_security")
  express_route_gateway_bypass_enabled = lookup(var.express_route_connection[count.index], "express_route_gateway_bypass_enabled")
  routing_weight                       = lookup(var.express_route_connection[count.index], "routing_weight")


  dynamic "routing" {
    for_each = lookup(var.express_route_connection[count.index], "routing") == null ? [] : ["routing"]
    content {
      associated_route_table_id = try(
        element(azurerm_virtual_hub_route_table.this.*.id, lookup(routing.value, "associated_route_table_id"))
      )
      inbound_route_map_id = try(
        element(azurerm_route_map.this.*.id, lookup(routing.value, "inbound_route_map_id"))
      )
      outbound_route_map_id = try(
        element(azurerm_route_map.this.*.id, lookup(routing.value, "outbound_route_map_id"))
      )

      dynamic "propagated_route_table" {
        for_each = lookup(routing.value, "propagated_route_table")
        content {
          labels = lookup(propagated_route_table.value, "labels")
          route_table_ids = try(
            element(azurerm_virtual_hub_route_table.this.*.id, lookup(propagated_route_table.value, "route_table_ids"))
          )
        }
      }
    }
  }
}

resource "azurerm_express_route_gateway" "this" {
  count = length(var.express_route_gateway)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.express_route_gateway[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  scale_units = lookup(var.express_route_gateway[count.index], "scale_units")
  virtual_hub_id = try(
    element(azurerm_virtual_hub.this.*.id, lookup(var.express_route_gateway[count.index], "virtual_hub_id"))
  )
  allow_non_virtual_wan_traffic = lookup(var.express_route_gateway[count.index], "allow_non_virtual_wan_traffic")
  tags = merge(
    var.tags,
    lookup(var.express_route_gateway[count.index], "tags")
  )
}

resource "azurerm_express_route_port" "this" {
  count             = length(var.express_route_port)
  bandwidth_in_gbps = lookup(var.express_route_port[count.index], "bandwidth_in_gbps")
  encapsulation     = lookup(var.express_route_port[count.index], "encapsulation")
  location = try(
    data.azurerm_resource_group.this.location
  )
  name             = lookup(var.express_route_port[count.index], "name")
  peering_location = lookup(var.express_route_port[count.index], "peering_location")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  billing_type = lookup(var.express_route_port[count.index], "billing_type")
  tags = merge(
    var.tags,
    lookup(var.express_route_port[count.index], "tags")
  )

  dynamic "link1" {
    for_each = lookup(var.express_route_port[count.index], "link1") == null ? [] : ["link1"]
    content {
      admin_enabled                 = lookup(link1.value, "admin_enabled")
      macsec_cipher                 = lookup(link1.value, "macsec_cipher")
      macsec_ckn_keyvault_secret_id = lookup(link1.value, "macsec_ckn_keyvault_secret_id")
      macsec_cak_keyvault_secret_id = lookup(link1.value, "macsec_cak_keyvault_secret_id")
    }
  }

  dynamic "link2" {
    for_each = lookup(var.express_route_port[count.index], "link2") == null ? [] : ["link2"]
    content {
      admin_enabled                 = lookup(link2.value, "admin_enabled")
      macsec_cipher                 = lookup(link2.value, "macsec_cipher")
      macsec_ckn_keyvault_secret_id = lookup(link2.value, "macsec_ckn_keyvault_secret_id")
      macsec_cak_keyvault_secret_id = lookup(link2.value, "macsec_cak_keyvault_secret_id")
    }
  }

  dynamic "identity" {
    for_each = lookup(var.express_route_port[count.index], "identity") == null ? [] : ["identity"]
    content {
      identity_ids = lookup(identity.value, "identity_ids")
      type         = lookup(identity.value, "type")
    }
  }
}

resource "azurerm_express_route_port_authorization" "this" {
  count = length(var.express_route_port_authorization) == "0" ? "0" : length(var.express_route_port)
  express_route_port_name = try(
    element(azurerm_express_route_port.this.*.name, lookup(var.express_route_port_authorization[count.index], "express_route_port_id"))
  )
  name = lookup(var.express_route_port_authorization[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
}

resource "azurerm_firewall" "this" {
  count = length(var.firewall)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.firewall[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  sku_name = lookup(var.firewall[count.index], "sku_name")
  sku_tier = lookup(var.firewall[count.index], "sku_tier")
  firewall_policy_id = try(
    element(azurerm_firewall_policy.this.*.id, lookup(var.firewall[count.index], "firewall_policy_id"))
  )
  dns_servers       = lookup(var.firewall[count.index], "dns_servers")
  private_ip_ranges = lookup(var.firewall[count.index], "private_ip_ranges")
  threat_intel_mode = lookup(var.firewall[count.index], "threat_intel_mode")
  zones             = lookup(var.firewall[count.index], "zones")
  tags = merge(
    var.tags,
    lookup(var.firewall[count.index], "tags")
  )

  dynamic "ip_configuration" {
    for_each = lookup(var.firewall[count.index], "ip_configuration") == null ? [] : ["ip_configuration"]
    content {
      name = lookup(ip_configuration.value, "name")
      subnet_id = try(
        element(azurerm_subnet.this.*.id, lookup(ip_configuration.value, "subnet_id"))
      )
      public_ip_address_id = try(
        element(azurerm_public_ip.this.*.id, lookup(ip_configuration.value, "public_ip_address_id"))
      )
    }
  }

  dynamic "management_ip_configuration" {
    for_each = lookup(var.firewall[count.index], "management_ip_configuration") == null ? [] : ["management_ip_configuration"]
    content {
      name = lookup(management_ip_configuration.value, "name")
      public_ip_address_id = try(
        element(azurerm_public_ip.this.*.id, lookup(management_ip_configuration.value, "public_ip_address_id"))
      )
      subnet_id = try(
        element(azurerm_subnet.this.*.id, lookup(management_ip_configuration.value, "subnet_id"))
      )
    }
  }

  dynamic "virtual_hub" {
    for_each = lookup(var.firewall[count.index], "virtual_hub") == null ? [] : ["virtual_hub"]
    content {
      virtual_hub_id = try(
        element(azurerm_virtual_hub.this.*.id, lookup(virtual_hub.value, "virtual_hub_id"))
      )
      public_ip_count = lookup(virtual_hub.value, "public_ip_count")
    }
  }
}

resource "azurerm_firewall_application_rule_collection" "this" {
  count  = length(var.firewall_application_rule_collection) == "0" ? "0" : length(var.firewall)
  action = lookup(var.firewall_application_rule_collection[count.index], "action")
  azure_firewall_name = try(
    element(azurerm_firewall.this.*.name, lookup(var.firewall_application_rule_collection[count.index], "azure_firewall_id"))
  )
  name     = lookup(var.firewall_application_rule_collection[count.index], "name")
  priority = lookup(var.firewall_application_rule_collection[count.index], "priority")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )

  dynamic "rule" {
    for_each = lookup(var.firewall_application_rule_collection[count.index], "rule")
    content {
      name             = lookup(rule.value, "name")
      description      = lookup(rule.value, "description")
      source_addresses = lookup(rule.value, "source_addresses")
      source_ip_groups = lookup(rule.value, "source_ip_groups")
      fqdn_tags        = lookup(rule.value, "fqdn_tags")
      target_fqdns     = lookup(rule.value, "target_fqdns")

      dynamic "protocol" {
        for_each = lookup(rule.value, "protocol")
        content {
          port = lookup(protocol.value, "port")
          type = lookup(protocol.value, "type")
        }
      }
    }
  }
}

resource "azurerm_firewall_nat_rule_collection" "this" {
  count  = length(var.firewall_nat_rule_collection) == "0" ? "0" : length(var.firewall)
  action = lookup(var.firewall_nat_rule_collection[count.index], "action")
  azure_firewall_name = try(
    element(azurerm_firewall.this.*.name, lookup(var.firewall_nat_rule_collection[count.index], "azure_firewall_id"))
  )
  name     = lookup(var.firewall_nat_rule_collection[count.index], "name")
  priority = lookup(var.firewall_nat_rule_collection[count.index], "priority")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )

  dynamic "rule" {
    for_each = lookup(var.firewall_nat_rule_collection[count.index], "rule") == null ? [] : ["rule"]
    content {
      destination_addresses = lookup(rule.value, "destination_addresses")
      destination_ports     = lookup(rule.value, "destination_ports")
      name                  = lookup(rule.value, "name")
      protocols             = lookup(rule.value, "protocols")
      translated_address    = lookup(rule.value, "translated_address")
      translated_port       = lookup(rule.value, "translated_port")
      description           = lookup(rule.value, "description")
      source_addresses      = lookup(rule.value, "source_addresses")
      source_ip_groups      = lookup(rule.value, "source_ip_groups")
    }
  }
}

resource "azurerm_firewall_network_rule_collection" "this" {
  count  = length(var.firewall_network_rule_collection) == "0" ? "0" : length(var.firewall)
  action = lookup(var.firewall_network_rule_collection[count.index], "action")
  azure_firewall_name = try(
    element(azurerm_firewall.this.*.name, lookup(var.firewall_network_rule_collection[count.index], "azure_firewall_id"))
  )
  name     = lookup(var.firewall_network_rule_collection[count.index], "name")
  priority = lookup(var.firewall_network_rule_collection[count.index], "priority")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )

  dynamic "rule" {
    for_each = lookup(var.firewall_network_rule_collection[count.index], "rule") == null ? [] : ["rule"]
    content {
      destination_ports     = lookup(rule.value, "destination_ports")
      name                  = lookup(rule.value, "name")
      protocols             = lookup(rule.value, "protocols")
      description           = lookup(rule.value, "description")
      destination_addresses = lookup(rule.value, "destination_addresses")
      destination_fqdns     = lookup(rule.value, "destination_fqdns")
      destination_ip_groups = lookup(rule.value, "destination_ip_groups")
      source_addresses      = lookup(rule.value, "source_addresses")
      source_ip_groups      = lookup(rule.value, "source_ip_groups")
    }
  }
}

resource "azurerm_firewall_policy" "this" {
  count = length(var.firewall_policy)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.firewall_policy[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  base_policy_id                    = lookup(var.firewall_policy[count.index], "base_policy_id")
  auto_learn_private_ranges_enabled = lookup(var.firewall_policy[count.index], "auto_learn_private_ranges_enabled")
  sku                               = lookup(var.firewall_policy[count.index], "sku")
  tags = merge(
    var.tags,
    lookup(var.firewall_policy[count.index], "tags")
  )
  threat_intelligence_mode = lookup(var.firewall_policy[count.index], "threat_intelligence_mode")
  sql_redirect_allowed     = lookup(var.firewall_policy[count.index], "sql_redirect_allowed")

  dynamic "dns" {
    for_each = lookup(var.firewall_policy[count.index], "dns") == null ? [] : ["dns"]
    content {
      proxy_enabled = lookup(dns.value, "proxy_enabled")
      servers       = lookup(dns.value, "servers")
    }
  }

  dynamic "identity" {
    for_each = lookup(var.firewall_policy[count.index], "identity") == null ? [] : ["identity"]
    content {
      identity_ids = lookup(identity.value, "identity_ids")
      type         = lookup(identity.value, "type")
    }
  }

  dynamic "insights" {
    for_each = lookup(var.firewall_policy[count.index], "insights") == null ? [] : ["insights"]
    content {
      default_log_analytics_workspace_id = lookup(insights.value, "default_log_analytics_workspace_id")
      enabled                            = lookup(insights.value, "enabled")
      retention_in_days                  = lookup(insights.value, "retention_in_days")

      dynamic "log_analytics_workspace" {
        for_each = lookup(insights.value, "log_analytics_workspace") == null ? [] : ["log_analytics_workspace"]
        content {
          firewall_location = lookup(log_analytics_workspace.value, "firewall_location")
          id                = lookup(log_analytics_workspace.value, "id")
        }
      }
    }
  }

  dynamic "intrusion_detection" {
    for_each = lookup(var.firewall_policy[count.index], "intrusion_detection") == null ? [] : ["intrusion_detection"]
    content {
      mode           = lookup(intrusion_detection.value, "mode")
      private_ranges = lookup(intrusion_detection.value, "private_ranges")

      dynamic "signature_overrides" {
        for_each = lookup(intrusion_detection.value, "signature_overrides") == null ? [] : ["signature_overrides"]
        content {
          id    = lookup(signature_overrides.value, "id")
          state = lookup(signature_overrides.value, "state")
        }
      }

      dynamic "traffic_bypass" {
        for_each = lookup(intrusion_detection.value, "traffic_bypass") == null ? [] : ["traffic_bypass"]
        content {
          name                  = lookup(traffic_bypass.value, "name")
          protocol              = lookup(traffic_bypass.value, "protocol")
          description           = lookup(traffic_bypass.value, "description")
          destination_addresses = lookup(traffic_bypass.value, "destination_addresses")
          destination_ip_groups = lookup(traffic_bypass.value, "destination_ip_groups")
          destination_ports     = lookup(traffic_bypass.value, "destination_ports")
          source_addresses      = lookup(traffic_bypass.value, "source_addresses")
          source_ip_groups      = lookup(traffic_bypass.value, "source_ip_groups")
        }
      }
    }
  }

  dynamic "threat_intelligence_allowlist" {
    for_each = lookup(var.firewall_policy[count.index], "threat_intelligence_allowlist") == null ? [] : ["threat_intelligence_allowlist"]
    content {
      fqdns        = lookup(threat_intelligence_allowlist.value, "fqdns")
      ip_addresses = lookup(threat_intelligence_allowlist.value, "ip_addresses")
    }
  }

  dynamic "tls_certificate" {
    for_each = lookup(var.firewall_policy[count.index], "tls_certificate") == null ? [] : ["tls_certificate"]
    content {
      key_vault_secret_id = lookup(tls_certificate.value, "key_vault_secret_id")
      name                = lookup(tls_certificate.value, "name")
    }
  }

  dynamic "explicit_proxy" {
    for_each = lookup(var.firewall_policy[count.index], "explicit_proxy") == null ? [] : ["explicit_proxy"]
    content {
      enabled         = lookup(explicit_proxy.value, "enabled")
      http_port       = lookup(explicit_proxy.value, "http_port")
      https_port      = lookup(explicit_proxy.value, "https_port")
      enable_pac_file = lookup(explicit_proxy.value, "enable_pac_file")
      pac_file_port   = lookup(explicit_proxy.value, "pac_file_port")
      pac_file        = lookup(explicit_proxy.value, "pac_file")
    }
  }
}

resource "azurerm_firewall_policy_rule_collection_group" "this" {
  count = length(var.firewall_policy_rule_collection_group) == "0" ? "0" : length(var.firewall_policy)
  firewall_policy_id = try(
    element(azurerm_firewall_policy.this.*.id, lookup(var.firewall_policy_rule_collection_group[count.index], "firewall_policy_id"))
  )
  name     = lookup(var.firewall_policy_rule_collection_group[count.index], "name")
  priority = lookup(var.firewall_policy_rule_collection_group[count.index], "priority")

  dynamic "application_rule_collection" {
    for_each = lookup(var.firewall_policy_rule_collection_group[count.index], "application_rule_collection") == null ? [] : ["application_rule_collection"]
    content {
      action   = lookup(application_rule_collection.value, "action")
      name     = lookup(application_rule_collection.value, "name")
      priority = lookup(application_rule_collection.value, "priority")

      dynamic "rule" {
        for_each = lookup(application_rule_collection.value, "rule") == null ? [] : ["rule"]
        content {
          name                  = lookup(rule.value, "name")
          description           = lookup(rule.value, "description")
          source_addresses      = lookup(rule.value, "source_addresses")
          source_ip_groups      = lookup(rule.value, "source_ip_groups")
          destination_addresses = lookup(rule.value, "destination_addresses")
          destination_fqdn_tags = lookup(rule.value, "destination_fqdn_tags")
          destination_fqdns     = lookup(rule.value, "destination_fqdns")
          destination_urls      = lookup(rule.value, "destination_urls")
          terminate_tls         = lookup(rule.value, "terminate_tls")
          web_categories        = lookup(rule.value, "web_categories")

          dynamic "protocols" {
            for_each = lookup(rule.value, "protocols") == null ? [] : ["protocols"]
            content {
              port = lookup(protocols.value, "port")
              type = lookup(protocols.value, "type")
            }
          }
        }
      }
    }
  }

  dynamic "network_rule_collection" {
    for_each = lookup(var.firewall_policy_rule_collection_group[count.index], "network_rule_collection") == null ? [] : ["network_rule_collection"]
    content {
      action   = lookup(network_rule_collection.value, "action")
      name     = lookup(network_rule_collection.value, "name")
      priority = lookup(network_rule_collection.value, "priority")

      dynamic "rule" {
        for_each = lookup(network_rule_collection.value, "rule") == null ? [] : ["rule"]
        content {
          destination_ports     = lookup(rule.value, "destination_ports")
          name                  = lookup(rule.value, "name")
          protocols             = lookup(rule.value, "protocols")
          destination_addresses = lookup(rule.value, "destination_addresses")
          destination_fqdns     = lookup(rule.value, "destination_fqdns")
          destination_ip_groups = lookup(rule.value, "destination_ip_groups")
          source_addresses      = lookup(rule.value, "source_addresses")
          source_ip_groups      = lookup(rule.value, "source_ip_groups")
        }
      }
    }
  }

  dynamic "nat_rule_collection" {
    for_each = lookup(var.firewall_policy_rule_collection_group[count.index], "nat_rule_collection") == null ? [] : ["nat_rule_collection"]
    content {
      action   = lookup(nat_rule_collection.value, "action")
      name     = lookup(nat_rule_collection.value, "name")
      priority = lookup(nat_rule_collection.value, "priority")

      dynamic "rule" {
        for_each = lookup(nat_rule_collection.value, "rule") == null ? [] : ["rule"]
        content {
          name                = lookup(rule.value, "name")
          protocols           = lookup(rule.value, "protocols")
          translated_port     = lookup(rule.value, "translated_port")
          source_addresses    = lookup(rule.value, "source_addresses")
          source_ip_groups    = lookup(rule.value, "source_ip_groups")
          destination_address = lookup(rule.value, "destination_address")
          destination_ports   = lookup(rule.value, "destination_ports")
          translated_address  = lookup(rule.value, "translated_address")
          translated_fqdn     = lookup(rule.value, "translated_fqdn")
        }
      }
    }
  }
}

resource "azurerm_frontdoor" "this" {
  count = length(var.frontdoor)
  name  = lookup(var.frontdoor[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  friendly_name         = lookup(var.frontdoor[count.index], "friendly_name")
  load_balancer_enabled = lookup(var.frontdoor[count.index], "load_balancer_enabled")
  tags = merge(
    var.tags,
    lookup(var.frontdoor[count.index], "tags")
  )

  dynamic "backend_pool" {
    for_each = lookup(var.frontdoor[count.index], "backend_pool") == null ? [] : ["backend_pool"]
    content {
      health_probe_name   = lookup(backend_pool.value, "health_probe_name")
      load_balancing_name = lookup(backend_pool.value, "load_balancing_name")
      name                = lookup(backend_pool.value, "name")
    }
  }

  dynamic "backend_pool_health_probe" {
    for_each = lookup(var.frontdoor[count.index], "backend_pool_health_probe") == null ? [] : ["backend_pool_health_probe"]
    content {
      name                = lookup(backend_pool_health_probe.value, "name")
      enabled             = lookup(backend_pool_health_probe.value, "enabled")
      path                = lookup(backend_pool_health_probe.value, "path")
      protocol            = lookup(backend_pool_health_probe.value, "protocol")
      probe_method        = lookup(backend_pool_health_probe.value, "probe_method")
      interval_in_seconds = lookup(backend_pool_health_probe.value, "interval_in_seconds")
    }
  }

  dynamic "backend_pool_load_balancing" {
    for_each = lookup(var.frontdoor[count.index], "backend_pool_load_balancing") == null ? [] : ["backend_pool_load_balancing"]
    content {
      name                            = lookup(backend_pool_load_balancing.value, "name")
      sample_size                     = lookup(backend_pool_load_balancing.value, "sample_size")
      successful_samples_required     = lookup(backend_pool_load_balancing.value, "successful_samples_required")
      additional_latency_milliseconds = lookup(backend_pool_load_balancing.value, "additional_latency_milliseconds")
    }
  }

  dynamic "backend_pool_settings" {
    for_each = lookup(var.frontdoor[count.index], "backend_pool_settings") == null ? [] : ["backend_pool_settings"]
    content {
      enforce_backend_pools_certificate_name_check = lookup(backend_pool_settings.value, "enforce_backend_pools_certificate_name_check")
      backend_pools_send_receive_timeout_seconds   = lookup(backend_pool_settings.value, "backend_pools_send_receive_timeout_seconds")
    }
  }

  dynamic "frontend_endpoint" {
    for_each = lookup(var.frontdoor[count.index], "frontend_endpoint") == null ? [] : ["frontend_endpoint"]
    content {
      host_name                    = lookup(frontend_endpoint.value, "host_name")
      name                         = lookup(frontend_endpoint.value, "name")
      session_affinity_enabled     = lookup(frontend_endpoint.value, "session_affinity_enabled")
      session_affinity_ttl_seconds = lookup(frontend_endpoint.value, "session_affinity_ttl_seconds")
      web_application_firewall_policy_link_id = try(
        element(azurerm_web_application_firewall_policy.this.*.id, lookup(frontend_endpoint.value, "web_application_firewall_policy_link_id"))
      )
    }
  }

  dynamic "routing_rule" {
    for_each = lookup(var.frontdoor[count.index], "routing_rule") == null ? [] : ["routing_rule"]
    content {
      accepted_protocols = lookup(routing_rule.value, "accepted_protocols")
      frontend_endpoints = lookup(routing_rule.value, "frontend_endpoints")
      name               = lookup(routing_rule.value, "name")
      patterns_to_match  = lookup(routing_rule.value, "patterns_to_match")
      enabled            = lookup(routing_rule.value, "enabled")

      dynamic "forwarding_configuration" {
        for_each = lookup(routing_rule.value, "forwarding_configuration") == null ? [] : ["forwarding_configuration"]
        content {
          backend_pool_name                     = lookup(forwarding_configuration.value, "backend_pool_name")
          cache_enabled                         = lookup(forwarding_configuration.value, "cache_enabled")
          cache_use_dynamic_compression         = lookup(forwarding_configuration.value, "cache_use_dynamic_compression")
          cache_query_parameter_strip_directive = lookup(forwarding_configuration.value, "cache_query_parameter_strip_directive")
          cache_query_parameters                = lookup(forwarding_configuration.value, "cache_query_parameters")
          cache_duration                        = lookup(forwarding_configuration.value, "cache_duration")
          custom_forwarding_path                = lookup(forwarding_configuration.value, "custom_forwarding_path")
          forwarding_protocol                   = lookup(forwarding_configuration.value, "forwarding_protocol")
        }
      }

      dynamic "redirect_configuration" {
        for_each = lookup(routing_rule.value, "redirect_configuration") == null ? [] : ["redirect_configuration"]
        content {
          redirect_protocol   = lookup(redirect_configuration.value, "redirect_protocol")
          redirect_type       = lookup(redirect_configuration.value, "redirect_type")
          custom_host         = lookup(redirect_configuration.value, "custom_host")
          custom_fragment     = lookup(redirect_configuration.value, "custom_fragment")
          custom_path         = lookup(redirect_configuration.value, "custom_path")
          custom_query_string = lookup(redirect_configuration.value, "custom_query_string")
        }
      }
    }
  }
}

resource "azurerm_frontdoor_custom_https_configuration" "this" {
  count                             = length(var.frontdoor_custom_https_configuration) == "0" ? "0" : length(var.frontdoor)
  custom_https_provisioning_enabled = lookup(frontdoor_custom_https_configuration[count.index], "custom_https_provisioning_enabled")
  frontend_endpoint_id = try(
    element(azurerm_frontdoor.this.*.frontend_endpoints[lookup(var.frontdoor, "name")], lookup(var.frontdoor_custom_https_configuration, "frontend_endpoint_id"))
  )

  dynamic "custom_https_configuration" {
    for_each = lookup(frontdoor_custom_https_configuration[count.index], "custom_https_configuration") == null ? [] : ["custom_https_configuration"]
    content {
      certificate_source                         = lookup(custom_https_configuration.value, "certificate_source")
      azure_key_vault_certificate_secret_name    = lookup(custom_https_configuration.value, "azure_key_vault_certificate_secret_name")
      azure_key_vault_certificate_secret_version = lookup(custom_https_configuration.value, "azure_key_vault_certificate_secret_version")
      azure_key_vault_certificate_vault_id       = lookup(custom_https_configuration.value, "azure_key_vault_certificate_vault_id")
    }
  }
}

resource "azurerm_frontdoor_firewall_policy" "this" {
  count = length(var.frontdoor_firewall_policy) == "0" ? "0" : length(var.frontdoor)
  name  = lookup(var.frontdoor_firewall_policy[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  enabled                           = lookup(var.frontdoor_firewall_policy[count.index], "enabled")
  mode                              = lookup(var.frontdoor_firewall_policy[count.index], "mode")
  redirect_url                      = lookup(var.frontdoor_firewall_policy[count.index], "redirect_url")
  custom_block_response_status_code = lookup(var.frontdoor_firewall_policy[count.index], "custom_block_response_status_code")
  custom_block_response_body        = lookup(var.frontdoor_firewall_policy[count.index], "custom_block_response_body")
  tags = merge(
    var.tags,
    lookup(var.frontdoor_firewall_policy[count.index], "tags")
  )

  dynamic "custom_rule" {
    for_each = lookup(frontdoor_firewall_policy[count.index], "custom_rule") == null ? [] : ["custom_rule"]
    content {
      action                         = lookup(custom_rule.value, "action")
      name                           = lookup(custom_rule.value, "name")
      type                           = lookup(custom_rule.value, "type")
      enabled                        = lookup(custom_rule.value, "enabled")
      priority                       = lookup(custom_rule.value, "priority")
      rate_limit_duration_in_minutes = lookup(custom_rule.value, "rate_limit_duration_in_minutes")
      rate_limit_threshold           = lookup(custom_rule.value, "rate_limit_threshold")

      dynamic "match_condition" {
        for_each = lookup(custom_rule.value, "match_condition") == null ? [] : ["match_condition"]
        content {
          match_values       = lookup(match_condition.value, "match_values")
          match_variable     = lookup(match_condition.value, "match_variable")
          operator           = lookup(match_condition.value, "operator")
          selector           = lookup(match_condition.value, "selector")
          negation_condition = lookup(match_condition.value, "negation_condition")
          transforms         = lookup(match_condition.value, "transforms")
        }
      }
    }
  }

  dynamic "managed_rule" {
    for_each = lookup(frontdoor_firewall_policy[count.index], "managed_rule") == null ? [] : ["managed_rule"]
    content {
      type    = lookup(managed_rule.value, "type")
      version = lookup(managed_rule.value, "version")

      dynamic "override" {
        for_each = lookup(managed_rule.value, "override") == null ? [] : ["override"]
        content {
          rule_group_name = lookup(override.value, "rule_group_name")

          dynamic "exclusion" {
            for_each = lookup(override.value, "exclusion") == null ? [] : ["exclusion"]
            content {
              match_variable = lookup(exclusion.value, "match_variable")
              operator       = lookup(exclusion.value, "operator")
              selector       = lookup(exclusion.value, "selector")
            }
          }

          dynamic "rule" {
            for_each = lookup(override.value, "rule") == null ? [] : ["rule"]
            content {
              action  = lookup(rule.value, "action")
              rule_id = lookup(rule.value, "rule_id")
              enabled = lookup(rule.value, "enabled")

              dynamic "exclusion" {
                for_each = lookup(rule.value, "exclusion") == null ? [] : ["exclusion"]
                content {
                  match_variable = lookup(exclusion.value, "match_variable")
                  operator       = lookup(exclusion.value, "operator")
                  selector       = lookup(exclusion.value, "selector")
                }
              }
            }
          }
        }
      }
      dynamic "exclusion" {
        for_each = lookup(managed_rule.value, "exclusion") == null ? [] : ["exclusion"]
        content {
          match_variable = lookup(exclusion.value, "match_variable")
          operator       = lookup(exclusion.value, "operator")
          selector       = lookup(exclusion.value, "selector")
        }
      }
    }
  }
}

resource "azurerm_frontdoor_rules_engine" "this" {
  count = length(var.frontdoor_rules_engine) == "0" ? "0" : length(var.frontdoor)
  frontdoor_name = try(
    element(azurerm_frontdoor.this.*.name, lookup(var.frontdoor_rules_engine[count.index], "frontdoor_id"))
  )
  name = lookup(var.frontdoor_rules_engine[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  enabled = lookup(var.frontdoor_rules_engine[count.index], "enabled")

  dynamic "rule" {
    for_each = lookup(var.frontdoor_rules_engine[count.index], rules) == null ? [] : ["rules"]
    content {
      name     = lookup(rule.value, "name")
      priority = lookup(rule.value, "priority")
      dynamic "action" {
        for_each = lookup(rule.value, "action") == null ? [] : ["action"]
        content {
          dynamic "request_header" {
            for_each = lookup(action.value, "request_header") == null ? [] : ["request_header"]
            content {
              header_action_type = lookup(request_header.value, "header_action_type")
              header_name        = lookup(request_header.value, "header_name")
              value              = lookup(request_header.value, "value")
            }
          }
          dynamic "response_header" {
            for_each = lookup(action.value, "response_header") == null ? [] : ["response_header"]
            content {
              header_action_type = lookup(response_header.value, "header_action_type")
              header_name        = lookup(response_header.value, "header_name")
              value              = lookup(response_header.value, "value")
            }
          }
        }
      }
      dynamic "match_condition" {
        for_each = lookup(rule.value, "match_condition") == null ? [] : ["match_condition"]
        content {
          operator         = lookup(match_condition.value, "operator")
          variable         = lookup(match_condition.value, "variable")
          selector         = lookup(match_condition.value, "selector")
          transform        = lookup(match_condition.value, "transform")
          negate_condition = lookup(match_condition.value, "negate_condition")
          value            = lookup(match_condition.value, "value")
        }
      }
    }
  }
}

resource "azurerm_ip_group" "this" {
  count = length(var.ip_group)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.ip_group[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  cidrs = lookup(var.ip_group[count.index], "cidrs")
  tags = merge(
    var.tags,
    lookup(var.ip_group[count.index], "tags")
  )
}

resource "azurerm_ip_group_cidr" "this" {
  count = length(var.ip_group_cidr)
  cidr  = lookup(var.ip_group_cidr[count.index], "cidr")
  ip_group_id = try(
    element(azurerm_ip_group.this.*.id, lookup(var.ip_group_cidr[count.index], "ip_group_id"))
  )
}

resource "azurerm_local_network_gateway" "this" {
  count = length(var.local_network_gateway)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.local_network_gateway[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  gateway_address = lookup(var.local_network_gateway[count.index], "gateway_address")
  gateway_fqdn    = lookup(var.local_network_gateway[count.index], "gateway_fqdn")
  address_space   = lookup(var.local_network_gateway[count.index], "address_space")

  dynamic "bgp_settings" {
    for_each = lookup(var.local_network_gateway[count.index], "bgp_settings") == null ? [] : ["bgp_settings"]
    content {
      asn                 = lookup(bgp_settings.value, "asn")
      bgp_peering_address = lookup(bgp_settings.value, "bgp_peering_address")
      peer_weight         = lookup(bgp_settings.value, "peer_weight")
    }
  }
}

resource "azurerm_nat_gateway" "this" {
  count = length(var.nat_gateway)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.nat_gateway[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  idle_timeout_in_minutes = lookup(var.nat_gateway[count.index], "idle_timeout_in_minutes")
  sku_name                = lookup(var.nat_gateway[count.index], "sku_name")
  tags = merge(
    var.tags,
    lookup(var.nat_gateway[count.index], "tags")
  )
  zones = lookup(var.nat_gateway[count.index], "zones")
}

resource "azurerm_nat_gateway_public_ip_association" "this" {
  count = length(var.nat_gateway_public_ip_association) == "0" ? "0" : length(var.nat_gateway)
  nat_gateway_id = try(
    element(azurerm_nat_gateway.this.*.id, lookup(var.nat_gateway_public_ip_association[count.index], "nat_gateway_id"))
  )
  public_ip_address_id = try(
    element(azurerm_public_ip.this.*.id, lookup(var.nat_gateway_public_ip_association[count.index], "public_ip_address_id"))
  )
}

resource "azurerm_nat_gateway_public_ip_prefix_association" "this" {
  count = length(var.nat_gateway_public_ip_prefix_association) == "0" ? "0" : length(var.nat_gateway)
  nat_gateway_id = try(
    element(azurerm_nat_gateway.this.*.id, lookup(var.nat_gateway_public_ip_prefix_association[count.index], "nat_gateway_id"))
  )
  public_ip_prefix_id = try(
    element(azurerm_public_ip_prefix.this.*.id, lookup(var.nat_gateway_public_ip_prefix_association[count.index], "public_ip_prefix_id"))
  )
}

resource "azurerm_network_connection_monitor" "this" {
  count = length(var.network_connection_monitor) == "0" ? "0" : (length(var.network_watcher))
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.network_connection_monitor[count.index], "name")
  network_watcher_id = try(
    element(azurerm_network_watcher.this.*.id, lookup(var.network_connection_monitor[count.index], "network_watcher_id"))
  )
  notes                         = lookup(var.network_connection_monitor[count.index], "notes")
  output_workspace_resource_ids = lookup(var.network_connection_monitor[count.index], "output_workspace_resource_ids")
  tags = merge(
    var.tags,
    lookup(var.network_connection_monitor[count.index], "tags")
  )

  dynamic "endpoint" {
    for_each = lookup(var.network_connection_monitor[count.index], "endpoint") == null ? [] : ["endpoint"]
    content {
      name                  = lookup(endpoint.value, "name")
      address               = lookup(endpoint.value, "address")
      coverage_level        = lookup(endpoint.value, "coverage_level")
      excluded_ip_addresses = lookup(endpoint.value, "excluded_ip_addresses")
      included_ip_addresses = lookup(endpoint.value, "included_ip_addresses")
      target_resource_id    = lookup(endpoint.value, "target_resource_id")
      target_resource_type  = lookup(endpoint.value, "target_resource_type")

      dynamic "filter" {
        for_each = lookup(endpoint.value, "filter") == null ? [] : ["filter"]
        content {
          type = lookup(filter.value, "type")

          dynamic "item" {
            for_each = lookup(filter.value, "item") == null ? [] : ["item"]
            content {
              type    = lookup(item.value, "type")
              address = lookup(item.value, "address")
            }
          }
        }
      }
    }
  }

  dynamic "test_configuration" {
    for_each = lookup(var.network_connection_monitor[count.index], "test_configuration") == null ? [] : ["test_configuration"]
    content {
      name                      = lookup(test_configuration.value, "name")
      protocol                  = lookup(test_configuration.value, "protocol")
      test_frequency_in_seconds = lookup(test_configuration.value, "test_frequency_in_seconds")

      dynamic "http_configuration" {
        for_each = lookup(test_configuration.value, "http_configuration") == null ? [] : ["http_configuration"]
        content {
          method                   = lookup(http_configuration.value, "method")
          port                     = lookup(http_configuration.value, "port")
          path                     = lookup(http_configuration.value, "path")
          prefer_https             = lookup(http_configuration.value, "prefer_https")
          valid_status_code_ranges = lookup(http_configuration.value, "valid_status_code_ranges")

          dynamic "request_header" {
            for_each = lookup(http_configuration.value, "request_header") == null ? [] : ["request_header"]
            content {
              name  = lookup(request_header.value, "name")
              value = lookup(request_header.value, "value")
            }
          }
        }
      }
      dynamic "icmp_configuration" {
        for_each = lookup(test_configuration.value, "icmp_configuration") == null ? [] : ["icmp_configuration"]
        content {
          trace_route_enabled = lookup(icmp_configuration.value, "trace_route_enabled")
        }
      }
      dynamic "tcp_configuration" {
        for_each = lookup(test_configuration.value, "tcp_configuration") == null ? [] : ["tcp_configuration"]
        content {
          port                      = lookup(tcp_configuration.value, "port")
          trace_route_enabled       = lookup(tcp_configuration.value, "trace_route_enabled")
          destination_port_behavior = lookup(tcp_configuration.value, "destination_port_behavior")
        }
      }
    }
  }

  dynamic "test_group" {
    for_each = lookup(var.network_connection_monitor[count.index], "test_group") == null ? [] : ["test_group"]
    content {
      destination_endpoints    = lookup(test_group.value, "destination_endpoints")
      name                     = lookup(test_group.value, "name")
      source_endpoints         = lookup(test_group.value, "source_endpoints")
      test_configuration_names = lookup(test_group.value, "test_configuration_names")
      enabled                  = lookup(test_group.value, "enabled")
    }
  }
}

resource "azurerm_network_ddos_protection_plan" "this" {
  count = length(var.network_ddos_protection_plan)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.network_ddos_protection_plan[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  tags = merge(
    var.tags,
    lookup(var.network_ddos_protection_plan[count.index], "tags")
  )
}

resource "azurerm_network_interface" "this" {
  count = length(var.network_interface)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.network_interface[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  dns_servers                   = lookup(var.network_interface[count.index], "dns_servers")
  edge_zone                     = lookup(var.network_interface[count.index], "edge_zone")
  enable_ip_forwarding          = lookup(var.network_interface[count.index], "enable_ip_forwarding")
  enable_accelerated_networking = lookup(var.network_interface[count.index], "enable_accelerated_networking")
  internal_dns_name_label       = lookup(var.network_interface[count.index], "internal_dns_name_label")
  tags = merge(
    var.tags,
    lookup(var.network_interface[count.index], "tags")
  )

  dynamic "ip_configuration" {
    for_each = lookup(var.network_interface[count.index], "ip_configuration") == null ? [] : ["ip_configuration"]
    content {
      name                                               = lookup(ip_configuration.value, "name")
      private_ip_address_allocation                      = lookup(ip_configuration.value, "private_ip_address_allocation")
      gateway_load_balancer_frontend_ip_configuration_id = lookup(ip_configuration.value, "gateway_load_balancer_frontend_ip_configuration_id")
      subnet_id = try(
        element(azurerm_subnet.this.*.id, lookup(ip_configuration.value, "subnet_id"))
      )
      private_ip_address_version = lookup(ip_configuration.value, "private_ip_address_version")
      private_ip_address         = lookup(ip_configuration.value, "private_ip_address")
      public_ip_address_id = try(
        element(azurerm_public_ip.this.*.id, lookup(ip_configuration.value, "public_ip_address_id"))
      )
      primary = lookup(ip_configuration.value, "primary")
    }
  }
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "this" {
  count = length(var.network_interface_application_gateway_backend_address_pool_association) == "0" ? "0" : (length(var.network_interface) && length(var.application_gateway))
  backend_address_pool_id = try(
    element(tolist(azurerm_application_gateway.this.*.backend_address_pool).0.id, lookup(var.network_interface_application_gateway_backend_address_pool_association[count.index], "backend_address_pool_id"))
  )
  ip_configuration_name = lookup(var.network_interface_application_gateway_backend_address_pool_association[count.index], "ip_configuration_name")
  network_interface_id = try(
    element(azurerm_network_interface.this.*.id, lookup(var.network_interface_application_gateway_backend_address_pool_association[count.index], "network_interface_id"))
  )
}

resource "azurerm_network_interface_application_security_group_association" "this" {
  count = length(var.network_interface_application_security_group_association) == "0" ? "0" : (length(var.network_interface) && length(var.application_security_group))
  application_security_group_id = try(
    element(azurerm_application_security_group.this.*.id, lookup(var.network_interface_application_security_group_association[count.index], "application_security_group_id"))
  )
  network_interface_id = try(
    element(azurerm_network_interface.this.*.id, lookup(var.network_interface_application_security_group_association[count.index], "network_interface_id"))
  )
}

resource "azurerm_network_interface_backend_address_pool_association" "this" {
  count                   = length(var.network_interface_backend_address_pool_association) == "0" ? "0" : (length(var.network_interface))
  backend_address_pool_id = lookup(var.network_interface_backend_address_pool_association[count.index], "backend_address_pool_id")
  ip_configuration_name   = lookup(var.network_interface_backend_address_pool_association[count.index], "ip_configuration_name")
  network_interface_id = try(
    element(azurerm_network_interface.this.*.id, lookup(var.network_interface_backend_address_pool_association[count.index], "network_interface_id"))
  )
}

resource "azurerm_network_interface_nat_rule_association" "this" {
  count                 = length(var.network_interface_nat_rule_association) == "0" ? "0" : (length(var.network_interface))
  ip_configuration_name = lookup(var.network_interface_nat_rule_association[count.index], "ip_configuration_name")
  nat_rule_id           = lookup(var.network_interface_nat_rule_association[count.index], "nat_rule_id")
  network_interface_id = try(
    element(azurerm_network_interface.this.*.id, lookup(var.network_interface_nat_rule_association[count.index], "network_interface_id"))
  )
}

resource "azurerm_network_interface_security_group_association" "this" {
  count = length(var.network_interface_security_group_association) == "0" ? "0" : (length(var.network_interface))
  network_interface_id = try(
    element(azurerm_network_interface.this.*.id, lookup(var.network_interface_security_group_association[count.index], "network_interface_id"))
  )
  network_security_group_id = try(
    element(azurerm_network_security_group.this.*.id, lookup(var.network_interface_security_group_association[count.index], "network_security_group_id"))
  )
}

resource "azurerm_network_manager" "this" {
  count = length(var.network_manager)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.network_manager[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  scope_accesses = lookup(var.network_manager[count.index], "scope_accesses")
  description    = lookup(var.network_manager[count.index], "description")
  tags = merge(
    var.tags,
    lookup(var.network_manager[count.index], tags)
  )

  dynamic "scope" {
    for_each = lookup(var.network_manager[count.index], "scope") == null ? [] : ["scope"]
    content {
      management_group_ids = lookup(scope.value, "management_group_ids")
      subscription_ids     = lookup(scope.value, "subscription_ids")
    }
  }
}

resource "azurerm_network_manager_admin_rule" "this" {
  count  = length(var.network_manager_admin_rule) == "0" ? "0" : (length(var.network_manager_admin_rule_collection))
  action = lookup(var.network_manager_admin_rule[count.index], "action")
  admin_rule_collection_id = try(
    element(azurerm_network_manager_admin_rule_collection.this.*.id, lookup(var.network_manager_admin_rule[count.index], "admin_rule_collection_id"))
  )
  direction               = lookup(var.network_manager_admin_rule[count.index], "direction")
  name                    = lookup(var.network_manager_admin_rule[count.index], "name")
  priority                = lookup(var.network_manager_admin_rule[count.index], "priority")
  protocol                = lookup(var.network_manager_admin_rule[count.index], "protocol")
  description             = lookup(var.network_manager_admin_rule[count.index], "description")
  destination_port_ranges = lookup(var.network_manager_admin_rule[count.index], "destination_port_ranges")
  source_port_ranges      = lookup(var.network_manager_admin_rule[count.index], "source_port_ranges")

  dynamic "destination" {
    for_each = lookup(var.network_manager_admin_rule[count.index], "destination") == null ? [] : ["destination"]
    content {
      address_prefix      = lookup(destination.value, "address_prefix")
      address_prefix_type = lookup(destination.value, "address_prefix_type")
    }
  }

  dynamic "source" {
    for_each = lookup(var.network_manager_admin_rule[count.index], "source") == null ? [] : ["source"]
    content {
      address_prefix      = lookup(source.value, "address_prefix")
      address_prefix_type = lookup(source.value, "address_prefix_type")
    }
  }
}

resource "azurerm_network_manager_admin_rule_collection" "this" {
  count = length(var.network_manager_admin_rule_collection) == "0" ? "0" : (length(var.network_manager_network_group))
  name  = lookup(var.network_manager_admin_rule_collection[count.index], "name")
  network_group_ids = try(
    element([azurerm_network_manager_network_group.this.*.id], lookup(var.network_manager_admin_rule_collection[count.index], "network_group_ids"))
  )
  security_admin_configuration_id = try(
    element(azurerm_network_manager_security_admin_configuration.this.*.id, lookup(var.network_manager_admin_rule_collection[count.index], "security_admin_configuration_id"))
  )
  description = lookup(var.network_manager_admin_rule_collection[count.index], "description")
}

resource "azurerm_network_manager_connectivity_configuration" "this" {
  count                 = length(var.network_manager_connectivity_configuration) == "0" ? "0" : (length(var.network_manager))
  connectivity_topology = lookup(var.network_manager_connectivity_configuration[count.index], "connectivity_topology")
  name                  = lookup(var.network_manager_connectivity_configuration[count.index], "name")
  network_manager_id = try(
    element(azurerm_network_manager.this.*.id, lookup(var.network_manager_connectivity_configuration[count.index], "network_manager_id"))
  )
  delete_existing_peering_enabled = lookup(var.network_manager_connectivity_configuration[count.index], "delete_existing_peering_enabled")
  description                     = lookup(var.network_manager_connectivity_configuration[count.index], "description")
  global_mesh_enabled             = lookup(var.network_manager_connectivity_configuration[count.index], "global_mesh_enabled")

  dynamic "applies_to_group" {
    for_each = lookup(var.network_manager_connectivity_configuration[count.index], "applies_to_group") == null ? [] : ["applies_to_group"]
    content {
      group_connectivity = lookup(applies_to_group.value, "group_connectivity")
      network_group_id = try(
        element(azurerm_network_manager_network_group.this.*.id, lookup(applies_to_group.value, "network_group_id"))
      )
      global_mesh_enabled = lookup(applies_to_group.value, "global_mesh_enabled")
      use_hub_gateway     = lookup(applies_to_group.value, "use_hub_gateway")
    }
  }

  dynamic "hub" {
    for_each = lookup(var.network_manager_connectivity_configuration[count.index], "hub") == null ? [] : ["hub"]
    content {
      resource_id = try(
        element(azurerm_virtual_network.this.*.id, lookup(hub.value, "resource_id"))
      )
      resource_type = lookup(hub.value, "resource_type")
    }
  }
}

resource "azurerm_network_manager_deployment" "this" {
  count = length(var.network_manager_deployment) == "0" ? "0" : (length(var.network_manager))
  configuration_ids = [
    try(
      element(azurerm_network_manager_connectivity_configuration.this.*.id, lookup(var.network_manager_deployment[count.index], "configuration_ids"))
    )
  ]
  location = try(
    data.azurerm_resource_group.this.location
  )
  network_manager_id = try(
    element(azurerm_network_manager.this.*.id, lookup(var.network_manager_deployment[count.index], "network_manager_id"))
  )
  scope_access = lookup(var.network_manager_deployment[count.index], "scope_access")
  triggers     = lookup(var.network_manager_deployment[count.index], "triggers")
}

resource "azurerm_network_manager_management_group_connection" "this" {
  count               = length(var.network_manager_management_group_connection) == "0" ? "0" : (length(var.network_manager))
  management_group_id = lookup(var.network_manager_management_group_connection[count.index], "management_group_id")
  name                = lookup(var.network_manager_management_group_connection[count.index], "name")
  network_manager_id = try(
    element(azurerm_network_manager.this.*.id, lookup(var.network_manager_management_group_connection[count.index], "network_manager_id"))
  )
  description = lookup(var.network_manager_management_group_connection[count.index], "description")
}

resource "azurerm_network_manager_network_group" "this" {
  count = length(var.network_manager_network_group) == "0" ? "0" : (length(var.network_manager))
  name  = lookup(var.network_manager_network_group[count.index], "name")
  network_manager_id = try(
    element(azurerm_network_manager.this.*.id, lookup(var.network_manager_network_group[count.index], "network_manager_id"))
  )
}

resource "azurerm_network_manager_scope_connection" "this" {
  count = length(var.network_manager_scope_connection) == "0" ? "0" : (length(var.network_manager))
  name  = lookup(var.network_manager_scope_connection[count.index], "name")
  network_manager_id = try(
    element(azurerm_network_manager.this.*.id, lookup(var.network_manager_scope_connection[count.index], "network_manager_id"))
  )
  target_scope_id = lookup(var.network_manager_scope_connection[count.index], "target_scope_id")
  tenant_id       = lookup(var.network_manager_scope_connection[count.index], "tenant_id")
}

resource "azurerm_network_manager_security_admin_configuration" "this" {
  count = length(var.network_manager_security_admin_configuration) == "0" ? "0" : (length(var.network_manager))
  name  = lookup(var.network_manager_security_admin_configuration[count.index], "name")
  network_manager_id = try(
    element(azurerm_network_manager.this.*.id, lookup(var.network_manager_security_admin_configuration[count.index], "network_manager_id"))
  )
  apply_on_network_intent_policy_based_services = lookup(var.network_manager_security_admin_configuration[count.index], "apply_on_network_intent_policy_based_services")
}

resource "azurerm_network_manager_static_member" "this" {
  count = length(var.network_manager_static_member) == "0" ? "0" : (length(var.network_manager) && length(var.network_manager_network_group))
  name  = lookup(var.network_manager_static_member[count.index], "name")
  network_group_id = try(
    element(azurerm_network_manager_network_group.this.*.id, lookup(var.network_manager_static_member[count.index], "network_group_id"))
  )
  target_virtual_network_id = try(
    element(azurerm_virtual_network.this.*.id, lookup(var.network_manager_static_member[count.index], "target_virtual_network_id"))
  )
}

resource "azurerm_network_manager_subscription_connection" "this" {
  count = length(var.network_manager_subscription_connection) == "0" ? "0" : (length(var.network_manager))
  name  = lookup(var.network_manager_subscription_connection[count.index], "name")
  network_manager_id = try(
    element(azurerm_network_manager.this.*.id, lookup(var.network_manager_subscription_connection[count.index], "network_manager_id"))
  )
  subscription_id = lookup(var.network_manager_subscription_connection[count.index], "subscription_id")
}

resource "azurerm_network_packet_capture" "this" {
  count = length(var.network_packet_capture)
  name  = lookup(var.network_packet_capture[count.index], "name")
  network_watcher_name = try(
    element(azurerm_network_watcher.this.*.name, lookup(var.network_packet_capture[count.index], "network_watcher_id"))
  )
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  target_resource_id        = lookup(var.network_packet_capture[count.index], "target_resource_id")
  maximum_bytes_per_packet  = lookup(var.network_packet_capture[count.index], "maximum_bytes_per_packet")
  maximum_bytes_per_session = lookup(var.network_packet_capture[count.index], "maximum_bytes_per_session")
  maximum_capture_duration  = lookup(var.network_packet_capture[count.index], "maximum_capture_duration")

  dynamic "storage_location" {
    for_each = lookup(var.network_packet_capture[count.index], "storage_location") == null ? [] : ["storage_location"]
    content {
      file_path          = lookup(storage_location.value, "file_path")
      storage_account_id = lookup(storage_location.value, "storage_account_id")
    }
  }

  dynamic "filter" {
    for_each = lookup(var.network_packet_capture[count.index], "filter") == null ? [] : ["filter"]
    content {
      protocol          = lookup(filter.value, "protocol")
      local_ip_address  = lookup(filter.value, "local_ip_address")
      local_port        = lookup(filter.value, "local_port")
      remote_ip_address = lookup(filter.value, "remote_ip_address")
      remote_port       = lookup(filter.value, "remote_port")
    }
  }
}

resource "azurerm_network_profile" "this" {
  count = length(var.network_profile)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.network_profile[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  tags = merge(
    var.tags,
    lookup(var.network_profile[count.index], "tags")
  )

  dynamic "container_network_interface" {
    for_each = lookup(var.network_profile[count.index], "container_network_interface") == null ? [] : ["container_network_interface"]
    content {
      name = lookup(container_network_interface.value, "name")

      dynamic "ip_configuration" {
        for_each = lookup(container_network_interface.value, "ip_configuration") == null ? [] : ["ip_configuration"]
        content {
          name = lookup(ip_configuration.value, "name")
          subnet_id = try(
            element(azurerm_subnet.this.*.id, lookup(ip_configuration.value, "subnet_id"))
          )
        }
      }
    }
  }
}

resource "azurerm_network_security_group" "this" {
  count = length(var.network_security_group)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.network_security_group[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )

  dynamic "security_rule" {
    for_each = lookup(var.network_security_group[count.index], "security_rule") == null ? [] : ["security_rule"]
    content {
      name                                  = lookup(security_rule.value, "name")
      description                           = lookup(security_rule.value, "description")
      protocol                              = lookup(security_rule.value, "protocol")
      source_port_range                     = lookup(security_rule.value, "source_port_range")
      source_port_ranges                    = lookup(security_rule.value, "source_port_ranges")
      destination_port_range                = lookup(security_rule.value, "destination_port_range")
      destination_port_ranges               = lookup(security_rule.value, "destination_port_ranges")
      source_address_prefix                 = lookup(security_rule.value, "source_address_prefix")
      source_address_prefixes               = lookup(security_rule.value, "source_address_prefixes")
      source_application_security_group_ids = lookup(security_rule.value, "source_application_security_group_ids")
      destination_address_prefix            = lookup(security_rule.value, "destination_address_prefix")
      destination_address_prefixes          = lookup(security_rule.value, "destination_address_prefixes")
      access                                = lookup(security_rule.value, "access")
      priority                              = lookup(security_rule.value, "priority")
      direction                             = lookup(security_rule.value, "direction")
    }
  }
}

resource "azurerm_network_watcher" "this" {
  count = length(var.network_watcher)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.network_watcher[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  tags = merge(
    var.tags,
    lookup(var.network_watcher[count.index], "tags")
  )
}

resource "azurerm_network_watcher_flow_log" "this" {
  count   = length(var.network_watcher_flow_log) == "0" ? "0" : (length(var.network_security_group) && length(var.network_watcher))
  enabled = lookup(var.network_watcher_flow_log[count.index], "enabled")
  name    = lookup(var.network_watcher_flow_log[count.index], "name")
  network_security_group_id = try(
    element(azurerm_network_security_group.this.*.id, lookup(var.network_watcher_flow_log[count.index], "network_security_group_id"))
  )
  network_watcher_name = try(
    element(azurerm_network_watcher.this.*.name, lookup(var.network_watcher_flow_log[count.index], "network_watcher_id"))
  )
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  storage_account_id = lookup(var.network_watcher_flow_log[count.index], "storage_account_id")
  location = try(
    data.azurerm_resource_group.this.location
  )
  version = lookup(var.network_watcher_flow_log[count.index], "version")
  tags = merge(
    var.tags,
    lookup(var.network_watcher_flow_log[count.index], "tags")
  )

  dynamic "traffic_analytics" {
    for_each = lookup(var.network_watcher_flow_log[count.index], "traffic_analytics") == null ? [] : ["traffic_analytics"]
    content {
      enabled               = lookup(traffic_analytics.value, "enabled")
      workspace_id          = lookup(traffic_analytics.value, "workspace_id")
      workspace_region      = lookup(traffic_analytics.value, "workspace_region")
      workspace_resource_id = lookup(traffic_analytics.value, "workspace_resource_id")
      interval_in_minutes   = lookup(traffic_analytics.value, "interval_in_minutes")
    }
  }

  dynamic "retention_policy" {
    for_each = lookup(var.network_watcher_flow_log[count.index], "retention_policy") == null ? [] : ["retention_policy"]
    content {
      days    = lookup(retention_policy.value, "days")
      enabled = lookup(retention_policy.value, "enabled")
    }
  }
}

resource "azurerm_point_to_site_vpn_gateway" "this" {
  count = length(var.point_to_site_vpn_gateway)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.point_to_site_vpn_gateway[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  scale_unit = lookup(var.point_to_site_vpn_gateway[count.index], "scale_unit")
  virtual_hub_id = try(
    element(azurerm_virtual_hub.this.*.id, lookup(var.point_to_site_vpn_gateway[count.index], "virtual_hub_id"))
  )
  vpn_server_configuration_id = try(
    element(azurerm_vpn_server_configuration.this.*.id, lookup(var.point_to_site_vpn_gateway[count.index], "vpn_server_configuration_id"))
  )
  dns_servers                         = lookup(var.point_to_site_vpn_gateway[count.index], "dns_servers")
  routing_preference_internet_enabled = lookup(var.point_to_site_vpn_gateway[count.index], "routing_preference_internet_enabled")
  tags = merge(
    var.tags,
    lookup(var.point_to_site_vpn_gateway[count.index], "tags")
  )

  dynamic "connection_configuration" {
    for_each = lookup(var.point_to_site_vpn_gateway[count.index], "connection_configuration") == null ? [] : ["connection_configuration"]
    content {
      name                      = lookup(connection_configuration.value, "name")
      internet_security_enabled = lookup(connection_configuration.value, "internet_security_enabled")

      dynamic "vpn_client_address_pool" {
        for_each = lookup(connection_configuration.value, "vpn_client_address_pool") == null ? [] : ["vpn_client_address_pool"]
        content {
          address_prefixes = lookup(vpn_client_address_pool.value, "address_prefixes")
        }
      }

      dynamic "route" {
        for_each = lookup(connection_configuration.value, "route") == null ? [] : ["route"]
        content {
          associated_route_table_id = try(
            element(azurerm_virtual_hub_route_table.this.*.id, lookup(route.value, "associated_route_table_id"))
          )
          inbound_route_map_id = try(
            element(azurerm_route_map.this.*.id, lookup(route.value, "inbound_route_map_id"))
          )
          outbound_route_map_id = try(
            element(azurerm_route_map.this.*.id, lookup(route.value, "outbound_route_map_id"))
          )

          dynamic "propagated_route_table" {
            for_each = lookup(route.value, "propagated_route_table") == null ? [] : ["propagated_route_table"]
            content {
              ids    = lookup(propagated_route_table.value, "ids")
              labels = lookup(propagated_route_table.value, "labels")
            }
          }
        }
      }

    }
  }
}

resource "azurerm_private_endpoint" "this" {
  count = length(var.private_endpoint) == "0" ? "0" : (length(var.subnet))
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.private_endpoint[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  subnet_id = try(
    element(azurerm_subnet.this.*.id, lookup(var.private_endpoint[count.index], "subnet_id"))
  )
  custom_network_interface_name = lookup(var.private_endpoint[count.index], "custom_network_interface_name")
  tags = merge(
    var.tags,
    lookup(private_endpoint[count.index], "tags")
  )

  dynamic "private_dns_zone_group" {
    for_each = lookup(var.private_endpoint[count.index], "private_dns_zone_group") == null ? [] : ["private_dns_zone_group"]
    content {
      name                 = lookup(private_dns_zone_group.value, "name")
      private_dns_zone_ids = lookup(private_dns_zone_group.value, "private_dns_zone_ids")
    }
  }

  dynamic "private_service_connection" {
    for_each = lookup(var.private_endpoint[count.index], "private_service_connection") == null ? [] : ["private_service_connection"]
    content {
      is_manual_connection              = lookup(private_service_connection.value, "is_manual_connection")
      name                              = lookup(private_service_connection.value, "name")
      private_connection_resource_id    = lookup(private_service_connection.value, "private_connection_resource_id")
      private_connection_resource_alias = lookup(private_service_connection.value, "private_connection_resource_alias")
      subresource_names                 = lookup(private_service_connection.value, "subresource_names")
      request_message                   = lookup(private_service_connection.value, "request_message")
    }
  }

  dynamic "ip_configuration" {
    for_each = lookup(var.private_endpoint[count.index], "ip_configuration") == null ? [] : ["ip_configuration"]
    content {
      name               = lookup(ip_configuration.value, "name")
      private_ip_address = lookup(ip_configuration.value, "private_ip_address")
      subresource_name   = lookup(ip_configuration.value, "subresource_name")
      member_name        = lookup(ip_configuration.value, "member_name")
    }
  }

}

resource "azurerm_private_endpoint_application_security_group_association" "this" {
  count = length(var.private_endpoint_application_security_group_association) == "0" ? "0" : (length(var.application_security_group) && length(var.private_endpoint))
  application_security_group_id = try(
    element(azurerm_application_security_group.this.*.id, lookup(var.private_endpoint_application_security_group_association[count.index], "application_security_group_id"))
  )
  private_endpoint_id = try(
    element(azurerm_private_endpoint.this.*.id, lookup(var.private_endpoint_application_security_group_association[count.index], "private_endpoint_id"))
  )
}

resource "azurerm_private_link_service" "this" {
  count                                       = length(var.private_link_service)
  load_balancer_frontend_ip_configuration_ids = lookup(var.private_link_service[count.index], "load_balancer_frontend_ip_configuration_ids")
  location = try(
    data.azurerm_resource_group.this.location
  )
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  name                           = lookup(var.private_link_service[count.index], "name")
  auto_approval_subscription_ids = lookup(var.private_link_service[count.index], "auto_approval_subscription_ids")
  enable_proxy_protocol          = lookup(var.private_link_service[count.index], "enable_proxy_protocol")
  fqdns                          = lookup(var.private_link_service[count.index], "fqdns")
  tags = merge(
    var.tags,
    lookup(var.private_link_service[count.index], "tags")
  )
  visibility_subscription_ids = lookup(var.private_link_service[count.index], "visibility_subscription_ids")

  dynamic "nat_ip_configuration" {
    for_each = lookup(var.private_link_service[count.index], "nat_ip_configuration") == null ? [] : ["nat_ip_configuration"]
    content {
      name    = lookup(nat_ip_configuration.value, "name")
      primary = lookup(nat_ip_configuration.value, "primary")
      subnet_id = try(
        element(azurerm_subnet.this.*.id, lookup(nat_ip_configuration.value, "subnet_id"))
      )
      private_ip_address         = lookup(nat_ip_configuration.value, "private_ip_address")
      private_ip_address_version = lookup(nat_ip_configuration.value, "private_ip_address_version")
    }
  }
}

resource "azurerm_public_ip" "this" {
  count = length(var.public_ip)
  location = try(
    data.azurerm_resource_group.this.location
  )
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  allocation_method    = lookup(var.public_ip[count.index], "allocation_method")
  name                 = lookup(var.public_ip[count.index], "name")
  zones                = lookup(var.public_ip[count.index], "zones")
  ddos_protection_mode = lookup(var.public_ip[count.index], "ddos_protection_mode")
  ddos_protection_plan_id = try(
    element(azurerm_network_ddos_protection_plan.this.*.id, lookup(var.public_ip[count.index], "ddos_protection_plan_id"))
  )
  domain_name_label       = lookup(var.public_ip[count.index], "domain_name_label")
  edge_zone               = lookup(var.public_ip[count.index], "edge_zone")
  idle_timeout_in_minutes = lookup(var.public_ip[count.index], "idle_timeout_in_minutes")
  ip_tags                 = lookup(var.public_ip[count.index], "ip_tags")
  ip_version              = lookup(var.public_ip[count.index], "ip_version")
  public_ip_prefix_id = try(
    element(azurerm_public_ip_prefix.this.*.id, lookup(var.public_ip[count.index], "pubic_ip_prefix_id"))
  )
  reverse_fqdn = lookup(var.public_ip[count.index], "reverse_fqdn")
  sku          = lookup(var.public_ip[count.index], "sku")
  sku_tier     = lookup(var.public_ip[count.index], "sku_tier")
  tags = merge(
    var.tags,
    lookup(var.public_ip[count.index], "tags")
  )
}

resource "azurerm_public_ip_prefix" "this" {
  count = length(var.public_ip_prefix)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.public_ip_prefix[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  sku           = lookup(var.public_ip_prefix[count.index], "sku")
  ip_version    = lookup(var.public_ip_prefix[count.index], "ip_version")
  prefix_length = lookup(var.public_ip_prefix[count.index], "prefix_length")
  tags = merge(
    var.tags,
    lookup(var.public_ip_prefix[count.index], "tags")
  )
  zones = lookup(var.public_ip_prefix[count.index], "zones")
}

resource "azurerm_route" "this" {
  count                  = length(var.route) == "0" ? "0" : (length(var.route_table))
  address_prefix         = lookup(var.route[count.index], "address_prefix")
  name                   = lookup(var.route[count.index], "name")
  next_hop_type          = lookup(var.route[count.index], "next_hop_type")
  resource_group_name    = lookup(var.route[count.index], "resource_group_name")
  route_table_name       = lookup(var.route[count.index], "route_table_name")
  next_hop_in_ip_address = lookup(var.route[count.index], "next_hop_in_ip_address")
}

resource "azurerm_route_filter" "this" {
  count = length(var.route_filter)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.route_filter[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  tags = merge(
    var.tags,
    lookup(var.route_filter[count.index], "tags")
  )

  dynamic "rule" {
    for_each = lookup(var.route_filter[count.index], "rule") == null ? [] : ["rule"]
    content {
      access      = lookup(rule.value, "access")
      communities = lookup(rule.value, "communities")
      name        = lookup(rule.value, "name")
      rule_type   = lookup(rule.value, "rule_type")
    }
  }
}

resource "azurerm_route_map" "this" {
  count = length(var.route_map) == "0" ? "0" : (length(var.virtual_hub))
  name  = lookup(var.route_map[count.index], "name")
  virtual_hub_id = try(
    element(azurerm_virtual_hub.this.*.id, lookup(var.route_map[count.index], "virtual_hub_id"))
  )

  dynamic "rule" {
    for_each = lookup(var.route_map[count.index], "rule") == null ? [] : ["rule"]
    content {
      name                 = lookup(rule.value, "name")
      next_step_if_matched = lookup(rule.value, "next_step_if_matched")

      dynamic "action" {
        for_each = lookup(rule.value, "action") == null ? [] : ["action"]
        content {
          type = lookup(action.value, "type")

          dynamic "parameter" {
            for_each = lookup(action.value, "parameter") == null ? [] : ["parameter"]
            content {
              as_path      = lookup(parameter.value, "as_path")
              community    = lookup(parameter.value, "community")
              route_prefix = lookup(parameter.value, "route_prefix")
            }
          }
        }
      }
      dynamic "match_criterion" {
        for_each = lookup(rule.value, "match_criterion") == null ? [] : ["match_criterion"]
        content {
          match_condition = lookup(match_criterion.value, "match_condition")
          as_path         = lookup(match_criterion.value, "as_path")
          community       = lookup(match_criterion.value, "community")
          route_prefix    = lookup(match_criterion.value, "route_prefix")
        }
      }
    }
  }
}

resource "azurerm_route_server" "this" {
  count = length(var.route_server) == "0" ? "0" : (length(var.public_ip) && length(var.subnet))
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.route_server[count.index], "name")
  public_ip_address_id = try(
    element(azurerm_public_ip.this.*.id, lookup(var.route_server[count.index], "public_ip_address_id"))
  )
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  sku = lookup(var.route_server[count.index], "sku")
  subnet_id = try(
    element(azurerm_subnet.this.*.id, lookup(var.route_server[count.index], "subnet_id"))
  )
  branch_to_branch_traffic_enabled = lookup(var.route_server[count.index], "branch_to_branch_traffic_enabled")
  tags = merge(
    var.tags,
    lookup(var.route_server[count.index], "tags")
  )
}

resource "azurerm_route_server_bgp_connection" "this" {
  count    = length(var.route_server_bgp_connection) == "0" ? "0" : (length(var.route_server))
  name     = lookup(var.route_server_bgp_connection[count.index], "name")
  peer_asn = lookup(var.route_server_bgp_connection[count.index], "peer_asn")
  peer_ip  = lookup(var.route_server_bgp_connection[count.index], "peer_ip")
  route_server_id = try(
    element(azurerm_route_server.this.*.id, lookup(var.route_server_bgp_connection[count.index], "route_server_id"))
  )
}

resource "azurerm_route_table" "this" {
  count                         = length(var.route_table)
  location                      = lookup(var.route_table[count.index], "location")
  name                          = lookup(var.route_table[count.index], "name")
  resource_group_name           = lookup(var.route_table[count.index], "resource_group_name")
  disable_bgp_route_propagation = lookup(var.route_table[count.index], "disable_bgp_route_propagation")
  tags = merge(
    var.tags,
    lookup(var.route_table[count.index], "tags")
  )

  dynamic "route" {
    for_each = lookup(var.route_table[count.index], "route") == null ? [] : ["route"]
    content {
      name                   = lookup(route.value, "name")
      address_prefix         = lookup(route.value, "address_prefix")
      next_hop_type          = lookup(route.value, "next_hop_type")
      next_hop_in_ip_address = lookup(route.value, "next_hop_in_ip_address")
    }
  }
}

resource "azurerm_subnet" "this" {
  count            = length(var.subnet) == "0" ? "0" : (length(var.virtual_network))
  address_prefixes = lookup(var.subnet[count.index], "address_prefixes")
  name             = lookup(var.subnet[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  virtual_network_name = try(
    element(azurerm_virtual_network.this.*.name, lookup(var.subnet[count.index], "virtual_network_id"))
  )
  private_endpoint_network_policies_enabled     = lookup(var.subnet[count.index], "private_endpoint_network_policies_enabled")
  private_link_service_network_policies_enabled = lookup(var.subnet[count.index], "private_link_service_network_policies_enabled")
  service_endpoints                             = lookup(var.subnet[count.index], "service_endpoints")
  service_endpoint_policy_ids                   = lookup(var.subnet[count.index], "service_endpoint_policy_ids")

  dynamic "delegation" {
    for_each = lookup(var.subnet[count.index], "delegation") == null ? [] : ["delegation"]
    content {
      name = lookup(delegation.value, "name")

      dynamic "service_delegation" {
        for_each = lookup(delegation.value, "service_delegation") == null ? [] : ["service_delegation"]
        content {
          name    = lookup(service_delegation.value, "name")
          actions = lookup(service_delegation.value, "actions")
        }
      }
    }
  }
}

resource "azurerm_subnet_nat_gateway_association" "this" {
  count = length(var.subnet_nat_gateway_association) == "0" ? "0" : (length(var.nat_gateway) && length(var.subnet))
  nat_gateway_id = try(
    element(azurerm_nat_gateway.this.*.id, lookup(var.subnet_nat_gateway_association[count.index], "nat_gateway_id"))
  )
  subnet_id = try(
    element(azurerm_subnet.this.*.id, lookup(var.subnet_nat_gateway_association[count.index], "subnet_id"))
  )
}

resource "azurerm_subnet_network_security_group_association" "this" {
  count = length(var.subnet_network_security_group_association) == "0" ? "0" : (length(var.subnet) && length(var.network_security_group))
  network_security_group_id = try(
    element(azurerm_network_security_group.this.*.id, lookup(var.subnet_network_security_group_association[count.index], "network_security_group_id"))
  )
  subnet_id = try(
    element(azurerm_subnet.this.*.id, lookup(var.subnet_network_security_group_association[count.index], "subnet_id"))
  )
}

resource "azurerm_subnet_route_table_association" "this" {
  count = length(var.subnet_route_table_association) == "0" ? "0" : (length(var.subnet) && length(var.route_table))
  route_table_id = try(
    element(azurerm_route_table.this.*.id, lookup(var.subnet_route_table_association[count.index], "route_table_id"))
  )
  subnet_id = try(
    element(azurerm_subnet.this.*.id, lookup(var.subnet_route_table_association[count.index], "subnet_id"))
  )
}

resource "azurerm_subnet_service_endpoint_storage_policy" "this" {
  count = length(var.subnet_service_endpoint_storage_policy)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.subnet_service_endpoint_storage_policy[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  tags = merge(
    var.tags,
    lookup(var.subnet_service_endpoint_storage_policy[count.index], "tags")
  )

  dynamic "definition" {
    for_each = lookup(var.subnet_service_endpoint_storage_policy[count.index], "definition") == null ? [] : ["definition"]
    content {
      name              = lookup(definition.value, "name")
      service_resources = lookup(definition.value, "service_resources")
      service           = lookup(definition.value, "service")
      description       = lookup(definition.value, "description")
    }
  }
}

resource "azurerm_traffic_manager_azure_endpoint" "this" {
  count = length(var.traffic_manager_azure_endpoint) == "0" ? "0" : (length(var.public_ip) && length(var.traffic_manager_profile))
  name  = lookup(var.traffic_manager_azure_endpoint[count.index], "name")
  profile_id = try(
    element(azurerm_traffic_manager_profile.this.*.id, lookup(var.traffic_manager_azure_endpoint[count.index], "profile_id"))
  )
  target_resource_id = try(
    element(azurerm_public_ip.this.*.id, lookup(var.traffic_manager_azure_endpoint[count.index], "target_resource_id"))
  )
  weight       = lookup(var.traffic_manager_azure_endpoint[count.index], "weight")
  enabled      = lookup(var.traffic_manager_azure_endpoint[count.index], "enabled")
  geo_mappings = lookup(var.traffic_manager_azure_endpoint[count.index], "geo_mappings")
  priority     = lookup(var.traffic_manager_azure_endpoint[count.index], "priority")

  dynamic "custom_header" {
    for_each = lookup(var.traffic_manager_azure_endpoint[count.index], "custom_header") == null ? [] : ["custom_header"]
    content {
      name  = lookup(custom_header.value, "name")
      value = lookup(custom_header.value, "value")
    }
  }

  dynamic "subnet" {
    for_each = lookup(var.traffic_manager_azure_endpoint[count.index], "subnet") == null ? [] : ["subnet"]
    content {
      first = lookup(subnet.value, "first")
      last  = lookup(subnet.value, "last")
      scope = lookup(subnet.value, "scope")
    }
  }
}

resource "azurerm_traffic_manager_external_endpoint" "this" {
  count = length(var.traffic_manager_external_endpoint) == "0" ? "0" : (length(var.traffic_manager_profile))
  name  = lookup(var.traffic_manager_external_endpoint[count.index], "name")
  profile_id = try(
    element(azurerm_traffic_manager_profile.this.*.id, lookup(var.traffic_manager_external_endpoint[count.index], "profile_id"))
  )
  target            = lookup(var.traffic_manager_external_endpoint[count.index], "target")
  weight            = lookup(var.traffic_manager_external_endpoint[count.index], "weight")
  endpoint_location = lookup(var.traffic_manager_external_endpoint[count.index], "endpoint_location")
  enabled           = lookup(var.traffic_manager_external_endpoint[count.index], "enabled")
  geo_mappings      = lookup(var.traffic_manager_external_endpoint[count.index], "geo_mappings")
  priority          = lookup(var.traffic_manager_external_endpoint[count.index], "priority")

  dynamic "custom_header" {
    for_each = lookup(var.traffic_manager_external_endpoint[count.index], "custom_header") == null ? [] : ["custom_header"]
    content {
      name  = lookup(custom_header.value, "name")
      value = lookup(custom_header.value, "value")
    }
  }

  dynamic "subnet" {
    for_each = lookup(var.traffic_manager_external_endpoint[count.index], "subnet") == null ? [] : ["subnet"]
    content {
      first = lookup(subnet.value, "first")
      last  = lookup(subnet.value, "last")
      scope = lookup(subnet.value, "scope")
    }
  }
}

resource "azurerm_traffic_manager_nested_endpoint" "this" {
  count                   = length(var.traffic_manager_nested_endpoint) == "0" ? "0" : (length(var.traffic_manager_profile))
  minimum_child_endpoints = lookup(var.traffic_manager_nested_endpoint[count.index], "minimum_child_endpoints")
  name                    = lookup(var.traffic_manager_nested_endpoint[count.index], "name")
  profile_id = try(
    element(azurerm_traffic_manager_profile.this.*.id, lookup(var.traffic_manager_nested_endpoint[count.index], "profile_id"))
  )
  target_resource_id = try(
    element(azurerm_traffic_manager_profile.this.*.id, lookup(var.traffic_manager_nested_endpoint[count.index], "target_resource_id"))
  )
  weight                                = lookup(var.traffic_manager_nested_endpoint[count.index], "weight")
  enabled                               = lookup(var.traffic_manager_nested_endpoint[count.index], "enabled")
  minimum_required_child_endpoints_ipv4 = lookup(var.traffic_manager_nested_endpoint[count.index], "minimum_required_child_endpoints_ipv4")
  minimum_required_child_endpoints_ipv6 = lookup(var.traffic_manager_nested_endpoint[count.index], "minimum_required_child_endpoints_ipv6")
  priority                              = lookup(var.traffic_manager_nested_endpoint[count.index], "priority")
  geo_mappings                          = lookup(var.traffic_manager_nested_endpoint[count.index], "geo_mappings")

  dynamic "custom_header" {
    for_each = lookup(var.traffic_manager_nested_endpoint[count.index], "custom_header") == null ? [] : ["custom_header"]
    content {
      name  = lookup(custom_header.value, "name")
      value = lookup(custom_header.value, "value")
    }
  }

  dynamic "subnet" {
    for_each = lookup(var.traffic_manager_nested_endpoint[count.index], "subnet") == null ? [] : ["subnet"]
    content {
      first = lookup(subnet.value, "first")
      last  = lookup(subnet.value, "last")
      scope = lookup(subnet.value, "scope")
    }
  }
}

resource "azurerm_traffic_manager_profile" "this" {
  count                  = length(var.traffic_manager_profile)
  name                   = lookup(var.traffic_manager_profile[count.index], "name")
  resource_group_name    = lookup(var.traffic_manager_profile[count.index], "resource_group_name")
  traffic_routing_method = lookup(var.traffic_manager_profile[count.index], "traffic_routing_method")
  traffic_view_enabled   = lookup(var.traffic_manager_profile[count.index], "traffic_view_enabled")
  max_return             = lookup(var.traffic_manager_profile[count.index], "max_return")
  tags = merge(
    var.tags,
    lookup(var.traffic_manager_profile[count.index], "tags")
  )
  profile_status = lookup(var.traffic_manager_profile[count.index], "profile_status")

  dynamic "dns_config" {
    for_each = lookup(var.traffic_manager_profile[count.index], "dns_config") == null ? [] : ["dns_config"]
    content {
      relative_name = lookup(dns_config.value, "relative_name")
      ttl           = lookup(dns_config.value, "ttl")
    }
  }

  dynamic "monitor_config" {
    for_each = lookup(var.traffic_manager_profile[count.index], "monitor_config") == null ? [] : ["monitor_config"]
    content {
      port                         = lookup(monitor_config.value, "port")
      protocol                     = lookup(monitor_config.value, "protocol")
      path                         = lookup(monitor_config.value, "path")
      expected_status_code_ranges  = lookup(monitor_config.value, "expected_status_code_ranges")
      interval_in_seconds          = lookup(monitor_config.value, "interval_in_seconds")
      timeout_in_seconds           = lookup(monitor_config.value, "timeout_in_seconds")
      tolerated_number_of_failures = lookup(monitor_config.value, "tolerated_number_of_failures")

      dynamic "custom_header" {
        for_each = lookup(monitor_config.value, "custom_header") == null ? [] : ["custom_header"]
        content {
          name  = lookup(custom_header.value, "name")
          value = lookup(custom_header.value, "value")
        }
      }
    }
  }
}

resource "azurerm_virtual_hub" "this" {
  count = length(var.virtual_hub)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.virtual_hub[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  address_prefix         = lookup(var.virtual_hub[count.index], "address_prefix")
  hub_routing_preference = lookup(var.virtual_hub[count.index], "hub_routing_preference")
  sku                    = lookup(var.virtual_hub[count.index], "sku")
  virtual_wan_id = try(
    element(azurerm_virtual_wan.this.*.id, lookup(var.virtual_hub[count.index], "virtual_wan_id"))
  )
  tags = merge(
    var.tags,
    lookup(var.virtual_hub[count.index], "tags")
  )

  dynamic "route" {
    for_each = lookup(var.virtual_hub[count.index], "route") == null ? [] : ["route"]
    content {
      address_prefixes    = lookup(route.value, "address_prefixes")
      next_hop_ip_address = lookup(route.value, "next_hop_ip_address")
    }
  }
}

resource "azurerm_virtual_hub_bgp_connection" "this" {
  count    = length(var.virtual_hub_bgp_connection) == "0" ? "0" : (length(var.virtual_hub))
  name     = lookup(var.virtual_hub_bgp_connection[count.index], "name")
  peer_asn = lookup(var.virtual_hub_bgp_connection[count.index], "peer_asn")
  peer_ip  = lookup(var.virtual_hub_bgp_connection[count.index], "peer_ip")
  virtual_hub_id = try(
    element(azurerm_virtual_hub.this.*.id, lookup(var.virtual_hub_bgp_connection[count.index], "virtual_hub_id"))
  )
  virtual_network_connection_id = try(
    element(azurerm_virtual_network.this.*.id, lookup(var.virtual_hub_bgp_connection[count.index], "virtual_network_connection_id"))
  )
}

resource "azurerm_virtual_hub_connection" "this" {
  count = length(var.virtual_hub_connection) == "0" ? "0" : (length(var.virtual_hub) && length(var.virtual_network))
  name  = lookup(var.virtual_hub_connection[count.index], "name")
  remote_virtual_network_id = try(
    element(azurerm_virtual_network.this.*.id, lookup(var.virtual_hub_connection[count.index], "remote_virtual_network_id"))
  )
  virtual_hub_id = try(
    element(azurerm_virtual_hub.this.*.id, lookup(var.virtual_hub_connection[count.index], "virtual_hub_id"))
  )
  internet_security_enabled = lookup(var.virtual_hub_connection[count.index], "internet_security_enabled")

  dynamic "routing" {
    for_each = lookup(var.virtual_hub_connection[count.index], "routing") == null ? [] : ["routing"]
    content {
      associated_route_table_id = try(
        element(azurerm_route_table.this.*.tags, lookup(routing.value, "associated_route_table_id"))
      )
      inbound_route_map_id = try(
        element(azurerm_route_map.this.*.id, lookup(routing.value, "inbound_route_map_id"))
      )
      outbound_route_map_id = try(
        element(azurerm_route_map.this.*.id, lookup(routing.value, "outbound_route_map_id"))
      )
      static_vnet_local_route_override_criteria = lookup(routing.value, "static_vnet_local_route_override_criteria")

      dynamic "propagated_route_table" {
        for_each = lookup(routing.value, "propagated_route_table") == null ? [] : ["propagated_route_table"]
        content {
          labels = lookup(propagated_route_table.value, "labels")
          route_table_ids = try(
            element(azurerm_route_table.this.*.id, lookup(propagated_route_table.value, "route_table_ids"))
          )
        }
      }

      dynamic "static_vnet_route" {
        for_each = lookup(routing.value, "static_vnet_route") == null ? [] : ["static_vnet_route"]
        content {
          name                = lookup(static_vnet_route.value, "name")
          address_prefixes    = lookup(static_vnet_route.value, "address_prefixes")
          next_hop_ip_address = lookup(static_vnet_route.value, "next_hop_ip_address")
        }
      }
    }
  }
}

resource "azurerm_virtual_hub_ip" "this" {
  count = length(var.virtual_hub_ip) == "0" ? "0" : (length(var.virtual_hub) && length(var.subnet) && length(var.public_ip))
  name  = lookup(var.virtual_hub_ip[count.index], "name")
  public_ip_address_id = try(
    element(azurerm_public_ip.this.*.id, lookup(var.virtual_hub_ip[count.index], "public_ip_address_id"))
  )
  subnet_id = try(
    element(azurerm_subnet.this.*.id, lookup(var.virtual_hub_ip[count.index], "subnet_id"))
  )
  virtual_hub_id = try(
    element(azurerm_virtual_hub.this.*.id, lookup(var.virtual_hub_ip[count.index], "virtual_hub_id"))
  )
  private_ip_address           = lookup(var.virtual_hub_ip[count.index], "private_ip_address")
  private_ip_allocation_method = lookup(var.virtual_hub_ip[count.index], "private_ip_allocation_method")
}

resource "azurerm_virtual_hub_route_table" "this" {
  count = length(var.virtual_hub_route_table) == "0" ? "0" : (length(var.virtual_hub))
  name  = lookup(var.virtual_hub_route_table[count.index], "name")
  virtual_hub_id = try(
    element(azurerm_virtual_hub.this.*.id, lookup(var.virtual_hub_route_table[count.index], "virtual_hub_id"))
  )
  labels = lookup(var.virtual_hub_route_table[count.index], "labels")

  dynamic "route" {
    for_each = lookup(var.virtual_hub_route_table[count.index], "route") == null ? [] : ["route"]
    content {
      destinations      = lookup(route.value, "destinations")
      destinations_type = lookup(route.value, "destinations_type")
      name              = lookup(route.value, "name")
      next_hop          = lookup(route.value, "next_hop")
      next_hop_type     = lookup(route.value, "next_hop_type")
    }
  }
}

resource "azurerm_virtual_hub_route_table_route" "this" {
  count             = length(var.virtual_hub_route_table_route) == "0" ? "0" : (length(var.virtual_hub_route_table) && length(var.virtual_hub_connection))
  destinations      = lookup(var.virtual_hub_route_table_route[count.index], "destinations")
  destinations_type = lookup(var.virtual_hub_route_table_route[count.index], "destinations_type")
  name              = lookup(var.virtual_hub_route_table_route[count.index], "name")
  next_hop = try(
    element(azurerm_virtual_hub_connection.this.*.id, lookup(var.virtual_hub_route_table_route[count.index], "next_hop_id"))
  )
  route_table_id = try(
    element(azurerm_virtual_hub_route_table.this.*.id, lookup(var.virtual_hub_route_table_route[count.index], "route_table_id"))
  )
  next_hop_type = lookup(var.virtual_hub_route_table_route[count.index], "next_hop_type")
}

resource "azurerm_virtual_hub_security_partner_provider" "this" {
  count = length(var.virtual_hub_security_partner_provider)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.virtual_hub_security_partner_provider[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  security_provider_name = lookup(var.virtual_hub_security_partner_provider[count.index], "security_provider_name")
  virtual_hub_id = try(
    element(azurerm_virtual_hub.this.*.id, lookup(var.virtual_hub_security_partner_provider[count.index], "virtual_hub_id"))
  )
  tags = merge(
    var.tags,
    lookup(var.virtual_hub_security_partner_provider[count.index], "tags")
  )
}

resource "azurerm_virtual_machine_packet_capture" "this" {
  count = length(var.virtual_machine_packet_capture) == "0" ? "0" : (length(var.network_watcher))
  name  = lookup(virtual_machine_packet_capture[count.index], "name")
  network_watcher_id = try(
    element(azurerm_network_watcher.this.*.id, lookup(var.virtual_machine_packet_capture[count.index], "network_watcher_id"))
  )
  virtual_machine_id                  = lookup(virtual_machine_packet_capture[count.index], "virtual_machine_id")
  maximum_bytes_per_packet            = lookup(virtual_machine_packet_capture[count.index], "maximum_bytes_per_packet")
  maximum_bytes_per_session           = lookup(virtual_machine_packet_capture[count.index], "maximum_bytes_per_session")
  maximum_capture_duration_in_seconds = lookup(virtual_machine_packet_capture[count.index], "maximum_capture_duration_in_seconds")

  dynamic "storage_location" {
    for_each = lookup(var.virtual_machine_packet_capture[count.index], "storage_location") == null ? [] : ["storage_location"]
    content {
      file_path          = lookup(storage_location.value, "file_path")
      storage_account_id = lookup(storage_location.value, "storage_account_id")
    }
  }

  dynamic "filter" {
    for_each = lookup(var.virtual_machine_packet_capture[count.index], "filter") == null ? [] : ["filter"]
    content {
      protocol          = lookup(filter.value, "protocol")
      local_ip_address  = lookup(filter.value, "local_ip_address")
      local_port        = lookup(filter.value, "local_port")
      remote_ip_address = lookup(filter.value, "remote_ip_address")
      remote_port       = lookup(filter.value, "remote_port")
    }
  }
}

resource "azurerm_virtual_machine_scale_set_packet_capture" "this" {
  count = length(var.virtual_machine_scale_set_packet_capture) == "0" ? "0" : (length(var.network_watcher))
  name  = lookup(var.virtual_machine_scale_set_packet_capture[count.index], "name")
  network_watcher_id = try(
    element(azurerm_network_watcher.this.*.id, lookup(var.virtual_machine_scale_set_packet_capture[count.index], "network_watcher_id"))
  )
  virtual_machine_scale_set_id        = lookup(var.virtual_machine_scale_set_packet_capture[count.index], "virtual_machine_scale_set_id")
  maximum_bytes_per_packet            = lookup(var.virtual_machine_scale_set_packet_capture[count.index], "maximum_bytes_per_packet")
  maximum_bytes_per_session           = lookup(var.virtual_machine_scale_set_packet_capture[count.index], "maximum_bytes_per_session")
  maximum_capture_duration_in_seconds = lookup(var.virtual_machine_scale_set_packet_capture[count.index], "maximum_capture_duration_in_seconds")

  dynamic "storage_location" {
    for_each = lookup(var.virtual_machine_scale_set_packet_capture[count.index], "storage_location") == null ? [] : ["storage_location"]
    content {
      file_path          = lookup(storage_location.value, "file_path")
      storage_account_id = lookup(storage_location.value, "storage_account_id")
    }
  }

  dynamic "filter" {
    for_each = lookup(var.virtual_machine_scale_set_packet_capture[count.index], "filter") == null ? [] : ["filter"]
    content {
      protocol          = lookup(filter.value, "protocol")
      local_ip_address  = lookup(filter.value, "local_ip_address")
      local_port        = lookup(filter.value, "local_port")
      remote_ip_address = lookup(filter.value, "remote_ip_address")
      remote_port       = lookup(filter.value, "remote_port")
    }
  }

  dynamic "machine_scope" {
    for_each = lookup(var.virtual_machine_scale_set_packet_capture[count.index], "machine_scope") == null ? [] : ["machine_scope"]
    content {
      exclude_instance_ids = lookup(machine_scope.value, "exclude_instance_ids")
      include_instance_ids = lookup(machine_scope.value, "include_instance_ids")
    }
  }
}

resource "azurerm_virtual_network" "this" {
  count         = length(var.virtual_network)
  address_space = lookup(var.virtual_network[count.index], "address_space")
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.virtual_network[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  bgp_community           = lookup(var.virtual_network[count.index], "bgp_community")
  dns_servers             = lookup(var.virtual_network[count.index], "dns_servers")
  edge_zone               = lookup(var.virtual_network[count.index], "edge_zone")
  flow_timeout_in_minutes = lookup(var.virtual_network[count.index], "flow_timeout_in_minutes")
  tags = merge(
    var.tags,
    lookup(var.virtual_network[count.index], "tags")
  )

  dynamic "ddos_protection_plan" {
    for_each = lookup(var.virtual_network[count.index], "ddos_protection_plan") == null ? [] : ["ddos_protection_plan"]
    content {
      enable = lookup(ddos_protection_plan.value, "enabled")
      id = try(
        element(azurerm_network_ddos_protection_plan.this.*.id, lookup(ddos_protection_plan.value, "id"))
      )
    }
  }

  dynamic "encrpytion" {
    for_each = lookup(var.virtual_network[count.index], "encrpytion") == null ? [] : ["encrpytion"]
    content {
      enforcement = lookup(encrpytion.value, "enforcement")
    }
  }

  dynamic "subnet" {
    for_each = lookup(var.virtual_network[count.index], "subnet") == null ? [] : ["subnet"]
    content {
      name           = lookup(subnet.value, "name")
      address_prefix = lookup(subnet.value, "address_prefix")
      security_group = try(
        element(azurerm_network_security_group.this.*.id, lookup(subnet.value, "security_group_id"))
      )
    }
  }
}

resource "azurerm_virtual_network_dns_servers" "this" {
  count = length(var.virtual_network_dns_servers) == "0" ? "0" : length(var.virtual_network)
  virtual_network_id = try(
    element(azurerm_virtual_network.this.*.id, lookup(var.virtual_network_dns_servers[count.index], "virtual_network_id"))
  )
  dns_servers = lookup(var.virtual_network_dns_servers[count.index], "dns_servers")
}

resource "azurerm_virtual_network_gateway" "this" {
  count = length(var.virtual_network_gateway)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.virtual_network_gateway[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  sku           = lookup(var.virtual_network_gateway[count.index], "sku")
  type          = lookup(var.virtual_network_gateway[count.index], "type")
  active_active = lookup(var.virtual_network_gateway[count.index], "active_active")
  default_local_network_gateway_id = try(
    element(azurerm_local_network_gateway.this.*.id, lookup(var.virtual_network_gateway[count.index], "default_local_network_gateway_id"))
  )
  edge_zone                  = lookup(var.virtual_network_gateway[count.index], "edge_zone")
  enable_bgp                 = lookup(var.virtual_network_gateway[count.index], "enable_bgp")
  generation                 = lookup(var.virtual_network_gateway[count.index], "generation")
  private_ip_address_enabled = lookup(var.virtual_network_gateway[count.index], "private_ip_address_enabled")
  tags = merge(
    var.tags,
    lookup(var.virtual_network_gateway[count.index], "tags")
  )
  vpn_type = lookup(var.virtual_network_gateway[count.index], "vpn_type")

  dynamic "ip_configuration" {
    for_each = lookup(var.virtual_network_gateway[count.index], "ip_configuration") == null ? [] : ["ip_configuration"]
    content {
      public_ip_address_id = try(
        element(azurerm_public_ip.this.*.id, lookup(ip_configuration.value, "public_ip_address_id"))
      )
      subnet_id = try(
        element(azurerm_subnet.this.*.id, lookup(ip_configuration.value, "subnet_id"))
      )
      name                          = lookup(ip_configuration.value, "name")
      private_ip_address_allocation = lookup(ip_configuration.value, "private_ip_address_allocation")
    }
  }

  dynamic "vpn_client_configuration" {
    for_each = lookup(var.virtual_network_gateway[count.index], "vpn_client_configuration") == null ? [] : ["vpn_client_configuration"]
    content {
      address_space         = lookup(vpn_client_configuration.value, "address_space")
      aad_tenant            = lookup(vpn_client_configuration.value, "aad_tenant")
      aad_audience          = lookup(vpn_client_configuration.value, "aad_audience")
      aad_issuer            = lookup(vpn_client_configuration.value, "aad_issuer")
      radius_server_address = lookup(vpn_client_configuration.value, "radius_server_address")
      radius_server_secret  = lookup(vpn_client_configuration.value, "radius_server_secret")
      vpn_client_protocols  = lookup(vpn_client_configuration.value, "vpn_client_protocols")
      vpn_auth_types        = lookup(vpn_client_configuration.value, "vpn_auth_types")

      dynamic "root_certificate" {
        for_each = lookup(vpn_client_configuration.value, "root_certificate") == null ? [] : ["root_certificate"]
        content {
          name             = lookup(root_certificate.value, "name")
          public_cert_data = lookup(root_certificate.value, "public_cert_data")
        }
      }

      dynamic "revoked_certificate" {
        for_each = lookup(vpn_client_configuration.value, "revoked_certificate") == null ? [] : ["revoked_certificate"]
        content {
          name       = lookup(revoked_certificate.value, "name")
          thumbprint = lookup(revoked_certificate.value, "thumbprint")
        }
      }
    }
  }

  dynamic "bgp_settings" {
    for_each = lookup(var.virtual_network_gateway[count.index], "bgp_settings") == null ? [] : ["bgp_settings"]
    content {
      asn         = lookup(bgp_settings.value, "asn")
      peer_weight = lookup(bgp_settings.value, "peer_weight")

      dynamic "peering_addresses" {
        for_each = lookup(bgp_settings.value, "peering_addresses") == null ? [] : ["peering_addresses"]
        content {
          ip_configuration_name = lookup(peering_addresses.value, "ip_configuration_name")
          apipa_addresses       = lookup(peering_addresses.value, "apipa_addresses")
        }
      }
    }
  }

  dynamic "custom_route" {
    for_each = lookup(var.virtual_network_gateway[count.index], "custom_route") == null ? [] : ["custom_route"]
    content {
      address_prefixes = lookup(custom_route.value, "address_prefixes")
    }
  }
}

resource "azurerm_virtual_network_gateway_connection" "this" {
  count = length(var.virtual_network_gateway_connection) == "0" ? "0" : (length(var.virtual_network_gateway))
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.virtual_network_gateway_connection[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  type = lookup(var.virtual_network_gateway_connection[count.index], "type")
  virtual_network_gateway_id = try(
    element(azurerm_virtual_network_gateway.this.*.id, lookup(var.virtual_network_gateway_connection[count.index], "virtual_network_gateway_id"))
  )
  authorization_key   = lookup(var.virtual_network_gateway_connection[count.index], "authorization_key")
  dpd_timeout_seconds = lookup(var.virtual_network_gateway_connection[count.index], "dpd_timeout_seconds")
  express_route_circuit_id = try(
    element(azurerm_express_route_circuit.this.*.id, lookup(var.virtual_network_gateway_connection[count.index], "express_route_circuit_id"))
  )
  peer_virtual_network_gateway_id = try(
    element(azurerm_virtual_network_gateway.this.*.id, lookup(var.virtual_network_gateway_connection[count.index], "peer_virtual_network_gateway_id"))
  )
  local_azure_ip_address_enabled = lookup(var.virtual_network_gateway_connection[count.index], "local_azure_ip_address_enabled")
  local_network_gateway_id = try(
    element(azurerm_local_network_gateway.this.*.id, lookup(var.virtual_network_gateway_connection[count.index], "local_network_gateway_id"))
  )
  routing_weight                     = lookup(var.virtual_network_gateway_connection[count.index], "routing_weight")
  shared_key                         = lookup(var.virtual_network_gateway_connection[count.index], "shared_key")
  connection_mode                    = lookup(var.virtual_network_gateway_connection[count.index], "connection_mode")
  connection_protocol                = lookup(var.virtual_network_gateway_connection[count.index], "connection_protocol")
  enable_bgp                         = lookup(var.virtual_network_gateway_connection[count.index], "enable_bgp")
  express_route_gateway_bypass       = lookup(var.virtual_network_gateway_connection[count.index], "express_route_gateway_bypass")
  egress_nat_rule_ids                = lookup(var.virtual_network_gateway_connection[count.index], "egress_nat_rule_ids")
  ingress_nat_rule_ids               = lookup(var.virtual_network_gateway_connection[count.index], "ingress_nat_rule_ids")
  use_policy_based_traffic_selectors = lookup(var.virtual_network_gateway_connection[count.index], "use_policy_based_traffic_selectors")
  tags = merge(
    var.tags,
    lookup(var.virtual_network_gateway_connection[count.index], "tags")
  )

  dynamic "custom_bgp_addresses" {
    for_each = lookup(var.virtual_network_gateway_connection[count.index], "custom_bgp_addresses") == null ? [] : ["custom_bgp_addresses"]
    content {
      primary   = lookup(custom_bgp_addresses.value, "primary")
      secondary = lookup(custom_bgp_addresses.value, "secondary")
    }
  }

  dynamic "ipsec_policy" {
    for_each = lookup(var.virtual_network_gateway_connection[count.index], "ipsec_policy") == null ? [] : ["ipsec_policy"]
    content {
      dh_group         = lookup(ipsec_policy.value, "dh_group")
      ike_encryption   = lookup(ipsec_policy.value, "ike_encryption")
      ike_integrity    = lookup(ipsec_policy.value, "ike_integrity")
      ipsec_encryption = lookup(ipsec_policy.value, "ipsec_encryption")
      ipsec_integrity  = lookup(ipsec_policy.value, "ipsec_integrity")
      pfs_group        = lookup(ipsec_policy.value, "pfs_group")
      sa_datasize      = lookup(ipsec_policy.value, "sa_datasize")
      sa_lifetime      = lookup(ipsec_policy.value, "sa_lifetime")
    }
  }

  dynamic "traffic_selector_policy" {
    for_each = lookup(var.virtual_network_gateway_connection[count.index], "traffic_selector_policy") == null ? [] : ["traffic_selector_policy"]
    content {
      local_address_cidrs  = lookup(traffic_selector_policy.value, "local_address_cidrs")
      remote_address_cidrs = lookup(traffic_selector_policy.value, "remote_address_cidrs")
    }
  }
}

resource "azurerm_virtual_network_gateway_nat_rule" "this" {
  count = length(var.virtual_network_gateway_nat_rule) == "0" ? "0" : (length(var.virtual_network_gateway))
  name  = lookup(var.virtual_network_gateway_nat_rule[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  virtual_network_gateway_id = try(
    element(azurerm_virtual_network_gateway.this.*.id, lookup(var.virtual_network_gateway_nat_rule[count.index], "virtual_network_gateway_id"))
  )
  mode = lookup(var.virtual_network_gateway_nat_rule[count.index], "mode")
  type = lookup(var.virtual_network_gateway_nat_rule[count.index], "type")

  dynamic "external_mapping" {
    for_each = lookup(var.virtual_network_gateway_nat_rule[count.index], "external_mapping") == null ? [] : ["external_mapping"]
    content {
      address_space = lookup(external_mapping.value, "address_space")
      port_range    = lookup(external_mapping.value, "port_range")
    }
  }

  dynamic "internal_mapping" {
    for_each = lookup(var.virtual_network_gateway_nat_rule[count.index], "internal_mapping") == null ? [] : ["internal_mapping"]
    content {
      address_space = lookup(internal_mapping.value, "address_space")
      port_range    = lookup(internal_mapping.value, "port_range")
    }
  }
}

resource "azurerm_virtual_network_peering" "this" {
  count = length(var.virtual_network_peering) == "0" ? "0" : (length(var.virtual_network))
  name  = lookup(var.virtual_network_peering[count.index], "name")
  remote_virtual_network_id = try(
    element(azurerm_virtual_network.this.*.id, lookup(var.virtual_network_peering[count.index], "remote_virtual_network_id"))
  )
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  virtual_network_name = try(
    element(azurerm_virtual_network.this.*.id, lookup(var.virtual_network_peering[count.index], "virtual_network_id"))
  )
  allow_virtual_network_access = lookup(var.virtual_network_peering[count.index], "allow_virtual_network_access")
  allow_forwarded_traffic      = lookup(var.virtual_network_peering[count.index], "allow_forwarded_traffic")
  allow_gateway_transit        = lookup(var.virtual_network_peering[count.index], "allow_gateway_transit")
  use_remote_gateways          = lookup(var.virtual_network_peering[count.index], "use_remote_gateways")
  triggers = merge(
    var.tags,
    lookup(var.virtual_network_peering[count.index], "tags")
  )
}

resource "azurerm_virtual_wan" "this" {
  count = length(var.virtual_wan)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.virtual_wan[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  disable_vpn_encryption            = lookup(var.virtual_wan[count.index], "disable_vpn_encryption")
  allow_branch_to_branch_traffic    = lookup(var.virtual_wan[count.index], "allow_branch_to_branch_traffic")
  office365_local_breakout_category = lookup(var.virtual_wan[count.index], "office365_local_breakout_category")
  type                              = lookup(var.virtual_wan[count.index], "type")
  tags = merge(
    var.tags,
    lookup(var.virtual_wan[count.index], "tags")
  )
}

resource "azurerm_vpn_gateway" "this" {
  count = length(var.vpn_gateway) == "0" ? "0" : (length(var.virtual_hub))
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.vpn_gateway[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  virtual_hub_id = try(
    element(azurerm_virtual_hub.this.*.id, lookup(var.vpn_gateway[count.index], "virtual_hub_id"))
  )
  bgp_route_translation_for_nat_enabled = lookup(var.vpn_gateway[count.index], "bgp_route_translation_for_nat_enabled")
  routing_preference                    = lookup(var.vpn_gateway[count.index], "routing_preference")
  scale_unit                            = lookup(var.vpn_gateway[count.index], "scale_unit")
  tags = merge(
    var.tags,
    lookup(var.vpn_gateway[count.index], "tags")
  )

  dynamic "bgp_settings" {
    for_each = lookup(var.vpn_gateway[count.index], "bgp_settings") == null ? [] : ["bgp_settings"]
    content {
      asn         = lookup(bgp_settings.value, "asn")
      peer_weight = lookup(bgp_settings.value, "peer_weight")

      dynamic "instance_0_bgp_peering_address" {
        for_each = lookup(bgp_settings.value, "instance_0_bgp_peering_address") == null ? [] : ["instance_0_bgp_peering_address"]
        content {
          custom_ips = lookup(instance_0_bgp_peering_address.value, "custom_ips")
        }
      }

      dynamic "instance_1_bgp_peering_address" {
        for_each = lookup(bgp_settings.value, "instance_1_bgp_peering_address") == null ? [] : ["instance_1_bgp_peering_address"]
        content {
          custom_ips = lookup(instance_1_bgp_peering_address.value, "custom_ips")
        }
      }
    }
  }
}

resource "azurerm_vpn_gateway_connection" "this" {
  count = length(var.vpn_gateway_connection) == "0" ? "0" : (length(var.vpn_gateway) && length(var.vpn_site))
  name  = lookup(var.vpn_gateway_connection[count.index], "name")
  remote_vpn_site_id = try(
    element(azurerm_vpn_site.this.*.id, lookup(var.vpn_gateway_connection[count.index], "remote_vpn_site_id"))
  )
  vpn_gateway_id = try(
    element(azurerm_vpn_gateway.this.*.id, lookup(var.vpn_gateway_connection[count.index], "vpn_gateway_id"))
  )

  dynamic "vpn_link" {
    for_each = lookup(var.vpn_gateway_connection[count.index], "vpn_link") == null ? [] : ["vpn_link"]
    content {
      name = lookup(vpn_link.value, "name")
      vpn_site_link_id = try(
        element(azurerm_vpn_site.this.*.id, lookup(vpn_link.value, "vpn_site_link_id"))
      )
      egress_nat_rule_ids                   = lookup(vpn_link.value, "egress_nat_rule_ids")
      ingress_nat_rule_ids                  = lookup(vpn_link.value, "ingress_nat_rule_ids")
      bandwidth_mbps                        = lookup(vpn_link.value, "bandwidth_mbps")
      bgp_enabled                           = lookup(vpn_link.value, "bgp_enabled")
      connection_mode                       = lookup(vpn_link.value, "connection_mode")
      protocol                              = lookup(vpn_link.value, "protocol")
      ratelimit_enabled                     = lookup(vpn_link.value, "ratelimit_enabled")
      route_weight                          = lookup(vpn_link.value, "route_weight")
      shared_key                            = lookup(vpn_link.value, "shared_key")
      local_azure_ip_address_enabled        = lookup(vpn_link.value, "local_azure_ip_address_enabled")
      policy_based_traffic_selector_enabled = lookup(vpn_link.value, "policy_based_traffic_selector_enabled")

      dynamic "ipsec_policy" {
        for_each = lookup(vpn_link.value, "ipsec_policy") == null ? [] : ["ipsec_policy"]
        content {
          dh_group                 = lookup(ipsec_policy.value, "dh_group")
          encryption_algorithm     = lookup(ipsec_policy.value, "encryption_algorithm")
          ike_encryption_algorithm = lookup(ipsec_policy.value, "ike_encryption_algorithm")
          ike_integrity_algorithm  = lookup(ipsec_policy.value, "ike_integrity_algorithm")
          integrity_algorithm      = lookup(ipsec_policy.value, "integrity_algorithm")
          pfs_group                = lookup(ipsec_policy.value, "pfs_group")
          sa_data_size_kb          = lookup(ipsec_policy.value, "sa_data_size_kb")
          sa_lifetime_sec          = lookup(ipsec_policy.value, "sa_lifetime_sec")
        }
      }

      dynamic "custom_bgp_address" {
        for_each = lookup(vpn_link.value, "custom_bgp_address") == null ? [] : ["custom_bgp_address"]
        content {
          ip_address          = lookup(custom_bgp_address.value, "ip_address")
          ip_configuration_id = lookup(custom_bgp_address.value, "ip_configuration_id")
        }
      }
    }
  }

  dynamic "routing" {
    for_each = lookup(var.vpn_gateway_connection[count.index], "routing") == null ? [] : ["routing"]
    content {
      associated_route_table = try(
        element(azurerm_route_table.this.*.id, lookup(routing.value, "associated_route_table"))
      )
      inbound_route_map_id = try(
        element(azurerm_route_map.this.*.id, lookup(routing.value, "inbound_route_map_id"))
      )
      outbound_route_map_id = try(
        element(azurerm_route_map.this.*.id, lookup(routing.value, "outbound_route_map_id"))
      )

      dynamic "propagated_route_table" {
        for_each = lookup(routing.value, "propagated_route_table")
        content {
          route_table_ids = try(
            element(azurerm_route_table.this.*.id, lookup(propagated_route_table.value, "route_table_ids"))
          )
          labels = lookup(propagated_route_table.value, "labels")
        }
      }
    }
  }

  dynamic "traffic_selector_policy" {
    for_each = lookup(var.vpn_gateway_connection[count.index], "traffic_selector_policy") == null ? [] : ["traffic_selector_policy"]
    content {
      local_address_ranges  = lookup(traffic_selector_policy.value, "local_address_ranges")
      remote_address_ranges = lookup(traffic_selector_policy.value, "remote_address_ranges")
    }
  }
}

resource "azurerm_vpn_gateway_nat_rule" "this" {
  count = length(var.vpn_gateway_nat_rule) == "0" ? "0" : (length(var.vpn_gateway))
  name  = lookup(var.vpn_gateway_nat_rule[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  vpn_gateway_id = try(
    element(azurerm_vpn_gateway.this.*.id, lookup(azurerm_vpn_gateway_nat_rule[count.index], "vpn_gateway_id"))
  )
  ip_configuration_id = lookup(var.vpn_gateway_nat_rule[count.index], "ip_configuration_id")
  mode                = lookup(var.vpn_gateway_nat_rule[count.index], "mode")
  type                = lookup(var.vpn_gateway_nat_rule[count.index], "type")

  dynamic "external_mapping" {
    for_each = lookup(var.vpn_gateway_nat_rule[count.index], "external_mapping") == null ? [] : ["external_mapping"]
    content {
      address_space = lookup(external_mapping.value, "address_space")
      port_range    = lookup(external_mapping.value, "port_range")
    }
  }

  dynamic "internal_mapping" {
    for_each = lookup(var.vpn_gateway_nat_rule[count.index], "internal_mapping") == null ? [] : ["internal_mapping"]
    content {
      address_space = lookup(internal_mapping.value, "address_space")
      port_range    = lookup(internal_mapping.value, "port_range")
    }
  }
}

resource "azurerm_vpn_server_configuration" "this" {
  count = length(var.vpn_server_configuration)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.vpn_server_configuration[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  vpn_authentication_types = lookup(var.vpn_server_configuration[count.index], "vpn_authentication_types")
  vpn_protocols            = lookup(var.vpn_server_configuration[count.index], "vpn_protocols")
  tags = merge(
    var.tags,
    lookup(var.vpn_server_configuration[count.index], "tags")
  )

  dynamic "ipsec_policy" {
    for_each = lookup(var.vpn_server_configuration[count.index], "ipsec_policy") == null ? [] : ["ipsec_policy"]
    content {
      dh_group               = lookup(ipsec_policy.value, "dh_group")
      ike_encryption         = lookup(ipsec_policy.value, "ike_encryption")
      ike_integrity          = lookup(ipsec_policy.value, "ike_integrity")
      ipsec_encryption       = lookup(ipsec_policy.value, "ipsec_encryption")
      ipsec_integrity        = lookup(ipsec_policy.value, "ipsec_integrity")
      pfs_group              = lookup(ipsec_policy.value, "pfs_group")
      sa_data_size_kilobytes = lookup(ipsec_policy.value, "sa_data_size_kilobytes")
      sa_lifetime_seconds    = lookup(ipsec_policy.value, "sa_lifetime_seconds")
    }
  }

  dynamic "azure_active_directory_authentication" {
    for_each = lookup(var.vpn_server_configuration[count.index], "azure_active_directory_authentication") == null ? [] : ["azure_active_directory_authentication"]
    content {
      audience = lookup(azure_active_directory_authentication.value, "audience")
      issuer   = lookup(azure_active_directory_authentication.value, "issuer")
      tenant   = lookup(azure_active_directory_authentication.value, "tenant")
    }
  }

  dynamic "radius" {
    for_each = lookup(var.vpn_server_configuration[count.index], "radius") == null ? [] : ["radius"]
    content {
      dynamic "server" {
        for_each = lookup(radius.value, "server") == null ? [] : ["server"]
        content {
          address = lookup(server.value, "address")
          score   = lookup(server.value, "score")
          secret  = lookup(server.value, "secret")
        }
      }

      dynamic "client_root_certificate" {
        for_each = lookup(radius.value, "client_root_certificate") == null ? [] : ["client_root_certificate"]
        content {
          name       = lookup(client_root_certificate.value, "name")
          thumbprint = lookup(client_root_certificate.value, "thumbprint")
        }
      }

      dynamic "server_root_certificate" {
        for_each = lookup(radius.value, "server_root_certificate") == null ? [] : ["server_root_certificate"]
        content {
          name             = lookup(server_root_certificate.value, "name")
          public_cert_data = lookup(server_root_certificate.value, "public_cert_data")
        }
      }
    }
  }

  dynamic "client_revoked_certificate" {
    for_each = lookup(var.vpn_server_configuration[count.index], "client_revoked_certificate") == null ? [] : ["client_revoked_certificate"]
    content {
      name       = lookup(client_revoked_certificate.value, "name")
      thumbprint = lookup(client_revoked_certificate.value, "thumbprint")
    }
  }

  dynamic "client_root_certificate" {
    for_each = lookup(var.vpn_server_configuration[count.index], "client_root_certificate") == null ? [] : ["client_root_certificate"]
    content {
      name             = lookup(client_root_certificate.value, "name")
      public_cert_data = lookup(client_root_certificate.value, "public_cert_data")
    }
  }
}

resource "azurerm_vpn_server_configuration_policy_group" "this" {
  count = length(var.vpn_server_configuration_policy_group) == "0" ? "0" : (length(var.vpn_server_configuration))
  name  = lookup(var.vpn_server_configuration_policy_group[count.index], "name")
  vpn_server_configuration_id = try(
    element(azurerm_vpn_server_configuration.this.*.id, lookup(var.vpn_server_configuration_policy_group[count.index], "vpn_server_configuration_id"))
  )
  is_default = lookup(var.vpn_server_configuration_policy_group[count.index], "is_default")
  priority   = lookup(var.vpn_server_configuration_policy_group[count.index], "priority")

  dynamic "policy" {
    for_each = lookup(var.vpn_server_configuration_policy_group[count.index], "policy") == null ? [] : ["policy"]
    content {
      name  = lookup(policy.value, "name")
      type  = lookup(policy.value, "type")
      value = lookup(policy.value, "value")
    }
  }
}

resource "azurerm_vpn_site" "this" {
  count = length(var.vpn_site) == "0" ? "0" : (length(var.virtual_wan))
  location = try(
  data.azurerm_resource_group.this.location)

  name = lookup(var.vpn_site[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  virtual_wan_id = try(
    element(azurerm_virtual_wan.this.*.id, lookup(var.vpn_site[count.index], "virtual_wan_id"))
  )
  address_cidrs = lookup(var.vpn_site[count.index], "address_cidrs")
  device_model  = lookup(var.vpn_site[count.index], "device_model")
  device_vendor = lookup(var.vpn_site[count.index], "device_vendor")
  tags = merge(
    var.tags,
    lookup(var.vpn_site[count.index], "tags")
  )

  dynamic "link" {
    for_each = lookup(var.vpn_site[count.index], "link") == null ? [] : ["link"]
    content {
      name          = lookup(link.value, "name")
      fqdn          = lookup(link.value, "fqdn")
      ip_address    = lookup(link.value, "ip_address")
      provider_name = lookup(link.value, "provider_name")
      speed_in_mbps = lookup(link.value, "speed_in_mbps")

      dynamic "bgp" {
        for_each = lookup(link.value, "bgp") == null ? [] : ["bgp"]
        content {
          asn             = lookup(bgp.value, "asn")
          peering_address = lookup(bgp.value, "peering_address")
        }
      }
    }
  }

  dynamic "o365_policy" {
    for_each = lookup(var.vpn_site[count.index], "o365_policy") == null ? [] : ["o365_policy"]
    content {
      dynamic "traffic_category" {
        for_each = lookup(o365_policy.value, "traffic_category") == null ? [] : ["traffic_category"]
        content {
          allow_endpoint_enabled    = lookup(traffic_category.value, "allow_endpoint_enabled")
          default_endpoint_enabled  = lookup(traffic_category.value, "default_endpoint_enabled")
          optimize_endpoint_enabled = lookup(traffic_category.value, "optimize_endpoint_enabled")
        }
      }
    }
  }
}

resource "azurerm_web_application_firewall_policy" "this" {
  count = length(var.web_application_firewall_policy)
  location = try(
    data.azurerm_resource_group.this.location
  )
  name = lookup(var.web_application_firewall_policy[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.name
  )
  tags = merge(
    var.tags,
    lookup(var.web_application_firewall_policy[count.index], "tags")
  )

  dynamic "custom_rules" {
    for_each = lookup(var.web_application_firewall_policy[count.index], "custom_rules") == null ? [] : ["custom_rules"]
    content {
      action              = lookup(custom_rules.value, "action")
      priority            = lookup(custom_rules.value, "priority")
      rule_type           = lookup(custom_rules.value, "rule_type")
      name                = lookup(custom_rules.value, "name")
      rate_limit_duration = lookup(custom_rules.value, "rate_limit_duration")
      group_rate_limit_by = lookup(custom_rules.value, "group_rate_limit_by")

      dynamic "match_conditions" {
        for_each = lookup(custom_rules.value, "match_conditions") == null ? [] : ["match_conditions"]
        content {
          operator           = lookup(match_conditions.value, "operator")
          match_values       = lookup(match_conditions.value, "match_values")
          negation_condition = lookup(match_conditions.value, "negation_condition")
          transforms         = lookup(match_conditions.value, "transforms")

          dynamic "match_variables" {
            for_each = lookup(match_conditions.value, "match_variables") == null ? [] : ["match_variables"]
            content {
              variable_name = lookup(match_variables.value, "variable_name")
              selector      = lookup(match_variables.value, "selector")
            }
          }
        }
      }
    }
  }

  dynamic "policy_settings" {
    for_each = lookup(var.web_application_firewall_policy[count.index], "policy_settings") == null ? [] : ["policy_settings"]
    content {
      enabled                          = lookup(policy_settings.value, "enabled")
      mode                             = lookup(policy_settings.value, "mode")
      file_upload_limit_in_mb          = lookup(policy_settings.value, "file_upload_limit_in_mb")
      request_body_check               = lookup(policy_settings.value, "request_body_check")
      max_request_body_size_in_kb      = lookup(policy_settings.value, "max_request_body_size_in_kb")
      request_body_inspect_limit_in_kb = lookup(policy_settings.value, "request_body_inspect_limit_in_kb")
    }
  }

  dynamic "managed_rules" {
    for_each = lookup(var.web_application_firewall_policy[count.index], "managed_rules") == null ? [] : ["managed_rules"]
    content {
      dynamic "exclusion" {
        for_each = lookup(managed_rules.value, "exclusion") == null ? [] : ["exclusion"]
        content {
          match_variable          = lookup(exclusion.value, "match_variable")
          selector                = lookup(exclusion.value, "selector")
          selector_match_operator = lookup(exclusion.value, "selector_match_operator")

          dynamic "excluded_rule_set" {
            for_each = lookup(exclusion.value, "excluded_rule_set") == null ? [] : ["excluded_rule_set"]
            content {
              type    = lookup(excluded_rule_set.value, "type")
              version = lookup(excluded_rule_set.value, "version")

              dynamic "rule_group" {
                for_each = lookup(excluded_rule_set.value, "rule_group") == null ? [] : ["rule_group"]
                content {
                  rule_group_name = lookup(rule_group.value, "rule_group_name")
                  excluded_rules  = lookup(rule_group.value, "excluded_rules")
                }
              }
            }
          }
        }
      }

      dynamic "managed_rule_set" {
        for_each = lookup(managed_rules.value, "managed_rule_set") == null ? [] : ["managed_rule_set"]
        content {
          version = lookup(managed_rule_set.value, "version")
          type    = lookup(managed_rule_set.value, "type")

          dynamic "rule_group_override" {
            for_each = lookup(managed_rule_set.value, "rule_group_override") == null ? [] : ["rule_group_override"]
            content {
              rule_group_name = lookup(rule_group_override.value, "rule_group_name")

              dynamic "rule" {
                for_each = lookup(rule_group_override.value, "rule") == null ? [] : ["rule"]
                content {
                  id      = lookup(rule.value, "id")
                  enabled = lookup(rule.value, "enabled")
                  action  = lookup(rule.value, "action")
                }
              }
            }
          }
        }
      }
    }
  }
}