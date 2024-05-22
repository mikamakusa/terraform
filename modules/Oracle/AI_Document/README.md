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
| [oci_ai_document_model.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/ai_document_model) | resource |
| [oci_ai_document_processor_job.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/ai_document_processor_job) | resource |
| [oci_ai_document_project.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/ai_document_project) | resource |
| [oci_ai_document_project.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/data-sources/ai_document_project) | data source |
| [oci_identity_compartment.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/data-sources/identity_compartment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | This data source provides details about a specific Compartment resource in Oracle Cloud Infrastructure Identity service.<br>Gets the specified compartment's information. | `string` | n/a | yes |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_model"></a> [model](#input\_model) | This resource provides the Model resource in Oracle Cloud Infrastructure Ai Document service.<br>Create a new model. | <pre>list(object({<br>    id                         = number<br>    model_type                 = string<br>    model_id                   = string<br>    project_id                 = number<br>    defined_tags               = optional(map(string))<br>    description                = optional(string)<br>    display_name               = optional(string)<br>    freeform_tags              = optional(map(string))<br>    is_quick_mode              = optional(bool)<br>    max_training_time_in_hours = optional(number)<br>    model_version              = optional(string)<br>    component_models = optional(list(object({<br>      model_id = optional(string)<br>    })), [])<br>    operations = optional(list(object({<br>      operation = optional(string)<br>      path      = optional(string)<br>      value     = optional(string)<br>    })), [])<br>    testing_dataset = optional(list(object({<br>      dataset_type = string<br>      bucket       = optional(string)<br>      dataset_id   = optional(string)<br>      object       = optional(string)<br>      namespace    = optional(string)<br>    })), [])<br>    training_dataset = optional(list(object({<br>      dataset_type = string<br>      bucket       = optional(string)<br>      dataset_id   = optional(string)<br>      namespace    = optional(string)<br>      object       = optional(string)<br>    })), [])<br>    validation_dataset = optional(list(object({<br>      dataset_type = string<br>      bucket       = optional(string)<br>      dataset_id   = optional(string)<br>      namespace    = optional(string)<br>      object       = optional(string)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_processor_job"></a> [processor\_job](#input\_processor\_job) | This resource provides the Processor Job resource in Oracle Cloud Infrastructure Ai Document service. | <pre>list(object({<br>    id           = number<br>    display_name = optional(string)<br>    input_location = list(object({<br>      source_type = string<br>      data        = optional(string)<br>      object_locations = optional(list(object({<br>        bucket    = string<br>        namespace = string<br>        object    = string<br>      })), [])<br>    }))<br>    output_location = list(object({<br>      bucket    = string<br>      namespace = string<br>      prefix    = string<br>    }))<br>    processor_config = list(object({<br>      processor_type        = string<br>      document_type         = optional(string)<br>      is_zip_output_enabled = optional(bool)<br>      language              = optional(string)<br>      features = list(object({<br>        feature_type            = string<br>        generate_searchable_pdf = optional(bool)<br>        max_results             = optional(number)<br>        model_id                = optional(string)<br>        tenancy_id              = optional(string)<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_project"></a> [project](#input\_project) | This resource provides the Project resource in Oracle Cloud Infrastructure Ai Document service. | <pre>list(object({<br>    id            = number<br>    defined_tags  = optional(map(string))<br>    description   = optional(string)<br>    display_name  = optional(string)<br>    freeform_tags = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_model"></a> [model](#output\_model) | n/a |
| <a name="output_processor_job"></a> [processor\_job](#output\_processor\_job) | n/a |
| <a name="output_project"></a> [project](#output\_project) | n/a |
