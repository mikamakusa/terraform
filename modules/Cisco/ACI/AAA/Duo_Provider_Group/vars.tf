variable "duo_provider_group" {
  type = map(object({
    annotation           = optional(string)
    auth_choice          = optional(string)
    provider_type        = optional(string)
    ldap_group_map_ref   = optional(string)
    sec_fac_auth_methods = optional(list(string))
    name_alias           = optional(string)
    description          = optional(string)
  }))

  validation {
    condition     = contains(["CiscoAVPair", "LdapGroupMap"], var.duo_provider_group.auth_choice)
    error_message = "Auth Choice must be one of 'CiscoAVPair' or 'LdapGroupMap'."
  }

  validation {
    condition     = contains(["ldap", "radius"], var.duo_provider_group.provider_type)
    error_message = "Provider Type must be one of 'ldap' or 'radius'."
  }

  validation {
    condition = contains(["auto","passcode","phone","push"], var.duo_provider_group.sec_fac_auth_methods)
    error_message = "Second factor authentication methods values allowed are 'auto', 'passcode', 'phone' and 'push'."
  }
}