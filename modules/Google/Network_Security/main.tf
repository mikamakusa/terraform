resource "google_network_security_address_group" "this" {
  count       = length(var.address_group)
  capacity    = lookup(var.address_group[count.index], "capacity")
  location    = lookup(var.address_group[count.index], "location")
  name        = lookup(var.address_group[count.index], "name")
  type        = lookup(var.address_group[count.index], "type")
  description = lookup(var.address_group[count.index], "description")
  labels      = merge(var.labels, lookup(var.address_group[count.index], "labels"))
  items       = lookup(var.address_group[count.index], "items")
  parent      = lookup(var.address_group[count.index], "parents")
}

resource "google_network_security_authorization_policy" "this" {
  count       = length(var.authorization_policy)
  action      = lookup(var.authorization_policy[count.index], "action")
  name        = lookup(var.authorization_policy[count.index], "name")
  labels      = merge(var.labels, lookup(var.authorization_policy[count.index], "labels"))
  description = lookup(var.authorization_policy[count.index], "description")
  location    = lookup(var.authorization_policy[count.index], "location")
  project     = lookup(var.authorization_policy[count.index], "project")

  dynamic "rules" {
    for_each = lookup(var.authorization_policy[count.index], "rules") == null ? [] : ["rules"]
    content {
      dynamic "sources" {
        for_each = lookup(rules.value, "sources") == null ? [] : ["sources"]
        content {
          principals = lookup(sources.value, "principals")
          ip_blocks  = lookup(sources.value, "ip_blocks")
        }
      }
      dynamic "destinations" {
        for_each = lookup(rules.value, "destinations") == null ? [] : ["destinations"]
        content {
          hosts   = lookup(destinations.value, "hosts")
          methods = lookup(destinations.value, "methods")
          ports   = lookup(destinations.value, "ports")
          dynamic "http_header_match" {
            for_each = lookup(destinations.value, "http_header_match") == null ? [] : ["http_header_match"]
            content {
              header_name = lookup(http_header_match.value, "header_name")
              regex_match = lookup(http_header_match.value, "regex_match")
            }
          }
        }
      }
    }
  }
}

resource "google_network_security_client_tls_policy" "this" {
  count       = length(var.client_tls_policy)
  name        = lookup(var.client_tls_policy[count.index], "name")
  labels      = merge(var.labels, lookup(var.client_tls_policy[count.index], "labels"))
  description = lookup(var.client_tls_policy[count.index], "description")
  sni         = lookup(var.client_tls_policy[count.index], "sni")
  location    = lookup(var.client_tls_policy[count.index], "location")
  project     = lookup(var.client_tls_policy[count.index], "project")

  dynamic "client_certificate" {
    for_each = lookup(var.client_tls_policy[count.index], "client_certificate") == null ? [] : ["client_certificate"]
    content {
      dynamic "grpc_endpoint" {
        for_each = lookup(client_certificate.value, "grpc_endpoint") == null ? [] : ["grpc_endpoint"]
        content {
          target_uri = lookup(grpc_endpoint.value, "target_uri")
        }
      }
      dynamic "certificate_provider_instance" {
        for_each = lookup(client_certificate.value, "certificate_provider_instance") == null ? [] : ["certificate_provider_instance"]
        content {
          plugin_instance = lookup(certificate_provider_instance.value, "plugin_instance")
        }
      }
    }
  }

  dynamic "server_validation_ca" {
    for_each = lookup(var.client_tls_policy[count.index], "server_validation_ca") == null ? [] : ["server_validation_ca"]
    content {
      dynamic "grpc_endpoint" {
        for_each = lookup(server_validation_ca.value, "grpc_endpoint") == null ? [] : ["grpc_endpoint"]
        content {
          target_uri = lookup(grpc_endpoint.value, "target_uri")
        }
      }
      dynamic "certificate_provider_instance" {
        for_each = lookup(server_validation_ca.value, "certificate_provider_instance") == null ? [] : ["certificate_provider_instance"]
        content {
          plugin_instance = lookup(certificate_provider_instance.value, "plugin_instance")
        }
      }
    }
  }
}

