variable "annotations" {
  type = list(object({
    key   = string
    value = string
  }))
  default     = []
  description = "Annotations to apply on the resources"
}

variable "configuration" {
  type = map(object({
    description                   = optional(string)
    name_alias                    = optional(string)
    from_card                     = optional(string)
    to_card                       = optional(string)
    from_port                     = optional(string)
    to_port                       = optional(string)
    access_port_selector_type     = string
    from_sub_port                 = optional(string)
    to_sub_port                   = optional(string)
    from_                         = optional(string)
    to_                           = optional(string)
    node_mgmt_epg_type            = string
    t_dn                          = string
    addr                          = optional(string)
    gw                            = optional(string)
    v6_addr                       = optional(string)
    v6_gw                         = optional(string)
    switches                      = list(string)
    spine_switch_association_type = optional(string)
  }))

  validation {
    condition     = contains(["ALL", "range"], var.configuration.access_port_selector_type)
    error_message = "Allowed values : \"ALL\", \"range\"."
  }
}