# Netbox modules documentation

## Usage
### main
```hcl
module "site" {
  source = "../../modules/Netbox/Site"
  site   = var.site
}

module "device_role" {
  source      = "../../modules/Netbox/Device_Role"
  device_role = var.device_role
}

module "manufacturer" {
  source       = "../../modules/Netbox/Manufacturer"
  manufacturer = var.manufacturer
}

module "device_type" {
  source       = "../../modules/Netbox/Device_Type"
  device_type  = var.device_type
  manufacturer = module.manufacturer.manufacturer_id
}

module "device" {
  source      = "../../modules/Netbox/Device"
  device      = var.device
  device_type = module.device_type.device_type_id
  role        = module.device_role.device_role_id
  site        = module.site.site_id
}

module "device_interface" {
  source           = "../../modules/Netbox/Device_Interface"
  device           = module.device.device_id
  device_interface = var.device_interface
}
```

### variables
```hcl
variable "site" {
  type = any
}

variable "device_role" {
  type = any
}

variable "manufacturer" {
  type = any
}

variable "device_type" {
  type = any
}

variable "device" {
  type = any
}

variable "device_interface" {
  type = any
}

variable "server_url" {
  type = string
}

variable "api_token" {
  type = string
}
```

### vars.auto.tfvars
```hcl
server_url = ""
api_token  = ""

site = [
  {
    id     = "0"
    name   = "site1"
    slug   = "site1"
    status = "production"
  },
  {
    id     = "1"
    name   = "site2"
    slug   = "site2"
    status = "staging"
  }
]

device_role = [
  {
    id        = "0"
    color_hex = "0000ff"
    name      = "role1"
  },
  {
    id        = "1"
    color_hex = "ff0000"
    name      = "role2"
  }
]

manufacturer = [
  {
    id   = "0"
    name = "$crosoft"
    slug = "$crosoft"
  }
]

device_type = [
  {
    id              = "0"
    model           = "XXX1-XX2-X3"
    manufacturer_id = "0"
    u_height        = "1"
  }
]

device = [
  {
    id             = "0"
    device_type_id = "0"
    role_id        = "1"
    site_id        = "0"
  }
]

device_interface = [
  {
    id             = "0"
    name           = "xxx1-x15"
    slug           = "x15"
    device_type_id = "0"
  }
]
```

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_device"></a> [device](#module\_device) | ../../modules/Netbox/Device | n/a |
| <a name="module_device_interface"></a> [device\_interface](#module\_device\_interface) | ../../modules/Netbox/Device_Interface | n/a |
| <a name="module_device_role"></a> [device\_role](#module\_device\_role) | ../../modules/Netbox/Device_Role | n/a |
| <a name="module_device_type"></a> [device\_type](#module\_device\_type) | ../../modules/Netbox/Device_Type | n/a |
| <a name="module_manufacturer"></a> [manufacturer](#module\_manufacturer) | ../../modules/Netbox/Manufacturer | n/a |
| <a name="module_site"></a> [site](#module\_site) | ../../modules/Netbox/Site | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_token"></a> [api\_token](#input\_api\_token) | n/a | `string` | n/a | yes |
| <a name="input_device"></a> [device](#input\_device) | n/a | `any` | n/a | yes |
| <a name="input_device_interface"></a> [device\_interface](#input\_device\_interface) | n/a | `any` | n/a | yes |
| <a name="input_device_role"></a> [device\_role](#input\_device\_role) | n/a | `any` | n/a | yes |
| <a name="input_device_type"></a> [device\_type](#input\_device\_type) | n/a | `any` | n/a | yes |
| <a name="input_manufacturer"></a> [manufacturer](#input\_manufacturer) | n/a | `any` | n/a | yes |
| <a name="input_server_url"></a> [server\_url](#input\_server\_url) | n/a | `string` | n/a | yes |
| <a name="input_site"></a> [site](#input\_site) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
