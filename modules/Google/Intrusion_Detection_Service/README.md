## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.7.4 |
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.18.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.18.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_cloud_ids_endpoint.this](https://registry.terraform.io/providers/hashicorp/google/5.18.0/docs/resources/cloud_ids_endpoint) | resource |
| [google_compute_global_address.this](https://registry.terraform.io/providers/hashicorp/google/5.18.0/docs/resources/compute_global_address) | resource |
| [google_service_networking_connection.this](https://registry.terraform.io/providers/hashicorp/google/5.18.0/docs/resources/service_networking_connection) | resource |
| [google_compute_network.this](https://registry.terraform.io/providers/hashicorp/google/5.18.0/docs/data-sources/compute_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_address"></a> [global\_address](#input\_global\_address) | Represents a Global Address resource. Global addresses are used for HTTP(S) load balancing. | <pre>list(map(object({<br>    id            = number<br>    name          = string<br>    address       = optional(string)<br>    description   = optional(string)<br>    labels        = optional(map(string))<br>    ip_version    = optional(string)<br>    prefix_length = optional(number)<br>    address_type  = optional(string)<br>    purpose       = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_ids_endpoint"></a> [ids\_endpoint](#input\_ids\_endpoint) | Cloud IDS is an intrusion detection service that provides threat detection for intrusions, malware, spyware, and command-and-control attacks on your network. | <pre>list(map(object({<br>    id                = number<br>    location          = string<br>    name              = string<br>    severity          = string<br>    description       = optional(string)<br>    threat_exceptions = optional(list(string))<br>  })))</pre> | `[]` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | `{}` | no |
| <a name="input_network"></a> [network](#input\_network) | n/a | `string` | n/a | yes |
| <a name="input_networking_connection"></a> [networking\_connection](#input\_networking\_connection) | Manages a private VPC connection with a GCP service provider | <pre>list(map(object({<br>    id         = number<br>    service_id = number<br>    service    = string<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_global_address_name"></a> [global\_address\_name](#output\_global\_address\_name) | n/a |
| <a name="output_ids_endpoint_name"></a> [ids\_endpoint\_name](#output\_ids\_endpoint\_name) | n/a |
| <a name="output_ids_endpoint_network"></a> [ids\_endpoint\_network](#output\_ids\_endpoint\_network) | n/a |
| <a name="output_ids_endpoint_threat_exceptions"></a> [ids\_endpoint\_threat\_exceptions](#output\_ids\_endpoint\_threat\_exceptions) | n/a |
| <a name="output_networking_connection_id"></a> [networking\_connection\_id](#output\_networking\_connection\_id) | n/a |
