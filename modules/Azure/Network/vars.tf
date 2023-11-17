variable "resource_group_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "application_gateway" {
  type = list(map(object({
    id                                = number
    name                              = string
    resource_group_id                 = any
    firewall_policy_id                = optional(any)
    fips_enabled                      = optional(bool, false)
    enable_http2                      = optional(bool, false)
    force_firewall_policy_association = optional(bool, false)
    zones                             = optional(set(string))
    tags                              = optional(map(string))
    authentication_certificate = optional(list(object({
      data = string
      name = string
    })), [])
    trusted_root_certificate = optional(list(object({
      name                = string
      data                = optional(string)
      key_vault_secret_id = optional(string)
    })), [])
    backend_address_pool = optional(list(object({
      name         = string
      fqdns        = optional(list(string))
      ip_addresses = optional(list(string))
    })), [])
    backend_http_settings = optional(list(object({
      cookie_based_affinity               = string
      name                                = string
      port                                = number
      protocol                            = string
      probe_name                          = optional(string)
      request_timeout                     = optional(number)
      host_name                           = optional(string)
      pick_host_name_from_backend_address = optional(bool, false)
      affinity_cookie_name                = optional(string)
      trusted_root_certificate_names      = optional(list(string))
      authentication_certificate = optional(list(object({
        name = string
      })), [])
      connection_draining = optional(list(object({
        drain_timeout_sec = number
        enabled           = bool
      })), [])
    })), [])
    frontend_ip_configuration = optional(list(object({
      name                            = string
      subnet_id                       = string
      private_ip_address              = string
      public_ip_address_id            = string
      private_ip_address_allocation   = string
      private_link_configuration_name = string
    })), [])
    frontend_port = optional(list(object({
      name = string
      port = number
    })), [])
    gateway_ip_configuration = optional(list(object({
      name      = string
      subnet_id = any
    })), [])
    http_listener = optional(list(object({
      frontend_ip_configuration_name = string
      frontend_port_name             = string
      name                           = string
      protocol                       = string
    })), [])
    identity = optional(list(object({
      identity_ids = list(any)
      type         = string
    })), [])
    private_link_configuration = optional(list(object({
      name = string
      ip_configuration = optional(list(object({
        name                          = string
        primary                       = bool
        private_ip_address_allocation = string
        subnet_id                     = string
        private_ip_address            = optional(string)
      })), [])
    })), [])
    redirect_configuration = optional(list(object({
      name          = string
      redirect_type = string
    })), [])
    rewrite_rule_set = optional(list(object({
      name = string
    })), [])
    url_path_map = optional(list(object({
      name                                = string
      default_backend_address_pool_name   = string
      default_backend_http_settings_name  = string
      default_redirect_configuration_name = string
      default_rewrite_rule_set_name       = string
      path_rule = optional(list(object({
        name  = string
        paths = list(string)
      })), [])
    })), [])
    trusted_client_certificate = optional(list(object({
      data = string
      name = string
    })), [])
    ssl_profile = optional(list(object({
      name                                 = string
      trusted_client_certificate_names     = optional(list(string))
      verify_client_cert_issuer_dn         = optional(bool, false)
      verify_client_certificate_revocation = optional(string)
      ssl_policy = optional(list(object({
        disabled_protocols   = optional(list(string))
        policy_name          = optional(string)
        policy_type          = optional(string)
        cipher_suites        = optional(list(string))
        min_protocol_version = optional(string)
      })), [])
    })), [])
    waf_configuration = optional(list(object({
      enabled                  = bool
      firewall_mode            = string
      rule_set_version         = string
      rule_set_type            = optional(string)
      file_upload_limit_mb     = optional(number)
      request_body_check       = optional(bool, false)
      max_request_body_size_kb = optional(number)
      exclusion = optional(list(object({
        match_variable          = string
        selector_match_operator = optional(string)
        selector                = optional(string)
      })), [])
      disabled_rule_group = optional(list(object({
        rule_group_name = string
        rules           = optional(list(string))
      })), [])
    })), [])
    custom_error_configuration = optional(list(object({
      custom_error_page_url = string
      status_code           = string
    })), [])
    redirect_configuration = optional(list(object({
      name                 = string
      redirect_type        = string
      target_listener_name = optional(string)
      target_url           = optional(string)
      include_path         = optional(bool, false)
      include_query_string = optional(bool, false)
    })), [])
    autoscale_configuration = optional(list(object({
      min_capacity = number
      max_capacity = optional(number)
    })), [])
    rewrite_rule_set = optional(list(object({
      name = string
      rewrite_rule = optional(list(object({
        name          = string
        rule_sequence = number
        condition = optional(list(object({
          pattern     = string
          variable    = string
          ignore_case = optional(bool, false)
          negate      = optional(bool, false)
        })), [])
        request_header_configuration = optional(list(object({
          header_name  = string
          header_value = string
        })), [])
        response_header_configuration = optional(list(object({
          header_name  = string
          header_value = string
        })), [])
        url = optional(list(object({
          query_string = optional(string)
          path         = optional(string)
          components   = optional(string)
          reroute      = optional(bool, false)
        })), [])
      })), [])
    })), [])
    ssl_policy = optional(list(object({
      disabled_protocols   = optional(list(string))
      policy_name          = optional(string)
      policy_type          = optional(string)
      cipher_suites        = optional(list(string))
      min_protocol_version = optional(string)
    })), [])
    ssl_certificate = optional(list(object({
      name                = string
      data                = optional(string)
      key_vault_secret_id = optional(any)
      password            = optional(string)
    })), [])
    global = optional(list(object({
      request_buffering_enabled  = bool
      response_buffering_enabled = bool
    })), [])
    probe = optional(list(object({
      interval            = number
      name                = string
      path                = string
      protocol            = string
      timeout             = number
      unhealthy_threshold = number
    })), [])
    request_routing_rule = optional(list(object({
      http_listener_name = string
      name               = string
      rule_type          = string
    })), [])
    sku = optional(list(object({
      name     = string
      tier     = string
      capacity = optional(number)
    })), [])
  })))
  default = []
}

variable "application_security_group" {
  type = list(map(object({
    id   = number
    name = string
    tags = optional(map(string))
  })))
  default = []
}

variable "bastion_host" {
  type = list(map(object({
    id                     = number
    name                   = string
    copy_paste_enabled     = optional(bool, false)
    file_copy_enabled      = optional(bool, false)
    ip_connect_enabled     = optional(bool, false)
    sku                    = optional(string)
    scale_units            = optional(number)
    shareable_link_enabled = optional(bool, false)
    tunneling_enabled      = optional(bool, false)
    tags                   = optional(map(string))
    ip_configuration = optional(list(object({
      name                 = string
      public_ip_address_id = any
      subnet_id            = any
    })), [])
  })))
  default = []
}

variable "express_route_circuit" {
  type = list(map(object({
    id                       = number
    name                     = string
    service_provider_name    = optional(string)
    peering_location         = optional(string)
    bandwidth_in_mbps        = optional(number)
    allow_classic_operations = optional(bool, false)
    express_route_port_id    = optional(string)
    bandwidth_in_gbps        = optional(number)
    authorization_key        = optional(string)
    tags                     = optional(map(string))
    sku = optional(list(object({
      family = string
      tier   = string
    })), [])
  })))
  default = []
}

