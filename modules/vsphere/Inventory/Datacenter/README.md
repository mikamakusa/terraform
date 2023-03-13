# VSphere Datacenter Terraform Module Documentation

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_vsphere"></a> [vsphere](#requirement\_vsphere) | 2.3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vsphere"></a> [vsphere](#provider\_vsphere) | 2.3.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vsphere_datacenter.datacenter](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/datacenter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_datacenter"></a> [datacenter](#input\_datacenter) | n/a | <pre>map(object({<br>    folder = optional(string)<br>    tags = optional(list(string))<br>    custom_attributes = optional(map(string))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_datacenter"></a> [datacenter](#output\_datacenter) | n/a |

## Usage
### main.tf / No Folder, No tags, No Custom Attributes
```hcl
module "datacenter" {
  source = "../../../modules/vsphere/Inventory/Datacenter"
  datacenter = {
    dc-01 = {}
  }
}
```

### main.tf / No Tags, No Custom Attributes 
```hcl
module "datacenter" {
  source = "../../../modules/vsphere/Inventory/Datacenter"
  datacenter = {
    dc-01 = {
      folder = "/research/"
    }
  }
}
```

### main.tf / No Custom Attributes
```hcl
module "datacenter" {
  source = "../../../modules/vsphere/Inventory/Datacenter"
  datacenter = {
    dc-01 = {
      folder  = "/research/"
      tags    = module.tags[*].tag
    }
  }
}
```

### main.tf / full options
```hcl
module "custom_attribute" {
  source = "../../../modules/vsphere/Inventory/Custom_Attribute"
  custom_attribute = {
    attribute-1 = {
      object_managed_type = "VirtualMachines"
    },
    attribute-2 = {
      object_managed_type = "Datacenters"
    }
  }
}

module "datacenter" {
  source = "../../../modules/vsphere/Inventory/Datacenter"
  datacenter = {
    dc-01 = {
      folder            = "/research/"
      tags              = module.tags[*].tag
      custom_attributes = module.custom_attributes[*].custom_attribute
    }
  }
}
```