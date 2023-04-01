variable "ldap_provider" {
  type        = any
  description = "Manages ACI LDAP Provider"

  validation {
    condition     = lookup(var.ldap_provider, "ssl_validation_level", null) == null ? "strict" : contains(["strict", "permissive"], var.ldap_provider["ssl_validation_level"])
    error_message = "Allowed values are ''strict' or 'permissive'."
  }

  validation {
    condition     = lookup(var.ldap_provider, "enable_ssl", null) == null ? "no" : contains(["yes", "no"], var.ldap_provider["enable_ssl"])
    error_message = "Allowed values are 'yes' or 'no'."
  }

  validation {
    condition     = lookup(var.ldap_provider, "monitor_server", null) == null ? "disabled" : contains(["disabled", "enabled"], var.ldap_provider["monitor_server"])
    error_message = "Allowed values are 'disabled' or 'enabled'."
  }
}