variable "express_route_circuit_authorization" {
  type = list(map(object({
    id                       = number
    express_route_circuit_id = any
    name                     = string
  })))
  default = []
}

variable "express_route_circuit_connection" {
  type = list(map(object({
    id                  = number
    address_prefix_ipv4 = string
    name                = string
    peer_peering_id     = any
    peering_id          = any
    authorization_key   = optional(string)
    address_prefix_ipv6 = optional(string)
  })))
  default = []
}

variable "express_route_circuit_peering" {
  type = list(map(object({
    id                            = number
    express_route_circuit_id      = any
    peering_type                  = string
    resource_group_name           = string
    vlan_id                       = number
    primary_peer_address_prefix   = optional(string)
    secondary_peer_address_prefix = optional(string)
    ipv4_enabled                  = optional(bool, false)
    shared_key                    = optional(string)
    peer_asn                      = optional(number)
    route_filter_id               = optional(string)
    microsoft_peering_config = optional(list(object({
      advertised_public_prefixes = list(string)
      customer_asn               = optional(number)
      routing_registry_name      = optional(string)
      advertised_communities     = optional(list(string))
    })), [])
    ipv6 = optional(list(object({
      primary_peer_address_prefix   = string
      secondary_peer_address_prefix = string
      enabled                       = optional(bool, false)
      route_filter_id               = optional(any)
      microsoft_peering = optional(list(object({
        advertised_public_prefixes = optional(list(string))
        customer_asn               = optional(number)
        routing_registry_name      = optional(list())
        advertised_communities     = optional(list(string))
      })), [])
    })), [])
  })))
  default = []
}

variable "express_route_connection" {
  type = list(map(object({
    id                                   = number
    express_route_circuit_peering_id     = any
    express_route_gateway_id             = any
    name                                 = string
    authorization_key                    = optional(string)
    enable_internet_security             = optional(bool, false)
    express_route_gateway_bypass_enabled = optional(bool, false)
    routing_weight                       = optional(number)
    routing = optional(list(object({
      associated_route_table_id = optional(any)
      inbound_route_map_id      = optional(any)
      outbound_route_map_id     = optional(any)
      propagated_route_table = optional(list(object({
        labels          = optional(list(string))
        route_table_ids = optional(list(any))
      })), [])
    })), [])
  })))
  default = []
}

variable "express_route_gateway" {
  type = list(map(object({
    id                            = number
    name                          = string
    scale_units                   = number
    virtual_hub_id                = string
    allow_non_virtual_wan_traffic = optional(bool, false)
    tags                          = optional(map(string))
  })))
  default = []
}

variable "express_route_port" {
  type = list(map(object({
    id                = number
    bandwidth_in_gbps = number
    encapsulation     = string
    name              = string
    peering_location  = string
    billing_type      = optional(string)
    tags              = optional(map(string))
    link1 = optional(list(object({
      admin_enabled                 = optional(bool, false)
      macsec_cipher                 = optional(string)
      macsec_ckn_keyvault_secret_id = optional(string)
      macsec_cak_keyvault_secret_id = optional(string)
    })), [])
    link2 = optional(list(object({
      admin_enabled                 = optional(bool, false)
      macsec_cipher                 = optional(string)
      macsec_ckn_keyvault_secret_id = optional(string)
      macsec_cak_keyvault_secret_id = optional(string)
    })), [])
    identity = optional(list(object({
      identity_ids = list(string)
      type         = string
    })), [])
  })))
  default = []
}

variable "express_route_port_authorization" {
  type = list(map(object({
    id                    = number
    express_route_port_id = any
    name                  = string
  })))
  default = []
}

variable "firewall" {
  type = list(map(object({
    id                 = number
    name               = string
    sku_name           = string
    sku_tier           = string
    firewall_policy_id = optional(any)
    dns_servers        = optional(list(string))
    private_ip_ranges  = optional(list(string))
    threat_intel_mode  = optional(string)
    zones              = optional(list(string))
    tags               = optional(map(string))
    ip_configuration = optional(list(object({
      name                 = string
      subnet_id            = optional(any)
      public_ip_address_id = optional(any)
    })), [])
    management_ip_configuration = optional(list(object({
      name                 = string
      public_ip_address_id = any
      subnet_id            = any
    })), [])
    virtual_hub = optional(list(object({
      virtual_hub_id  = any
      public_ip_count = optional(number)
    })), [])
  })))
  default = []
}

variable "firewall_application_rule_collection" {
  type = list(map(object({
    id                = number
    action            = string
    azure_firewall_id = any
    name              = string
    priority          = number
    rule = optional(list(object({
      name             = string
      description      = optional(string)
      source_addresses = optional(list(string))
      source_ip_groups = optional(list(string))
      fqdn_tags        = optional(list(string))
      target_fqdns     = optional(list(string))
      protocol = optional(list(object({
        port = number
        type = string
      })), [])
    })), [])
  })))
  default = []
}

variable "firewall_nat_rule_collection" {
  type = list(map(object({
    id                = number
    action            = string
    azure_firewall_id = any
    name              = string
    priority          = number
    rule = optional(list(object({
      destination_addresses = list(string)
      destination_ports     = list(string)
      name                  = string
      protocols             = list(string)
      translated_address    = string
      translated_port       = string
      description           = optional(string)
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
    })), [])
  })))
  default = []
}

variable "firewall_network_rule_collection" {
  type = list(map(object({
    id                = number
    action            = string
    azure_firewall_id = any
    name              = string
    priority          = number
    rule = optional(list(object({
      destination_ports     = list(string)
      name                  = string
      protocols             = list(string)
      description           = optional(string)
      destination_addresses = optional(list(string))
      destination_fqdns     = optional(list(string))
      destination_ip_groups = optional(list(string))
      source_addresses      = optional(list(string))
      source_ip_groups      = optional(list(string))
    })), [])
  })))
  default = []
}

variable "firewall_policy" {
  type = list(map(object({
    id                                = number
    name                              = string
    base_policy_id                    = optional(string)
    auto_learn_private_ranges_enabled = optional(bool, false)
    sku                               = optional(string)
    tags                              = optional(list(string))
    threat_intelligence_mode          = optional(string)
    sql_redirect_allowed              = optional(bool, false)
    dns = optional(list(object({
      proxy_enabled = optional(bool, false)
      servers       = optional(list(string))
    })), [])
    identity = optional(list(object({
      identity_ids = list(string)
      type         = string
    })), [])
    insights = optional(list(object({
      default_log_analytics_workspace_id = string
      enabled                            = bool
      retention_in_days                  = optional(number)
      log_analytics_workspace = optional(list(object({
        firewall_location = string
        id                = string
      })), [])
    })), [])
    intrusion_detection = optional(list(object({
      mode           = optional(string)
      private_ranges = optional(list(string))
      signature_overrides = optional(list(object({
        id    = optional(string)
        state = optional(string)
      })), [])
      traffic_bypass = optional(list(object({
        name                  = string
        protocol              = string
        description           = optional(string)
        destination_addresses = optional(list(string))
        destination_ip_groups = optional(list(string))
        destination_ports     = optional(list(string))
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
      })), [])
    })), [])
    threat_intelligence_allowlist = optional(list(object({
      fqdns        = optional(list(string))
      ip_addresses = optional(list(string))
    })), [])
    tls_certificate = optional(list(object({
      key_vault_secret_id = string
      name                = string
    })), [])
    explicit_proxy = optional(list(object({
      enabled         = optional(bool, false)
      http_port       = optional(number)
      https_port      = optional(number)
      enable_pac_file = optional(bool, false)
      pac_file_port   = optional(number)
      pac_file        = optional(string)
    })), [])
  })))
  default = []
}

