variable "resource_group_name" {
  type    = string
  default = null
}

variable "resource_instance_name" {
  type    = string
  default = null
}

variable "resource_group" {
  type = list(map(object({
    id   = number
    name = string
    tags = optional(list(s))
  })))
  default = []
}

variable "resource_instance" {
  type = list(map(object({
    id                = number
    location          = string
    name              = string
    plan              = string
    service           = string
    parameters        = optional(map(string))
    parameters_json   = optional(string)
    resource_group_id = optional(any)
    tags              = optional(list(string))
    service_endpoints = optional(string)
  })))
  default = []
}

variable "resource_key" {
  type = list(map(object({
    id                   = number
    name                 = string
    parameters           = optional(map(string))
    role                 = optional(string)
    resource_instance_id = any
    resource_alias_id    = optional(string)
    tags                 = optional(list(string))
  })))
  default = []
}