variable "resource_group_name" {
  type     = string
  nullable = true
  default  = null
}

variable "cos_bucket" {
  type     = string
  nullable = true
  default  = null
}

variable "cluster" {
  type = list(object({
    id                              = number
    location_id                     = number
    name                            = string
    crn_token                       = optional(string)
    default_worker_pool_labels      = optional(map(string))
    disable_public_service_endpoint = optional(bool)
    enable_config_admin             = optional(bool)
    host_labels                     = optional(list(string))
    infrastructure_topology         = optional(string)
    kube_version                    = optional(string)
    operating_system                = optional(string)
    patch_version                   = optional(string)
    pod_subnet                      = optional(string)
    pull_secret                     = optional(string)
    retry_patch_version             = optional(number)
    service_subnet                  = optional(string)
    tags                            = optional(list(string))
    wait_for_worker_update          = optional(bool)
    worker_count                    = optional(number)
    zones = optional(list(object({
      id = string
    })), [])
  }))
  nullable    = true
  default     = []
  description = <<EOF
  EOF

  validation {
    condition = alltrue([
      for i in var.cluster : contains(["REDHAT_7_64", "REDHAT_8_64", "RHCOS"], i.operating_system)
    ])
    error_message = "Valid values are 'REDHAT_7_64', 'REDHAT_8_64' or RHCOS'."
  }
}

variable "cluster_worker_pool" {
  type = list(object({
    id                 = number
    cluster_id         = number
    name               = string
    disk_encryption    = optional(bool)
    entitlement        = optional(string)
    flavor             = optional(string)
    host_labels        = optional(list(string))
    isolation          = optional(string)
    operating_system   = optional(string)
    resource_group_id  = optional(string)
    worker_count       = optional(number)
    worker_pool_labels = optional(map(string))
    zones = optional(list(object({
      id = string
    })), [])
  }))
  nullable    = true
  default     = []
  description = <<EOF
  EOF
}

variable "cluster_worker_pool_zone_attachment" {
  type = list(object({
    id             = number
    cluster_id     = number
    worker_pool_id = number
    zone           = string
  }))
  nullable    = true
  default     = []
  description = <<EOF
  EOF
}

variable "endpoint" {
  type = list(object({
    id                 = number
    client_protocol    = string
    connection_type    = string
    display_name       = string
    location_id        = number
    server_host        = string
    server_port        = number
    client_mutual_auth = optional(bool)
    created_by         = optional(string)
    server_mutual_auth = optional(bool)
    server_protocol    = optional(string)
    sni                = optional(string)
    timeout            = optional(number)
  }))
  nullable    = true
  default     = []
  description = <<EOF
  EOF

  validation {
    condition     = var.endpoint.timeout >= 1 && var.endpoint.timeout <= 180
    error_message = "Timeout must be between 1 and 180."
  }

  validation {
    condition = alltrue([
      for i in var.endpoint : contains(["udp", "tcp", "tls"], i.server_protocol)
    ])
    error_message = "Valid values are 'udp', 'tcp' or 'tls'."
  }
}

variable "host" {
  type = list(object({
    id             = number
    host_id        = string
    location_id    = number
    host_provider  = optional(string)
    labels         = optional(list(string))
    worker_pool_id = optional(number)
  }))
  nullable    = true
  default     = []
  description = <<EOF
  EOF
}

variable "link" {
  type = list(object({
    id          = number
    location_id = number
  }))
  nullable    = true
  default     = []
  description = <<EOF
  EOF
}

variable "location" {
  type = list(object({
    id                 = number
    location           = string
    managed_from       = string
    resource_group_id  = optional(number)
    zones              = optional(list(string))
    coreos_enabled     = optional(bool)
    description        = optional(string)
    logging_account_id = optional(string)
    pod_subnet         = optional(string)
    service_subnet     = optional(string)
    cos_config = optional(list(object({
      endpoint = optional(string)
      region   = optional(string)
    })), [])
    cos_credentials = optional(list(object({
      access_key_id     = optional(string)
      secret_access_key = optional(string)
    })), [])
  }))
  nullable    = true
  default     = []
  description = <<EOF
  EOF
}

variable "location_nlb_dns" {
  type = list(object({
    id          = number
    ips         = list(string)
    location_id = number
  }))
  nullable    = true
  default     = []
  description = <<EOF
  EOF
}

variable "storage_assignment" {
  type = list(object({
    id                     = number
    assignment_name        = string
    config_id              = number
    cluster_id             = optional(number)
    groups                 = optional(list(string))
    update_config_revision = optional(bool)
  }))
  nullable    = true
  default     = []
  description = <<EOF
  EOF
}

variable "storage_configuration" {
  type = list(object({
    id                       = number
    config_name              = string
    location_id              = number
    storage_template_name    = string
    storage_template_version = string
    user_config_parameters   = map(string)
    user_secret_parameters   = map(string)
    delete_assignments       = optional(bool)
    storage_class_parameters = optional(list(map(string)))
    update_assignments       = optional(bool)
  }))
  nullable    = true
  default     = []
  description = <<EOF
  EOF
}
