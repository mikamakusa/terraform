variable "resource_group" {
  type = any
}

variable "virtual_network" {
  type = any
}

variable "subnet" {
  type = any
}

variable "security_group" {
  type = map(object({
    location            = string
    resource_group_name = string
    security_rule = optional(map(object({
      priority                   = optional(string)
      direction                  = optional(string)
      access                     = optional(string)
      protocol                   = optional(string)
      source_port_range          = optional(string)
      destination_port_range     = optional(string)
      source_address_prefix      = optional(string)
      destination_address_prefix = optional(string)
    })))
  }))
}

variable "security_group_association" {
  type = any
}

variable "ad_group" {
  type = any
}

variable "ad_user" {
  type = any
}

variable "group_member" {
  type = any
}

variable "ad_domain_services" {
  type = any
}

variable "application" {
  type = string
}

variable "secure_ldap" {}