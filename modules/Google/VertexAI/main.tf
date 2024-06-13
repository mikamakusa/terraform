resource "google_kms_key_ring" "this" {
  count    = var.kms_key_ring_name == null && length(var.key_ring)
  location = var.location
  name     = lookup(var.key_ring[count.index], "name")
}

resource "google_kms_crypto_key" "this" {
  count    = (var.kms_key_ring_name && var.kms_crypto_key_name) == null && (length(var.key_ring) == 0 ? 0 : length(var.crypto_key))
  key_ring = try(element(google_kms_key_ring.this.*.id, lookup(var.crypto_key[count.index], "key_ring_id")))
  name     = lookup(var.crypto_key[count.index], "name")
}

resource "google_vertex_ai_dataset" "this" {
  count               = length(var.dataset)
  metadata_schema_uri = lookup(var.dataset[count.index], "metadata_schema_uri")
  display_name        = lookup(var.dataset[count.index], "display_name")
  labels              = merge(var.labels, lookup(var.dataset[count.index], "labels"))
  project             = lookup(var.dataset[count.index], "project")
  region              = lookup(var.dataset[count.index], "region")

  dynamic "encryption_spec" {
    for_each = lookup(var.dataset[count.index], "encryption_spec") == null ? [] : ["encryption_spec"]
    content {
      kms_key_name = try(
        data.google_kms_crypto_key.this.id,
        element(google_kms_crypto_key.this.*.name, lookup(encryption_spec.value, "key_key_id"))
      )
    }
  }
}

resource "google_vertex_ai_deployment_resource_pool" "this" {
  count   = length(var.deployment_resource_pool)
  name    = lookup(var.deployment_resource_pool[count.index], "name")
  region  = var.region
  project = var.project

  dynamic "dedicated_resources" {
    for_each = lookup(var.deployment_resource_pool[count.index], "dedicated_resources")
    content {
      min_replica_count = lookup(dedicated_resources.value, "min_replica_count")
      max_replica_count = lookup(dedicated_resources.value, "max_replica_count")

      dynamic "machine_spec" {
        for_each = lookup(dedicated_resources.value, "machine_spec")
        content {
          machine_type      = lookup(machine_spec.value, "machine_type")
          accelerator_type  = lookup(machine_spec.value, "accelerator_type")
          accelerator_count = lookup(machine_spec.value, "accelerator_count")
        }
      }

      dynamic "autoscaling_metric_specs" {
        for_each = lookup(dedicated_resources.value, "autoscaling_metric_specs") == null ? [] : ["autoscaling_metric_specs"]
        content {
          metric_name = lookup(autoscaling_metric_specs.value, "metric_name")
          target      = lookup(autoscaling_metric_specs.value, "target")
        }
      }
    }
  }
}

resource "google_compute_network" "this" {
  count = length(var.compute_network)
  name  = lookup(var.compute_network[count.index], "name")
}

resource "google_compute_global_address" "this" {
  count         = length(var.compute_network) == 0 ? 0 : length(var.compute_global_address)
  name          = lookup(var.compute_global_address[count.index], "name")
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = try(element(google_compute_network.this.*.id, lookup(var.compute_global_address[count.index], "network_id")))
}

resource "google_service_networking_connection" "this" {
  count                   = (length(var.compute_network) && length(var.compute_global_address)) == 0 ? 0 : length(var.service_networking_connection)
  network                 = try(element(google_compute_network.this.*.id, lookup(var.service_networking_connection[count.index], "network_id")))
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = try(element(google_compute_global_address.this.*.name, lookup(var.service_networking_connection[count.index], "global_address_id")))
}

