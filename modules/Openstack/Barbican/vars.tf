variable "project_name" {
  type = string
}

variable "metadata" {
  type    = map(string)
  default = {}
}

variable "container_v1" {
  type = list(object({
    id   = number
    type = string
    name = optional(string)
    secret_refs = optional(list(object({
      secret_id = number
      name      = optional(string)
    })), [])
    acl = optional(list(object({
      read = optional(list(object({
        project_access = optional(bool)
        users          = optional(list(string))
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "order_v1" {
  type = list(object({
    id   = number
    type = string
    meta = list(object({
      algorithm            = string
      bit_length           = number
      expiration           = optional(string)
      mode                 = optional(string)
      payload_content_type = optional(string)
    }))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "secret_v1" {
  type = list(object({
    id                       = number
    name                     = optional(string)
    bit_length               = optional(number)
    algorithm                = optional(string)
    mode                     = optional(string)
    secret_type              = optional(string)
    payload                  = optional(string)
    payload_content_encoding = optional(string)
    payload_content_type     = optional(string)
    expiration               = optional(string)
    metadata                 = optional(map(string))
    acl = optional(list(object({
      read = optional(list(object({
        project_access = optional(bool)
        users          = optional(list(string))
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
  EOF
}
