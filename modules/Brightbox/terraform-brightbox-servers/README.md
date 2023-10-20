## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | 1.5.7 |
| <a name="requirement_brightbox"></a> [brightbox](#requirement\_brightbox) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_brightbox"></a> [brightbox](#provider\_brightbox) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [brightbox_load_balancer.this](https://registry.terraform.io/providers/brightbox/brightbox/3.4.3/docs/resources/load_balancer) | resource |
| [brightbox_server.this](https://registry.terraform.io/providers/brightbox/brightbox/3.4.3/docs/resources/server) | resource |
| [brightbox_server_group.this](https://registry.terraform.io/providers/brightbox/brightbox/3.4.3/docs/resources/server_group) | resource |
| [brightbox_server_group_membership.this](https://registry.terraform.io/providers/brightbox/brightbox/3.4.3/docs/resources/server_group_membership) | resource |
| [brightbox_volume.this](https://registry.terraform.io/providers/brightbox/brightbox/3.4.3/docs/resources/volume) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_load_balancer"></a> [load\_balancer](#input\_load\_balancer) | type                    = list(map)<br>id                      = number<br>name                    = (Optional) A label assigned to the Load Balancer<br>policy                  = (Optional) Method of load balancing to use, either least-connections or round-robin<br>https\_redirect          = (Optional) Redirect any requests on port 80 automatically to port 443<br>ssl\_minimum\_version     = (Optional) The minimum TLS/SSL version for the load balancer to accept. Supports TLSv1.0, TLSv1.1, TLSv1.2, TLSv1.3 and SSLv3<br>locked                  = (Optional) Set to true to stop the load balancer from being deleted<br>nodes                   = (Optional) An array of Server IDs<br>domains                 = (Optional) An array of domain names to attempt to register with ACME. Conflicts with certificate\_pem and certificate\_private\_key<br>certificate\_pem         = (Optional) A X509 SSL certificate in PEM format. Must be included along with certificate\_key.<br>certificate\_private\_key = (Optional) The RSA private key used to sign the certificate in PEM format.<br>listener = (Required) List<br>  protocol       = Protocol of the listener. One of tcp, http, https, http+ws, https+wss<br>  in             = Port to listen on<br>  out            = Port to pass through to<br>  timeout        = (Optional) Timeout of connection in milliseconds. Default is 50000<br>  proxy\_protocol = (Optional) Proxy Protocol version supported by backend server. One of v1, v2, v2-ssl, v2-ssl-cn.<br>healthcheck = (Required) List<br>  type           = Type of health check required: tcp or http<br>  port           = Port to connect to to check health<br>  request        = (Optional) Path used for HTTP check<br>  interval       = (Optional) Frequency of checks in milliseconds<br>  timeout        = (Optional) Timeout of health check in milliseconds<br>  threshold\_down = (Optional) Number of checks that must pass before connection is considered healthy<br>  threshold\_up   = (Optional) Number of checks that must fail before connection is considered unhealthy | <pre>list(map(object({<br>    id                      = number<br>    name                    = optional(string)<br>    policy                  = optional(string)<br>    https_redirect          = optional(bool, true)<br>    ssl_minimum_version     = optional(string)<br>    locked                  = optional(bool, true)<br>    nodes                   = optional(set(string))<br>    domains                 = optional(set(string))<br>    certificate_pem         = optional(string)<br>    certificate_private_key = optional(string)<br>    listener = list(object({<br>      protocol       = string<br>      in             = number<br>      out            = number<br>      timeout        = optional(number, 5000)<br>      proxy_protocol = optional(string)<br>    }))<br>    healthcheck = list(object({<br>      type           = string<br>      port           = number<br>      request        = optional(string)<br>      interval       = optional(number)<br>      timeout        = optional(number)<br>      threshold_down = optional(number)<br>      threshold_up   = optional(number)<br>    }))<br>  })))</pre> | `[]` | no |
| <a name="input_server"></a> [server](#input\_server) | id                  = number<br>name                = string<br>volume              = optional(string)<br>server\_groups       = optional(set(string))<br>image               = optional(string)<br>type                = optional(string)<br>zone                = optional(string)<br>locked              = optional(bool, true)<br>disk\_encrypted      = optional(bool, true)<br>disk\_size           = optional(number)<br>snapshots\_retention = optional(string)<br>snapshots\_schedule  = optional(string)<br>user\_data           = optional(string)<br>user\_data\_base64    = optional(string) | <pre>list(map(object({<br>    id                  = number<br>    name                = string<br>    volume              = optional(string)<br>    server_groups       = optional(set(string))<br>    image               = optional(string)<br>    type                = optional(string)<br>    zone                = optional(string)<br>    locked              = optional(bool, true)<br>    disk_encrypted      = optional(bool, true)<br>    disk_size           = optional(number)<br>    snapshots_retention = optional(string)<br>    snapshots_schedule  = optional(string)<br>    user_data           = optional(string)<br>    user_data_base64    = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_server_group"></a> [server\_group](#input\_server\_group) | n/a | <pre>list(map(object({<br>    id          = number<br>    name        = string<br>    description = optional(string)<br>  })))</pre> | `[]` | no |
| <a name="input_server_group_membership"></a> [server\_group\_membership](#input\_server\_group\_membership) | n/a | <pre>list(map(object({<br>    group   = string<br>    servers = optional(set(string))<br>  })))</pre> | `[]` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | name             = (Optional) A label assigned to the Volume<br>image            = (Optional) Image used to create the volume. One of image, filesystem\_type or source is required.<br>size             = (Optional) Disk size in megabytes<br>description      = (Optional) Verbose Description of this volume<br>encrypted        = (Optional) True if the volume is encrypted<br>filesystem\_label = (Optional) Label given to the filesystem on the volume. Up to 12 characters.<br>filesystem\_type  = (Optional) Format of the filesystem on the volume. Either ext4 or xfs. One of image, filesystem\_type or source is required.<br>serial           = (Optional) Volume Serial Number. Up to 20 characters.<br>server           = (Optional) The ID of the server this volume should be attached to.<br>source           = (Optional) The ID of the source volume for this image. | <pre>list(map(object({<br>    id               = number<br>    name             = optional(string)<br>    image            = optional(string)<br>    size             = optional(number)<br>    description      = optional(string)<br>    encrypted        = optional(bool, true)<br>    filesystem_label = optional(string)<br>    filesystem_type  = optional(string)<br>    serial           = optional(string)<br>    server           = optional(string)<br>    source           = optional(string)<br>  })))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_load_balancer"></a> [load\_balancer](#output\_load\_balancer) | n/a |
| <a name="output_server_group"></a> [server\_group](#output\_server\_group) | n/a |
| <a name="output_server_group_membership"></a> [server\_group\_membership](#output\_server\_group\_membership) | n/a |
| <a name="output_servers"></a> [servers](#output\_servers) | n/a |
| <a name="output_volumes"></a> [volumes](#output\_volumes) | n/a |