variable "firewall_policy_rule_collection_group" {
  type = list(map(object({
    id                 = number
    firewall_policy_id = any
    name               = string
    priority           = string
    application_rule_collection = optional(list(object({
      action   = string
      name     = string
      priority = string
      rule = optional(list(object({
        name                  = optional(string)
        description           = optional(string)
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
        destination_addresses = optional(list(string))
        destination_fqdn_tags = optional(list(string))
        destination_fqdns     = optional(list(string))
        destination_urls      = optional(list(string))
        terminate_tls         = optional(bool, false)
        web_categories        = optional(list(string))
        protocols = optional(list(object({
          port = number
          type = string
        })), [])
      })), [])
    })), [])
    network_rule_collection = optional(list(object({
      action   = string
      name     = string
      priority = number
      rule = optional(list(object({
        destination_ports     = list(string)
        name                  = string
        protocols             = list(string)
        destination_addresses = optional(list(string))
        destination_fqdns     = optional(list(string))
        destination_ip_groups = optional(list(string))
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
      })), [])
    })), [])
    nat_rule_collection = optional(list(object({
      action   = string
      name     = string
      priority = number
      rule = optional(list(object({
        name                = string
        protocols           = list(string)
        translated_port     = number
        source_addresses    = optional(list(string))
        source_ip_groups    = optional(list(string))
        destination_address = optional(string)
        destination_ports   = optional(list(string))
        translated_address  = optional(string)
        translated_fqdn     = optional(string)
      })), [])
    })), [])
  })))
  default = []
}

variable "frontdoor" {
  type = list(map(object({
    id                    = number
    name                  = string
    friendly_name         = optional(string)
    tags                  = optional(map(string))
    load_balancer_enabled = optional(bool, false)
    backend_pool = optional(list(object({
      health_probe_name   = string
      load_balancing_name = string
      name                = string
    })), [])
    backend_pool_health_probe = optional(list(object({
      name                = string
      enabled             = optional(bool, false)
      path                = optional(string)
      protocol            = optional(string)
      probe_method        = optional(string)
      interval_in_seconds = optional(number)
    })), [])
    backend_pool_load_balancing = optional(list(object({
      name                            = string
      sample_size                     = optional(number)
      successful_samples_required     = optional(number)
      additional_latency_milliseconds = optional(number)
    })), [])
    backend_pool_settings = optional(list(object({
      enforce_backend_pools_certificate_name_check = bool
      backend_pools_send_receive_timeout_seconds   = optional(number)
    })), [])
    frontend_endpoint = optional(list(object({
      host_name                               = string
      name                                    = string
      session_affinity_enabled                = optional(bool, false)
      session_affinity_ttl_seconds            = optional(number)
      web_application_firewall_policy_link_id = optional(any)
    })), [])
    routing_rule = optional(list(object({
      accepted_protocols = list(string)
      frontend_endpoints = list(string)
      name               = string
      patterns_to_match  = list(string)
      enabled            = optional(bool, false)
      forwarding_configuration = optional(list(object({
        backend_pool_name                     = string
        cache_enabled                         = optional(bool, false)
        cache_use_dynamic_compression         = optional(bool, false)
        cache_query_parameter_strip_directive = optional(string)
        cache_query_parameters                = optional(list(string))
        cache_duration                        = optional(string)
        custom_forwarding_path                = optional(string)
        forwarding_protocol                   = optional(string)
      })), [])
      redirect_configuration = optional(list(object({
        redirect_protocol   = string
        redirect_type       = string
        custom_host         = optional(string)
        custom_fragment     = optional(string)
        custom_path         = optional(string)
        custom_query_string = optional(string)
      })), [])
    })), [])
  })))
  default = []
}

variable "frontdoor_custom_https_configuration" {
  type = list(map(object({
    id                                = number
    custom_https_provisioning_enabled = bool
    frontend_endpoint_id              = any
    custom_https_configuration = optional(list(object({
      certificate_source                         = optional(string)
      azure_key_vault_certificate_secret_name    = optional(string)
      azure_key_vault_certificate_secret_version = optional(string)
      azure_key_vault_certificate_vault_id       = optional(string)
    })), [])
  })))
  default = []
}

variable "frontdoor_firewall_policy" {
  type = list(map(object({
    id                                = number
    name                              = string
    enabled                           = optional(bool, false)
    mode                              = optional(string)
    redirect_url                      = optional(string)
    custom_block_response_status_code = optional(number)
    custom_block_response_body        = optional(string)
    tags                              = optional(map(string))
    custom_rule = optional(list(object({
      action                         = string
      name                           = string
      type                           = string
      enabled                        = optional(bool, false)
      priority                       = optional(number)
      rate_limit_duration_in_minutes = optional(number)
      rate_limit_threshold           = optional(number)
      match_condition = optional(list(object({
        match_values       = list(string)
        match_variable     = string
        operator           = string
        selector           = optional(string)
        negation_condition = optional(bool, false)
        transforms         = optional(list(string))
      })), [])
    })), [])
    managed_rule = optional(list(object({
      type    = string
      version = string
      override = optional(list(object({
        rule_group_name = string
        exclusion = optional(list(object({
          match_variable = string
          operator       = string
          selector       = string
        })), [])
        rule = optional(list(object({
          action  = string
          rule_id = string
          enabled = optional(bool, false)
          exclusion = optional(list(object({
            match_variable = string
            operator       = string
            selector       = string
          })), [])
        })), [])
      })), [])
      exclusion = optional(list(object({
        match_variable = string
        operator       = string
        selector       = string
      })), [])
    })), [])
  })))
  default = []
}

variable "frontdoor_rules_engine" {
  type = list(map(object({
    id           = number
    frontdoor_id = any
    name         = string
    enabled      = optional(bool, false)
    rule = optional(list(object({
      name     = string
      priority = number
      action = optional(list(object({
        request_header = optional(list(object({
          header_action_type = optional(string)
          header_name        = optional(string)
          value              = optional(string)
        })), [])
        response_header = optional(list(object({
          header_action_type = optional(string)
          header_name        = optional(string)
          value              = optional(string)
        })), [])
      })), [])
      match_condition = optional(list(object({
        operator         = string
        variable         = optional(string)
        selector         = optional(string)
        transform        = optional(list(string))
        negate_condition = optional(bool, false)
        value            = optional(list(string))
      })), [])
    })), [])
  })))
  default = []
}

