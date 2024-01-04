variable "resource_group" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "cognitive_account_name" {
  type    = string
  default = null
}

variable "cognitive_account" {
  type = list(map(object({
    id       = number
    kind     = string
    name     = string
    sku_name = string
  })))
  default = []
}

variable "alexa" {
  type = list(map(object({
    id              = number
    registration_id = number
    skill_id        = string
  })))
  default = []
}

variable "direct_line_speech" {
  type = list(map(object({
    id                         = number
    registration_id            = number
    cognitive_account_id       = optional(number)
    custom_speech_model_id     = optional(string)
    custom_voice_deployment_id = optional(string)
  })))
  default = []
}

variable "directline" {
  type = list(map(object({
    id              = number
    registration_id = number
  })))
  default = []
}

variable "email" {
  type = list(map(object({
    id              = number
    registration_id = number
    email_address   = string
    email_password  = string
  })))
  default = []
}

variable "facebook" {
  type = list(map(object({
    id                          = number
    registration_id             = number
    facebook_application_id     = string
    facebook_application_secret = string
  })))
  default = []
}

variable "channel_line" {
  type = list(map(object({
    id              = number
    registration_id = number
    line_channel = list(object({
      access_token = string
      secret       = string
    }))
  })))
  default = []
}

variable "ms_teams" {
  type = list(map(object({
    id                     = number
    registration_id        = number
    calling_web_hook       = optional(string)
    deployment_environment = optional(string)
    enable_calling         = optional(bool)
  })))
  default = []
}

variable "slack" {
  type = list(map(object({
    id                 = number
    registration_id    = number
    client_id          = string
    client_secret      = string
    verification_token = string
    landing_page_url   = optional(string)
    signing_secret     = optional(string)
  })))
  default = []
}

variable "sms" {
  type = list(map(object({
    id                              = number
    registration_id                 = number
    phone_number                    = string
    sms_channel_account_security_id = string
    sms_channel_auth_token          = string
  })))
  default = []
}

variable "web_chat" {
  type = list(map(object({
    id              = number
    registration_id = number
    site = optional(list(object({
      name                        = string
      user_upload_enabled         = optional(bool)
      endpoint_parameters_enabled = optional(bool)
      storage_enabled             = optional(bool)
    })))
  })))
  default = []
}

variable "registration" {
  type = list(map(object({
    id                = number
    location          = optional(string)
    microsoft_app_id  = string
    name              = string
    sku               = string
    cmk_key_vault_url = optional(string)
  })))
  default = []
}

variable "bot_connection" {
  type = list(map(object({
    id                    = number
    registration_id       = number
    client_id             = string
    client_secret         = string
    name                  = string
    service_provider_name = string
    scopes                = optional(string)
    parameters            = optional(map(string))
  })))
  default = []
}

variable "azure_bot" {
  type = list(map(object({
    id                                    = number
    location                              = optional(string)
    microsoft_app_id                      = string
    name                                  = string
    sku                                   = string
    developer_app_insights_api_key        = optional(string)
    developer_app_insights_application_id = optional(string)
    developer_app_insights_key            = optional(string)
    display_name                          = optional(string)
    endpoint                              = optional(string)
    icon_url                              = optional(string)
    microsoft_app_msi_id                  = optional(string)
    microsoft_app_tenant_id               = optional(string)
    microsoft_app_type                    = optional(string)
    local_authentication_enabled          = optional(bool)
    luis_app_ids                          = optional(list(string))
    luis_key                              = optional(string)
    streaming_endpoint_enabled            = optional(bool)
    tags                                  = optional(map(string))
  })))
  default = []
}

variable "web_app" {
  type = list(map(object({
    id                                    = number
    microsoft_app_id                      = string
    name                                  = string
    resource_group_name                   = string
    sku                                   = string
    display_name                          = optional(string)
    endpoint                              = optional(string)
    developer_app_insights_api_key        = optional(string)
    developer_app_insights_application_id = optional(string)
    developer_app_insights_key            = optional(string)
    luis_app_ids                          = optional(list(string))
    luis_key                              = optional(string)
    tags                                  = optional(map(string))
  })))
  default = []
}