resource "google_vertex_ai_endpoint" "this" {
  count        = (length(var.compute_network) && length(var.compute_global_address) && length(var.service_networking_connection)) || var.compute_network_name == 0 ? 0 : length(var.endpoint)
  name         = lookup(var.endpoint[count.index], "name")
  display_name = lookup(var.endpoint[count.index], "display_name")
  location     = var.location
  description  = lookup(var.endpoint[count.index], "description")
  labels       = merge(var.labels, lookup(var.endpoint[count.index], "labels"))
  network = try(
    data.google_compute_network.this.name,
    element(google_compute_network.this.*.name, lookup(var.endpoint[count.index], "network_id"))
  )
  project = var.project
  region  = var.region

  dynamic "encryption_spec" {
    for_each = lookup(var.endpoint[count.index], "encryption_spec") == null ? [] : ["encryption_spec"]
    content {
      kms_key_name = try(
        data.google_kms_crypto_key.this.id,
        element(google_kms_crypto_key.this.*.name, lookup(encryption_spec.value, "key_key_id"))
      )
    }
  }
}

resource "google_bigquery_dataset" "this" {
  count         = length(var.bigquery_dataset)
  dataset_id    = lookup(var.bigquery_dataset[count.index], "name")
  friendly_name = lookup(var.bigquery_dataset[count.index], "friendly_name")
  description   = lookup(var.bigquery_dataset[count.index], "description")
  location      = var.location
}

resource "google_bigquery_table" "this" {
  count               = length(var.bigquery_dataset) == 0 ? 0 : length(var.bigquery_table)
  dataset_id          = try(element(google_bigquery_dataset.this.*.id, lookup(var.bigquery_table[count.index], "dataset_id")))
  table_id            = lookup(var.bigquery_table[count.index], "table_id")
  deletion_protection = false
  schema              = lookup(var.bigquery_table[count.index], "schema")
}

resource "google_vertex_ai_feature_group" "this" {
  count   = length(var.bigquery_table) == 0 ? 0 : length(var.feature_group)
  name    = lookup(var.feature_group[count.index], "name")
  project = var.project
  region  = var.region

  dynamic "big_query" {
    for_each = lookup(var.feature_group[count.index], "big_query") == null ? [] : ["big_query"]
    content {
      entity_id_columns = lookup(big_query.value, "entity_id_columns")

      dynamic "big_query_source" {
        for_each = lookup(big_query.value, "big_query_source") == null ? [] : ["big_query_source"]
        content {
          input_uri = join("//", ["bq:", join(".", [
            try(
              element(google_bigquery_table.this.*.project, lookup(big_query_source.value, "bigquery_table_id"))
            ),
            try(
              element(google_bigquery_table.this.*.dataset_id, lookup(big_query_source.value, "bigquery_table_id"))
            ),
            try(
              element(google_bigquery_table.this.*.table_id, lookup(big_query_source.value, "bigquery_table_id"))
            )
          ])])
        }
      }
    }
  }
}

resource "google_vertex_ai_feature_group_feature" "this" {
  count               = length(var.feature_group) == 0 ? 0 : length(var.feature_group_feature)
  name                = lookup(var.feature_group_feature[count.index], "name")
  feature_group       = try(element(google_vertex_ai_feature_group.this.*.name, lookup(var.feature_group_feature[count.index], "feature_group_id")))
  region              = var.region
  description         = lookup(var.feature_group_feature[count.index], "description")
  labels              = merge(var.labels, lookup(var.feature_group_feature[count.index], "labels"))
  project             = var.project
  version_column_name = lookup(var.feature_group_feature[count.index], "version_column_name")
}

resource "google_vertex_ai_feature_online_store" "this" {
  count         = length(var.feature_online_store)
  provider      = google-beta
  name          = lookup(var.feature_online_store[count.index], "name")
  force_destroy = lookup(var.feature_online_store[count.index], "force_destroy")
  labels        = merge(var.labels, lookup(var.feature_online_store[count.index], "labels"))
  project       = var.project
  region        = var.region

  dynamic "bigtable" {
    for_each = lookup(var.feature_online_store[count.index], "bigtable") == null ? [] : ["bigtable"]
    content {
      dynamic "auto_scaling" {
        for_each = lookup(bigtable.value, "auto_scaling") == null ? [] : ["auto_scaling"]
        content {
          max_node_count         = lookup(auto_scaling.value, "max_node_count")
          min_node_count         = lookup(auto_scaling.value, "min_node_count")
          cpu_utilization_target = lookup(auto_scaling.value, "cpu_utilization_target")
        }
      }
    }
  }

  dynamic "dedicated_serving_endpoint" {
    for_each = lookup(var.feature_online_store[count.index], "dedicated_serving_endpoint") == null ? [] : ["dedicated_serving_endpoint"]
    content {
      dynamic "private_service_connect_config" {
        for_each = lookup(dedicated_serving_endpoint.value, "private_service_connect_config") == null ? [] : ["private_service_connect_config"]
        content {
          enable_private_service_connect = lookup(private_service_connect_config.value, "enable_private_service_connect")
          project_allowlist              = lookup(private_service_connect_config.value, "project_allowlist")
        }
      }
    }
  }

  dynamic "embedding_management" {
    for_each = lookup(var.feature_online_store[count.index], "embedding_management") == null ? [] : ["embedding_management"]
    content {
      enabled = lookup(embedding_management.value, "enabled")
    }
  }
}

