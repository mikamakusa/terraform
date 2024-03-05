variable "defined_tags" {
  type        = map(string)
  default     = {}
  description = "Defined tags"
}

variable "freeform_tags" {
  type        = map(string)
  default     = {}
  description = "Freeform tags"
}

variable "compartment_id" {
  type        = string
  description = "Compartment id - mandatory - to be used as data source"
}

variable "subnet_id" {
  type = string
}

variable "knowledge_base" {
  type = list(map(object({
    id            = number
    defined_tags  = optional(map(string))
    display_name  = optional(string)
    freeform_tags = optional(map(string))
  })))
  default     = []
  description = <<EOF
This resource provides the Knowledge Base resource in Oracle Cloud Infrastructure Adm service.
EOF
}

variable "remediation_recipe" {
  type = list(map(object({
    id                            = number
    is_run_triggered_on_kb_change = bool
    knowledge_base_id             = number
    display_name                  = optional(string)
    defined_tags                  = optional(map(string))
    freeform_tags                 = optional(map(string))
    detect_configuration = list(object({
      exclusions                   = optional(list(string))
      max_permissible_cvss_v2score = optional(number)
      max_permissible_cvss_v3score = optional(number)
      upgrade_policy               = optional(string)
      max_permissible_severity     = optional(number)
    }))
    network_configuration = list(object({
      subnet_id = string
      nsg_ids   = optional(list(string))
    }))
    scm_configuration = list(object({
      branch                 = string
      is_automerge_enabled   = bool
      scm_type               = string
      build_file_location    = optional(string)
      oci_code_repository_id = optional(string)
      pat_secret_id          = optional(string)
      repository_url         = optional(string)
      username               = optional(string)
    }))
    verify_configuration = list(object({
      build_service_type    = string
      additional_parameters = optional(map(string))
      jenkins_url           = optional(string)
      job_name              = optional(string)
      pat_secret_id         = optional(string)
      pipeline_id           = optional(string)
      repository_url        = optional(string)
      trigger_secret_id     = optional(string)
      username              = optional(string)
      workflow_name         = optional(string)
    }))
  })))
  default = []
  description = <<EOF
This resource provides the Remediation Recipe resource in Oracle Cloud Infrastructure Adm service.
EOF
}

variable "remediation_run" {
  type = list(map(object({
    id                    = number
    remediation_recipe_id = number
    defined_tags          = optional(map(string))
    freeform_tags         = optional(map(string))
    display_name          = optional(string)
  })))
  default = []
  description = <<EOF
This resource provides the Remediation Run resource in Oracle Cloud Infrastructure Adm service.
EOF
}

variable "vulnerability_audit" {
  type = list(map(object({
    id                = number
    build_type        = string
    knowledge_base_id = number
    display_name      = optional(string)
    defined_tags      = optional(map(string))
    freeform_tags     = optional(map(string))
    application_dependencies = optional(list(object({
      gav                             = string
      node_id                         = string
      application_dependency_node_ids = optional(list(string))
      purl                            = optional(string)
    })), [])
    configuration = optional(list(object({
      exclusions                   = optional(list(string))
      max_permissible_cvss_v2score = optional(number)
      max_permissible_cvss_v3score = optional(number)
      max_permissible_severity     = optional(number)
    })), [])
    source = optional(list(object({
      type            = string
      description     = optional(string)
      oci_resource_id = optional(string)
    })), [])
    usage_data = optional(list(object({
      bucket      = string
      namespace   = string
      object      = string
      source_type = string
    })), [])
  })))
  default = []
  description = <<EOF
This resource provides the Vulnerability Audit resource in Oracle Cloud Infrastructure Adm service.
Creates a new Vulnerability Audit by providing a tree of Application Dependencies.
EOF
}