resource "google_network_security_gateway_security_policy" "this" {
  count                 = length(var.gateway_security_policy) == "0" ? "0" : length(var.tls_inspection_policy)
  name                  = lookup(var.gateway_security_policy[count.index], "name")
  description           = lookup(var.gateway_security_policy[count.index], "description")
  tls_inspection_policy = try(element(google_network_security_tls_inspection_policy.this.*.id, lookup(var.gateway_security_policy[count.index], "tls_inspection_policy_id")))
  location              = lookup(var.gateway_security_policy[count.index], "location")
  project               = lookup(var.gateway_security_policy[count.index], "project")
}

resource "google_network_security_gateway_security_policy_rule" "this" {
  count                   = length(var.gateway_security_policy_rule) == "0" ? "0" : length(var.gateway_security_policy)
  basic_profile           = lookup(var.gateway_security_policy_rule[count.index], "basic_profile")
  enabled                 = lookup(var.gateway_security_policy_rule[count.index], "enabled")
  gateway_security_policy = try(element(google_network_security_gateway_security_policy.this.*.name, lookup(var.gateway_security_policy_rule[count.index], "gateway_security_policy_id")))
  location                = lookup(var.gateway_security_policy_rule[count.index], "location")
  name                    = lookup(var.gateway_security_policy_rule[count.index], "name")
  priority                = lookup(var.gateway_security_policy_rule[count.index], "priority")
  session_matcher         = lookup(var.gateway_security_policy_rule[count.index], "session_matcher")
  description             = lookup(var.gateway_security_policy_rule[count.index], "description")
  application_matcher     = lookup(var.gateway_security_policy_rule[count.index], "application_matcher")
  tls_inspection_enabled  = lookup(var.gateway_security_policy_rule[count.index], "tls_inspection_enabled")
  project                 = lookup(var.gateway_security_policy_rule[count.index], "project")
}

resource "google_network_security_server_tls_policy" "this" {
  count       = length(var.server_tls_policy)
  name        = lookup(var.server_tls_policy[count.index], "name")
  labels      = merge(var.labels, lookup(var.server_tls_policy[count.index], "labels"))
  description = lookup(var.server_tls_policy[count.index], "description")
  allow_open  = lookup(var.server_tls_policy[count.index], "allow_open")
  location    = lookup(var.server_tls_policy[count.index], "location")
  project     = lookup(var.server_tls_policy[count.index], "project")

  dynamic "server_certificate" {
    for_each = lookup(var.server_tls_policy[count.index], "server_certificate") == null ? [] : ["server_certificate"]
    content {
      dynamic "grpc_endpoint" {
        for_each = lookup(server_certificate.value, "grpc_endpoint") == null ? [] : ["grpc_endpoint"]
        content {
          target_uri = lookup(grpc_endpoint.value, "target_uri")
        }
      }
      dynamic "certificate_provider_instance" {
        for_each = lookup(server_certificate.value, "certificate_provider_instance") == null ? [] : ["certificate_provider_instance"]
        content {
          plugin_instance = lookup(certificate_provider_instance.value, "plugin_instance")
        }
      }
    }
  }

  dynamic "mtls_policy" {
    for_each = lookup(var.server_tls_policy[count.index], "mtls_policy") == null ? [] : ["mtls_policy"]
    content {
      client_validation_mode         = lookup(mtls_policy.value, "client_validation_mode")
      client_validation_trust_config = lookup(mtls_policy.value, "client_validation_trust_config")
      dynamic "client_validation_ca" {
        for_each = lookup(mtls_policy.value, "client_validation_ca") == null ? [] : ["client_validation_ca"]
        content {
          dynamic "grpc_endpoint" {
            for_each = lookup(client_validation_ca.value, "grpc_endpoint") == null ? [] : ["grpc_endpoint"]
            content {
              target_uri = lookup(grpc_endpoint.value, "target_uri")
            }
          }
          dynamic "certificate_provider_instance" {
            for_each = lookup(client_validation_ca.value, "certificate_provider_instance") == null ? [] : ["certificate_provider_instance"]
            content {
              plugin_instance = lookup(certificate_provider_instance.value, "plugin_instance")
            }
          }
        }
      }
    }
  }
}