resource "google_vertex_ai_feature_online_store_featureview" "this" {
  count                = length(var.feature_online_store) == 0 ? 0 : length(var.feature_online_store_featureview)
  feature_online_store = try(element(google_vertex_ai_feature_online_store.this.*.name, lookup(var.feature_online_store_featureview[count.index], "feature_online_store_id")))
  region               = var.region
  labels               = merge(var.labels, lookup(var.feature_online_store_featureview[count.index], "labels"))
  name                 = lookup(var.feature_online_store_featureview[count.index], "name")
  project              = var.project
  provider             = google-beta

  dynamic "big_query_source" {
    for_each = lookup(var.feature_online_store_featureview.value, "big_query_source") == null ? [] : ["big_query_source"]
    content {
      uri = join("//", ["bq:", join(".", [
        try(
          element(google_bigquery_table.this.*.project, lookup(big_query_source.value, "bigquery_table_id"))
        ),
        try(
          element(google_bigquery_table.this.*.dataset_id, lookup(big_query_source.value, "bigquery_table_id"))
        ),
        try(
          element(google_bigquery_table.this.*.table_id, lookup(big_query_source.value, "bigquery_table_id"))
        )
      ])])
      entity_id_columns = lookup(big_query_source.value, "entity_id_columns")
    }
  }

  dynamic "feature_registry_source" {
    for_each = lookup(var.feature_online_store_featureview.value, "feature_registry_source") == null ? [] : ["feature_registry_source"]
    content {
      dynamic "feature_groups" {
        for_each = lookup(feature_registry_source.value, "feature_groups")
        content {
          feature_group_id = try(element(google_vertex_ai_feature_group.this.*.name, lookup(feature_groups.value, "feature_group_id")))
          feature_ids      = try(element(google_vertex_ai_feature_group_feature.this.*.name, lookup(feature_groups.value, "feature_id")))
        }
      }
    }
  }

  dynamic "sync_config" {
    for_each = lookup(var.feature_online_store_featureview.value, "sync_config") == null ? [] : ["sync_config"]
    content {
      cron = lookup(sync_config.value, "cron")
    }
  }

  dynamic "vector_search_config" {
    for_each = lookup(var.feature_online_store_featureview.value, "vector_search_config") == null ? [] : ["vector_search_config"]
    content {
      embedding_column      = lookup(vector_search_config.value, "embedding_column")
      filter_columns        = lookup(vector_search_config.value, "filter_columns")
      crowding_column       = lookup(vector_search_config.value, "crowding_column")
      distance_measure_type = lookup(vector_search_config.value, "distance_measure_type")
      embedding_dimension   = lookup(vector_search_config.value, "embedding_dimension")

      dynamic "tree_ah_config" {
        for_each = lookup(vector_search_config.value, "tree_ah_config") == null ? [] : ["tree_ah_config"]
        content {
          leaf_node_embedding_count = lookup(tree_ah_config.value, "leaf_node_embedding_count")
        }
      }
    }
  }
}

