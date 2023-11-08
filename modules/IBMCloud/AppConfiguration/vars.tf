variable "environment_id" {
  type = object({
    environment = string
    guid        = string
  })
  default = null
}

variable "collection_id" {
  type = object({
    collection = string
    guid       = string
  })
  default = null
}

variable "collection" {
  type = list(map(object({
    id            = number
    collection_id = string
    guid          = string
    name          = string
    description   = optional(string)
    tags          = optional(string)
  })))
  default = []
}

variable "environment" {
  type = list(map(object({
    id             = number
    environment_id = string
    guid           = string
    name           = string
    description    = optional(string)
    tags           = optional(string)
    color_code     = optional(string)
  })))
  default = []
}

variable "feature" {
  type = list(map(object({
    id                 = number
    disabled_value     = string
    enabled_value      = string
    environment_id     = any
    feature_id         = string
    guid               = string
    name               = string
    type               = string
    description        = optional(string)
    tags               = optional(string)
    rollout_percentage = optional(number)
    segment_rules = optional(list(object({
      order              = number
      value              = string
      rollout_percentage = optional(number)
      rules = optional(list(object({
        segments = list(string)
      })), [])
    })), [])
    collections = optional(list(object({
      collection_id = any
    })), [])
  })))
  default = []
}

variable "property" {
  type = list(map(object({
    id             = number
    environment_id = any
    guid           = string
    name           = string
    property_id    = string
    type           = string
    value          = string
    description    = optional(string)
    tags           = optional(string)
    format         = optional(string)
    segment_rules = optional(list(object({
      order              = number
      value              = string
      rollout_percentage = optional(number)
      rules = optional(list(object({
        segments = list(string)
      })), [])
    })), [])
    collections = optional(list(object({
      collection_id = any
    })), [])
  })))
  default = []
}

variable "segment" {
  type = list(map(object({
    id          = number
    guid        = string
    name        = string
    segment_id  = string
    description = optional(string)
    tags        = optional(string)
    rules = optional(list(object({
      attribute_name = string
      operator       = string
      values         = list(string)
    })), [])
  })))
  default = []
}

variable "snapshot" {
  type = list(map(object({
    id              = number
    collection_id   = any
    environment_id  = any
    git_branch      = string
    git_config_id   = string
    git_config_name = string
    git_file_path   = string
    git_token       = string
    git_url         = string
    guid            = string
  })))
  default = []
}