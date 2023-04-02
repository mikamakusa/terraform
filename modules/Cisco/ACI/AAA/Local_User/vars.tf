variable "local_user" {
  type = map(object({
    account_status      = optional(string)
    annotation          = optional(string)
    cert_attribute      = optional(string)
    clear_pwd_history   = optional(string)
    description         = optional(string)
    email               = optional(string)
    expiration          = optional(string)
    expires             = optional(string)
    first_name          = optional(string)
    last_name           = optional(string)
    name_alias          = optional(string)
    otpenable           = optional(string)
    otpkey              = optional(string)
    phone               = optional(string)
    pwd                 = optional(string)
    pwd_life_time       = optional(string)
    pwd_update_required = optional(string)
    rbac_string         = optional(string)
  }))
  description = "Manages ACI Local User"

  validation {
    condition     = contains(["active", "inactive"], var.local_user.account_status)
    error_message = "Allowed value for account_status : 'active' or 'inactive'."
  }

  validation {
    condition     = contains(["yes", "no"], var.local_user.clear_pwd_history)
    error_message = "Allowed values for clear_pwd_status : 'yes' or 'no'."
  }

  validation {
    condition     = contains(["yes", "no"], var.local_user.expires)
    error_message = "Allowed values for expires : 'yes' or 'no'."
  }

  validation {
    condition     = contains(["yes", "no"], var.local_user.otpenable)
    error_message = "Allowed values for otpenable: 'yes' or 'no'."
  }

  validation {
    condition     = contains(["yes", "no"], var.local_user.pwd_update_required)
    error_message = "Allowed values for pwd_update_required : 'yes' or 'no'."
  }

  validation {
    condition     = var.local_user.pwd_life_time >= 1 && var.local_user.pwd_life_time <= 3650
    error_message = "Allowed values for pwd_life_time are in a range 1 to 3650."
  }
}