resource "google_vertex_ai_featurestore" "this" {
  count                   = length(var.featurestore)
  labels                  = merge(var.labels, lookup(var.featurestore[count.index], "labels"))
  force_destroy           = lookup(var.featurestore[count.index], "force_destroy")
  name                    = lookup(var.featurestore[count.index], "name")
  online_storage_ttl_days = lookup(var.featurestore[count.index], "online_storage_ttl_days")
  project                 = var.project
  provider                = google-beta
  region                  = var.region

  dynamic "encryption_spec" {
    for_each = lookup(var.featurestore[count.index], "encryption_spec") == null ? [] : ["encryption_spec"]
    content {
      kms_key_name = try(
        data.google_kms_crypto_key.this.name,
        element(google_kms_crypto_key.this.*.name, lookup(encryption_spec.value, "kms_key_id"))
      )
    }
  }

  dynamic "online_serving_config" {
    for_each = lookup(var.featurestore[count.index], "online_serving_config") == null ? [] : ["online_serving_config"]
    content {
      fixed_node_count = lookup(online_serving_config.value, "fixed_node_count")

      dynamic "scaling" {
        for_each = lookup(online_serving_config.value, "scaling") == null ? [] : ["scaling"]
        content {
          max_node_count = lookup(scaling.value, "max_node_count")
          min_node_count = lookup(scaling.value, "min_node_count")
        }
      }
    }
  }
}

resource "google_vertex_ai_featurestore_entitytype" "this" {
  count                    = length(var.featurestore) == 0 ? 0 : length(var.featurestore_entitytype)
  provider                 = google-beta
  featurestore             = try(element(google_vertex_ai_featurestore.this.*.id, lookup(var.featurestore_entitytype[count.index], "featurestore_id")))
  name                     = lookup(var.featurestore_entitytype[count.index], "name")
  description              = lookup(var.featurestore_entitytype[count.index], "description")
  labels                   = merge(var.labels, lookup(var.featurestore_entitytype[count.index], "labels"))
  offline_storage_ttl_days = lookup(var.featurestore_entitytype[count.index], "offline_storage_ttl_days")

  dynamic "monitoring_config" {
    for_each = lookup(var.featurestore_entitytype[count.index], "monitoring_config") == null ? [] : ["monitoring_config"]
    content {
      dynamic "categorical_threshold_config" {
        for_each = lookup(monitoring_config.value, "categorical_threshold_config") == null ? [] : ["categorical_threshold_config"]
        content {
          value = lookup(categorical_threshold_config.value, "value")
        }
      }

      dynamic "import_features_analysis" {
        for_each = lookup(var.featurestore_entitytype[count.index], "import_features_analysis") == null ? [] : ["import_features_analysis"]
        content {
          state                      = lookup(import_features_analysis.value, "state")
          anomaly_detection_baseline = lookup(import_features_analysis.value, "anomaly_detection_baseline")

        }
      }

      dynamic "numerical_threshold_config" {
        for_each = lookup(var.featurestore_entitytype[count.index], "numerical_threshold_config") == null ? [] : ["numerical_threshold_config"]
        content {
          value = lookup(numerical_threshold_config.value, "value")
        }
      }

      dynamic "snapshot_analysis" {
        for_each = lookup(var.featurestore_entitytype[count.index], "snapshot_analysis") == null ? [] : ["snapshot_analysis"]
        content {
          disabled                 = lookup(snapshot_analysis.value, "disabled")
          monitoring_interval_days = lookup(snapshot_analysis.value, "monitoring_interval_days")
          staleness_days           = lookup(snapshot_analysis.value, "staleness_days")
        }
      }
    }
  }
}

resource "google_vertex_ai_featurestore_entitytype_feature" "this" {
  count       = length(var.featurestore_entitytype) == 0 ? 0 : length(var.featurestore_entitytype_feature)
  entitytype  = try(element(google_vertex_ai_featurestore_entitytype.this.*.id, lookup(var.featurestore_entitytype_feature[count.index], "entitytype_id")))
  value_type  = lookup(var.featurestore_entitytype_feature[count.index], "value_type")
  name        = lookup(var.featurestore_entitytype_feature[count.index], "name")
  labels      = merge(var.labels, lookup(var.featurestore_entitytype_feature[count.index], "labels"))
  description = lookup(var.featurestore_entitytype_feature[count.index], "description")
}

