variable "aks_cluster_name" {
  type     = string
  default  = null
  nullable = true
}

variable "cloudwatch_log_group" {
  type     = string
  default  = null
  nullable = true
}

variable "alert_manager_definition" {
  type = list(object({
    id           = number
    definition   = string
    workspace_id = number
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "rule_group_namespace" {
  type = list(object({
    id           = number
    data         = string
    name         = string
    workspace_id = number
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "scraper" {
  type = list(object({
    id                   = number
    scrape_configuration = string
    alias                = optional(string)
    destination = list(object({
      amp = list(object({
        workspace_id = number
      }))
    }))
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "workspace" {
  type = list(object({
    id          = number
    alias       = optional(string)
    kms_key_arn = optional(string)
    tags        = optional(map(string))
  }))
  default     = []
  description = <<EOF
    EOF
}
