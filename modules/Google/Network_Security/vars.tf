variable "labels" {
  type    = map(string)
  default = {}
}

variable "address_group" {
  type = list(map(object({
    id          = number
    capacity    = number
    location    = string
    name        = string
    type        = string
    description = optional(string)
    labels      = optional(map(string))
    items       = optional(list(string))
    parent      = optional(string)
  })))
  default = []
  description = <<EOF
- type : The type of the Address Group. Possible values are "IPV4" or "IPV6". Possible values are: IPV4, IPV6
- capacity : Capacity of the Address Group
- name : Name of the AddressGroup resource
- location : The location of the gateway security policy. The default value is 'global'.
EOF

  validation {
    condition     = contains(["IPV4", "IPV6"], lookup(var.address_group[count.index], "type"))
    error_message = "Type must be IPV4 or IPV6."
  }
}

variable "authorization_policy" {
  type = list(map(object({
    id          = number
    action      = string
    name        = string
    labels      = optional(map(string))
    description = optional(string)
    location    = optional(string)
    project     = optional(string)
    rules = optional(list(object({
      sources = optional(list(object({
        principals = optional(list(string))
        ip_blocks  = optional(list(object({})))
      })), [])
      destinations = optional(list(object({
        hosts   = list(string)
        methods = list(string)
        ports   = list(string)
        http_header_match = optional(list(object({
          header_name = string
          regex_match = string
        })), [])
      })), [])
    })), [])
  })))
  default = []
  description = <<EOF
- action : The action to take when a rule match is found. Possible values are "ALLOW" or "DENY"
- name : Name of the AuthorizationPolicy resource
- rules : List of rules to match.
EOF
  validation {
    condition = contains(["ALLOW","DENY"], lookup(var.authorization_policy[count.index], "action"))
    error_message = "The action to take when a rule match is found. Possible values are \"ALLOW\" or \"DENY\"."
  }
}

variable "client_tls_policy" {
  type = list(map(object({
    id          = number
    name        = string
    labels      = optional(map(string))
    description = optional(string)
    sni         = optional(string)
    location    = optional(string)
    project     = optional(string)
    client_certificate = optional(list(object({
      grpc_endpoint = optional(list(object({
        target_uri = string
      })), [])
      certificate_provider_instance = optional(list(object({
        plugin_instance = string
      })), [])
    })), [])
    server_validation_ca = optional(list(object({
      grpc_endpoint = optional(list(object({
        target_uri = string
      })), [])
      certificate_provider_instance = optional(list(object({
        plugin_instance = string
      })), [])
    })), [])
  })))
  default = []
}

variable "gateway_security_policy" {
  type = list(map(object({
    id                       = number
    name                     = string
    description              = optional(string)
    tls_inspection_policy_id = optional(number)
    location                 = optional(string)
    project                  = optional(string)
  })))
  default = []
}

variable "gateway_security_policy_rule" {
  type = list(map(object({
    id                         = number
    basic_profile              = string
    enabled                    = bool
    gateway_security_policy_id = number
    location                   = string
    name                       = string
    priority                   = number
    session_matcher            = string
    description                = optional(string)
    application_matcher        = optional(string)
    tls_inspection_enabled     = optional(bool)
    project                    = optional(string)
  })))
  default = []
}

variable "server_tls_policy" {
  type = list(map(object({
    id          = number
    name        = string
    labels      = optional(map(string))
    description = optional(string)
    allow_open  = optional(bool)
    location    = optional(string)
    project     = optional(string)
    server_certificate = optional(list(object({
      grpc_endpoint = optional(list(object({
        target_uri = string
      })), [])
      certificate_provider_instance = optional(list(object({
        plugin_instance = string
      })), [])
    })), [])
    mtls_policy = optional(list(object({
      client_validation_mode         = optional(string)
      client_validation_trust_config = optional(string)
      server_validation_ca = optional(list(object({
        grpc_endpoint = optional(list(object({
          target_uri = string
        })), [])
        certificate_provider_instance = optional(list(object({
          plugin_instance = string
        })), [])
      })), [])
    })), [])
  })))
  default = []
}

variable "tls_inspection_policy" {
  type = list(map(object({
    id                    = number
    ca_pool               = string
    name                  = string
    description           = optional(string)
    exclude_public_ca_set = optional(bool)
    location              = optional(string)
    project               = optional(string)
  })))
  default = []
}

variable "url_lists" {
  type = list(map(object({
    id          = number
    location    = string
    name        = string
    values      = list(string)
    description = optional(string)
    project     = optional(string)
  })))
  default = []
}

variable "address_group_iam_binding" {
  type = list(map(object({
    id               = number
    project          = string
    address_group_id = number
    members          = list(string)
  })))
  default = []
}

variable "firewall_endpoint" {
  type = list(map(object({
    id       = number
    location = string
    name     = string
    parent   = string
    labels   = optional(map(string))
  })))
  default = []
}

variable "profile" {
  type = list(map(object({
    id          = number
    type        = string
    name        = string
    description = optional(string)
    labels      = optional(map(string))
    location    = optional(string)
    parent      = optional(string)
    threat_prevention_profile = optional(list(object({
      severity_overrides = optional(list(object({
        action   = string
        severity = string
      })), [])
      threat_overrides = optional(list(object({
        action    = string
        threat_id = string
        type      = string
      })), [])
    })), [])
  })))
  default = []
}

variable "profile_group" {
  type = list(map(object({
    id                           = number
    name                         = string
    description                  = optional(string)
    labels                       = optional(map(string))
    threat_prevention_profile_id = optional(number)
    location                     = optional(string)
    parent                       = optional(string)
  })))
  default = []
}