# EVPN Cisco IOSXE Terraform module documentation

## Usage
### module declaration
```hcl
provider "iosxe" {
  username = var.username
  password = var.password
  url      = var.url
  insecure = true
}

module "EVPN" {
  source        = "./EVPN"
  evpn          = [
    {
      replication_type_ingress  = false
      replication_type_static   = true
      replication_type_p2mp     = false
      replication_type_mp2mp    = false
      mac_duplication_limit     = 10
      mac_duplication_time      = 100
      ip_duplication_limit      = 10
      ip_duplication_time       = 100
      router_id_loopback        = 100
      default_gateway_advertise = true
      logging_peer_state        = true
      route_target_auto_vni     = true
    }
  ]
  evpn_instance = [
    {
      evpn_instance_num                    = 10
      vlan_based_replication_type_ingress  = false
      vlan_based_replication_type_static   = true
      vlan_based_replication_type_p2mp     = false
      vlan_based_replication_type_mp2mp    = false
      vlan_based_encapsulation             = "vxlan"
      vlan_based_auto_route_target         = false
      vlan_based_rd                        = "10:10"
      vlan_based_route_target              = "10:10"
      vlan_based_route_target_both         = "10:10"
      vlan_based_route_target_import       = "10:10"
      vlan_based_route_target_export       = "10:10"
      vlan_based_ip_local_learning_disable = false
      vlan_based_ip_local_learning_enable  = true
      vlan_based_default_gateway_advertise = "enable"
      vlan_based_re_originate_route_type5  = true
    }
  ]
}
```

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
| [iosxe_evpn.evpn](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/evpn) | resource |
| [iosxe_evpn_instance.evpn](https://registry.terraform.io/providers/netascode/iosxe/latest/docs/resources/evpn_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_evpn"></a> [evpn](#input\_evpn) | n/a | <pre>list(object({<br>    device                    = optional(string)<br>    default_gateway_advertise = optional(bool)<br>    mac_duplication_limit     = optional(number)<br>    mac_duplication_time      = optional(number)<br>    ip_duplication_limit      = optional(number)<br>    ip_duplication_time       = optional(number)<br>    logging_peer_state        = optional(bool)<br>    replication_type_ingress  = optional(bool)<br>    replication_type_static   = optional(bool)<br>    replication_type_p2mp     = optional(bool)<br>    replication_type_mp2mp    = optional(bool)<br>    route_target_auto_vni     = optional(bool)<br>    router_id_loopback        = optional(number)<br>  }))</pre> | `[]` | no |
| <a name="input_evpn_instance"></a> [evpn\_instance](#input\_evpn\_instance) | n/a | <pre>list(object({<br>    evpn_instance_num                    = number<br>    vlan_based_replication_type_ingress  = optional(bool)<br>    vlan_based_replication_type_static   = optional(bool)<br>    vlan_based_replication_type_p2mp     = optional(bool)<br>    vlan_based_replication_type_mp2mp    = optional(bool)<br>    vlan_based_encapsulation             = optional(string)<br>    vlan_based_auto_route_target         = optional(bool)<br>    vlan_based_rd                        = optional(string)<br>    vlan_based_route_target              = optional(string)<br>    vlan_based_route_target_both         = optional(string)<br>    vlan_based_route_target_import       = optional(string)<br>    vlan_based_route_target_export       = optional(string)<br>    vlan_based_ip_local_learning_disable = optional(bool)<br>    vlan_based_ip_local_learning_enable  = optional(bool)<br>    vlan_based_default_gateway_advertise = optional(string)<br>    vlan_based_re_originate_route_type5  = optional(bool)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_evpn"></a> [evpn](#output\_evpn) | n/a |
