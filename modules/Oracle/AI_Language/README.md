## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.7.4 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | 5.31.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 5.31.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_ai_language_endpoint.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/ai_language_endpoint) | resource |
| [oci_ai_language_model.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/ai_language_model) | resource |
| [oci_ai_language_project.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/ai_language_project) | resource |
| [oci_ai_language_model.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/data-sources/ai_language_model) | data source |
| [oci_ai_language_project.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/data-sources/ai_language_project) | data source |
| [oci_identity_compartment.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/data-sources/identity_compartment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | This data source provides details about a specific Compartment resource in Oracle Cloud Infrastructure Identity service.<br>Gets the specified compartment's information. | `string` | n/a | yes |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | This resource provides the Endpoint resource in Oracle Cloud Infrastructure Ai Language service. | <pre>list(object({<br>    id              = number<br>    model_id        = number<br>    defined_tags    = optional(map(string))<br>    description     = optional(string)<br>    display_name    = optional(string)<br>    freeform_tags   = optional(map(string))<br>    inference_units = optional(number)<br>  }))</pre> | `[]` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_model"></a> [model](#input\_model) | This resource provides the Model resource in Oracle Cloud Infrastructure Ai Language service.<br>Creates a new model for training and train the model with date provided. | <pre>list(object({<br>    id            = number<br>    project_id    = number<br>    defined_tags  = optional(map(string))<br>    display_name  = optional(string)<br>    freeform_tags = optional(map(string))<br>    id            = optional(string)<br>    model_details = list(object({<br>      model_type    = string<br>      language_code = optional(string)<br>      version       = optional(string)<br>      classification_mode = optional(list(object({<br>        classification_mode = optional(string)<br>        version             = optional(string)<br>      })), [])<br>    }))<br>    test_strategy = optional(list(object({<br>      strategy_type = string<br>      testing_dataset = optional(list(object({<br>        dataset_type = string<br>        dataset_id   = optional(string)<br>        location_details = optional(list(object({<br>          bucket        = string<br>          location_type = string<br>          namespace     = string<br>          object_names  = list(string)<br>        })), [])<br>      })), [])<br>      validation_dataset = optional(list(object({<br>        dataset_type = string<br>        dataset_id   = optional(string)<br>        location_details = optional(list(object({<br>          bucket        = string<br>          location_type = string<br>          namespace     = string<br>          object_names  = list(string)<br>        })), [])<br>      })), [])<br>    })), [])<br>    training_dataset = optional(list(object({<br>      dataset_type = string<br>      dataset_id   = optional(string)<br>      location_details = optional(list(object({<br>        bucket        = string<br>        location_type = string<br>        namespace     = string<br>        object_names  = list(string)<br>      })), [])<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_model_id"></a> [model\_id](#input\_model\_id) | n/a | `string` | `null` | no |
| <a name="input_project"></a> [project](#input\_project) | This resource provides the Project resource in Oracle Cloud Infrastructure Ai Language service. | <pre>list(object({<br>    id            = number<br>    defined_tags  = optional(map(string))<br>    description   = optional(string)<br>    display_name  = optional(string)<br>    freeform_tags = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | n/a |
| <a name="output_model"></a> [model](#output\_model) | n/a |
| <a name="output_project"></a> [project](#output\_project) | n/a |
