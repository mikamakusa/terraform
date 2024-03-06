variable "defined_tags" {
  type    = map(string)
  default = {}
}

variable "freeform_tags" {
  type    = map(string)
  default = {}
}

variable "compartment_id" {
  type = string
  description = <<EOF
This data source provides details about a specific Compartment resource in Oracle Cloud Infrastructure Identity service.
Gets the specified compartment's information.
EOF
}

variable "project_id" {
  type    = string
  default = null
}

variable "model" {
  type = list(map(object({
    id                         = number
    model_type                 = string
    model_id                   = string
    project_id                 = number
    defined_tags               = optional(map(string))
    description                = optional(string)
    display_name               = optional(string)
    freeform_tags              = optional(map(string))
    is_quick_mode              = optional(bool)
    max_training_time_in_hours = optional(number)
    model_version              = optional(string)
    component_models = optional(list(object({
      model_id = optional(string)
    })), [])
    operations = optional(list(object({
      operation = optional(string)
      path      = optional(string)
      value     = optional(string)
    })), [])
    testing_dataset = optional(list(object({
      dataset_type = string
      bucket       = optional(string)
      dataset_id   = optional(string)
      object       = optional(string)
      namespace    = optional(string)
    })), [])
    training_dataset = optional(list(object({
      dataset_type = string
      bucket       = optional(string)
      dataset_id   = optional(string)
      namespace    = optional(string)
      object       = optional(string)
    })), [])
    validation_dataset = optional(list(object({
      dataset_type = string
      bucket       = optional(string)
      dataset_id   = optional(string)
      namespace    = optional(string)
      object       = optional(string)
    })), [])
  })))
  default     = []
  description = <<EOF
This resource provides the Model resource in Oracle Cloud Infrastructure Ai Document service.
Create a new model.
EOF
}

variable "processor_job" {
  type = list(map(object({
    id           = number
    display_name = optional(string)
    input_location = list(object({
      source_type = string
      data        = optional(string)
      object_locations = optional(list(object({
        bucket    = string
        namespace = string
        object    = string
      })), [])
    }))
    output_location = list(object({
      bucket    = string
      namespace = string
      prefix    = string
    }))
    processor_config = list(object({
      processor_type        = string
      document_type         = optional(string)
      is_zip_output_enabled = optional(bool)
      language              = optional(string)
      features = list(object({
        feature_type            = string
        generate_searchable_pdf = optional(bool)
        max_results             = optional(number)
        model_id                = optional(string)
        tenancy_id              = optional(string)
      }))
    }))
  })))
  default     = []
  description = <<EOF
This resource provides the Processor Job resource in Oracle Cloud Infrastructure Ai Document service.
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
This resource provides the Project resource in Oracle Cloud Infrastructure Ai Document service.
EOF
}