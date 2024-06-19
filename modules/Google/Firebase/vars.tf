variable "project_name" {
  type     = string
  nullable = true
}

variable "time_sleep" {
  type = string
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "apikeys_key" {
  type = list(object({
    id           = number
    name         = string
    display_name = optional(string)
    restrictions = optional(list(object({
      android_key_restrictions = list(object({
        allowed_applications = list(object({
          sha1_fingerprint = string
          package_name     = string
        }))
      }))
      api_targets = optional(list(object({
        service = string
        methods = optional(list(string))
      })))
      browser_key_restrictions = optional(list(object({
        allowed_referrers = list(string)
      })))
      ios_key_restrictions = optional(list(object({
        allowed_bundle_ids = list(string)
      })))
      server_key_restrictions = optional(list(object({
        allowed_ips = list(string)
      })))
    })))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "android_app" {
  type = list(object({
    id              = number
    display_name    = string
    package_name    = string
    sha1_hashes     = optional(list(string))
    sha256_hashes   = optional(list(string))
    api_key_id      = optional(number)
    project         = optional(string)
    deletion_policy = optional(string)
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "apple_app" {
  type = list(object({
    id              = number
    bundle_id       = string
    display_name    = string
    app_store_id    = optional(string)
    api_key_id      = optional(number)
    team_id         = optional(string)
    deletion_policy = optional(string)
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "web_app" {
  type = list(object({
    id              = number
    display_name    = string
    api_key_id      = optional(number)
    deletion_policy = optional(string)
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "app_check_app_attest_config" {
  type = list(object({
    id        = number
    app_id    = number
    token_ttl = optional(string)
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "app_check_debug_token" {
  type = list(object({
    id           = number
    app_id       = number
    display_name = string
    token        = string
  }))
  default     = []
  description = <<EOF
    EOF
}
variable "app_check_device_check_config" {
  type = list(object({
    id          = number
    key_id      = string
    app_id      = number
    private_key = string
    token_ttl   = optional(string)
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "app_check_play_integrity_config" {
  type = list(object({
    id        = number
    app_id    = number
    token_ttl = optional(string)
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "app_check_recaptcha_enterprise_config" {
  type = list(object({
    id        = number
    app_id    = number
    site_key  = string
    token_ttl = optional(string)
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "app_check_recaptcha_v3_config" {
  type = list(object({
    id          = number
    site_secret = string
    app_id      = number
    token_ttl   = optional(string)
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "app_check_service_config" {
  type = list(object({
    id               = number
    service_id       = string
    enforcement_mode = optional(string)
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "extensions_instance" {
  type = list(object({
    id          = number
    instance_id = string
    config = list(object({
      extension_ref       = string
      params              = map(string)
      system_params       = optional(map(string))
      allowed_event_types = optional(list(string))
      eventarc_channel    = optional(string)
      extension_version   = optional(string)
    }))
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "database_instance" {
  type = list(object({
    id            = number
    instance_id   = string
    region        = string
    type          = optional(string)
    desired_state = optional(string)
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "hosting_channel" {
  type = list(object({
    id                     = number
    channel_id             = string
    site_id                = number
    retained_release_count = optional(number)
    labels                 = optional(map(string))
    expire_time            = optional(string)
    ttl                    = optional(string)
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "hosting_custom_domain" {
  type = list(object({
    id                    = number
    custom_domain         = string
    site_id               = number
    cert_preference       = optional(string)
    redirect_target       = optional(string)
    wait_dns_verification = optional(bool)
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "hosting_release" {
  type = list(object({
    id         = number
    site_id    = number
    type       = optional(string)
    message    = optional(string)
    channel_id = optional(number)
    version_id = optional(number)
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "hosting_site" {
  type = list(object({
    id      = number
    app_id  = optional(number)
    site_id = optional(string)
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "hosting_version" {
  type = list(object({
    id      = number
    site_id = number
    config = list(object({
      redirects = optional(list(object({
        location    = string
        status_code = string
        glob        = optional(string)
        regex       = optional(string)
      })), [])
      rewrites = optional(list(object({
        glob     = optional(string)
        regex    = optional(string)
        path     = optional(string)
        function = optional(string)
        run = optional(list(object({
          service_id = string
          region     = optional(string)
        })), [])
      })), [])
    }))
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "storage_bucket" {
  type = list(object({
    id       = number
    name     = string
    location = string
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "firebase_storage_bucket" {
  type = list(object({
    id        = number
    bucket_id = number
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "firebaserules_release" {
  type = list(object({
    id         = number
    name       = string
    ruleset_id = number
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "firebaserules_ruleset" {
  type = list(object({
    id = number
    source = list(object({
      language = optional(string)
      files = list(object({
        name        = string
        content     = string
        fingerprint = optional(string)
      }))
    }))
  }))
  default     = []
  description = <<EOF
    EOF
}