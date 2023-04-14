# BGP Cisco IOSXE Terraform module documentation

## Usage
### module declaration
```hcl
provider "iosxe" {
  username = var.username
  password = var.password
  url      = var.url
  insecure = true
}

module "BGP" {
  source         = "./BGP"
  address_family = [
    {
      ipv4    = true
      asn     = "65000"
      af_name = "unicast"
    }
  ]
  bgp            = [
    {
      asn                  = "65000"
      default_ipv4_unicast = false
      log_neighbor_changes = true
      router_id_loopback   = 100
    }
  ]
  l2vpn          = [
    {
      asn                    = "65000"
      ip                     = "3.3.3.3"
      activate               = true
      send_community         = "both"
      route_reflector_client = false
    }
  ]
  neighbor       = []
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
| [iosxe_bgp.bgp](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/bgp) | resource |
| [iosxe_bgp_address_family_ipv4_vrf.address_family](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/bgp_address_family_ipv4_vrf) | resource |
| [iosxe_bgp_address_family_ipv6_vrf.address_family](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/bgp_address_family_ipv6_vrf) | resource |
| [iosxe_bgp_address_family_l2vpn.l2vpn](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/bgp_address_family_l2vpn) | resource |
| [iosxe_bgp_ipv4_unicast_neighbor.unicast](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/bgp_ipv4_unicast_neighbor) | resource |
| [iosxe_bgp_ipv4_unicast_vrf_neighbor.unicast](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/bgp_ipv4_unicast_vrf_neighbor) | resource |
| [iosxe_bgp_l2vpn_evpn_neighbor.evpn_neighbor](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/bgp_l2vpn_evpn_neighbor) | resource |
| [iosxe_bgp_neighbor.neighbor](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/bgp_neighbor) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_family"></a> [address\_family](#input\_address\_family) | This resource can manage the BGP Address Family IPv4 / IPv6 VRF configuration. | <pre>list(object({<br>    af_name = string<br>    asn     = string<br>    ipv4    = bool<br>    device  = optional(string)<br>    vrfs = optional(list(object({<br>      name                   = optional(string)<br>      advertise_l2vpn_evpn   = optional(bool)<br>      redistribute_connected = optional(bool)<br>      redistribute_static    = optional(bool)<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_bgp"></a> [bgp](#input\_bgp) | This resource can manage the BGP configuration. | <pre>list(object({<br>    asn                  = string<br>    default_ipv4_unicast = optional(bool)<br>    log_neighbor_changes = optional(bool)<br>    router_id_loopback   = optional(number)<br>    devices              = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_l2vpn"></a> [l2vpn](#input\_l2vpn) | This resource can manage the BGP Address Family L2VPN configuration. | <pre>list(object({<br>    af_name = string<br>    asn     = string<br>    device  = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_neighbor"></a> [neighbor](#input\_neighbor) | This resource can manage the BGP IPv4 Unicast VRF  or eVPN Neighbor configuration. | <pre>list(object({<br>    asn                    = string<br>    ip                     = string<br>    unicast                = optional(bool)<br>    evpn                   = optional(bool)<br>    vrf                    = optional(string)<br>    activate               = optional(bool)<br>    description            = optional(string)<br>    device                 = optional(string)<br>    remote_as              = optional(string)<br>    route_reflector_client = optional(string)<br>    shutdown               = optional(bool)<br>    update_source_loopback = optional(string)<br>    send_community         = optional(string)<br>    route_maps = optional(list(object({<br>      in_out         = optional(string)<br>      route_map_name = optional(string)<br>    })))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address_family"></a> [address\_family](#output\_address\_family) | n/a |
| <a name="output_bgp"></a> [bgp](#output\_bgp) | n/a |
| <a name="output_evpn_neighbor"></a> [evpn\_neighbor](#output\_evpn\_neighbor) | n/a |
| <a name="output_neighbor"></a> [neighbor](#output\_neighbor) | n/a |
| <a name="output_unicast"></a> [unicast](#output\_unicast) | n/a |