variable "ip_group" {
  type = list(map(object({
    id    = number
    name  = string
    cidrs = optional(list(string))
    tags  = optional(map(string))
  })))
  default = []
}

variable "ip_group_cidr" {
  type = list(map(object({
    id          = number
    cidr        = string
    ip_group_id = any
  })))
  default = []
}

variable "local_network_gateway" {
  type = list(map(object({
    id              = number
    name            = string
    gateway_address = optional(string)
    gateway_fqdn    = optional(string)
    address_space   = optional(list(string))
    bgp_settings = optional(list(object({
      asn                 = number
      bgp_peering_address = string
      peer_weight         = optional(number)
    })), [])
  })))
  default = []
}

variable "nat_gateway" {
  type = list(map(object({
    id                      = number
    name                    = string
    idle_timeout_in_minutes = optional(number)
    sku_name                = optional(string)
    tags                    = optional(map(string))
    zones                   = optional(list(string))
  })))
  default = []
}

variable "nat_gateway_public_ip_association" {
  type = list(map(object({
    id                   = number
    nat_gateway_id       = any
    public_ip_address_id = any
  })))
  default = []
}

variable "nat_gateway_public_ip_prefix_association" {
  type = list(map(object({
    id                  = number
    nat_gateway_id      = any
    public_ip_prefix_id = any
  })))
  default = []
}

variable "network_connection_monitor" {
  type = list(map(object({
    id                            = number
    name                          = string
    network_watcher_id            = string
    notes                         = optional(string)
    output_workspace_resource_ids = optional(list(string))
    tags                          = optional(map(string))
    endpoint = optional(list(object({
      name                  = string
      address               = optional(string)
      coverage_level        = optional(string)
      excluded_ip_addresses = optional(list(string))
      included_ip_addresses = optional(list(string))
      target_resource_id    = optional(string)
      target_resource_type  = optional(string)
      filter = optional(list(object({
        type = optional(string)
        item = optional(list(object({
          type    = optional(string)
          address = optional(string)
        })), [])
      })), [])
    })), [])
    test_configuration = optional(list(object({
      name                      = string
      protocol                  = string
      test_frequency_in_seconds = optional(number)
      http_configuration = optional(list(object({
        method                   = optional(string)
        port                     = optional(number)
        path                     = optional(string)
        prefer_https             = optional(bool, false)
        valid_status_code_ranges = optional(list(string))
        request_header = optional(list(object({
          name  = optional(string)
          value = optional(string)
        })), [])
      })), [])
      icmp_configuration = optional(list(object({
        trace_route_enabled = optional(bool, false)
      })), [])
      tcp_configuration = optional(list(object({
        port                      = number
        trace_route_enabled       = optional(bool, false)
        destination_port_behavior = optional(string)
      })), [])
    })), [])
    test_group = optional(list(object({
      destination_endpoints    = list(string)
      name                     = string
      source_endpoints         = list(string)
      test_configuration_names = list(string)
      enabled                  = optional(bool, false)
    })), [])
  })))
  default = []
}

variable "network_ddos_protection_plan" {
  type = list(map(object({
    id   = number
    name = string
    tags = optional(map(string))
  })))
  default = []
}

variable "network_interface" {
  type = list(map(object({
    id                            = number
    name                          = string
    dns_servers                   = optional(list(string))
    edge_zone                     = optional(string)
    enable_ip_forwarding          = optional(bool, false)
    enable_accelerated_networking = optional(bool, false)
    internal_dns_name_label       = optional(string)
    tags                          = optional(map(string))
    ip_configuration = optional(list(object({
      name                                               = string
      private_ip_address_allocation                      = string
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      subnet_id                                          = optional(any)
      private_ip_address_version                         = optional(string)
      private_ip_address                                 = optional(string)
      public_ip_address_id                               = optional(any)
      primary                                            = optional(bool, false)
    })), [])
  })))
  default = []
}

variable "network_interface_application_gateway_backend_address_pool_association" {
  type = list(map(object({
    id                      = number
    backend_address_pool_id = any
    ip_configuration_name   = string
    network_interface_id    = any
  })))
  default = []
}

variable "network_interface_application_security_group_association" {
  type = list(map(object({
    id                            = number
    application_security_group_id = any
    network_interface_id          = any
  })))
  default = []
}

variable "network_interface_backend_address_pool_association" {
  type = list(map(object({
    id                      = number
    backend_address_pool_id = any
    ip_configuration_name   = string
    network_interface_id    = any
  })))
  default = []
}

variable "network_interface_nat_rule_association" {
  type = list(map(object({
    id                    = number
    ip_configuration_name = string
    nat_rule_id           = any
    network_interface_id  = any
  })))
  default = []
}

variable "network_interface_security_group_association" {
  type = list(map(object({
    id                        = number
    network_interface_id      = any
    network_security_group_id = any
  })))
  default = []
}

variable "network_manager" {
  type = list(map(object({
    id             = number
    name           = string
    scope_accesses = list(string)
    description    = optional(string)
    tags           = optional(map(string))
    scope = optional(list(object({
      management_group_ids = optional(list(string))
      subscription_ids     = optional(list(string))
    })), [])
  })))
  default = []
}

variable "network_manager_admin_rule" {
  type = list(map(object({
    id                       = number
    action                   = string
    admin_rule_collection_id = any
    direction                = string
    name                     = string
    priority                 = number
    protocol                 = string
    description              = optional(string)
    destination_port_ranges  = optional(list(string))
    source_port_ranges       = optional(list(string))
    destination = optional(list(object({
      address_prefix      = string
      address_prefix_type = string
    })), [])
    source = optional(list(object({
      address_prefix      = string
      address_prefix_type = string
    })), [])
  })))
  default = []
}

variable "network_manager_admin_rule_collection" {
  type = list(map(object({
    id                              = number
    name                            = string
    network_group_ids               = list(any)
    security_admin_configuration_id = any
    description                     = optional(string)
  })))
  default = []
}

variable "network_manager_connectivity_configuration" {
  type = list(map(object({
    id                              = number
    connectivity_topology           = string
    name                            = string
    network_manager_id              = any
    delete_existing_peering_enabled = optional(bool, false)
    description                     = optional(string)
    global_mesh_enabled             = optional(bool, false)
    applies_to_group = optional(list(object({
      group_connectivity  = string
      network_group_id    = any
      global_mesh_enabled = optional(bool, false)
      use_hub_gateway     = optional(bool, false)
    })), [])
    hub = optional(list(object({
      resource_id   = any
      resource_type = string
    })), [])
  })))
  default = []
}

variable "network_manager_deployment" {
  type = list(map(object({
    id                 = number
    configuration_ids  = list(string)
    network_manager_id = string
    scope_access       = string
    triggers           = optional(map(string))
  })))
  default = []
}

variable "network_manager_management_group_connection" {
  type = list(map(object({
    id                  = number
    management_group_id = any
    name                = string
    network_manager_id  = any
    description         = string
  })))
  default = []
}

