# VSphere Custom Attribute Terraform Module Documentation

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
| [vsphere_custom_attribute.custom_attribute](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/custom_attribute) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_attribute"></a> [custom\_attribute](#input\_custom\_attribute) | n/a | <pre>map(object({<br>    managed_object_type = optional(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_custom_attribute"></a> [custom\_attribute](#output\_custom\_attribute) | n/a |

## Usage
### main.tf / No Object Managed Type
```hcl
module "custom_attribute" {
  source = "../../../modules/vsphere/Inventory/Custom_Attribute"
  custom_attribute = {
    attribute-1 = {}
  }
}
```

### main.tf / With Object Managed Type
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
```