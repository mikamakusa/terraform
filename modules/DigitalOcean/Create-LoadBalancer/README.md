## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | ~> 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_loadbalancer.loadbalancer](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/loadbalancer) | resource |
| [digitalocean_certificate.this](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/certificate) | data source |
| [digitalocean_droplet.this](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/droplet) | data source |
| [digitalocean_project.this](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/project) | data source |
| [digitalocean_region.this](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/region) | data source |
| [digitalocean_vpc.this](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_name"></a> [certificate\_name](#input\_certificate\_name) | n/a | `string` | n/a | yes |
| <a name="input_droplet_id"></a> [droplet\_id](#input\_droplet\_id) | n/a | `list(string)` | n/a | yes |
| <a name="input_forwarding_rule"></a> [forwarding\_rule](#input\_forwarding\_rule) | Define a list of forwarding rules for this load balancer. | <pre>list(object({<br>    entry_protocol  = string<br>    entry_port      = number<br>    target_protocol = string<br>    target_port     = number<br>    tls_passthrough = optional(bool)<br>  }))</pre> | n/a | yes |
| <a name="input_healthcheck"></a> [healthcheck](#input\_healthcheck) | Use this variable and its arguments to define a healthcheck | <pre>object({<br>    protocol                 = string<br>    port                     = optional(number)<br>    path                     = optional(string)<br>    check_interval_seconds   = optional(number)<br>    response_timeout_seconds = optional(number)<br>    unealthy_threshold       = optional(number)<br>    healthy_threshold        = optional(number)<br>  })</pre> | n/a | yes |
| <a name="input_load_balancer"></a> [load\_balancer](#input\_load\_balancer) | Main arguments to define for creating a Load Balancer in DigitalOcean. | <pre>map(object({<br>    algorithm                        = optional(string)<br>    redirect_http_to_https           = optional(bool)<br>    enable_proxy_protocol            = optional(bool)<br>    enable_backend_keepalive         = optional(bool)<br>    http_idle_timeout_seconds        = optional(number)<br>    disable_lets_encrypt_dns_records = optional(bool)<br>    size                             = string<br>  }))</pre> | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_sticky_sessions"></a> [sticky\_sessions](#input\_sticky\_sessions) | Use this variable and its arguments to define sticky sessions block | <pre>object({<br>    type               = string<br>    cookie_name        = optional(string)<br>    cookie_ttl_seconds = optional(number)<br>  })</pre> | n/a | yes |
| <a name="input_token"></a> [token](#input\_token) | n/a | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_loadbalancer"></a> [loadbalancer](#output\_loadbalancer) | n/a |