variable "network_manager_network_group" {
  type = list(map(object({
    id                 = number
    name               = string
    network_manager_id = any
  })))
  default = []
}

variable "network_manager_scope_connection" {
  type = list(map(object({
    id                 = number
    name               = string
    network_manager_id = any
    target_scope_id    = any
    tenant_id          = any
  })))
  default = []
}

variable "network_manager_security_admin_configuration" {
  type = list(map(object({
    id                                            = number
    name                                          = string
    network_manager_id                            = any
    apply_on_network_intent_policy_based_services = optional(list(string))
  })))
  default = []
}

variable "network_manager_static_member" {
  type = list(map(object({
    id                        = number
    name                      = string
    network_group_id          = any
    target_virtual_network_id = any
  })))
  default = []
}

variable "network_manager_subscription_connection" {
  type = list(map(object({
    id                 = number
    name               = string
    network_manager_id = any
    subscription_id    = any
  })))
  default = []
}

variable "network_packet_capture" {
  type = list(map(object({
    id                        = number
    name                      = string
    network_watcher_id        = any
    target_resource_id        = any
    maximum_bytes_per_packet  = optional(number)
    maximum_bytes_per_session = optional(number)
    maximum_capture_duration  = optional(number)
    storage_location = optional(list(object({
      file_path          = optional(string)
      storage_account_id = optional(any)
    })), [])
    filter = optional(list(object({
      protocol          = string
      local_ip_address  = optional(string)
      local_port        = optional(string)
      remote_ip_address = optional(string)
      remote_port       = optional(string)
    })), [])
  })))
  default = []
}

variable "network_profile" {
  type = list(map(object({
    id   = number
    name = string
    tags = optional(map(string))
    container_network_interface = optional(list(object({
      name      = string
      subnet_id = any
    })), [])
  })))
  default = []
}

variable "network_security_group" {
  type = list(map(object({
    id   = number
    name = string
    security_rule = optional(list(object({
      name                                  = optional(string)
      description                           = optional(string)
      protocol                              = optional(string)
      source_port_range                     = optional(string)
      source_port_ranges                    = optional(list(string))
      destination_port_range                = optional(string)
      destination_port_ranges               = optional(list(string))
      source_address_prefix                 = optional(string)
      source_address_prefixes               = optional(list(string))
      source_application_security_group_ids = optional(list(string))
      destination_address_prefix            = optional(string)
      destination_address_prefixes          = optional(list(string))
      access                                = optional(string)
      priority                              = optional(number)
      direction                             = optional(string)
    })), [])
  })))
  default = []
}

variable "network_watcher" {
  type = list(map(object({
    id   = number
    name = string
    tags = optional(map(string))
  })))
  default = []
}

variable "network_watcher_flow_log" {
  type = list(map(object({
    id                        = number
    name                      = string
    network_security_group_id = any
    network_watcher_id        = any
    storage_account_id        = any
    version                   = optional(number)
    tags                      = optional(map(string))
    traffic_analytics = optional(list(object({
      enabled               = bool
      workspace_id          = any
      workspace_region      = any
      workspace_resource_id = any
      interval_in_minutes   = optional(number)
    })), [])
    retention_policy = optional(list(object({
      days    = number
      enabled = bool
    })), [])
  })))
  default = []
}

variable "point_to_site_vpn_gateway" {
  type = list(map(object({
    id                                  = number
    name                                = string
    scale_unit                          = number
    virtual_hub_id                      = any
    vpn_server_configuration_id         = any
    dns_servers                         = optional(list(string))
    routing_preference_internet_enabled = optional(bool, false)
    tags                                = optional(map(string))
    connection_configuration = optional(list(object({
      name                      = string
      internet_security_enabled = optional(bool, false)
      vpn_client_address_pool = optional(list(object({
        address_prefixes = []
      })), [])
      route = optional(list(object({
        associated_route_table_id = string
        inbound_route_map_id      = optional(string)
        outbound_route_map_id     = optional(string)
        propagated_route_table = optional(list(object({
          ids    = list(string)
          labels = optional(list(string))
        })), [])
      })), [])
    })), [])
  })))
  default = []
}

variable "private_endpoint" {
  type = list(map(object({
    id                            = number
    name                          = string
    subnet_id                     = optional(any)
    custom_network_interface_name = optional(string)
    tags                          = optional(map(string))
    private_dns_zone_group = optional(list(object({
      name                 = string
      private_dns_zone_ids = list(string)
    })), [])
    private_service_connection = optional(list(object({
      is_manual_connection              = bool
      name                              = string
      private_connection_resource_id    = optional(string)
      private_connection_resource_alias = optional(string)
      subresource_names                 = optional(list(string))
      request_message                   = optional(string)
    })), [])
    ip_configuration = optional(list(object({
      name               = string
      private_ip_address = string
      subresource_name   = optional(string)
      member_name        = optional(string)
    })), [])
  })))
  default = []
}

variable "private_endpoint_application_security_group_association" {
  type = list(map(object({
    id                            = number
    application_security_group_id = any
    private_endpoint_id           = any
  })))
  default = []
}

variable "private_link_service" {
  type = list(map(object({
    id                                          = number
    load_balancer_frontend_ip_configuration_ids = list(string)
    name                                        = string
    auto_approval_subscription_ids              = optional(list(string))
    enable_proxy_protocol                       = optional(bool, false)
    fqdns                                       = optional(list(string))
    tags                                        = optional(map(string))
    visibility_subscription_ids                 = optional(list(string))
    nat_ip_configuration = optional(list(object({
      name                       = string
      subnet_id                  = any
      primary                    = bool
      private_ip_address         = optional(string)
      private_ip_address_version = optional(string)
    })), [])
  })))
  default = []
}

variable "public_ip" {
  type = list(map(object({
    id                      = number
    allocation_method       = string
    name                    = string
    zones                   = optional(list(string))
    ddos_protection_mode    = optional(string)
    ddos_protection_plan_id = optional(any)
    domain_name_label       = optional(string)
    edge_zone               = optional(string)
    idle_timeout_in_minutes = optional(number)
    ip_tags                 = optional(map(string))
    ip_version              = optional(string)
    public_ip_prefix_id     = optional(any)
    reverse_fqdn            = optional(string)
    sku                     = optional(string)
    sku_tier                = optional(string)
    tags                    = optional(map(string))
  })))
  default = []
}

variable "public_ip_prefix" {
  type = list(map(object({
    id            = number
    name          = string
    sku           = optional(string)
    ip_version    = optional(string)
    prefix_length = optional(number)
    tags          = optional(map(string))
    zones         = optional(list(string))
  })))
  default = []
}

variable "route" {
  type = list(map(object({
    id                     = number
    address_prefix         = string
    name                   = string
    next_hop_type          = string
    route_table_name       = any
    next_hop_in_ip_address = optional(string)
  })))
  default = []
}

variable "route_filter" {
  type = list(map(object({
    id   = number
    name = string
    tags = optional(map(string))
    rule = optional(list(object({
      access      = string
      communities = list(string)
      name        = string
      rule_type   = string
    })), [])
  })))
  default = []
}

