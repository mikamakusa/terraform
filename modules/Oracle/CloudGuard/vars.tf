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

variable "cloud_guard_configuration" {
  type = list(object({
    id                    = number
    reporting_region      = string
    status                = string
    self_manage_resources = optional(bool)
  }))
  default     = []
  description = <<EOF
  This resource provides the Cloud Guard Configuration resource in Oracle Cloud Infrastructure Cloud Guard service.
  EOF
}

variable "data_mask_rule" {
  type = list(object({
    id                    = number
    data_mask_categories  = list(string)
    display_name          = string
    iam_group_id          = string
    data_mask_rule_status = optional(string)
    defined_tags          = optional(map(string))
    freeform_tags         = optional(map(string))
    description           = optional(string)
    state                 = optional(string)
    target_selected = list(object({
      kind   = string
      values = optional(list(string))
    }))
  }))
  default     = []
  description = <<EOF
  This resource provides the Data Mask Rule resource in Oracle Cloud Infrastructure Cloud Guard service.
  EOF
}

variable "data_source" {
  type = list(object({
    id                        = number
    data_source_feed_provider = string
    display_name              = string
    defined_tags              = optional(map(string))
    freeform_tags             = optional(map(string))
    data_source_details = optional(list(object({
      data_source_feed_provider = string
      additional_entities_count = optional(number)
      interval_in_minutes       = optional(number)
      logging_query_type        = optional(string)
      operator                  = optional(string)
      query                     = optional(string)
      regions                   = optional(list(string))
      threshold                 = optional(number)
      logging_query_details = optional(list(object({
        logging_query_type = string
        key_entities_count = optional(number)
      })), [])
      query_start_time = optional(list(object({
        start_policy_type = string
        query_start_time  = optional(string)
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
  This resource provides the Data Source resource in Oracle Cloud Infrastructure Cloud Guard service.
  EOF
}

variable "detector_recipe" {
  type = list(object({
    id                        = number
    display_name              = string
    defined_tags              = optional(map(string))
    freeform_tags             = optional(map(string))
    description               = optional(string)
    detector                  = optional(string)
    source_detector_recipe_id = optional(string)
    detector_rules = optional(list(object({
      detector_rule_id = string
      details = list(object({
        is_enabled     = bool
        risk_level     = string
        condition      = optional(string)
        data_source_id = optional(string)
        description    = optional(string)
        labels         = optional(list(string))
        recommendation = optional(string)
        configurations = optional(list(object({
          config_key = string
          name       = string
          data_type  = optional(string)
          value      = optional(string)
          values = optional(list(object({
            list_type         = string
            managed_list_type = string
            value             = string
          })), [])
        })), [])
        entities_mappings = optional(list(object({
          query_field  = string
          entity_type  = string
          display_name = optional(string)
        })), [])
      }))
    })), [])
  }))
  default     = []
  description = <<EOF
  This resource provides the Detector Recipe resource in Oracle Cloud Infrastructure Cloud Guard service.
  EOF
}

variable "managed_list" {
  type = list(object({
    id                     = number
    display_name           = string
    defined_tags           = optional(map(string))
    freeform_tags          = optional(map(string))
    description            = optional(string)
    list_items             = optional(list(string))
    list_type              = optional(string)
    source_managed_list_id = optional(string)
  }))
  default     = []
  description = <<EOF
  This resource provides the Managed List resource in Oracle Cloud Infrastructure Cloud Guard service.
  EOF
}

variable "responder_recipe" {
  type = list(object({
    id                         = number
    display_name               = string
    source_responder_recipe_id = number
    defined_tags               = optional(map(string))
    freeform_tags              = optional(map(string))
    description                = optional(string)
    responder_rules = optional(list(object({
      responder_rule_id = string
    })), [])
  }))
  default     = []
  description = <<EOF
  This resource provides the Responder Recipe resource in Oracle Cloud Infrastructure Cloud Guard service.
  EOF
}

variable "security_recipe" {
  type = list(object({
    id                = number
    display_name      = string
    security_policies = list(string)
    defined_tags      = optional(map(string))
    freeform_tags     = optional(map(string))
    description       = optional(string)
  }))
  default     = []
  description = <<EOF
  This resource provides the Security Recipe resource in Oracle Cloud Infrastructure Cloud Guard service.
  EOF
}

variable "security_zone" {
  type = list(object({
    id                      = number
    display_name            = string
    security_zone_recipe_id = string
    defined_tags            = optional(map(string))
    freeform_tags           = optional(map(string))
    description             = optional(string)
  }))
  default     = []
  description = <<EOF
  This resource provides the Security Zone resource in Oracle Cloud Infrastructure Cloud Guard service.
  EOF
}

variable "target" {
  type = list(object({
    id                   = number
    display_name         = string
    target_resource_id   = string
    target_resource_type = string
    defined_tags         = optional(map(string))
    freeform_tags        = optional(map(string))
    description          = optional(string)
    state                = optional(string)
    target_detector_recipes = optional(list(object({
      detector_recipe_id = string
      detector_rules = optional(list(object({
        detector_rule_id = string
        details = optional(list(object({
          condition_groups = optional(list(object({
            compartment_id = string
            condition      = string
          })), [])
        })), [])
      })), [])
    })), [])
    target_responder_recipes = optional(list(object({
      responder_recipe_id = string
      responder_rules = optional(list(object({
        responder_rule_id = string
        details = optional(list(object({
          condition = string
          mode      = optional(string)
          configurations = optional(list(object({
            config_key = string
            name       = string
            value      = string
          })), [])
        })), [])
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
  This resource provides the Target resource in Oracle Cloud Infrastructure Cloud Guard service.
  EOF
}
