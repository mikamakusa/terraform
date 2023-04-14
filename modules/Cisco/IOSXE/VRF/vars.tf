variable "vrf" {
  type = map(object({
    description         = optional(string)
    rd                  = optional(string)
    address_family_ipv4 = optional(bool)
    address_family_ipv6 = optional(bool)
    vpn_id              = optional(bool)
    route_target_import = optional(list(object({
      value     = optional(string)
      stitching = optional(bool)
    })))
    route_target_export = optional(list(object({
      value     = optional(string)
      stitching = optional(bool)
    })))
    ipv4_route_target_import = optional(list(object({
      value = optional(string)
    })))
    ipv4_route_target_import_stitching = optional(list(object({
      value     = optional(string)
      stitching = optional(bool)
    })))
    ipv4_route_target_export = optional(list(object({
      value = optional(string)
    })))
    ipv4_route_target_export_stitching = optional(list(object({
      value     = optional(string)
      stitching = optional(bool)
    })))
    ipv6_route_target_import = optional(list(object({
      value = optional(string)
    })))
    ipv6_route_target_import_stitching = optional(list(object({
      value     = optional(string)
      stitching = optional(bool)
    })))
    ipv6_route_target_export = optional(list(object({
      value = optional(string)
    })))
    ipv6_route_target_export_stitching = optional(list(object({
      value     = optional(string)
      stitching = optional(bool)
    })))
  }))

  description = "This resource can manage the VRF configuration."
}