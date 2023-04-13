variable "encryption_config" {
  type = list(object({
    type   = string
    key_id = optional(string)
  }))

  default = []

  description = "Creates and manages an AWS XRay Encryption Config."
}

variable "xray_group" {
  type = map(object({
    filter_expression = string
    insight_configuration = optional(list(object({
      insights_enabled      = optional(bool)
      notifications_enabled = optional(bool)
    })))
    tags = optional(map(string))
  }))

  default = {}

  description = "Creates and manages an AWS XRay Group."
}


variable "sampling_rule" {
  type = map(object({
    priority       = number
    version        = number
    reservoir_size = number
    fixed_rate     = number
    url_path       = string
    host           = string
    http_method    = string
    service_type   = string
    service_name   = string
    resource_arn   = string
    attirbutes     = optional(map(string))
    tags           = optional(map(string))
  }))

  default = {}

  description = "Creates and manages an AWS XRay Sampling Rule."
}