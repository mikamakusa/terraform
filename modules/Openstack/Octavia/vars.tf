variable "project_name" {
  type = string
}

variable "l7policy_v2" {
  type = list(object({
    id               = number
    action           = string
    listener_id      = string
    region           = optional(string)
    tenant_id        = optional(string)
    name             = optional(string)
    description      = optional(string)
    position         = optional(number)
    redirect_pool_id = optional(number)
    redirect_url     = optional(string)
    admin_state_up   = optional(bool)
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "l7rule_v2" {
  type = list(object({
    id             = number
    compare_type   = string
    l7policy_id    = number
    type           = string
    value          = string
    key            = optional(string)
    invert         = optional(bool)
    admin_state_up = optional(bool)
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "listener_v2" {
  type = list(object({
    id                        = number
    loadbalancer_id           = number
    protocol                  = string
    protocol_port             = number
    name                      = optional(string)
    default_pool_id           = optional(string)
    description               = optional(string)
    connection_limit          = optional(number)
    timeout_client_data       = optional(number)
    timeout_member_connect    = optional(number)
    timeout_member_data       = optional(number)
    timeout_tcp_inspect       = optional(number)
    default_tls_container_ref = optional(string)
    sni_container_refs        = optional(list(string))
    admin_state_up            = optional(bool)
    insert_headers            = optional(map(string))
    allowed_cidrs             = optional(list(string))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "loadbalancer_v2" {
  type = list(object({
    id                    = number
    vip_address           = optional(string)
    vip_network_id        = optional(string)
    vip_port_id           = optional(string)
    vip_subnet_id         = optional(string)
    name                  = optional(string)
    description           = optional(string)
    admin_state_up        = optional(bool)
    flavor_id             = optional(string)
    loadbalancer_provider = optional(string)
    availability_zone     = optional(string)
    security_group_ids    = optional(list(string))
    tags                  = optional(list(string))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "member_v2" {
  type = list(object({
    id              = number
    address         = string
    pool_id         = number
    protocol_port   = number
    subnet_id       = optional(string)
    name            = optional(string)
    weight          = optional(number)
    admin_state_up  = optional(bool)
    monitor_address = optional(string)
    monitor_port    = optional(number)
    backup          = optional(bool)
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "members_v2" {
  type = list(object({
    id      = number
    pool_id = number
    member = optional(list(object({
      address         = string
      protocol_port   = number
      subnet_id       = optional(string)
      name            = optional(string)
      weight          = optional(number)
      monitor_port    = optional(number)
      monitor_address = optional(string)
      admin_state_up  = optional(bool)
      backup          = optional(bool)
    })), [])
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "monitor_v2" {
  type = list(object({
    id               = number
    delay            = number
    max_retries      = number
    pool_id          = number
    timeout          = number
    type             = string
    name             = optional(string)
    max_retries_down = optional(number)
    url_path         = optional(string)
    http_method      = optional(string)
    expected_codes   = optional(string)
    admin_state_up   = optional(bool)
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "pool_v2" {
  type = list(object({
    id              = number
    lb_method       = string
    protocol        = string
    name            = optional(string)
    description     = optional(string)
    loadbalancer_id = optional(number)
    listener_id     = optional(number)
    admin_state_up  = optional(bool)
    persistence = optional(list(object({
      type        = string
      cookie_name = optional(string)
    })), [])
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "quota_v2" {
  type = list(object({
    id             = number
    loadbalancer   = optional(number)
    listener       = optional(number)
    member         = optional(number)
    pool           = optional(number)
    health_monitor = optional(number)
    l7_policy      = optional(number)
    l7_rule        = optional(number)
  }))
  default     = []
  description = <<EOF
  EOF
}
