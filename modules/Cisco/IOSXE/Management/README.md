# Management Cisco IOSXE Terraform module documentation

## Usage
### module declaration
```hcl
provider "iosxe" {
  username = var.username
  password = var.password
  url      = var.url
  insecure = true
}

module "management" {
  source = "../../modules/Cisco/IOSXE/Management"
  logging = [
    {
      monitor_severity  = "informational"
      buffered_size     = 16000
      buffered_severity = "informational"
      console_severity  = "informational"
      facility          = "local0"
      history_size      = 100
      history_severity  = "informational"
      trap              = true
      trap_severity     = "informational"
    }
  ]
  ipv4_logging = [
    {
      ipv4_host = "2.2.2.2"
    }
  ]
  group = {
    grp1 = {
      v3_security = [
        {
          security_level  = "priv"
          context_node    = "CON1"
          match_node      = "exact"
          read_node       = "VIEW1"
          write_node      = "VIEW2"
          notify_node     = "VIEW3"
        }
      ]
    }
  }
  user = {
    user1 = {
      grpname           = "grp1"
      v3_auth_algorithm = "md5"
      v3_auth_password  = "Azerty123!"
    }
  }
}
```

## Requirements

| Name | Version   |
|------|-----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.5  |
| <a name="requirement_iosxe"></a> [iosxe](#requirement\_iosxe) | >= 0.1.15 |

## Providers

| Name | Version   |
|------|-----------|
| <a name="provider_iosxe"></a> [iosxe](#provider\_iosxe) | >= 0.1.15 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [iosxe_logging.logging](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/logging) | resource |
| [iosxe_logging_ipv4_host_transport.logging](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/logging_ipv4_host_transport) | resource |
| [iosxe_logging_ipv4_host_vrf_transport.logging](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/logging_ipv4_host_vrf_transport) | resource |
| [iosxe_logging_ipv6_host_transport.logging](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/logging_ipv6_host_transport) | resource |
| [iosxe_logging_ipv6_host_vrf_transport.logging](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/logging_ipv6_host_vrf_transport) | resource |
| [iosxe_snmp_server.snmp](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/snmp_server) | resource |
| [iosxe_snmp_server_group.snmp](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/snmp_server_group) | resource |
| [iosxe_snmp_server_user.snmp](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/snmp_server_user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group"></a> [group](#input\_group) | This resource can manage the SNMP Group configuration. | <pre>map(object({<br>    device = optional(string)<br>    v3_security = optional(list(object({<br>      access_acl_name     = optional(string)<br>      access_ipv6_acl     = optional(string)<br>      access_standard_acl = optional(number)<br>      context_node        = optional(string)<br>      match_node          = optional(string)<br>      notify_node         = optional(string)<br>      read_node           = optional(string)<br>      security_level      = optional(string)<br>      write_node          = optional(string)<br>    })))<br>  }))</pre> | `{}` | no |
| <a name="input_ipv4_logging"></a> [ipv4\_logging](#input\_ipv4\_logging) | This resource can manage the Logging IPv4 /IPv4 VRF / IPv6 / IPv6 VRF Host Transport configuration. | <pre>list(object({<br>    ipv4_host = string<br>    device    = optional(string)<br>    transport_tcp_ports = optional(list(object({<br>      port_number = optional(number)<br>    })))<br>    transport_tls_ports = optional(list(object({<br>      port_number = optional(number)<br>      profile     = optional(string)<br>    })))<br>    transport_udp_ports = optional(list(object({<br>      port_number = optional(number)<br>      profile     = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_ipv4_vrf_logging"></a> [ipv4\_vrf\_logging](#input\_ipv4\_vrf\_logging) | This resource can manage the Logging IPv4 /IPv4 VRF / IPv6 / IPv6 VRF Host Transport configuration. | <pre>list(object({<br>    ipv4_host = string<br>    vrf       = string<br>    device    = optional(string)<br>    ransport_tcp_ports = optional(list(object({<br>      port_number = optional(number)<br>    })))<br>    transport_tls_ports = optional(list(object({<br>      port_number = optional(number)<br>      profile     = optional(string)<br>    })))<br>    transport_udp_ports = optional(list(object({<br>      port_number = optional(number)<br>      profile     = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_ipv6_logging"></a> [ipv6\_logging](#input\_ipv6\_logging) | This resource can manage the Logging IPv4 /IPv4 VRF / IPv6 / IPv6 VRF Host Transport configuration. | <pre>list(object({<br>    ipv4_host = string<br>    vrf       = string<br>    device    = optional(string)<br>    ransport_tcp_ports = optional(list(object({<br>      port_number = optional(number)<br>    })))<br>    transport_tls_ports = optional(list(object({<br>      port_number = optional(number)<br>      profile     = optional(string)<br>    })))<br>    transport_udp_ports = optional(list(object({<br>      port_number = optional(number)<br>      profile     = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_ipv6_vrf_logging"></a> [ipv6\_vrf\_logging](#input\_ipv6\_vrf\_logging) | This resource can manage the Logging IPv4 /IPv4 VRF / IPv6 / IPv6 VRF Host Transport configuration. | <pre>list(object({<br>    ipv4_host = string<br>    vrf       = optional(string)<br>    device    = string<br>    ransport_tcp_ports = optional(list(object({<br>      port_number = optional(number)<br>    })))<br>    transport_tls_ports = optional(list(object({<br>      port_number = optional(number)<br>      profile     = optional(string)<br>    })))<br>    transport_udp_ports = optional(list(object({<br>      port_number = optional(number)<br>      profile     = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_logging"></a> [logging](#input\_logging) | This resource can manage the Logging configuration. | <pre>list(object({<br>    origin_id_name    = optional(string)<br>    monitor_severity  = optional(string)<br>    buffered_severity = optional(string)<br>    console_severity  = optional(string)<br>    history_severity  = optional(string)<br>    trap_severity     = optional(string)<br>    buffered_size     = optional(number)<br>    facility          = optional(string)<br>    history_size      = optional(number)<br>    trap              = optional(bool)<br>    origin_id_type    = optional(string)<br>    source_interface  = optional(string)<br>    file_max_size     = optional(number)<br>    file_min_size     = optional(number)<br>    device            = optional(string)<br>    source_interfaces_vrf = optional(list(object({<br>      vrf            = optional(string)<br>      interface_name = optional(string)<br>    })))<br>    ipv4_hosts = optional(list(object({<br>      ipv4_host = optional(string)<br>    })))<br>    ipv4_vrf_hosts = optional(list(object({<br>      ipv4_host = optional(string)<br>      vrf = optional(string)<br>    })))<br>    ipv6_hosts = optional(list(object({<br>      ipv6_host = optional(string)<br>    })))<br>    ipv6_vrf_hosts = optional(list(object({<br>      ipv6_host = optional(string)<br>      vrf = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_snmp"></a> [snmp](#input\_snmp) | This resource can manage the SNMP Server configuration. | <pre>map(object({<br>    device                                           = optional(string)<br>    contact                                          = optional(string)<br>    ifindex_persist                                  = optional(bool)<br>    location                                         = optional(string)<br>    packetsize                                       = optional(number)<br>    queue_length                                     = optional(number)<br>    enable_informs                                   = optional(bool)<br>    enable_logging_getop                             = optional(bool)<br>    enable_logging_setop                             = optional(bool)<br>    enable_traps                                     = optional(bool)<br>    enable_traps_snmp_authentication                 = optional(bool)<br>    enable_traps_snmp_coldstart                      = optional(bool)<br>    enable_traps_snmp_linkdown                       = optional(bool)<br>    enable_traps_snmp_linkup                         = optional(bool)<br>    enable_traps_snmp_warmstart                      = optional(bool)<br>    ifindex_persist                                  = optional(bool)<br>    source_interface_informs_forty_gigabit_ethernet  = optional(string)<br>    source_interface_informs_gigabit_ethernet        = optional(string)<br>    source_interface_informs_hundred_gig_e           = optional(string)<br>    source_interface_informs_loopback                = optional(number)<br>    source_interface_informs_port_channel            = optional(number)<br>    source_interface_traps_gigabit_ethernet          = optional(string)<br>    source_interface_traps_port_channel              = optional(number)<br>    source_interface_traps_port_channel_subinterface = optional(string)<br>    source_interface_traps_ten_gigabit_ethernet      = optional(string)<br>    source_interface_traps_vlan                      = optional(number)<br>    trap_source_forty_gigabit_ethernet               = optional(string)<br>    trap_source_gigabit_ethernet                     = optional(string)<br>    trap_source_hundred_gig_e                        = optional(string)<br>    trap_source_loopback                             = optional(number)<br>    trap_source_port_channel                         = optional(number)<br>    trap_source_port_channel_subinterface            = optional(string)<br>    trap_source_ten_gigabit_ethernet                 = optional(string)<br>    trap_source_vlan                                 = optional(number)<br>    views = optional(list(object({<br>      name    = optional(string)<br>      inc_exl = optional(string)<br>      mib     = optional(string)<br>    })))<br>    contexts = optional(list(object({<br>      name = optional(string)<br>    })))<br>    snmp_communities = optional(list(object({<br>      name             = optional(string)<br>      access_list_name = optional(string)<br>      ipv6             = optional(string)<br>      permission       = optional(string)<br>      view             = optional(string)<br>    })))<br>  }))</pre> | `{}` | no |
| <a name="input_user"></a> [user](#input\_user) | This resource can manage the SNMP User configuration. | <pre>map(object({<br>    device                                = optional(string)<br>    grpname                               = string<br>    v3_auth_algorithm                     = optional(string)<br>    v3_auth_password                      = optional(string)<br>    v3_auth_access_acl_name               = optional(string)<br>    v3_auth_access_ipv6_acl               = optional(string)<br>    v3_auth_access_standard_acl           = optional(number)<br>    v3_auth_priv_aes_access_acl_name      = optional(string)<br>    v3_auth_priv_aes_access_ipv6_acl      = optional(string)<br>    v3_auth_priv_aes_access_standard_acl  = optional(number)<br>    v3_auth_priv_aes_algorithm            = optional(string)<br>    v3_auth_priv_aes_password             = optional(string)<br>    v3_auth_priv_des3_access_acl_name     = optional(string)<br>    v3_auth_priv_des3_access_ipv6_acl     = optional(string)<br>    v3_auth_priv_des3_access_standard_acl = optional(number)<br>    v3_auth_priv_des3_password            = optional(string)<br>    v3_auth_priv_des_access_acl_name      = optional(string)<br>    v3_auth_priv_des_access_ipv6_acl      = optional(string)<br>    v3_auth_priv_des_access_standard_acl  = optional(number)<br>    v3_auth_priv_des_password             = optional(string)<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_logging"></a> [logging](#output\_logging) | n/a |
