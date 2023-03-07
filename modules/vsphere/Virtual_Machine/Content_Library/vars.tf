variable "publication" {
  type = map(object({
    description = optional(string)
    storage_backing = optional(list(string))
    authentication_method = optional(string)
    published = optional(bool)
  }))
  default = {}
  description = "Options to publish a local content library"
}

variable "subscription" {
  type = map(object({
    description = optional(string)
    storage_backing = optional(list(string))
    subscription_url = optional(string)
    authentication_method = optional(string)
    automatic_sync = optional(bool)
    on_demand = optional(bool)
  }))
  default = {}
  description = "Options to subscribe to a published content library"
}

variable "username" {
  type = string
}

variable "password" {
  type = string
  sensitive = true
}