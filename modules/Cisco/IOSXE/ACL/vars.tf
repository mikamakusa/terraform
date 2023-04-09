variable "acl" {
  type = map(object({
    sequence                      = optional(number)
    remark                        = optional(string)
    deny_prefix                   = optional(string)
    deny_prefix_mask              = optional(string)
    deny_any                      = optional(bool)
    deny_host                     = optional(string)
    permit_any                    = optional(bool)
    permit_host                   = optional(string)
    permit_prefix                 = optional(string)
    permit_prefix_mask            = optional(string)
    ace_rule_action               = optional(string)
    ace_rule_protocol             = optional(string)
    source_prefix                 = optional(string)
    source_prefix_mask            = optional(string)
    source_port_equal             = optional(string)
    destination_host              = optional(string)
    destination_port_range_from   = optional(string)
    destination_port_range_to     = optional(string)
    destination_any               = optional(bool)
    destination_object_group      = optional(string)
    destination_port_equal        = optional(string)
    destination_port_greater_than = optional(string)
    destination_port_lesser_than  = optional(string)
    destination_prefix            = optional(string)
    destination_prefix_mask       = optional(string)
    ack                           = optional(bool)
    fin                           = optional(bool)
    psh                           = optional(bool)
    rst                           = optional(bool)
    syn                           = optional(bool)
    urg                           = optional(bool)
    dscp                          = optional(string)
    established                   = optional(bool)
    fragments                     = optional(bool)
    precedence                    = optional(string)
    service_object_group          = optional(string)
    source_any                    = optional(bool)
    source_host                   = optional(string)
    source_object_group           = optional(string)
    source_port_equal             = optional(string)
    source_port_greater_than      = optional(string)
    source_port_lesser_than       = optional(string)
    source_port_range_from        = optional(string)
    source_port_range_to          = optional(string)
    source_prefix                 = optional(string)
    source_prefix_mask            = optional(string)
    tos                           = optional(string)
    standard                      = bool
  }))

  validation {
    condition     = contains(["deny", "permit"], var.acl.ace_rule_action)
    error_message = "Allowed values : 'deny', 'permit'."
  }

  validation {
    condition     = var.acl.sequence >= 1 && var.acl.sequence <= 2147483647
    error_message = "Allowed range value : 1 to 2147483647."
  }
}