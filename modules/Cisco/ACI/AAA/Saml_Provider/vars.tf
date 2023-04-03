variable "saml_provider" {
  type = map(object({
    name_alias                      = optional(string)
    description                     = optional(string)
    annotation                      = optional(string)
    entity_id                       = optional(string)
    gui_banner_message              = optional(string)
    https_proxy                     = optional(string)
    id_p                            = optional(string)
    key                             = optional(string)
    metadata_url                    = optional(string)
    monitor_server                  = optional(string)
    monitoring_user                 = optional(string)
    monitoring_password             = optional(string)
    retries                         = optional(string)
    sig_alg                         = optional(string)
    timeout                         = optional(string)
    tp                              = optional(string)
    want_assertions_encrypted       = optional(string)
    want_assertions_signed          = optional(string)
    want_requests_signed            = optional(string)
    want_response_signed            = optional(string)
    relation_aaa_rs_prov_to_epp     = optional(string)
    relation_aaa_rs_sec_prov_to_epg = optional(string)
  }))

  validation {
    condition     = contains(["adfs", "okta", "ping identity"], var.saml_provider.id_p)
    error_message = "Allowed values for id_p | identity provider | are 'adfs', 'okta' or 'ping identity'."
  }

  validation {
    condition     = contains(["disabled", "enabled"], var.saml_provider.monitor_server)
    error_message = "Allowed values for monitor_server are : 'enabled' or 'disabled'."
  }

  validation {
    condition     = contains(["SIG_RSA_SHA1", "SIG_RSA_SHA224", "SIG_RSA_SHA256", "SIG_RSA_SHA384", "SIG_RSA_SHA512"], var.saml_provider.sig_alg)
    error_message = "Allowed values for signature algorithm are 'SIG_RSA_SHA1', 'SIG_RSA_SHA224', 'SIG_RSA_SHA256', 'SIG_RSA_SHA384', 'SIG_RSA_SHA512'."
  }

  validation {
    condition     = contains(["no", "yes"], var.saml_provider.want_assertions_encrypted)
    error_message = "Want Encrypted SAML Assertions. Allowed values are 'no' and 'yes'."
  }

  validation {
    condition     = contains(["no", "yes"], var.saml_provider.want_assertions_signed)
    error_message = "Want Assertions in SAML Response Signed. Allowed values are 'no' and 'yes'."
  }

  validation {
    condition     = contains(["no", "yes"], var.saml_provider.want_response_signed)
    error_message = "Want SAML Auth Requests Signed. Allowed values are 'no' and 'yes'."
  }

  validation {
    condition     = contains(["no", "yes"], var.saml_provider.want_requests_signed)
    error_message = "Want SAML Response Message Signed. Allowed values are 'no' and 'yes'."
  }

  validation {
    condition     = var.saml_provider.retries >= 1 && var.saml_provider.retries <= 5
    error_message = "Allowed range is '1' to '5'."
  }

  validation {
    condition     = var.saml_provider.timeout >= 5 && var.saml_provider.timeout <= 60
    error_message = "The amount of time between authentication attempts. Allowed range is '5'-'60'."
  }
}