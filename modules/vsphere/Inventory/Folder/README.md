# VSphere Folder Terraform Module Documentation

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
| [vsphere_folder.folder](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/folder) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_folder"></a> [folder](#input\_folder) | n/a | <pre>object({<br>    path              = string<br>    type              = string<br>    datacenter_id     = optional(string)<br>    tags              = optional(list(string))<br>    custom_attributes = optional(map(string))<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_folder"></a> [folder](#output\_folder) | n/a |

## Usage
### main.tf
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

module "folder" {
  source = "../../../modules/vsphere/Inventory/Folder"
  folder = {
    path = "terraform"
    type = "datacenter"
    datacenter_id = module.datacenter[*].datacenter
  }
}
```