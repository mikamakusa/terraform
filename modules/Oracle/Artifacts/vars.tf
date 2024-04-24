variable "defined_tags" {
  type    = map(string)
  default = {}
}

variable "freeform_tags" {
  type    = map(string)
  default = {}
}

variable "compartment_id" {
  type        = string
  description = <<EOF
This data source provides details about a specific Compartment resource in Oracle Cloud Infrastructure Identity service.
Gets the specified compartment's information.
EOF
}

variable "container_configuration" {
  type = list(map(object({
    id                                  = number
    is_repository_created_on_first_push = bool
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "container_image_signature" {
  type = list(map(object({
    id                 = number
    image_id           = string
    kms_key_id         = string
    kms_key_version_id = string
    message            = string
    signature          = string
    signing_algorithm  = string
    freeform_tags      = optional(map(string))
    defined_tags       = optional(map(string))
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "container_repository" {
  type = list(map(object({
    id            = number
    display_name  = string
    defined_tags  = optional(map(string))
    freeform_tags = optional(map(string))
    is_immutable  = optional(bool)
    is_public     = optional(bool)
    readme = optional(list(object({
      content = string
      format  = string
    })))
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "generic_artifact" {
  type = list(map(object({
    id            = number
    artifact_id   = string
    defined_tags  = optional(map(string))
    freeform_tags = optional(map(string))
  })))
  default     = []
  description = <<EOF
  EOF
}

variable "repository" {
  type = list(map(object({
    id              = number
    is_immutable    = bool
    repository_type = string
    defined_tags    = optional(map(string))
    freeform_tags   = optional(map(string))
    description     = optional(string)
    display_name    = optional(string)
  })))
  default     = []
  description = <<EOF
  EOF
}
