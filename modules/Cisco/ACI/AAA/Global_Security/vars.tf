variable "global_security" {
  type = map(object({
    annotation                 = optional(string)
    description                = optional(string)
    pwd_strength_check         = optional(string)
    change_count               = optional(string)
    change_during_interval     = optional(string)
    change_interval            = optional(string)
    expiration_warn_time       = optional(string)
    history_count              = optional(string)
    no_change_interval         = optional(string)
    block_duration             = optional(string)
    max_failed_attempts        = optional(string)
    max_failed_attempts_window = optional(string)
    maximum_validity_period    = optional(string)
    session_record_flags       = optional(list(string))
    ui_idle_timeout_seconds    = optional(string)
    webtoken_timeout_seconds   = optional(string)
    relation_aaa_rs_to_user_ep = optional(string)
  }))

  validation {
    condition     = contains(["yes", "no"], var.global_security.pwd_strength_check)
    error_message = "Password Strength Check must be 'yes' or 'no'."
  }

  validation {
    condition     = contains(["enable", "disable"], var.global_security.change_during_interval)
    error_message = "Enforcing password policy value must be 'enable' or 'disable'."
  }

  validation {
    condition     = contains(["login", "logout", "refresh"], var.global_security.session_record_flags)
    error_message = "Allowed values for Session Recording Options are 'login', 'logout' or 'refresh'.'"
  }
}