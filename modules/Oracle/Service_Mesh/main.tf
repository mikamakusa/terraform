resource "oci_service_mesh_access_policy" "this" {
  count          = length(var.access_policy) == "0" ? "0" : length(var.mesh)
  compartment_id = data.oci_identity_compartment.this.id
  mesh_id = try(
    element(oci_service_mesh_mesh.this.*.id, lookup(var.access_policy[count.index], "mesh_id"))
  )
  name = lookup(var.access_policy[count.index], "mesh")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.access_policy[count.index], "defined_tags")
  )
  description = lookup(var.access_policy[count.index], "description")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.access_policy[count.index], "freeform_tags")
  )

  dynamic "rules" {
    for_each = lookup(var.access_policy[count.index], "rules")
    content {
      action = lookup(rules.value, "action")

      dynamic "destination" {
        for_each = lookup(rules.value, "destination")
        content {
          type               = lookup(destination.value, "type")
          hostnames          = lookup(destination.value, "hostnames")
          ingress_gateway_id = lookup(destination.value, "ingress_gateway_id")
          ip_addresses       = lookup(destination.value, "ip_addresses")
          ports              = lookup(destination.value, "ports")
          protocol           = lookup(destination.value, "protocol")
          virtual_service_id = lookup(destination.value, "virtual_service_id")
        }
      }

      dynamic "source" {
        for_each = lookup(rules.value, "source")
        content {
          type               = lookup(source.value, "type")
          ingress_gateway_id = lookup(source.value, "ingress_gateway_id")
          ip_addresses       = lookup(source.value, "ip_addresses")
          ports              = lookup(source.value, "ports")
          protocol           = lookup(source.value, "protocol")
          virtual_service_id = lookup(source.value, "virtual_service_id")
        }
      }
    }
  }
}

