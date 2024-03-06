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

variable "project_id" {
  type    = string
  default = null
}

variable "model_id" {
  type    = string
  default = null
}

variable "endpoint" {
  type = list(map(object({
    id              = number
    model_id        = number
    defined_tags    = optional(map(string))
    description     = optional(string)
    display_name    = optional(string)
    freeform_tags   = optional(map(string))
    inference_units = optional(number)
  })))
  default     = []
  description = <<EOF
This resource provides the Endpoint resource in Oracle Cloud Infrastructure Ai Language service.
EOF
}

variable "model" {
  type = list(map(object({
    id            = number
    project_id    = number
    defined_tags  = optional(map(string))
    display_name  = optional(string)
    freeform_tags = optional(map(string))
    id            = optional(string)
    model_details = list(object({
      model_type    = string
      language_code = optional(string)
      version       = optional(string)
      classification_mode = optional(list(object({
        classification_mode = optional(string)
        version             = optional(string)
      })), [])
    }))
    test_strategy = optional(list(object({
      strategy_type = string
      testing_dataset = optional(list(object({
        dataset_type = string
        dataset_id   = optional(string)
        location_details = optional(list(object({
          bucket        = string
          location_type = string
          namespace     = string
          object_names  = list(string)
        })), [])
      })), [])
      validation_dataset = optional(list(object({
        dataset_type = string
        dataset_id   = optional(string)
        location_details = optional(list(object({
          bucket        = string
          location_type = string
          namespace     = string
          object_names  = list(string)
        })), [])
      })), [])
    })), [])
    training_dataset = optional(list(object({
      dataset_type = string
      dataset_id   = optional(string)
      location_details = optional(list(object({
        bucket        = string
        location_type = string
        namespace     = string
        object_names  = list(string)
      })), [])
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Model resource in Oracle Cloud Infrastructure Ai Language service.
Creates a new model for training and train the model with date provided.
EOF
}

variable "project" {
  type = list(map(object({
    id            = number
    defined_tags  = optional(map(string))
    description   = optional(string)
    display_name  = optional(string)
    freeform_tags = optional(map(string))
  })))
  default     = []
  description = <<EOF
This resource provides the Project resource in Oracle Cloud Infrastructure Ai Language service.
EOF
}