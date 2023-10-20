variable "volumes" {
  type = list(map(object({
    id               = number
    name             = optional(string)
    image            = optional(string)
    size             = optional(number)
    description      = optional(string)
    encrypted        = optional(bool, true)
    filesystem_label = optional(string)
    filesystem_type  = optional(string)
    serial           = optional(string)
    server           = optional(string)
    source           = optional(string)
  })))
  default     = []
  description = <<-EOT
    name             = (Optional) A label assigned to the Volume
    image            = (Optional) Image used to create the volume. One of image, filesystem_type or source is required.
    size             = (Optional) Disk size in megabytes
    description      = (Optional) Verbose Description of this volume
    encrypted        = (Optional) True if the volume is encrypted
    filesystem_label = (Optional) Label given to the filesystem on the volume. Up to 12 characters.
    filesystem_type  = (Optional) Format of the filesystem on the volume. Either ext4 or xfs. One of image, filesystem_type or source is required.
    serial           = (Optional) Volume Serial Number. Up to 20 characters.
    server           = (Optional) The ID of the server this volume should be attached to.
    source           = (Optional) The ID of the source volume for this image.
EOT
}

variable "server_group" {
  type = list(map(object({
    id          = number
    name        = string
    description = optional(string)
  })))
  default = []
}

variable "server" {
  type = list(map(object({
    id                  = number
    name                = string
    volume              = optional(string)
    server_groups       = optional(set(string))
    image               = optional(string)
    type                = optional(string)
    zone                = optional(string)
    locked              = optional(bool, true)
    disk_encrypted      = optional(bool, true)
    disk_size           = optional(number)
    snapshots_retention = optional(string)
    snapshots_schedule  = optional(string)
    user_data           = optional(string)
    user_data_base64    = optional(string)
  })))
  default     = []
  description = <<-EOT
    id                  = number
    name                = string
    volume              = optional(string)
    server_groups       = optional(set(string))
    image               = optional(string)
    type                = optional(string)
    zone                = optional(string)
    locked              = optional(bool, true)
    disk_encrypted      = optional(bool, true)
    disk_size           = optional(number)
    snapshots_retention = optional(string)
    snapshots_schedule  = optional(string)
    user_data           = optional(string)
    user_data_base64    = optional(string)
EOT
}

variable "server_group_membership" {
  type = list(map(object({
    group   = string
    servers = optional(set(string))
  })))
  default     = []
  description = <<-EOT
EOT
}

variable "load_balancer" {
  type = list(map(object({
    id                      = number
    name                    = optional(string)
    policy                  = optional(string)
    https_redirect          = optional(bool, true)
    ssl_minimum_version     = optional(string)
    locked                  = optional(bool, true)
    nodes                   = optional(set(string))
    domains                 = optional(set(string))
    certificate_pem         = optional(string)
    certificate_private_key = optional(string)
    listener = list(object({
      protocol       = string
      in             = number
      out            = number
      timeout        = optional(number, 5000)
      proxy_protocol = optional(string)
    }))
    healthcheck = list(object({
      type           = string
      port           = number
      request        = optional(string)
      interval       = optional(number)
      timeout        = optional(number)
      threshold_down = optional(number)
      threshold_up   = optional(number)
    }))
  })))
  default     = []
  description = <<-EOT
    type                    = list(map)
    id                      = number
    name                    = (Optional) A label assigned to the Load Balancer
    policy                  = (Optional) Method of load balancing to use, either least-connections or round-robin
    https_redirect          = (Optional) Redirect any requests on port 80 automatically to port 443
    ssl_minimum_version     = (Optional) The minimum TLS/SSL version for the load balancer to accept. Supports TLSv1.0, TLSv1.1, TLSv1.2, TLSv1.3 and SSLv3
    locked                  = (Optional) Set to true to stop the load balancer from being deleted
    nodes                   = (Optional) An array of Server IDs
    domains                 = (Optional) An array of domain names to attempt to register with ACME. Conflicts with certificate_pem and certificate_private_key
    certificate_pem         = (Optional) A X509 SSL certificate in PEM format. Must be included along with certificate_key.
    certificate_private_key = (Optional) The RSA private key used to sign the certificate in PEM format.
    listener = (Required) List
      protocol       = Protocol of the listener. One of tcp, http, https, http+ws, https+wss
      in             = Port to listen on
      out            = Port to pass through to
      timeout        = (Optional) Timeout of connection in milliseconds. Default is 50000
      proxy_protocol = (Optional) Proxy Protocol version supported by backend server. One of v1, v2, v2-ssl, v2-ssl-cn.
    healthcheck = (Required) List
      type           = Type of health check required: tcp or http
      port           = Port to connect to to check health
      request        = (Optional) Path used for HTTP check
      interval       = (Optional) Frequency of checks in milliseconds
      timeout        = (Optional) Timeout of health check in milliseconds
      threshold_down = (Optional) Number of checks that must pass before connection is considered healthy
      threshold_up   = (Optional) Number of checks that must fail before connection is considered unhealthy
EOT
}