variable "route_map" {
  type = list(map(object({
    id             = number
    name           = string
    virtual_hub_id = any
    rule = optional(list(object({
      name                 = string
      next_step_if_matched = optional(string)
      action = optional(list(object({
        type = string
        parameter = optional(list(object({
          as_path      = optional(list(string))
          community    = optional(list(string))
          route_prefix = optional(list(string))
        })), [])
      })), [])
      match_criterion = optional(list(object({
        match_condition = string
        as_path         = optional(list(string))
        community       = optional(list(string))
        route_prefix    = optional(list(string))
      })), [])
    })), [])
  })))
  default = []
}

variable "route_server" {
  type = list(map(object({
    id                               = number
    name                             = string
    public_ip_address_id             = any
    sku                              = string
    subnet_id                        = any
    branch_to_branch_traffic_enabled = optional(bool, false)
    tags                             = optional(map(string))
  })))
  default = []
}

variable "route_server_bgp_connection" {
  type = list(map(object({
    id              = number
    name            = string
    peer_asn        = number
    peer_ip         = string
    route_server_id = any
  })))
  default = []
}

variable "route_table" {
  type = list(map(object({
    id                            = number
    name                          = string
    disable_bgp_route_propagation = optional(bool, false)
    tags                          = optional(map(string))
    route = optional(list(object({
      name                   = optional(string)
      address_prefix         = optional(string)
      next_hop_type          = optional(string)
      next_hop_in_ip_address = optional(string)
    })), [])
  })))
  default = []
}

variable "subnet" {
  type = list(map(object({
    id                                            = number
    address_prefixes                              = list(string)
    name                                          = string
    virtual_network_id                            = any
    private_endpoint_network_policies_enabled     = optional(bool, false)
    private_link_service_network_policies_enabled = optional(bool, false)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))
    delegation = optional(list(object({
      name = string
      service_delegation = optional(list(object({
        name    = string
        actions = optional(string)
      })), [])
    })), [])
  })))
  default = []
}

variable "subnet_nat_gateway_association" {
  type = list(map(object({
    id             = number
    nat_gateway_id = any
    subnet_id      = any
  })))
  default = []
}

variable "subnet_network_security_group_association" {
  type = list(map(object({
    id                        = number
    network_security_group_id = any
    subnet_id                 = any
  })))
  default = []
}

variable "subnet_route_table_association" {
  type = list(map(object({
    id             = number
    route_table_id = any
    subnet_id      = any
  })))
  default = []
}

variable "subnet_service_endpoint_storage_policy" {
  type = list(map(object({
    id   = number
    name = string
    tags = optional(map(string))
    definition = optional(list(object({
      name              = string
      service_resources = list(string)
      service           = optional(string)
      description       = optional(string)
    })), [])
  })))
  default = []
}

variable "traffic_manager_azure_endpoint" {
  type = list(map(object({
    id                 = number
    name               = string
    profile_id         = any
    target_resource_id = any
    weight             = optional(number)
    enabled            = optional(bool, false)
    geo_mappings       = optional(list(string))
    priority           = optional(number)
    custom_header = optional(list(object({
      name  = string
      value = string
    })), [])
    subnet = optional(list(object({
      first = string
      last  = optional(string)
      scope = optional(number)
    })), [])
  })))
  default = []
}

variable "traffic_manager_external_endpoint" {
  type = list(map(object({
    id                = number
    name              = string
    profile_id        = any
    target            = string
    weight            = optional(number)
    endpoint_location = optional(string)
    enabled           = optional(bool, false)
    geo_mappings      = optional(list(string))
    priority          = optional(number)
    custom_header = optional(list(object({
      name  = string
      value = string
    })), [])
    subnet = optional(list(object({
      first = string
      last  = optional(string)
      scope = optional(number)
    })), [])
  })))
  default = []
}

variable "traffic_manager_nested_endpoint" {
  type = list(map(object({
    id                                    = number
    minimum_child_endpoints               = number
    name                                  = string
    profile_id                            = any
    target_resource_id                    = any
    weight                                = optional(number)
    enabled                               = optional(bool, false)
    minimum_required_child_endpoints_ipv4 = optional(number)
    minimum_required_child_endpoints_ipv6 = optional(number)
    priority                              = optional(number)
    geo_mappings                          = optional(list(string))
    custom_header = optional(list(object({
      name  = string
      value = string
    })), [])
    subnet = optional(list(object({
      first = string
      last  = optional(string)
      scope = optional(number)
    })), [])
  })))
  default = []
}

variable "traffic_manager_profile" {
  type = list(map(object({
    id                     = number
    name                   = string
    traffic_routing_method = string
    traffic_view_enabled   = optional(bool, false)
    max_return             = optional(number)
    tags                   = optional(map(string))
    profile_status         = optional(string)
    dns_config = optional(list(object({
      relative_name = string
      ttl           = number
    })), [])
    monitor_config = optional(list(object({
      port                         = number
      protocol                     = string
      path                         = optional(string)
      expected_status_code_ranges  = optional(list(string))
      interval_in_seconds          = optional(number)
      timeout_in_seconds           = optional(number)
      tolerated_number_of_failures = optional(number)
      custom_header = optional(list(object({
        name  = string
        value = string
      })), [])
    })), [])
  })))
  default = []
}

variable "virtual_hub" {
  type = list(map(object({
    id                     = number
    name                   = string
    address_prefix         = optional(string)
    hub_routing_preference = optional(string)
    sku                    = optional(string)
    virtual_wan_id         = optional(string)
    tags                   = optional(map(string))
    route = optional(list(object({
      address_prefixes    = list(string)
      next_hop_ip_address = string
    })), [])
  })))
  default = []
}

variable "virtual_hub_bgp_connection" {
  type = list(map(object({
    id                            = number
    name                          = string
    peer_asn                      = number
    peer_ip                       = string
    virtual_hub_id                = any
    virtual_network_connection_id = optional(string)
  })))
  default = []
}

variable "virtual_hub_connection" {
  type = list(map(object({
    id                        = number
    name                      = string
    remote_virtual_network_id = any
    virtual_hub_id            = any
    internet_security_enabled = bool
    routing = optional(list(object({
      associated_route_table_id                 = optional(any)
      inbound_route_map_id                      = optional(any)
      outbound_route_map_id                     = optional(any)
      static_vnet_local_route_override_criteria = optional(string)
      propagated_route_table = optional(list(object({
        labels          = optional(list(string))
        route_table_ids = optional(list(any))
      })), [])
      static_vnet_route = optional(list(object({
        name                = optional(string)
        address_prefixes    = optional(list(string))
        next_hop_ip_address = optional(string)
      })), [])
    })), [])
  })))
  default = []
}

variable "virtual_hub_ip" {
  type = list(map(object({
    id                           = number
    name                         = string
    public_ip_address_id         = any
    subnet_id                    = any
    virtual_hub_id               = any
    private_ip_address           = optional(string)
    private_ip_allocation_method = optional(string)
  })))
  default = []
}

