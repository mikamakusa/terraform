# VSphere License Terraform module documentation

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
| [vsphere_license.license](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/license) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | `{}` | no |
| <a name="input_license"></a> [license](#input\_license) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_license"></a> [license](#output\_license) | n/a |

## Usage
### main.tf / No labels
```hcl
module "License" {
  source = "../../../modules/vsphere/Administration/License"
  license = var.license
}
```

### main.tf / With Labels
```hcl
module "License" {
  source = "../../../modules/vsphere/Administration/License"
  license = var.license
  labels = {
    label1 = "label1"
    label2 = "label2"
  }
}
```

### vars.tf
```hcl
variable "license" {
  type = string
}
```