resource "oci_service_mesh_ingress_gateway" "this" {
  count          = length(var.ingress_gateway) == "0" ? "0" : length(var.mesh)
  compartment_id = data.oci_identity_compartment.this.id
  mesh_id = try(
    element(oci_service_mesh_mesh.this.*.id, lookup(var.ingress_gateway[count.index], "mesh_id"))
  )
  name = lookup(var.ingress_gateway[count.index], "name")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.ingress_gateway[count.index], "defined_tags")
  )
  description = lookup(var.ingress_gateway[count.index], "description")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.ingress_gateway[count.index], "freeform_tags")
  )

  dynamic "hosts" {
    for_each = lookup(ingress_gateway[count.index], "hosts")
    content {
      name      = lookup(hosts.value, "name")
      hostnames = lookup(hosts.value, "hostnames")

      dynamic "listeners" {
        for_each = lookup(hosts.value, "listeners")
        content {
          port     = lookup(listeners.value, "port")
          protocol = lookup(listeners.value, "protocol")

          dynamic "tls" {
            for_each = lookup(listeners.value, "tls") == null ? [] : ["tls"]
            content {
              mode = lookup(tls.value, "mode")

              dynamic "client_validation" {
                for_each = lookup(tls.value, "client_validation") == null ? [] : ["client_validation"]
                content {
                  subject_alternate_names = lookup(client_validation.value, "subject_alternate_names")

                  dynamic "trusted_ca_bundle" {
                    for_each = lookup(client_validation.value, "trusted_ca_bundle") == null ? [] : ["trusted_ca_bundle"]
                    content {
                      type         = lookup(trusted_ca_bundle.value, "type")
                      ca_bundle_id = lookup(trusted_ca_bundle.value, "ca_bundle_id")
                      secret_name  = lookup(trusted_ca_bundle.value, "secret_name")
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "access_logging" {
    for_each = lookup(ingress_gateway[count.index], "access_logging") == null ? [] : ["access_logging"]
    content {
      is_enabled = lookup(access_logging.value, "is_enabled")
    }
  }

  dynamic "mtls" {
    for_each = lookup(ingress_gateway[count.index], "mtls") == null ? [] : ["mtls"]
    content {
      maximum_validity = lookup(mtls.value, "maximum_validity")
    }
  }
}

resource "oci_service_mesh_ingress_gateway_route_table" "this" {
  count          = length(var.ingress_gateway_route_table) == "0" ? "0" : length(var.ingress_gateway)
  compartment_id = data.oci_identity_compartment.this.id
  ingress_gateway_id = try(
    element(oci_service_mesh_ingress_gateway.this.*.id, lookup(var.ingress_gateway_route_table[count.index], "ingress_gateway_id"))
  )
  name = lookup(var.ingress_gateway_route_table[count.index], "name")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.ingress_gateway_route_table[count.index], "defined_tags")
  )
  description = lookup(var.ingress_gateway_route_table[count.index], "description")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.ingress_gateway_route_table[count.index], "freeform_tags")
  )
  priority = lookup(var.ingress_gateway_route_table[count.index], "priority")

  dynamic "route_rules" {
    for_each = lookup(var.ingress_gateway_route_table[count.index], "route_rules")
    content {
      type                    = lookup(route_rules.value, "type")
      is_grpc                 = lookup(route_rules.value, "is_grpc")
      is_host_rewrite_enabled = lookup(route_rules.value, "is_host_rewrite_enabled")
      is_path_rewrite_enabled = lookup(route_rules.value, "is_path_rewrite_enabled")
      path                    = lookup(route_rules.value, "path")
      path_type               = lookup(route_rules.value, "path_type")
      request_timeout_in_ms   = lookup(route_rules.value, "request_timeout_in_ms")

      dynamic "destinations" {
        for_each = lookup(route_rules.value, "destinations")
        content {
          virtual_service_id = lookup(destinations.value, "virtual_service_id")
          port               = lookup(destinations.value, "port")
          weight             = lookup(destinations.value, "weight")
        }
      }
      dynamic "ingress_gateway_host" {
        for_each = lookup(route_rules.value, "ingress_gateway_host") == null ? [] : ["ingress_gateway_host"]
        content {
          name = lookup(ingress_gateway_host.value, "name")
          port = lookup(ingress_gateway_host.value, "port")
        }
      }
    }
  }
}

resource "oci_service_mesh_mesh" "this" {
  count          = length(var.mesh)
  compartment_id = data.oci_identity_compartment.this.id
  display_name   = lookup(var.mesh[count.index], "display_name")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.mesh[count.index], "defined_tags")
  )
  description = lookup(var.mesh[count.index], "description")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.mesh[count.index], "freeform_tags")
  )

  dynamic "certificate_authorities" {
    for_each = lookup(var.mesh[count.index], "certificate_authorities")
    content {
      id = lookup(certificate_authorities.value, "id")
    }
  }

  dynamic "mtls" {
    for_each = lookup(var.mesh[count.index], "mtls") == null ? [] : ["mtls"]
    content {
      minimum = lookup(mtls.value, "minimum")
    }
  }
}

resource "oci_service_mesh_virtual_deployment" "this" {
  count          = length(var.virtual_deployment) == "0" ? "0" : length(var.virtual_service)
  compartment_id = data.oci_identity_compartment.this.id
  name           = lookup(var.virtual_deployment[count.index], "name")
  virtual_service_id = try(
    element(oci_service_mesh_virtual_service.this.*.id, lookup(var.virtual_deployment[count.index], "virtual_service_id"))
  )
  defined_tags = merge(
    var.defined_tags,
    lookup(var.virtual_deployment[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.virtual_deployment[count.index], "freeform_tags")
  )


  dynamic "listeners" {
    for_each = lookup(var.virtual_deployment[count.index], "listeners") == null ? [] : ["listeners"]
    content {
      port                  = lookup(listeners.value, "port")
      protocol              = lookup(listeners.value, "protocol")
      idle_timeout_in_ms    = lookup(listeners.value, "idle_timeout_in_ms")
      request_timeout_in_ms = lookup(listeners.value, "request_timeout_in_ms")
    }
  }

  dynamic "service_discovery" {
    for_each = lookup(var.virtual_deployment[count.index], "service_discovery") == null ? [] : ["service_discovery"]
    content {
      type     = lookup(service_discovery.value, "type")
      hostname = lookup(service_discovery.value, "hostname")
    }
  }

  dynamic "access_logging" {
    for_each = lookup(var.virtual_deployment[count.index], "access_logging") == null ? [] : ["access_logging"]
    content {
      is_enabled = lookup(access_logging.value, "is_enabled")
    }
  }
}

resource "oci_service_mesh_virtual_service" "this" {
  count          = length(var.virtual_service) == "0" ? "0" : length(var.mesh)
  compartment_id = data.oci_identity_compartment.this.id
  mesh_id = try(
    element(oci_service_mesh_mesh.this.*.id, lookup(var.virtual_service[count.index], "mesh_id"))
  )
  name = lookup(var.virtual_service[count.index], "name")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.virtual_service[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.virtual_service[count.index], "freeform_tags")
  )
  description = lookup(var.virtual_service[count.index], "description")
  hosts       = lookup(var.virtual_service[count.index], "hosts")

  dynamic "default_routing_policy" {
    for_each = lookup(var.virtual_service[count.index], "default_routing_policy") == null ? [] : ["default_routing_policy"]
    content {
      type = lookup(default_routing_policy.value, "type")
    }
  }

  dynamic "mtls" {
    for_each = lookup(var.virtual_service[count.index], "mtls") == null ? [] : ["mtls"]
    content {
      mode             = lookup(mtls.value, "mode")
      maximum_validity = lookup(mtls.value, "maximum_validity")
    }
  }
}

resource "oci_service_mesh_virtual_service_route_table" "this" {
  count          = length(var.virtual_service_route_table) == "0" ? "0" : length(var.virtual_service)
  compartment_id = data.oci_identity_compartment.this.id
  name           = lookup(var.virtual_service_route_table[count.index], "name")
  virtual_service_id = try(
    element(oci_service_mesh_virtual_service.this.*.id, lookup(var.virtual_service_route_table[count.index], "virtual_service_id"))
  )
  defined_tags = merge(
    var.defined_tags,
    lookup(var.virtual_service_route_table[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.virtual_service_route_table[count.index], "freeform_tags")
  )
  description = lookup(var.ingress_gateway_route_table[count.index], "description")
  priority    = lookup(var.ingress_gateway_route_table[count.index], "priority")

  dynamic "route_rules" {
    for_each = lookup(var.ingress_gateway_route_table[count.index], "route_rules")
    content {
      type                  = lookup(route_rules.value, "type")
      is_grpc               = lookup(route_rules.value, "is_grpc")
      path                  = lookup(route_rules.value, "path")
      path_type             = lookup(route_rules.value, "path_type")
      request_timeout_in_ms = lookup(route_rules.value, "request_timeout_in_ms")

      dynamic "destinations" {
        for_each = lookup(route_rules.value, "destinations")
        content {
          virtual_deployment_id = lookup(destinations.value, "virtual_deployment_id")
          weight                = lookup(destinations.value, "weight")
          port                  = lookup(destinations.value, "port")
        }
      }
    }
  }
}