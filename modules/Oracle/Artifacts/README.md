## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.7.4 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | 5.39.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 5.39.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_artifacts_container_configuration.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/artifacts_container_configuration) | resource |
| [oci_artifacts_container_image_signature.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/artifacts_container_image_signature) | resource |
| [oci_artifacts_container_repository.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/artifacts_container_repository) | resource |
| [oci_artifacts_generic_artifact.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/artifacts_generic_artifact) | resource |
| [oci_artifacts_repository.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/resources/artifacts_repository) | resource |
| [oci_identity_compartment.this](https://registry.terraform.io/providers/oracle/oci/5.39.0/docs/data-sources/identity_compartment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | This data source provides details about a specific Compartment resource in Oracle Cloud Infrastructure Identity service.<br>Gets the specified compartment's information. | `string` | n/a | yes |
| <a name="input_container_configuration"></a> [container\_configuration](#input\_container\_configuration) | n/a | <pre>list(object({<br>    id                                  = number<br>    is_repository_created_on_first_push = bool<br>  }))</pre> | `[]` | no |
| <a name="input_container_image_signature"></a> [container\_image\_signature](#input\_container\_image\_signature) | n/a | <pre>list(object({<br>    id                 = number<br>    image_id           = string<br>    kms_key_id         = string<br>    kms_key_version_id = string<br>    message            = string<br>    signature          = string<br>    signing_algorithm  = string<br>    freeform_tags      = optional(map(string))<br>    defined_tags       = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_container_repository"></a> [container\_repository](#input\_container\_repository) | n/a | <pre>list(object({<br>    id            = number<br>    display_name  = string<br>    defined_tags  = optional(map(string))<br>    freeform_tags = optional(map(string))<br>    is_immutable  = optional(bool)<br>    is_public     = optional(bool)<br>    readme = optional(list(object({<br>      content = string<br>      format  = string<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_generic_artifact"></a> [generic\_artifact](#input\_generic\_artifact) | n/a | <pre>list(object({<br>    id            = number<br>    artifact_id   = string<br>    defined_tags  = optional(map(string))<br>    freeform_tags = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | n/a | <pre>list(object({<br>    id              = number<br>    is_immutable    = bool<br>    repository_type = string<br>    defined_tags    = optional(map(string))<br>    freeform_tags   = optional(map(string))<br>    description     = optional(string)<br>    display_name    = optional(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_configuration"></a> [container\_configuration](#output\_container\_configuration) | n/a |
| <a name="output_container_image_signature"></a> [container\_image\_signature](#output\_container\_image\_signature) | n/a |
| <a name="output_container_repository"></a> [container\_repository](#output\_container\_repository) | n/a |
| <a name="output_generic_artifact"></a> [generic\_artifact](#output\_generic\_artifact) | n/a |
| <a name="output_repository"></a> [repository](#output\_repository) | n/a |
