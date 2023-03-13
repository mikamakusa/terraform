# VSphere Tag Category Terraform Module Documentation

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
| [vsphere_tag_category.tag_category](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/tag_category) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tag_category"></a> [tag\_category](#input\_tag\_category) | n/a | <pre>map(object({<br>    description      = optional(string)<br>    cardinality      = string<br>    associable_types = list(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tag_category"></a> [tag\_category](#output\_tag\_category) | n/a |

## Usage
### main.tf
```hcl
module "tag_category" {
  source       = "../../../modules/vsphere/Inventory/Tag_Category"
  tag_category = {
    category-1 = {
      cardinality       = "SINGLE"
      associable_types  = [
        "VirtualMachine",
        "Datastore"
      ]
    }
  }
}
```