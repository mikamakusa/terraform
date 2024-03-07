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
| [oci_apm_apm_domain.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/apm_apm_domain) | resource |
| [oci_apm_config_config.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/apm_config_config) | resource |
| [oci_apm_synthetics_dedicated_vantage_point.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/apm_synthetics_dedicated_vantage_point) | resource |
| [oci_apm_synthetics_monitor.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/apm_synthetics_monitor) | resource |
| [oci_apm_synthetics_script.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/resources/apm_synthetics_script) | resource |
| [oci_identity_compartment.this](https://registry.terraform.io/providers/oracle/oci/5.31.0/docs/data-sources/identity_compartment) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | This data source provides details about a specific Compartment resource in Oracle Cloud Infrastructure Identity service.<br>Gets the specified compartment's information. | `string` | n/a | yes |
| <a name="input_config"></a> [config](#input\_config) | This resource provides the Config resource in Oracle Cloud Infrastructure Apm Config service. | <pre>list(map(object({<br>    id            = number<br>    apm_domain_id = number<br>    config_type   = string<br>    display_name  = string<br>    filter_id     = optional(string)<br>    filter_text   = optional(string)<br>    group         = optional(string)<br>    namespace     = optional(string)<br>    opc_dry_run   = optional(string)<br>    options       = optional(string)<br>    defined_tags  = optional(map(string))<br>    freeform_tags = optional(map(string))<br>    description   = optional(string)<br>    dimensions = optional(list(object({<br>      name         = string<br>      value_source = string<br>    })), [])<br>    metrics = optional(list(object({<br>      description  = string<br>      name         = string<br>      unit         = string<br>      value_source = string<br>    })), [])<br>    rules = optional(list(object({<br>      display_name             = string<br>      filter_text              = string<br>      is_apply_to_error_spans  = bool<br>      is_enabled               = bool<br>      priority                 = number<br>      satisfied_response_time  = number<br>      tolerating_response_time = number<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_defined_tags"></a> [defined\_tags](#input\_defined\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | <pre>list(map(object({<br>    id            = number<br>    display_name  = string<br>    defined_tags  = optional(map(string))<br>    freeform_tags = optional(map(string))<br>    is_free_tier  = optional(bool)<br>    description   = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_freeform_tags"></a> [freeform\_tags](#input\_freeform\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_synthetics_dedicated_vantage_point"></a> [synthetics\_dedicated\_vantage\_point](#input\_synthetics\_dedicated\_vantage\_point) | This resource provides the Dedicated Vantage Point resource in Oracle Cloud Infrastructure Apm Synthetics service. | <pre>list(map(object({<br>    id            = number<br>    apm_domain_id = number<br>    display_name  = string<br>    region        = string<br>    defined_tags  = optional(map(string))<br>    freeform_tags = optional(map(string))<br>    status        = optional(string)<br>    dvp_stack_details = list(object({<br>      dvp_stack_id   = string<br>      dvp_stack_type = string<br>      dvp_stream_id  = string<br>      dvp_version    = string<br>    }))<br>  })))</pre> | `[]` | no |
| <a name="input_synthetics_monitor"></a> [synthetics\_monitor](#input\_synthetics\_monitor) | This resource provides the Monitor resource in Oracle Cloud Infrastructure Apm Synthetics service. | <pre>list(map(object({<br>    id                         = number<br>    apm_domain_id              = number<br>    display_name               = string<br>    monitor_type               = string<br>    repeat_interval_in_seconds = number<br>    batch_interval_in_seconds  = optional(number)<br>    defined_tags               = optional(map(string))<br>    freeform_tags              = optional(map(string))<br>    is_run_now                 = optional(bool)<br>    is_run_once                = optional(bool)<br>    availability_configuration = optional(list(object({<br>      max_allowed_failures_per_interval = optional(number)<br>      min_allowed_runs_per_interval     = optional(number)<br>    })), [])<br>    vantage_points = list(object({<br>      name         = string<br>      display_name = string<br>    }))<br>    configuration = optional(list(object({<br>      config_type                       = optional(string)<br>      is_certificate_validation_enabled = optional(bool)<br>      is_default_snapshot_enabled       = optional(bool)<br>      is_failure_retried                = optional(bool)<br>      is_redirection_enabled            = optional(bool)<br>      req_authentication_scheme         = optional(string)<br>      request_method                    = optional(string)<br>      request_post_body                 = optional(string)<br>      verify_response_codes             = optional(list(string))<br>      verify_response_content           = optional(string)<br>      client_certificate_details = optional(list(object({<br>        client_certificate = optional(list(object({<br>          content   = optional(string)<br>          file_name = optional(string)<br>        })), [])<br>        private_key = optional(list(object({<br>          content   = optional(string)<br>          file_name = optional(string)<br>        })), [])<br>      })), [])<br>      dns_configuration = optional(list(object({<br>        is_override_dns = optional(bool)<br>        override_dns_ip = optional(string)<br>      })), [])<br>      network_configuration = optional(list(object({<br>        number_of_hops    = optional(number)<br>        probe_mode        = optional(string)<br>        probe_per_hop     = optional(number)<br>        protocol          = optional(string)<br>        transmission_rate = optional(number)<br>      })), [])<br>      req_authentication_details = optional(list(object({<br>        auth_request_method    = optional(string)<br>        auth_request_post_body = optional(string)<br>        auth_token             = optional(string)<br>        auth_url               = optional(string)<br>        auth_user_name         = optional(string)<br>        auth_user_password     = optional(string)<br>        oauth_scheme           = optional(string)<br>      })), [])<br>      request_headers = optional(list(object({<br>        header_name  = optional(string)<br>        header_value = optional(string)<br>      })), [])<br>      request_query_params = optional(list(object({<br>        param_name  = optional(string)<br>        param_value = optional(string)<br>      })), [])<br>      verify_texts = optional(list(object({<br>        text = optional(string)<br>      })), [])<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_synthetics_script"></a> [synthetics\_script](#input\_synthetics\_script) | This resource provides the Script resource in Oracle Cloud Infrastructure Apm Synthetics service. | <pre>list(map(object({<br>    id                = number<br>    apm_domain_id     = string<br>    content           = string<br>    content_type      = string<br>    display_name      = string<br>    content_file_name = optional(string)<br>    defined_tags      = optional(map(string))<br>    freeform_tags     = optional(map(string))<br>    parameters = optional(list(object({<br>      param_name  = string<br>      is_secret   = optional(bool)<br>      param_value = optional(string)<br>    })), [])<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_config"></a> [config](#output\_config) | n/a |
| <a name="output_dedicated_vantage_point"></a> [dedicated\_vantage\_point](#output\_dedicated\_vantage\_point) | n/a |
| <a name="output_domain"></a> [domain](#output\_domain) | n/a |
| <a name="output_synthetics_monitor"></a> [synthetics\_monitor](#output\_synthetics\_monitor) | n/a |
| <a name="output_synthetics_script"></a> [synthetics\_script](#output\_synthetics\_script) | n/a |
