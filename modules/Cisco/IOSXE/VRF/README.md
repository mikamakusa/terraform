# System Cisco IOSXE Terraform module documentation

## Usage
### module declaration
```hcl
provider "iosxe" {
  username = var.username
  password = var.password
  url      = var.url
  insecure = true
}

module "VRF" {
  source = "./VRF"
  vrf    = {
    vrf_130 = {
      rd                  = "22:22"
      address_family_ipv4 = true
      address_family_ipv6 = true
      vpn_id              = "22:22"
      route_target_import = [
        {
          value     = "22:22"
          stitching = false
        }
      ]
      route_target_export = [
        {
          value     = "22:22"
          stitching = false
        }
      ]
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
| [iosxe_vrf.vrf](https://registry.terraform.io/providers/netascode/iosxe/0.1.15/docs/resources/vrf) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vrf"></a> [vrf](#input\_vrf) | This resource can manage the VRF configuration. | <pre>map(object({<br>    description         = optional(string)<br>    rd                  = optional(string)<br>    address_family_ipv4 = optional(bool)<br>    address_family_ipv6 = optional(bool)<br>    vpn_id              = optional(bool)<br>    route_target_import = optional(list(object({<br>      value     = optional(string)<br>      stitching = optional(bool)<br>    })))<br>    route_target_export = optional(list(object({<br>      value     = optional(string)<br>      stitching = optional(bool)<br>    })))<br>    ipv4_route_target_import = optional(list(object({<br>      value = optional(string)<br>    })))<br>    ipv4_route_target_import_stitching = optional(list(object({<br>      value     = optional(string)<br>      stitching = optional(bool)<br>    })))<br>    ipv4_route_target_export = optional(list(object({<br>      value = optional(string)<br>    })))<br>    ipv4_route_target_export_stitching = optional(list(object({<br>      value     = optional(string)<br>      stitching = optional(bool)<br>    })))<br>    ipv6_route_target_import = optional(list(object({<br>      value = optional(string)<br>    })))<br>    ipv6_route_target_import_stitching = optional(list(object({<br>      value     = optional(string)<br>      stitching = optional(bool)<br>    })))<br>    ipv6_route_target_export = optional(list(object({<br>      value = optional(string)<br>    })))<br>    ipv6_route_target_export_stitching = optional(list(object({<br>      value     = optional(string)<br>      stitching = optional(bool)<br>    })))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vrf"></a> [vrf](#output\_vrf) | n/a |
