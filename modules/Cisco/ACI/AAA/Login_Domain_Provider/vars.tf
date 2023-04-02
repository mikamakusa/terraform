variable "login_domain_provider" {
  type = any

  validation {
    condition     = lookup(var.login_domain_provider[count.index], "type") >= 0 && lookup(var.login_domain_provider[count.index], "type") <= 16
    error_message = "Allowed value for type must be in a range between 0 and 16."
  }
}