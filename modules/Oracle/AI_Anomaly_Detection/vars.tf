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
}

variable "subnet_id" {
  type = string
}

variable "private_endpoint" {
  type = list(map(object({
    id            = number
    dns_zones     = list(string)
    display_name  = optional(string)
    defined_tags  = optional(map(string))
    freeform_tags = optional(map(string))
  })))
  default = []
  description = <<EOF
This resource provides the Ai Private Endpoint resource in Oracle Cloud Infrastructure Ai Anomaly Detection service.
EOF
}

variable "data_asset" {
  type = list(map(object({
    id                  = number
    project_id          = number
    display_name        = optional(string)
    defined_tags        = optional(map(string))
    freeform_tags       = optional(map(string))
    description         = optional(string)
    private_endpoint_id = optional(string)
    data_source_details = list(object({
      data_source_type          = string
      atp_password_secret_id    = optional(string)
      atp_user_name             = optional(string)
      bucket                    = optional(string)
      cwallet_file_secret_id    = optional(string)
      database_name             = optional(string)
      ewallet_file_secret_id    = optional(string)
      key_store_file_secret_id  = optional(string)
      measurement_name          = optional(string)
      namespace                 = optional(string)
      object                    = optional(string)
      ojdbc_file_secret_id      = optional(string)
      password_secret_id        = optional(string)
      table_name                = optional(string)
      tnsnames_file_secret_id   = optional(string)
      truststore_file_secret_id = optional(string)
      url                       = optional(string)
      user_name                 = optional(string)
      wallet_password_secret_id = optional(string)
      version_specific_details = optional(list(object({
        influx_version        = string
        bucket                = string
        database_name         = string
        organization_name     = string
        retention_policy_name = optional(string)
      })), [])
    }))
  })))
  default = []
  description = <<EOF
This resource provides the Data Asset resource in Oracle Cloud Infrastructure Ai Anomaly Detection service.
EOF
}

variable "anomaly_job" {
  type = list(map(object({
    id           = number
    model_id     = number
    description  = optional(string)
    display_name = optional(string)
    sensitivity  = optional(number)
    input_details = list(object({
      input_type   = string
      content      = optional(string)
      content_type = optional(string)
      signal_names = optional(list(string))
      data = optional(list(object({
        timestamp = optional(string)
        values    = optional(list(string))
      })), [])
      object_locations = optional(list(object({
        bucket    = optional(string)
        namespace = optional(string)
        object    = optional(string)
      })), [])
    }))
    output_details = list(object({
      bucket      = string
      namespace   = string
      output_type = string
      prefix      = optional(string)
    }))
  })))
  default = []
  description = <<EOF
This resource provides the Detect Anomaly Job resource in Oracle Cloud Infrastructure Ai Anomaly Detection service.
EOF
}

variable "model" {
  type = list(map(object({
    id            = number
    project_id    = number
    defined_tags  = optional(map(string))
    description   = optional(string)
    display_name  = optional(string)
    freeform_tags = optional(map(string))
    model_training_details = list(object({
      data_asset_ids    = list(string)
      algorithm_hint    = optional(string)
      target_fap        = optional(number)
      training_fraction = optional(number)
      window_size       = optional(number)
    }))
  })))
  default = []
  description = <<EOF
This resource provides the Model resource in Oracle Cloud Infrastructure Ai Anomaly Detection service.
EOF
}

variable "project" {
  type = list(map(object({
    id            = number
    display_name  = optional(string)
    description   = optional(string)
    defined_tags  = optional(map(string))
    freeform_tags = optional(map(string))
  })))
  default = []
  description = <<EOF
This resource provides the Project resource in Oracle Cloud Infrastructure Ai Anomaly Detection service.
EOF
}