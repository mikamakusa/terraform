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
| [oci_ai_anomaly_detection_ai_private_endpoint.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/ai_anomaly_detection_ai_private_endpoint) | resource |
| [oci_ai_anomaly_detection_data_asset.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/ai_anomaly_detection_data_asset) | resource |
| [oci_ai_anomaly_detection_detect_anomaly_job.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/ai_anomaly_detection_detect_anomaly_job) | resource |
| [oci_ai_anomaly_detection_model.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/ai_anomaly_detection_model) | resource |
| [oci_ai_anomaly_detection_project.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/ai_anomaly_detection_project) | resource |
| [oci_core_subnet.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/data-sources/core_subnet) | data source |
| [oci_identity_compartment.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/data-sources/identity_compartment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_anomaly_job"></a> [anomaly\_job](#input\_anomaly\_job) | This resource provides the Detect Anomaly Job resource in Oracle Cloud Infrastructure Ai Anomaly Detection service. | <pre>list(map(object({<br>    id           = number<br>    model_id     = number<br>    description  = optional(string)<br>    display_name = optional(string)<br>    sensitivity  = optional(number)<br>    input_details = list(object({<br>      input_type   = string<br>      content      = optional(string)<br>      content_type = optional(string)<br>      signal_names = optional(list(string))<br>      data = optional(list(object({<br>        timestamp = optional(string)<br>        values    = optional(list(string))<br>      })), [])<br>      object_locations = optional(list(object({<br>        bucket    = optional(string)<br>        namespace = optional(string)<br>        object    = optional(string)<br>      })), [])<br>    }))<br>    output_details = list(object({<br>      bucket      = string<br>      namespace   = string<br>      output_type = string<br>      prefix      = optional(string)<br>    }))<br>  })))</pre> | `[]` | no |
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | n/a | `string` | n/a | yes |
| <a name="input_data_asset"></a> [data\_asset](#input\_data\_asset) | This resource provides the Data Asset resource in Oracle Cloud Infrastructure Ai Anomaly Detection service. | <pre>list(map(object({<br>    id                  = number<br>    project_id          = number<br>    display_name        = optional(string)<br>    defined_tags        = optional(map(string))<br>    freeform_tags       = optional(map(string))<br>    description         = optional(string)<br>    private_endpoint_id = optional(string)<br>    data_source_details = list(object({<br>      data_source_type          = string<br>      atp_password_secret_id    = optional(string)<br>      atp_user_name             = optional(string)<br>      bucket                    = optional(string)<br>      cwallet_file_secret_id    = optional(string)<br>      database_name             = optional(string)<br>      ewallet_file_secret_id    = optional(string)<br>      key_store_file_secret_id  = optional(string)<br>      measurement_name          = optional(string)<br>      namespace                 = optional(string)<br>      object                    = optional(string)<br>      ojdbc_file_secret_id      = optional(string)<br>      password_secret_id        = optional(string)<br>      table_name                = optional(string)<br>      tnsnames_file_secret_id   = optional(string)<br>      truststore_file_secret_id = optional(string)<br>      url                       = optional(string)<br>      user_name                 = optional(string)<br>      wallet_password_secret_id = optional(string)<br>      version_specific_details = optional(list(object({<br>        influx_version        = string<br>        bucket                = string<br>        database_name         = string<br>        organization_name     = string<br>        retention_policy_name = optional(string)<br>      })), [])<br>    }))<br>  })))</pre> | `[]` | no |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_model"></a> [model](#input\_model) | This resource provides the Model resource in Oracle Cloud Infrastructure Ai Anomaly Detection service. | <pre>list(map(object({<br>    id            = number<br>    project_id    = number<br>    defined_tags  = optional(map(string))<br>    description   = optional(string)<br>    display_name  = optional(string)<br>    freeform_tags = optional(map(string))<br>    model_training_details = list(object({<br>      data_asset_ids    = list(string)<br>      algorithm_hint    = optional(string)<br>      target_fap        = optional(number)<br>      training_fraction = optional(number)<br>      window_size       = optional(number)<br>    }))<br>  })))</pre> | `[]` | no |
| <a name="input_private_endpoint"></a> [private\_endpoint](#input\_private\_endpoint) | This resource provides the Ai Private Endpoint resource in Oracle Cloud Infrastructure Ai Anomaly Detection service. | <pre>list(map(object({<br>    id            = number<br>    dns_zones     = list(string)<br>    display_name  = optional(string)<br>    defined_tags  = optional(map(string))<br>    freeform_tags = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_project"></a> [project](#input\_project) | This resource provides the Project resource in Oracle Cloud Infrastructure Ai Anomaly Detection service. | <pre>list(map(object({<br>    id            = number<br>    display_name  = optional(string)<br>    description   = optional(string)<br>    defined_tags  = optional(map(string))<br>    freeform_tags = optional(map(string))<br>  })))</pre> | `[]` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_anomaly_job"></a> [anomaly\_job](#output\_anomaly\_job) | n/a |
| <a name="output_data_asset"></a> [data\_asset](#output\_data\_asset) | n/a |
| <a name="output_model"></a> [model](#output\_model) | n/a |
| <a name="output_project"></a> [project](#output\_project) | n/a |
