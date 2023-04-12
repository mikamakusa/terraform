## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_iosxe"></a> [iosxe](#requirement\_iosxe) | >=0.1.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_iosxe"></a> [iosxe](#provider\_iosxe) | >=0.1.13 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [iosxe_access_list_extended.extended](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/access_list_extended) | resource |
| [iosxe_access_list_standard.standard](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/access_list_standard) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl"></a> [acl](#input\_acl) | n/a | <pre>map(object({<br>    sequence                      = optional(number)<br>    remark                        = optional(string)<br>    deny_prefix                   = optional(string)<br>    deny_prefix_mask              = optional(string)<br>    deny_any                      = optional(bool)<br>    deny_host                     = optional(string)<br>    permit_any                    = optional(bool)<br>    permit_host                   = optional(string)<br>    permit_prefix                 = optional(string)<br>    permit_prefix_mask            = optional(string)<br>    ace_rule_action               = optional(string)<br>    ace_rule_protocol             = optional(string)<br>    source_prefix                 = optional(string)<br>    source_prefix_mask            = optional(string)<br>    source_port_equal             = optional(string)<br>    destination_host              = optional(string)<br>    destination_port_range_from   = optional(string)<br>    destination_port_range_to     = optional(string)<br>    destination_any               = optional(bool)<br>    destination_object_group      = optional(string)<br>    destination_port_equal        = optional(string)<br>    destination_port_greater_than = optional(string)<br>    destination_port_lesser_than  = optional(string)<br>    destination_prefix            = optional(string)<br>    destination_prefix_mask       = optional(string)<br>    ack                           = optional(bool)<br>    fin                           = optional(bool)<br>    psh                           = optional(bool)<br>    rst                           = optional(bool)<br>    syn                           = optional(bool)<br>    urg                           = optional(bool)<br>    dscp                          = optional(string)<br>    established                   = optional(bool)<br>    fragments                     = optional(bool)<br>    precedence                    = optional(string)<br>    service_object_group          = optional(string)<br>    source_any                    = optional(bool)<br>    source_host                   = optional(string)<br>    source_object_group           = optional(string)<br>    source_port_equal             = optional(string)<br>    source_port_greater_than      = optional(string)<br>    source_port_lesser_than       = optional(string)<br>    source_port_range_from        = optional(string)<br>    source_port_range_to          = optional(string)<br>    source_prefix                 = optional(string)<br>    source_prefix_mask            = optional(string)<br>    tos                           = optional(string)<br>    standard                      = bool<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ios_access_list_id"></a> [ios\_access\_list\_id](#output\_ios\_access\_list\_id) | n/a |