resource "google_network_security_tls_inspection_policy" "this" {
  count                 = length(var.tls_inspection_policy)
  ca_pool               = lookup(var.tls_inspection_policy[count.index], "ca_pool")
  name                  = lookup(var.tls_inspection_policy[count.index], "name")
  description           = lookup(var.tls_inspection_policy[count.index], "description")
  exclude_public_ca_set = lookup(var.tls_inspection_policy[count.index], "exclude_public_ca_set")
  location              = lookup(var.tls_inspection_policy[count.index], "location")
  project               = lookup(var.tls_inspection_policy[count.index], "project")
}

resource "google_network_security_url_lists" "this" {
  count       = length(var.url_lists)
  location    = lookup(var.url_lists[count.index], "location")
  name        = lookup(var.url_lists[count.index], "name")
  values      = lookup(var.url_lists[count.index], "values")
  description = lookup(var.url_lists[count.index], "description")
  project     = lookup(var.url_lists[count.index], "project")
}

resource "google_network_security_address_group_iam_binding" "this" {
  count    = length(var.address_group_iam_binding) == "0" ? "0" : length(var.address_group)
  provider = "google-beta"
  project  = lookup(var.address_group_iam_binding[count.index], "project")
  location = try(element(google_network_security_address_group.this.*.location, lookup(var.address_group_iam_binding[count.index], "address_group_id")))
  name     = try(element(google_network_security_address_group.this.*.name, lookup(var.address_group_iam_binding[count.index], "address_group_id")))
  role     = "roles/compute.networkAdmin"
  members  = lookup(var.address_group_iam_binding[count.index], "members")
}

resource "google_network_security_firewall_endpoint" "this" {
  count    = length(var.firewall_endpoint)
  provider = "google-beta"
  location = lookup(var.firewall_endpoint[count.index], "location")
  name     = lookup(var.firewall_endpoint[count.index], "name")
  parent   = lookup(var.firewall_endpoint[count.index], "parent")
  labels   = merge(var.labels, lookup(var.firewall_endpoint[count.index], "labels"))
}

resource "google_network_security_profile" "this" {
  count       = length(var.profile)
  provider    = "google-beta"
  type        = lookup(var.profile[count.index], "type")
  name        = lookup(var.profile[count.index], "name")
  description = lookup(var.profile[count.index], "description")
  labels      = merge(var.labels, lookup(var.profile[count.index], "labels"))
  location    = lookup(var.profile[count.index], "location")
  parent      = lookup(var.profile[count.index], "parent")

  dynamic "threat_prevention_profile" {
    for_each = lookup(var.profile[count.index], "threat_prevention_profile") == null ? [] : ["threat_prevention_profile"]
    content {
      dynamic "severity_overrides" {
        for_each = lookup(var.profile[count.index], "severity_overrides") == null ? [] : ["severity_overrides"]
        content {
          action   = lookup(severity_overrides.value, "action")
          severity = lookup(severity_overrides.value, "severity")
        }
      }
      dynamic "threat_overrides" {
        for_each = lookup(var.profile[count.index], "threat_overrides") == null ? [] : ["threat_overrides"]
        content {
          action    = lookup(threat_overrides.value, "action")
          threat_id = lookup(threat_overrides.value, "threat_id")
          type      = lookup(threat_overrides.value, "type")
        }
      }
    }
  }
}

resource "google_network_security_profile_group" "this" {
  count                     = length(var.profile_group) == "0" ? "0" : length(var.profile)
  provider                  = "google-beta"
  name                      = lookup(var.profile_group[count.index], "name")
  description               = lookup(var.profile_group[count.index], "description")
  labels                    = merge(var.labels, lookup(var.profile_group[count.index], "labels"))
  threat_prevention_profile = try(element(google_network_security_profile.this.*.id, lookup(var.profile_group[count.index], "threat_prevention_profile_id")))
  location                  = lookup(var.profile_group[count.index], "location")
  parent                    = lookup(var.profile_group[count.index], "parent")
}

