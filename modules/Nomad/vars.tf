variable "nomad_plugin" {
  type    = string
  default = null
}

variable "acl_auth_method" {
  type = list(object({
    id             = number
    max_token_ttl  = string
    name           = string
    token_locality = string
    type           = string
    default        = optional(bool)
    config = optional(list(object({
      allowed_redirect_uris = list(string)
      oidc_client_id        = string
      oidc_client_secret    = string
      oidc_discovery_url    = string
      oidc_scopes           = optional(list(string))
      bound_audiences       = optional(list(string))
      signing_algs          = optional(list(string))
      discovery_ca_pem      = optional(list(string))
      claim_mappings        = optional(map(string))
      list_claim_mappings   = optional(map(string))
    })), [])
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "acl_binding_rule" {
  type = list(object({
    id             = number
    auth_method_id = number
    bind_type      = string
    description    = optional(string)
    selector       = optional(string)
    bind_name      = optional(string)
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "acl_policy" {
  type = list(object({
    id          = number
    name        = string
    rules_hcl   = string
    description = optional(string)
    job_acl = optional(list(object({
      job_id       = number
      namespace_id = optional(number)
      group        = optional(string)
      task         = optional(string)
    })), [])
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "acl_role" {
  type = list(object({
    id          = number
    name        = string
    description = optional(string)
    policy = list(object({
      policy_id = number
    }))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "acl_token" {
  type = list(object({
    id             = number
    type           = string
    name           = optional(string)
    policies       = optional(list(string))
    global         = optional(bool)
    expiration_ttl = optional(string)
    role = optional(list(object({
      id = number
    })))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "csi_volume" {
  type = list(object({
    id           = number
    name         = string
    volume_id    = string
    namespace_id = optional(number)
    snapshot_id  = optional(string)
    clone_id     = optional(string)
    capacity_min = optional(string)
    capacity_max = optional(string)
    secrets      = optional(map(string))
    parameters   = optional(map(string))
    capability = optional(list(object({
      access_mode     = string
      attachment_mode = string
    })), [])
    mount_options = optional(list(object({
      fs_type     = optional(string)
      mount_flags = optional(list(string))
    })), [])
    topology_request = optional(list(object({
      required = optional(list(object({
        topology = optional(list(object({
          segments = map(string)
        })), [])
      })), [])
      preferred = optional(list(object({
        topology = optional(list(object({
          segments = map(string)
        })), [])
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "csi_volume_registration" {
  type = list(object({
    id                    = number
    external_id           = string
    name                  = string
    volume_id             = number
    namespace_id          = optional(number)
    capacity_min          = optional(string)
    capacity_max          = optional(string)
    secrets               = optional(map(string))
    parameters            = optional(map(string))
    context               = optional(map(string))
    deregister_on_destroy = optional(bool)
    capability = optional(list(object({
      access_mode     = string
      attachment_mode = string
    })), [])
    mount_options = optional(list(object({
      fs_type     = optional(string)
      mount_flags = optional(list(string))
    })), [])
    topology_request = optional(list(object({
      required = optional(list(object({
        topology = optional(list(object({
          segments = map(string)
        })), [])
      })), [])
      preferred = optional(list(object({
        topology = optional(list(object({
          segments = map(string)
        })), [])
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "external_volume" {
  type = list(object({
    id           = number
    name         = string
    volume_id    = number
    namespace_id = optional(number)
    snapshot_id  = optional(string)
    clone_id     = optional(string)
    capacity_min = optional(string)
    capacity_max = optional(string)
    secrets      = optional(map(string))
    parameters   = optional(map(string))
    capability = optional(list(object({
      access_mode     = string
      attachment_mode = string
    })), [])
    mount_options = optional(list(object({
      fs_type     = optional(string)
      mount_flags = optional(list(string))
    })), [])
    topology_request = optional(list(object({
      required = optional(list(object({
        topology = optional(list(object({
          segments = map(string)
        })), [])
      })), [])
      preferred = optional(list(object({
        topology = optional(list(object({
          segments = map(string)
        })), [])
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "job" {
  type = list(object({
    id                      = number
    jobspec                 = string
    consul_token            = optional(string)
    deregister_on_destroy   = optional(bool)
    deregister_on_id_change = optional(bool)
    detach                  = optional(bool)
    hcl1                    = optional(bool)
    json                    = optional(bool)
    policy_override         = optional(bool)
    purge_on_destroy        = optional(bool)
    vault_token             = optional(string)
    hcl2 = optional(list(object({
      allow_fs = optional(bool)
      vars     = optional(map(string))
    })))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "namespace" {
  type = list(object({
    id          = number
    name        = string
    description = optional(string)
    quota_id    = optional(number)
    meta        = optional(map(string))
    capabilities = optional(list(object({
      enabled_task_drivers  = optional(list(string))
      disabled_task_drivers = optional(list(string))
    })), [])
    node_pool_config = optional(list(object({
      default = optional(string)
      allowed = optional(list(string))
      denied  = optional(list(string))
    })), [])
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "node_pool" {
  type = list(object({
    id          = number
    name        = string
    description = optional(string)
    meta        = optional(map(string))
    scheduler_config = optional(list(object({
      scheduler_algorithm     = optional(string)
      memory_oversubscription = optional(string)
    })), [])
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "quota_specification" {
  type = list(object({
    id          = number
    name        = string
    description = optional(string)
    limits = list(object({
      region = string
      region_limit = list(object({
        cpu       = optional(number)
        memory_mb = optional(number)
      }))
    }))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "scheduler_config" {
  type = list(object({
    id = number
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "sentinel_policy" {
  type = list(object({
    id                = number
    enforcement_level = string
    name              = string
    policy            = string
    scope             = string
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "variable" {
  type = list(object({
    id    = number
    items = map(string)
    path  = string
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "volume" {
  type = list(object({
    id          = number
    external_id = string
    name        = string
    plugin_id   = string
    volume_id   = string
  }))
  default     = []
  description = <<EOF
  EOF
}