variable "virtual_hub_route_table" {
  type = list(map(object({
    id             = number
    name           = string
    virtual_hub_id = any
    labels         = optional(list(string))
    route = optional(list(object({
      destinations      = list(string)
      destinations_type = string
      name              = string
      next_hop          = string
      next_hop_type     = optional(string)
    })), [])
  })))
  default = []
}

variable "virtual_hub_route_table_route" {
  type = list(map(object({
    id                = number
    destinations      = list(string)
    destinations_type = string
    name              = string
    next_hop_id       = any
    route_table_id    = any
    next_hop_type     = optional(string)
  })))
  default = []
}

variable "virtual_hub_security_partner_provider" {
  type = list(map(object({
    id                     = number
    name                   = string
    security_provider_name = string
    virtual_hub_id         = optional(string)
    tags                   = optional(map(string))
  })))
  default = []
}

variable "virtual_machine_packet_capture" {
  type = list(map(object({
    id                                  = number
    name                                = string
    network_watcher_id                  = any
    virtual_machine_id                  = any
    maximum_bytes_per_packet            = optional(number)
    maximum_bytes_per_session           = optional(number)
    maximum_capture_duration_in_seconds = optional(number)
    storage_location = optional(list(object({
      file_path          = optional(string)
      storage_account_id = optional(any)
    })), [])
    filter = optional(list(object({
      protocol          = string
      local_ip_address  = optional(string)
      local_port        = optional(string)
      remote_ip_address = optional(string)
      remote_port       = optional(string)
    })), [])
  })))
  default = []
}

variable "virtual_machine_scale_set_packet_capture" {
  type = list(map(object({
    id                                  = number
    name                                = string
    network_watcher_id                  = any
    virtual_machine_scale_set_id        = any
    maximum_bytes_per_packet            = optional(number)
    maximum_bytes_per_session           = optional(number)
    maximum_capture_duration_in_seconds = optional(number)
    storage_location = optional(list(object({
      file_path          = optional(string)
      storage_account_id = optional(any)
    })), [])
    filter = optional(list(object({
      protocol          = string
      local_ip_address  = optional(string)
      local_port        = optional(string)
      remote_ip_address = optional(string)
      remote_port       = optional(string)
    })), [])
    machine_scope = optional(list(object({
      exclude_instance_ids = optional(list(string))
      include_instance_ids = optional(list(string))
    })), [])
  })))
  default = []
}

variable "virtual_network" {
  type = list(map(object({
    id                      = number
    address_space           = list(string)
    name                    = string
    bgp_community           = optional(string)
    dns_servers             = optional(list(string))
    edge_zone               = optional(string)
    flow_timeout_in_minutes = optional(number)
    tags                    = optional(map(string))
    ddos_protection_plan = optional(list(object({
      id     = any
      enable = bool
    })), [])
    encryption = optional(list(object({
      enforcement = string
    })), [])
    subnet = optional(list(object({
      name              = string
      address_prefix    = string
      security_group_id = optional(any)
    })), [])
  })))
  default = []
}

variable "virtual_network_dns_servers" {
  type = list(map(object({
    id                 = number
    virtual_network_id = any
    dns_servers        = optional(list(string))
  })))
  default = []
}

variable "virtual_network_gateway" {
  type = list(map(object({
    id                               = number
    name                             = string
    sku                              = string
    type                             = string
    active_active                    = optional(bool, false)
    default_local_network_gateway_id = optional(string)
    edge_zone                        = optional(string)
    enable_bgp                       = optional(bool, false)
    generation                       = optional(string)
    private_ip_address_enabled       = optional(bool, false)
    tags                             = optional(map(string))
    vpn_type                         = optional(string)
    ip_configuration = optional(list(object({
      public_ip_address_id          = string
      subnet_id                     = string
      name                          = optional(string)
      private_ip_address_allocation = optional(string)
    })), [])
    vpn_client_configuration = optional(list(object({
      address_space         = list(string)
      aad_tenant            = optional(string)
      aad_audience          = optional(string)
      aad_issuer            = optional(string)
      radius_server_address = optional(string)
      radius_server_secret  = optional(string)
      vpn_client_protocols  = optional(list(string))
      vpn_auth_types        = optional(list(string))
      root_certificate = optional(list(object({
        name             = string
        public_cert_data = string
      })), [])
      revoked_certificate = optional(list(object({
        name       = string
        thumbprint = string
      })), [])
    })), [])
    bgp_settings = optional(list(object({
      asn         = optional(number)
      peer_weight = optional(number)
      peering_addresses = optional(list(object({
        ip_configuration_name = optional(string)
        apipa_addresses       = optional(list(string))
      })), [])
    })), [])
    custom_route = optional(list(object({
      address_prefixes = optional(list(string))
    })), [])
  })))
  default = []
}

variable "virtual_network_gateway_connection" {
  type = list(map(object({
    id                                 = number
    name                               = string
    type                               = string
    virtual_network_gateway_id         = any
    authorization_key                  = optional(string)
    dpd_timeout_seconds                = optional(number)
    express_route_circuit_id           = optional(string)
    peer_virtual_network_gateway_id    = optional(string)
    local_azure_ip_address_enabled     = optional(bool, false)
    local_network_gateway_id           = optional(bool)
    routing_weight                     = optional(number)
    shared_key                         = optional(string)
    connection_mode                    = optional(string)
    connection_protocol                = optional(string)
    enable_bgp                         = optional(bool, false)
    express_route_gateway_bypass       = optional(bool, false)
    egress_nat_rule_ids                = optional(list(string))
    ingress_nat_rule_ids               = optional(list(string))
    use_policy_based_traffic_selectors = optional(bool, false)
    tags                               = optional(map(string))
    custom_bgp_addresses = optional(list(object({
      primary   = string
      secondary = string
    })), [])
    ipsec_policy = optional(list(object({
      dh_group         = string
      ike_encryption   = string
      ike_integrity    = string
      ipsec_encryption = string
      ipsec_integrity  = string
      pfs_group        = string
      sa_datasize      = optional(number)
      sa_lifetime      = optional(number)
    })), [])
    traffic_selector_policy = optional(list(object({
      local_address_cidrs  = list(string)
      remote_address_cidrs = list(string)
    })), [])
  })))
  default = []
}

variable "virtual_network_gateway_nat_rule" {
  type = list(map(object({
    id                         = number
    name                       = string
    virtual_network_gateway_id = any
    mode                       = optional(string)
    type                       = optional(string)
    external_mapping = list(object({
      address_space = string
      port_range    = optional(string)
    }))
    internal_mapping = list(object({
      address_space = string
      port_range    = optional(string)
    }))
  })))
  default = []
}

variable "virtual_network_peering" {
  type = list(map(object({
    id                           = number
    name                         = string
    remote_virtual_network_id    = any
    virtual_network_id           = any
    allow_virtual_network_access = optional(bool, false)
    allow_forwarded_traffic      = optional(bool, false)
    allow_gateway_transit        = optional(bool, false)
    use_remote_gateways          = optional(bool, false)
    triggers                     = optional(map(string))
  })))
  default = []
}

