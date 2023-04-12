## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_iosxe"></a> [iosxe](#requirement\_iosxe) | >=0.1.13 |
| <a name="requirement_utils"></a> [utils](#requirement\_utils) | >= 0.2.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_iosxe"></a> [iosxe](#provider\_iosxe) | >=0.1.13 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [iosxe_interface_ethernet.interface](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/interface_ethernet) | resource |
| [iosxe_interface_loopback.interface](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/interface_loopback) | resource |
| [iosxe_interface_nve.interface](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/interface_nve) | resource |
| [iosxe_interface_port_channel.interface](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/interface_port_channel) | resource |
| [iosxe_interface_port_channel_subinterface.interface](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/interface_port_channel_subinterface) | resource |
| [iosxe_interface_vlan.interface](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/interface_vlan) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ethernet"></a> [ethernet](#input\_ethernet) | This resource can manage the Interface Ethernet configuration. | <pre>map(object({<br>    type                           = string<br>    description                    = optional(string)<br>    shutdown                       = optional(bool)<br>    ipv4_address                   = optional(string)<br>    ipv4_address_mask              = optional(string)<br>    ip_dhcp_relay_source_interface = optional(string)<br>    ip_access_group_in             = optional(string)<br>    ip_access_group_in_enable      = optional(string)<br>    ip_access_group_out            = optional(string)<br>    ip_access_group_out_enable     = optional(string)<br>    channel_group_mode             = optional(string)<br>    channel_group_number           = optional(number)<br>    encapsulation_dot1q_vlan_id    = optional(string)<br>    media_type                     = optional(string)<br>    switch_port                    = optional(bool)<br>    unnumbered                     = optional(string)<br>    vrf_forwarding                 = optional(bool)<br>    helper_addresses = optional(object({<br>      address = optional(string)<br>      global  = optional(bool)<br>      vrf     = optional(string)<br>    }))<br>    source_template = optional(object({<br>      merge         = optional(bool)<br>      template_name = optional(string)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_loopback"></a> [loopback](#input\_loopback) | This resource can manage the Interface Loopback configuration. | <pre>map(object({<br>    description                = optional(string)<br>    shutdown                   = optional(bool)<br>    vrf_forwarding             = optional(bool)<br>    ipv4_address               = optional(string)<br>    ipv4_address_mask          = optional(string)<br>    ip_access_group_in         = optional(string)<br>    ip_access_group_in_enable  = optional(string)<br>    ip_access_group_out        = optional(string)<br>    ip_access_group_out_enable = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_nve"></a> [nve](#input\_nve) | This resource can manage the Interface NVE configuration. | <pre>map(object({<br>    description                    = optional(string)<br>    device                         = optional(string)<br>    host_reachability_protocol_bgp = optional(bool)<br>    shutdown                       = optional(bool)<br>    source_interface_loopback      = optional(number)<br>    vnis = optional(list(object({<br>      ingress_replication  = optional(bool)<br>      ipv4_multicast_group = optional(string)<br>      vni_range            = optional(string)<br>    })))<br>    vni_vrfs = list(object({<br>      vni_range = optional(string)<br>      vrf       = optional(string)<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_port_channel"></a> [port\_channel](#input\_port\_channel) | This resource can manage the Interface Port Channel and Subinterface configuration. | <pre>map(object({<br>    description                    = optional(string)<br>    device                         = optional(string)<br>    ip_access_group_in             = optional(string)<br>    ip_access_group_in_enable      = optional(bool)<br>    ip_access_group_out            = optional(string)<br>    ip_access_group_out_enable     = optional(bool)<br>    ip_dhcp_relay_source_interface = optional(string)<br>    ipv4_address                   = optional(string)<br>    ipv4_address_mask              = optional(string)<br>    shutdown                       = optional(bool)<br>    switchport                     = optional(bool)<br>    vrf_forwarding                 = optional(string)<br>    encapsulation_dot1q_vlan_id    = optional(number)<br>    helper_addresses = optional(list(object({<br>      address = optional(string)<br>      global  = optional(bool)<br>      vrf     = optional(string)<br>    })))<br>  }))</pre> | `{}` | no |
| <a name="input_vlan"></a> [vlan](#input\_vlan) | This resource can manage the Interface VLAN configuration. | <pre>map(object({<br>    autostate                      = optional(bool)<br>    description                    = optional(string)<br>    shutdown                       = optional(bool)<br>    vrf_forwarding                 = optional(bool)<br>    ipv4_address                   = optional(string)<br>    ipv4_address_mask              = optional(string)<br>    ip_access_group_in             = optional(string)<br>    ip_access_group_in_enable      = optional(bool)<br>    ip_access_group_out            = optional(string)<br>    ip_access_group_out_enable     = optional(bool)<br>    ip_dhcp_relay_source_interface = optional(string)<br>    helper_addresses = optional(list(object({<br>      address = optional(string)<br>      global  = optional(bool)<br>      vrf     = optional(string)<br>    })))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_interface"></a> [interface](#output\_interface) | n/a |
