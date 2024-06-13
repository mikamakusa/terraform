variable "kms_key_ring_name" {
  type    = string
  default = null
}

variable "kms_crypto_key_name" {
  type    = string
  default = null
}

variable "location" {
  type    = string
  default = null
}

variable "project" {
  type = string
}

variable "region" {
  type    = string
  default = null
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "compute_network_name" {
  type    = string
  default = null
}

variable "compute_network" {
  type = list(object({
    id   = number
    name = string
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "compute_global_address" {
  type = list(object({
    id         = number
    name       = string
    network_id = number
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "service_networking_connection" {
  type = list(object({
    id                = number
    network_id        = number
    global_address_id = number
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "key_ring" {
  type = list(object({
    id   = number
    name = string
  }))
  default     = []
  description = <<EOF
EOF
}

variable "crypto_key" {
  type = list(object({
    id          = number
    key_ring_id = number
    name        = string
  }))
  default     = []
  description = <<EOF
EOF
}

variable "bigquery_dataset" {
  type = list(object({
    id            = number
    dataset_id    = string
    friendly_name = optional(string)
    description   = optional(string)
  }))
  default = []
}

variable "bigquery_table" {
  type = list(object({
    id         = number
    dataset_id = number
    table_id   = string
    schema     = string
  }))
  default = []
}

variable "dataset" {
  type = list(object({
    id                  = number
    metadata_schema_uri = string
    display_name        = string
    labels              = optional(map(string))
    project             = optional(string)
    region              = optional(string)
    encryption_spec = optional(list(object({
      kms_key_id = optional(number)
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "deployment_resource_pool" {
  type = list(object({
    id      = number
    name    = string
    region  = optional(string)
    project = optional(string)
    dedicated_resources = list(object({
      max_replica_count = optional(number)
      min_replica_count = number
      machine_spec = list(object({
        machine_type      = optional(string)
        accelerator_type  = optional(string)
        accelerator_count = optional(number)
      }))
      autoscaling_metric_specs = optional(list(object({
        metric_name = string
        target      = optional(number)
      })), [])
    }))
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "endpoint" {
  type = list(object({
    id           = number
    name         = string
    display_name = string
    location     = string
    description  = optional(string)
    labels       = optional(map(string))
    network_id   = optional(number)
    project      = optional(string)
    region       = optional(string)
    encryption_spec = optional(list(object({
      kms_key_id = optional(number)
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "feature_group" {
  type = list(object({
    id      = number
    name    = optional(string)
    big_query = optional(list(object({
      entity_id_columns = optional(list(string))
      big_query_source = optional(list(object({
        input_uri = optional(string)
      })))
    })))
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "feature_group_feature" {
  type = list(object({
    id                  = number
    name                = string
    feature_group_id    = number
    region              = string
    description         = optional(string)
    labels              = optional(map(string))
    project             = optional(string)
    version_column_name = optional(string)
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "feature_online_store" {
  type = list(object({
    id            = number
    name          = string
    force_destroy = optional(bool)
    labels        = optional(map(string))
    project       = optional(string)
    region        = optional(string)
    bigtable = optional(list(object({
      auto_scaling = optional(list(object({
        max_node_count         = optional(number)
        min_node_count         = number
        cpu_utilization_target = optional(number)
      })), [])
    })), [])
    dedicated_serving_endpoint = optional(list(object({
      private_service_connect_config = optional(list(object({
        enable_private_service_connect = bool
        project_allowlist              = optional(list(string))
      })), [])
    })), [])
    embedding_management = optional(list(object({
      enabled = optional(bool)
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "feature_online_store_featureview" {
  type = list(object({
    id                      = number
    feature_online_store_id = number
    region                  = string
    labels                  = optional(map(string))
    name                    = optional(string)
    project                 = optional(string)
    big_query_source = optional(list(object({
      bigquery_table_id               = number
      entity_id_columns = string
    })), [])
    feature_registry_source = optional(list(object({
      feature_groups = list(object({
        feature_group_id = number
        feature_ids      = list(number)
      }))
    })), [])
    sync_config = optional(list(object({
      cron = optional(string)
    })), [])
    vector_search_config = optional(list(object({
      embedding_column      = string
      filter_columns        = optional(list(string))
      crowding_column       = optional(string)
      distance_measure_type = optional(string)
      embedding_dimension   = optional(number)
      tree_ah_config = optional(list(object({
        leaf_node_embedding_count = optional(string)
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "featurestore" {
  type = list(object({
    id                      = number
    labels                  = optional(map(string))
    force_destroy           = optional(bool)
    name                    = optional(string)
    online_storage_ttl_days = optional(number)
    project                 = optional(string)
    region                  = optional(string)
    encryption_spec = optional(list(object({
      kms_key_name = optional(string)
    })), [])
    online_serving_config = optional(list(object({
      fixed_node_count = optional(number)
      scaling = optional(list(object({
        max_node_count = number
        min_node_count = number
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "featurestore_entitytype" {
  type = list(object({
    id                       = number
    featurestore_id          = number
    name                     = optional(string)
    description              = optional(string)
    labels                   = optional(map(string))
    offline_storage_ttl_days = optional(number)
    monitoring_config = optional(list(object({
      categorical_threshold_config = optional(list(object({
        value = string
      })), [])
      import_features_analysis = optional(list(object({
        state                      = optional(string)
        anomaly_detection_baseline = optional(string)
      })), [])
      numerical_threshold_config = optional(list(object({
        value = string
      })), [])
      snapshot_analysis = optional(list(object({
        disabled                 = optional(bool)
        monitoring_interval_days = optional(number)
        staleness_days           = optional(number)
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "featurestore_entitytype_feature" {
  type = list(object({
    id            = number
    entitytype_id = number
    value_type    = string
    name          = optional(string)
    labels        = optional(map(string))
    description   = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "index" {
  type = list(object({
    id                  = number
    display_name        = string
    labels              = optional(map(string))
    index_update_method = optional(string)
    region              = optional(string)
    project             = optional(string)
    metadata = optional(list(object({
      contents_delta_uri    = string
      is_complete_overwrite = optional(bool)
      config = optional(list(object({
        dimensions                  = number
        approximate_neighbors_count = optional(number)
        shard_size                  = optional(string)
        distance_measure_type       = optional(string)
        feature_norm_type           = optional(string)
        algorithm_config = optional(list(object({
          tree_ah_config = optional(list(object({
            leaf_node_embedding_count    = number
            leaf_nodes_to_search_percent = number
          })))
        })), [])
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "index_endpoint" {
  type = list(object({
    id                      = number
    display_name            = string
    description             = optional(string)
    labels                  = optional(map(string))
    network_id                 = optional(number)
    public_endpoint_enabled = optional(bool)
    project                 = optional(string)
    private_service_connect_config = optional(list(object({
      enable_private_service_connect = bool
      project_allowlist              = optional(list(string))
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "metadata_store" {
  type = list(object({
    id          = number
    name        = optional(string)
    description = optional(string)
    region      = optional(string)
    project     = optional(string)
    encryption_spec = optional(list(object({
      kms_key_name = optional(string)
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}

variable "tensorboard" {
  type = list(object({
    id           = number
    display_name = string
    description  = optional(string)
    labels       = optional(map(string))
    region       = optional(string)
    project      = optional(string)
    encryption_spec = optional(list(object({
      kms_key_name = optional(string)
    })), [])
  }))
  default     = []
  description = <<EOF
    EOF
}