resource "google_vertex_ai_index" "this" {
  count               = length(var.index)
  display_name        = lookup(var.index[count.index], "display_name")
  labels              = merge(var.labels, lookup(var.index[count.index], "labels"))
  index_update_method = lookup(var.index[count.index], "index_update_method")
  region              = var.region
  project             = var.project
  provider            = google-beta

  dynamic "metadata" {
    for_each = lookup(var.index[count.index], "metadata") == null ? [] : ["metadata"]
    content {
      contents_delta_uri    = lookup(metadata.value, "contents_delta_uri")
      is_complete_overwrite = lookup(metadata.value, "is_complete_overwrite")

      dynamic "config" {
        for_each = lookup(metadata.value, "config") == null ? [] : ["config"]
        content {
          dimensions                  = lookup(config.value, "dimensions")
          approximate_neighbors_count = lookup(config.value, "approximate_neighbors_count")
          shard_size                  = lookup(config.value, "shard_size")
          distance_measure_type       = lookup(config.value, "distance_measure_type")
          feature_norm_type           = lookup(config.value, "feature_norm_type")

          dynamic "algorithm_config" {
            for_each = lookup(config.value, "algorithm_config") == null ? [] : ["algorithm_config"]
            content {
              dynamic "tree_ah_config" {
                for_each = lookup(algorithm_config.value, "tree_ah_config") == null ? [] : ["tree_ah_config"]
                content {
                  leaf_node_embedding_count    = lookup(tree_ah_config.value, "leaf_node_embedding_count")
                  leaf_nodes_to_search_percent = lookup(tree_ah_config.value, "leaf_nodes_to_search_percent")
                }
              }
            }
          }
        }
      }
    }
  }
}

resource "google_vertex_ai_index_endpoint" "this" {
  count                   = length(var.index_endpoint)
  display_name            = lookup(var.index_endpoint[count.index], "display_name")
  description             = lookup(var.index_endpoint[count.index], "description")
  labels                  = merge(var.labels, lookup(var.index_endpoint[count.index], "labels"))
  network                 = try(element(google_compute_network.this.*.id, lookup(var.index_endpoint[count.index], "network_id")))
  provider                = google-beta
  public_endpoint_enabled = lookup(var.index_endpoint[count.index], "public_endpoint_enabled")
  project                 = var.project

  dynamic "private_service_connect_config" {
    for_each = lookup(var.index_endpoint[count.index], "private_service_connect_config") == null ? [] : ["private_service_connect_config"]
    content {
      enable_private_service_connect = lookup(private_service_connect_config.value, "enable_private_service_connect")
      project_allowlist              = lookup(private_service_connect_config.value, "project_allowlist")
    }
  }
}

resource "google_vertex_ai_metadata_store" "this" {
  count       = length(var.metadata_store)
  provider    = google-beta
  name        = lookup(var.metadata_store[count.index], "name")
  description = lookup(var.metadata_store[count.index], "description")
  region      = var.region
  project     = var.project

  dynamic "encryption_spec" {
    for_each = lookup(var.metadata_store[count.index], "encryption_spec")
    content {
      kms_key_name = try(
        data.google_kms_crypto_key.this.id,
        element(google_kms_crypto_key.this.*.name, lookup(encryption_spec.value, "key_key_id"))
      )
    }
  }
}

resource "google_vertex_ai_tensorboard" "this" {
  count        = length(var.tensorboard)
  display_name = lookup(var.tensorboard[count.index], "display_name")
  description  = lookup(var.tensorboard[count.index], "description")
  labels       = merge(var.labels, lookup(var.tensorboard[count.index], "labels"))
  region       = var.region
  project      = var.project
  provider     = google-beta

  dynamic "encryption_spec" {
    for_each = lookup(var.tensorboard[count.index], "encryption_spec") == null ? [] : ["encryption_spec"]
    content {
      kms_key_name = try(
        data.google_kms_crypto_key.this.id,
        element(google_kms_crypto_key.this.*.name, lookup(encryption_spec.value, "key_key_id"))
      )
    }
  }
}

