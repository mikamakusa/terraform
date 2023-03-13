# VSphere Tag Terraform Module Documentation

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
| [vsphere_tag.tag](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/tag) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tag"></a> [tag](#input\_tag) | n/a | <pre>map(object({<br>    category_id = string<br>    description = optional(string)<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tag"></a> [tag](#output\_tag) | n/a |

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

module "tags" {
  source = "../../../modules/vsphere/Inventory/Tag"
  tag    = {
    tag_category = module.tag_category[*].tag_category
  }
}
```