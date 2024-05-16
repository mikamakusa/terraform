## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.8.3 |
| <a name="requirement_openstack"></a> [openstack](#requirement\_openstack) | 1.54.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_openstack"></a> [openstack](#provider\_openstack) | 1.54.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [openstack_lb_l7policy_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/lb_l7policy_v2) | resource |
| [openstack_lb_l7rule_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/lb_l7rule_v2) | resource |
| [openstack_lb_listener_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/lb_listener_v2) | resource |
| [openstack_lb_loadbalancer_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/lb_loadbalancer_v2) | resource |
| [openstack_lb_member_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/lb_member_v2) | resource |
| [openstack_lb_members_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/lb_members_v2) | resource |
| [openstack_lb_monitor_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/lb_monitor_v2) | resource |
| [openstack_lb_pool_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/lb_pool_v2) | resource |
| [openstack_lb_quota_v2.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/resources/lb_quota_v2) | resource |
| [openstack_identity_project_v3.this](https://registry.terraform.io/providers/terraform-provider-openstack/openstack/1.54.1/docs/data-sources/identity_project_v3) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_l7policy_v2"></a> [l7policy\_v2](#input\_l7policy\_v2) | n/a | <pre>list(map(object({<br>    id               = number<br>    action           = string<br>    listener_id      = string<br>    region           = optional(string)<br>    tenant_id        = optional(string)<br>    name             = optional(string)<br>    description      = optional(string)<br>    position         = optional(number)<br>    redirect_pool_id = optional(number)<br>    redirect_url     = optional(string)<br>    admin_state_up   = optional(bool)<br>  })))</pre> | `[]` | no |
| <a name="input_l7rule_v2"></a> [l7rule\_v2](#input\_l7rule\_v2) | n/a | <pre>list(map(object({<br>    id             = number<br>    compare_type   = string<br>    l7policy_id    = number<br>    type           = string<br>    value          = string<br>    key            = optional(string)<br>    invert         = optional(bool)<br>    admin_state_up = optional(bool)<br>  })))</pre> | `[]` | no |
| <a name="input_listener_v2"></a> [listener\_v2](#input\_listener\_v2) | n/a | <pre>list(map(object({<br>    id                        = number<br>    loadbalancer_id           = number<br>    protocol                  = string<br>    protocol_port             = number<br>    name                      = optional(string)<br>    default_pool_id           = optional(string)<br>    description               = optional(string)<br>    connection_limit          = optional(number)<br>    timeout_client_data       = optional(number)<br>    timeout_member_connect    = optional(number)<br>    timeout_member_data       = optional(number)<br>    timeout_tcp_inspect       = optional(number)<br>    default_tls_container_ref = optional(string)<br>    sni_container_refs        = optional(list(string))<br>    admin_state_up            = optional(bool)<br>    insert_headers            = optional(map(string))<br>    allowed_cidrs             = optional(list(string))<br>  })))</pre> | `[]` | no |
| <a name="input_loadbalancer_v2"></a> [loadbalancer\_v2](#input\_loadbalancer\_v2) | n/a | <pre>list(map(object({<br>    id                    = number<br>    vip_address           = optional(string)<br>    vip_network_id        = optional(string)<br>    vip_port_id           = optional(string)<br>    vip_subnet_id         = optional(string)<br>    name                  = optional(string)<br>    description           = optional(string)<br>    admin_state_up        = optional(bool)<br>    flavor_id             = optional(string)<br>    loadbalancer_provider = optional(string)<br>    availability_zone     = optional(string)<br>    security_group_ids    = optional(list(string))<br>    tags                  = optional(list(string))<br>  })))</pre> | `[]` | no |
| <a name="input_member_v2"></a> [member\_v2](#input\_member\_v2) | n/a | <pre>list(map(object({<br>    id              = number<br>    address         = string<br>    pool_id         = number<br>    protocol_port   = number<br>    subnet_id       = optional(string)<br>    name            = optional(string)<br>    weight          = optional(number)<br>    admin_state_up  = optional(bool)<br>    monitor_address = optional(string)<br>    monitor_port    = optional(number)<br>    backup          = optional(bool)<br>  })))</pre> | `[]` | no |
| <a name="input_members_v2"></a> [members\_v2](#input\_members\_v2) | n/a | <pre>list(map(object({<br>    id      = number<br>    pool_id = number<br>    member = optional(list(object({<br>      address         = string<br>      protocol_port   = number<br>      subnet_id       = optional(string)<br>      name            = optional(string)<br>      weight          = optional(number)<br>      monitor_port    = optional(number)<br>      monitor_address = optional(string)<br>      admin_state_up  = optional(bool)<br>      backup          = optional(bool)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_monitor_v2"></a> [monitor\_v2](#input\_monitor\_v2) | n/a | <pre>list(map(object({<br>    id               = number<br>    delay            = number<br>    max_retries      = number<br>    pool_id          = number<br>    timeout          = number<br>    type             = string<br>    name             = optional(string)<br>    max_retries_down = optional(number)<br>    url_path         = optional(string)<br>    http_method      = optional(string)<br>    expected_codes   = optional(string)<br>    admin_state_up   = optional(bool)<br>  })))</pre> | `[]` | no |
| <a name="input_pool_v2"></a> [pool\_v2](#input\_pool\_v2) | n/a | <pre>list(map(object({<br>    id              = number<br>    lb_method       = string<br>    protocol        = string<br>    name            = optional(string)<br>    description     = optional(string)<br>    loadbalancer_id = optional(number)<br>    listener_id     = optional(number)<br>    admin_state_up  = optional(bool)<br>    persistence = optional(list(object({<br>      type        = string<br>      cookie_name = optional(string)<br>    })), [])<br>  })))</pre> | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_quota_v2"></a> [quota\_v2](#input\_quota\_v2) | n/a | <pre>list(map(object({<br>    id             = number<br>    loadbalancer   = optional(number)<br>    listener       = optional(number)<br>    member         = optional(number)<br>    pool           = optional(number)<br>    health_monitor = optional(number)<br>    l7_policy      = optional(number)<br>    l7_rule        = optional(number)<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_l7policy"></a> [l7policy](#output\_l7policy) | n/a |
| <a name="output_listener"></a> [listener](#output\_listener) | n/a |
| <a name="output_loadbalancer"></a> [loadbalancer](#output\_loadbalancer) | n/a |
| <a name="output_member"></a> [member](#output\_member) | n/a |
| <a name="output_monitor"></a> [monitor](#output\_monitor) | n/a |
| <a name="output_pool"></a> [pool](#output\_pool) | n/a |
| <a name="output_quota"></a> [quota](#output\_quota) | n/a |