variable "virtual_wan" {
  type = list(map(object({
    id                                = number
    name                              = string
    disable_vpn_encryption            = optional(bool, false)
    allow_branch_to_branch_traffic    = optional(bool, false)
    office365_local_breakout_category = optional(string)
    type                              = optional(string)
    tags                              = optional(map(string))
  })))
  default = []
}

variable "vpn_gateway" {
  type = list(map(object({
    id                                    = number
    name                                  = string
    virtual_hub_id                        = any
    bgp_route_translation_for_nat_enabled = optional(bool, false)
    routing_preference                    = optional(string)
    scale_unit                            = optional(number)
    tags                                  = optional(map(string))
    bgp_settings = optional(list(object({
      asn         = number
      peer_weight = number
      instance_0_bgp_peering_address = optional(list(object({
        custom_ips = list(string)
      })), [])
      instance_1_bgp_peering_address = optional(list(object({
        custom_ips = list(string)
      })), [])
    })), [])
  })))
  default = []
}

variable "vpn_gateway_connection" {
  type = list(map(object({
    id                 = number
    name               = string
    remote_vpn_site_id = any
    vpn_gateway_id     = any
    vpn_link = optional(list(object({
      name                                  = string
      vpn_site_link_id                      = any
      egress_nat_rule_ids                   = optional(list(string))
      ingress_nat_rule_ids                  = optional(list(string))
      bandwidth_mbps                        = optional(number)
      bgp_enabled                           = optional(number)
      connection_mode                       = optional(string)
      protocol                              = optional(string)
      ratelimit_enabled                     = optional(bool)
      route_weight                          = optional(number)
      shared_key                            = optional(string)
      local_azure_ip_address_enabled        = optional(bool)
      policy_based_traffic_selector_enabled = optional(bool)
      ipsec_policy = optional(list(object({
        dh_group                 = string
        encryption_algorithm     = string
        ike_encryption_algorithm = string
        ike_integrity_algorithm  = string
        integrity_algorithm      = string
        pfs_group                = string
        sa_data_size_kb          = number
        sa_lifetime_sec          = number
      })), [])
      custom_bgp_address = optional(list(object({
        ip_address          = string
        ip_configuration_id = any
      })), [])
    })), [])
    routing = optional(list(object({
      associated_route_table = string
      inbound_route_map_id   = any
      outbound_route_map_id  = any
      propagated_route_table = optional(list(object({
        route_table_ids = list(string)
        labels          = optional(list(string))
      })), [])
    })), [])
    traffic_selector_policy = optional(list(object({
      local_address_ranges  = list(string)
      remote_address_ranges = list(string)
    })), [])
  })))
  default = []
}

variable "vpn_gateway_nat_rule" {
  type = list(map(object({
    id                  = number
    vpn_gateway_id      = any
    ip_configuration_id = any
    mode                = optional(string)
    type                = optional(string)
    external_mapping = optional(list(object({
      address_space = string
      port_range    = optional(string)
    })), [])
    internal_mapping = optional(list(object({
      address_space = string
      port_range    = optional(string)
    })), [])
  })))
  default = []
}

variable "vpn_server_configuration" {
  type = list(map(object({
    id                       = number
    name                     = string
    vpn_authentication_types = list(string)
    vpn_protocols            = optional(list(string))
    tags                     = optional(map(string))
    ipsec_policy = optional(list(object({
      dh_group               = string
      ike_encryption         = string
      ike_integrity          = string
      ipsec_encryption       = string
      ipsec_integrity        = string
      pfs_group              = string
      sa_data_size_kilobytes = number
      sa_lifetime_seconds    = number
    })), [])
    azure_active_directory_authentication = optional(list(object({
      audience = string
      issuer   = string
      tenant   = string
    })), [])
    radius = optional(list(object({
      server = optional(list(object({
        address = string
        score   = number
        secret  = string
      })), [])
      client_root_certificate = optional(list(object({
        name       = string
        thumbprint = string
      })), [])
      server_root_certificate = optional(list(object({
        name             = string
        public_cert_data = string
      })), [])
    })), [])
    client_revoked_certificate = optional(list(object({
      name       = string
      thumbprint = string
    })), [])
    client_root_certificate = optional(list(object({
      name             = string
      public_cert_data = string
    })), [])
  })))
  default = []
}

variable "vpn_server_configuration_policy_group" {
  type = list(map(object({
    id                          = number
    name                        = string
    vpn_server_configuration_id = any
    is_default                  = optional(bool, false)
    priority                    = optional(number)
    policy = optional(list(object({
      name  = string
      type  = string
      value = string
    })), [])
  })))
  default = []
}

variable "vpn_site" {
  type = list(map(object({
    id             = number
    name           = string
    virtual_wan_id = any
    address_cidrs  = optional(list(string))
    device_model   = optional(string)
    device_vendor  = optional(string)
    tags           = optional(map(string))
    link = optional(list(object({
      name          = string
      fqdn          = optional(string)
      ip_address    = optional(string)
      provider_name = optional(string)
      speed_in_mbps = optional(number)
      bgp = optional(list(object({
        asn             = number
        peering_address = string
      })), [])
    })), [])
    o365_policy = optional(list(object({
      traffic_category = optional(list(object({
        allow_endpoint_enabled    = optional(bool, false)
        default_endpoint_enabled  = optional(bool, false)
        optimize_endpoint_enabled = optional(bool, false)
      })), [])
    })), [])
  })))
  default = []
}

variable "web_application_firewall_policy" {
  type = list(map(object({
    id   = number
    name = string
    tags = optional(map(string))
    custom_rules = optional(list(object({
      action              = string
      priority            = number
      rule_type           = string
      name                = optional(string)
      rate_limit_duration = optional(string)
      group_rate_limit_by = optional(string)
      match_conditions = optional(list(object({
        operator           = string
        match_values       = optional(list(string))
        negation_condition = optional(bool, false)
        transforms         = optional(list(string))
        match_variables = optional(list(object({
          variable_name = string
          selector      = optional(string)
        })), [])
      })), [])
    })), [])
    policy_settings = optional(list(object({
      enabled                          = optional(bool)
      mode                             = optional(string)
      file_upload_limit_in_mb          = optional(number)
      request_body_check               = optional(bool)
      max_request_body_size_in_kb      = optional(number)
      request_body_inspect_limit_in_kb = optional(number)
    })), [])
    managed_rules = optional(list(object({
      exclusion = optional(list(object({
        match_variable          = string
        selector                = string
        selector_match_operator = string
        excluded_rule_set = optional(list(object({
          type    = optional(string)
          version = optional(string)
          rule_group = optional(list(object({
            rule_group_name = string
            excluded_rules  = optional(list(string))
          })), [])
        })), [])
      })), [])
      managed_rule_set = optional(list(object({
        version = string
        type    = optional(string)
        rule_group_override = optional(list(object({
          rule_group_name = string
          rule = optional(list(object({
            id      = string
            enabled = optional(bool, false)
            action  = optional(string)
          })), [])
        })), [])
      })), [])
    })), [])
  })))
  default = []
}