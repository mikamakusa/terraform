variable "load_balancer" {
  type = map(object({
    algorithm                        = optional(string)
    redirect_http_to_https           = optional(bool)
    enable_proxy_protocol            = optional(bool)
    enable_backend_keepalive         = optional(bool)
    http_idle_timeout_seconds        = optional(number)
    disable_lets_encrypt_dns_records = optional(bool)
    size                             = string
  }))

  validation {
    condition     = contains(["lb-small", "lb-medium", "lb-large"], var.load_balancer.size)
    error_message = "Size value must be : 'lb-small', 'lb-medium' or 'lb-large'."
  }
  description = "Main arguments to define for creating a Load Balancer in DigitalOcean."
}

variable "forwarding_rule" {
  type = list(object({
    entry_protocol  = string
    entry_port      = number
    target_protocol = string
    target_port     = number
    tls_passthrough = optional(bool)
  }))

  validation {
    condition     = contains(["http", "https", "http2", "http3", "tcp", "udp"], var.forwarding_rule.entry_protocol)
    error_message = "Allowed value are \"http\",\"https\",\"http2\",\"http3\",\"tcp\",\"udp\"."
  }

  validation {
    condition     = contains(["http", "https", "http2", "http3", "tcp", "udp"], var.forwarding_rule.target_protocol)
    error_message = "Allowed value are \"http\",\"https\",\"http2\",\"http3\",\"tcp\",\"udp\"."
  }

  description = "Define a list of forwarding rules for this load balancer."
}

variable "healthcheck" {
  type = object({
    protocol                 = string
    port                     = optional(number)
    path                     = optional(string)
    check_interval_seconds   = optional(number)
    response_timeout_seconds = optional(number)
    unealthy_threshold       = optional(number)
    healthy_threshold        = optional(number)
  })

  validation {
    condition     = contains(["http", "https", "tcp"], var.healthcheck.protocol)
    error_message = "Allowed value are \"http\",\"https\",\"tcp\"."
  }

  description = "Use this variable and its arguments to define a healthcheck"
}

variable "sticky_sessions" {
  type = object({
    type               = string
    cookie_name        = optional(string)
    cookie_ttl_seconds = optional(number)
  })

  description = "Use this variable and its arguments to define sticky sessions block"

  validation {
    condition     = contains(["cookies", "none"], var.sticky_sessions.type)
    error_message = "Allowed values are 'cookies' or 'none'."
  }
}

variable "droplet_id" {
  type = list(string)
}

variable "certificate_name" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "project_name" {
  type = string
}

variable "token" {
  type = string
}