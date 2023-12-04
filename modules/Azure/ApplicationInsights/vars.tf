variable "tags" {
  type = map(string)
  default = {}
}

variable "resource_group_name" {
  type = string
}

variable "application_insights" {
  type = list(map(object({
    id                                    = number
    name                                  = string
    application_type                      = string
    daily_data_cap_in_gb                  = optional(number)
    daily_data_cap_notifications_disabled = optional(bool)
    retention_in_days                     = optional(number)
    sampling_percentage                   = optional(number)
    disable_ip_masking                    = optional(bool)
    tags                                  = optional(map(string))
    workspace_id                          = optional(string)
  })))
  default = []
}

variable "analytics_item" {
  type = list(map(object({
    id                      = number
    application_insights_id = any
    content                 = string
    name                    = string
    scope                   = string
    type                    = string
    function_alias          = optional(string)
  })))
  default = []
}

variable "api_key" {
  type = list(map(object({
    id                      = number
    application_insights_id = any
    name                    = string
    read_permissions        = optional(list(string))
    write_permissions       = optional(list(string))
  })))
  default = []
}

variable "smart_detection_rule" {
  type = list(map(object({
    id                                 = number
    application_insights_id            = any
    name                               = string
    enabled                            = optional(bool)
    send_emails_to_subscription_owners = optional(bool)
    additional_email_recipients        = optional(list(string))
  })))
  default = []
}

variable "standard_web_test" {
  type = list(map(object({
    id                      = number
    application_insights_id = any
    geo_locations           = list(string)
    name                    = string
    description             = optional(string)
    enabled                 = optional(bool)
    frequency               = optional(number)
    retry_enabled           = optional(bool)
    tags                    = optional(map(string))
    timeout                 = optional(number)
    request = optional(list(object({
      url                              = optional(string)
      body                             = optional(string)
      follow_redirects_enabled         = optional(bool)
      http_verb                        = optional(string)
      parse_dependent_requests_enabled = optional(bool)
      header = optional(list(object({
        name  = string
        value = string
      })), [])
    })), [])
    validation_rules = optional(list(object({
      expected_status_code        = optional(number)
      ssl_check_enabled           = optional(bool)
      ssl_cert_remaining_lifetime = optional(number)
      content = optional(list(object({
        content_match      = optional(string)
        ignore_case        = optional(bool)
        pass_if_text_found = optional(bool)
      })), [])
    })), [])
  })))
  default = []
}

variable "web_test" {
  type = list(map(object({
    id                      = number
    application_insights_id = any
    configuration           = string
    geo_locations           = list(string)
    kind                    = string
    name                    = string
    frequency               = optional(number)
    timeout                 = optional(number)
    enabled                 = optional(bool)
    retry_enabled           = optional(number)
    description             = optional(string)
    tags                    = optional(map(string))
  })))
  default = []
}

variable "workbook" {
  type = list(map(object({
    id                   = number
    data_json            = string
    display_name         = string
    name                 = string
    source_id            = optional(string)
    category             = optional(string)
    description          = optional(string)
    storage_container_id = optional(string)
    tags                 = optional(map(string))
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    })), [])
  })))
  default = []
}

variable "workbook_template" {
  type = list(map(object({
    id            = number
    name          = string
    template_data = string
    author        = optional(string)
    localized     = optional(string)
    priority      = optional(number)
    tags          = optional(map(string))
    galleries = optional(list(object({
      category      = string
      name          = string
      order         = optional(number)
      resource_type = optional(string)
      type          = optional(string)
    })), [])
  })))
  default = []
}