variable "console_authentication" {
  type = object({
    annotation     = string
    provider_group = string
    realm          = string
    realm_sub_type = string
    name_alias     = string
    description    = string
  })

  validation {
    condition     = contains(["ldap", "local", "radius", "rsa", "saml", "tacacs"], var.console_authentication.realm)
    error_message = "Realm value must be one of 'ldap', 'local', 'radius', 'rsa', 'saml' or 'tacacs'."
  }

  validation {
    condition     = contains(["default", "duo"], var.console_authentication.realm_sub_type)
    error_message = "Allowed value for Realm Sub Type must be 'default' or 'duo'."
  }
}