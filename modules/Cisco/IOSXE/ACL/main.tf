resource "iosxe_access_list_standard" "standard" {
  for_each = { for key, value in var.acl : key => value
    if lookup(value, "standard", null) == true
  }
  name = each.key
  entries = [
    {
      sequence           = each.value.sequence
      remark             = each.value.remark
      deny_prefix        = each.value.deny_prefix
      deny_prefix_mask   = each.value.deny_prefix_mask
      deny_any           = each.value.deny_any
      deny_host          = each.value.deny_host
      permit_any         = each.value.permit_any
      permit_host        = each.value.permit_host
      permit_prefix      = each.value.permit_prefix
      permit_prefix_mask = each.value.permit_prefix_mask
    }
  ]
}

resource "iosxe_access_list_extended" "extended" {
  for_each = { for key, value in var.acl : key => value
    if lookup(value, "standard", null) == false
  }
  name = each.key
  entries = [
    {
      sequence                      = each.value.sequence
      remark                        = each.value.remark
      ace_rule_action               = each.value.ace_rule_action
      ace_rule_protocol             = each.value.ace_rule_protocol
      source_prefix                 = each.value.source_prefix
      source_prefix_mask            = each.value.source_prefix_mask
      source_port_equal             = each.value.source_port_equal
      source_any                    = each.value.source_any
      source_host                   = each.value.source_host
      source_object_group           = each.value.source_object_group
      source_port_greater_than      = each.value.source_port_greater_than
      source_port_lesser_than       = each.value.source_port_lesser_than
      source_port_range_from        = each.value.source_port_range_from
      source_port_range_to          = each.value.source_port_range_to
      destination_host              = each.value.destination_host
      destination_port_range_from   = each.value.destination_port_range_from
      destination_port_range_to     = each.value.destination_port_range_to
      destination_any               = each.value.destination_any
      destination_object_group      = each.value.destination_object_group
      destination_port_equal        = each.value.destination_port_equal
      destination_port_greater_than = each.value.destination_port_greater_than
      destination_port_lesser_than  = each.value.destination_port_lesser_than
      destination_prefix            = each.value.destination_prefix
      destination_prefix_mask       = each.value.destination_prefix_mask
      ack                           = each.value.ack
      fin                           = each.value.fin
      psh                           = each.value.psh
      rst                           = each.value.rst
      syn                           = each.value.syn
      urg                           = each.value.urg
      dscp                          = each.value.dscp
      established                   = each.value.established
      fragments                     = each.value.fragments
      precedence                    = each.value.precedence
      service_object_group          = each.value.service_object_group
      tos                           = each.value.tos
    }
  ]
}