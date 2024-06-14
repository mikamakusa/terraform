## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.33.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.33.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_vertex_ai_feature_online_store.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_vertex_ai_feature_online_store) | resource |
| [google-beta_google_vertex_ai_feature_online_store_featureview.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_vertex_ai_feature_online_store_featureview) | resource |
| [google-beta_google_vertex_ai_featurestore.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_vertex_ai_featurestore) | resource |
| [google-beta_google_vertex_ai_featurestore_entitytype.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_vertex_ai_featurestore_entitytype) | resource |
| [google-beta_google_vertex_ai_index.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_vertex_ai_index) | resource |
| [google-beta_google_vertex_ai_index_endpoint.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_vertex_ai_index_endpoint) | resource |
| [google-beta_google_vertex_ai_metadata_store.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_vertex_ai_metadata_store) | resource |
| [google-beta_google_vertex_ai_tensorboard.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_vertex_ai_tensorboard) | resource |
| [google_bigquery_dataset.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/bigquery_dataset) | resource |
| [google_bigquery_table.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/bigquery_table) | resource |
| [google_compute_global_address.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/compute_global_address) | resource |
| [google_compute_network.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/compute_network) | resource |
| [google_kms_crypto_key.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/kms_crypto_key) | resource |
| [google_kms_key_ring.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/kms_key_ring) | resource |
| [google_service_networking_connection.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/service_networking_connection) | resource |
| [google_vertex_ai_dataset.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/vertex_ai_dataset) | resource |
| [google_vertex_ai_deployment_resource_pool.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/vertex_ai_deployment_resource_pool) | resource |
| [google_vertex_ai_endpoint.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/vertex_ai_endpoint) | resource |
| [google_vertex_ai_feature_group.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/vertex_ai_feature_group) | resource |
| [google_vertex_ai_feature_group_feature.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/vertex_ai_feature_group_feature) | resource |
| [google_vertex_ai_featurestore_entitytype_feature.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/vertex_ai_featurestore_entitytype_feature) | resource |
| [google_compute_network.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/data-sources/compute_network) | data source |
| [google_kms_crypto_key.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/data-sources/kms_crypto_key) | data source |
| [google_kms_key_ring.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/data-sources/kms_key_ring) | data source |
| [google_project.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bigquery_dataset"></a> [bigquery\_dataset](#input\_bigquery\_dataset) | n/a | <pre>list(object({<br>    id            = number<br>    dataset_id    = string<br>    friendly_name = optional(string)<br>    description   = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_bigquery_table"></a> [bigquery\_table](#input\_bigquery\_table) | n/a | <pre>list(object({<br>    id         = number<br>    dataset_id = number<br>    table_id   = string<br>    schema     = string<br>  }))</pre> | `[]` | no |
| <a name="input_compute_global_address"></a> [compute\_global\_address](#input\_compute\_global\_address) | n/a | <pre>list(object({<br>    id         = number<br>    name       = string<br>    network_id = number<br>  }))</pre> | `[]` | no |
| <a name="input_compute_network"></a> [compute\_network](#input\_compute\_network) | n/a | <pre>list(object({<br>    id   = number<br>    name = string<br>  }))</pre> | `[]` | no |
| <a name="input_compute_network_name"></a> [compute\_network\_name](#input\_compute\_network\_name) | n/a | `string` | `null` | no |
| <a name="input_crypto_key"></a> [crypto\_key](#input\_crypto\_key) | n/a | <pre>list(object({<br>    id          = number<br>    key_ring_id = number<br>    name        = string<br>  }))</pre> | `[]` | no |
| <a name="input_dataset"></a> [dataset](#input\_dataset) | n/a | <pre>list(object({<br>    id                  = number<br>    metadata_schema_uri = string<br>    display_name        = string<br>    labels              = optional(map(string))<br>    project             = optional(string)<br>    region              = optional(string)<br>    encryption_spec = optional(list(object({<br>      kms_key_id = optional(number)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_deployment_resource_pool"></a> [deployment\_resource\_pool](#input\_deployment\_resource\_pool) | n/a | <pre>list(object({<br>    id      = number<br>    name    = string<br>    region  = optional(string)<br>    project = optional(string)<br>    dedicated_resources = list(object({<br>      max_replica_count = optional(number)<br>      min_replica_count = number<br>      machine_spec = list(object({<br>        machine_type      = optional(string)<br>        accelerator_type  = optional(string)<br>        accelerator_count = optional(number)<br>      }))<br>      autoscaling_metric_specs = optional(list(object({<br>        metric_name = string<br>        target      = optional(number)<br>      })), [])<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | n/a | <pre>list(object({<br>    id           = number<br>    name         = string<br>    display_name = string<br>    location     = string<br>    description  = optional(string)<br>    labels       = optional(map(string))<br>    network_id   = optional(number)<br>    project      = optional(string)<br>    region       = optional(string)<br>    encryption_spec = optional(list(object({<br>      kms_key_id = optional(number)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_feature_group"></a> [feature\_group](#input\_feature\_group) | n/a | <pre>list(object({<br>    id      = number<br>    name    = optional(string)<br>    big_query = optional(list(object({<br>      entity_id_columns = optional(list(string))<br>      big_query_source = optional(list(object({<br>        input_uri = optional(string)<br>      })))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_feature_group_feature"></a> [feature\_group\_feature](#input\_feature\_group\_feature) | n/a | <pre>list(object({<br>    id                  = number<br>    name                = string<br>    feature_group_id    = number<br>    region              = string<br>    description         = optional(string)<br>    labels              = optional(map(string))<br>    project             = optional(string)<br>    version_column_name = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_feature_online_store"></a> [feature\_online\_store](#input\_feature\_online\_store) | n/a | <pre>list(object({<br>    id            = number<br>    name          = string<br>    force_destroy = optional(bool)<br>    labels        = optional(map(string))<br>    project       = optional(string)<br>    region        = optional(string)<br>    bigtable = optional(list(object({<br>      auto_scaling = optional(list(object({<br>        max_node_count         = optional(number)<br>        min_node_count         = number<br>        cpu_utilization_target = optional(number)<br>      })), [])<br>    })), [])<br>    dedicated_serving_endpoint = optional(list(object({<br>      private_service_connect_config = optional(list(object({<br>        enable_private_service_connect = bool<br>        project_allowlist              = optional(list(string))<br>      })), [])<br>    })), [])<br>    embedding_management = optional(list(object({<br>      enabled = optional(bool)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_feature_online_store_featureview"></a> [feature\_online\_store\_featureview](#input\_feature\_online\_store\_featureview) | n/a | <pre>list(object({<br>    id                      = number<br>    feature_online_store_id = number<br>    region                  = string<br>    labels                  = optional(map(string))<br>    name                    = optional(string)<br>    project                 = optional(string)<br>    big_query_source = optional(list(object({<br>      bigquery_table_id               = number<br>      entity_id_columns = string<br>    })), [])<br>    feature_registry_source = optional(list(object({<br>      feature_groups = list(object({<br>        feature_group_id = number<br>        feature_ids      = list(number)<br>      }))<br>    })), [])<br>    sync_config = optional(list(object({<br>      cron = optional(string)<br>    })), [])<br>    vector_search_config = optional(list(object({<br>      embedding_column      = string<br>      filter_columns        = optional(list(string))<br>      crowding_column       = optional(string)<br>      distance_measure_type = optional(string)<br>      embedding_dimension   = optional(number)<br>      tree_ah_config = optional(list(object({<br>        leaf_node_embedding_count = optional(string)<br>      })), [])<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_featurestore"></a> [featurestore](#input\_featurestore) | n/a | <pre>list(object({<br>    id                      = number<br>    labels                  = optional(map(string))<br>    force_destroy           = optional(bool)<br>    name                    = optional(string)<br>    online_storage_ttl_days = optional(number)<br>    project                 = optional(string)<br>    region                  = optional(string)<br>    encryption_spec = optional(list(object({<br>      kms_key_name = optional(string)<br>    })), [])<br>    online_serving_config = optional(list(object({<br>      fixed_node_count = optional(number)<br>      scaling = optional(list(object({<br>        max_node_count = number<br>        min_node_count = number<br>      })), [])<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_featurestore_entitytype"></a> [featurestore\_entitytype](#input\_featurestore\_entitytype) | n/a | <pre>list(object({<br>    id                       = number<br>    featurestore_id          = number<br>    name                     = optional(string)<br>    description              = optional(string)<br>    labels                   = optional(map(string))<br>    offline_storage_ttl_days = optional(number)<br>    monitoring_config = optional(list(object({<br>      categorical_threshold_config = optional(list(object({<br>        value = string<br>      })), [])<br>      import_features_analysis = optional(list(object({<br>        state                      = optional(string)<br>        anomaly_detection_baseline = optional(string)<br>      })), [])<br>      numerical_threshold_config = optional(list(object({<br>        value = string<br>      })), [])<br>      snapshot_analysis = optional(list(object({<br>        disabled                 = optional(bool)<br>        monitoring_interval_days = optional(number)<br>        staleness_days           = optional(number)<br>      })), [])<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_featurestore_entitytype_feature"></a> [featurestore\_entitytype\_feature](#input\_featurestore\_entitytype\_feature) | n/a | <pre>list(object({<br>    id            = number<br>    entitytype_id = number<br>    value_type    = string<br>    name          = optional(string)<br>    labels        = optional(map(string))<br>    description   = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_index"></a> [index](#input\_index) | n/a | <pre>list(object({<br>    id                  = number<br>    display_name        = string<br>    labels              = optional(map(string))<br>    index_update_method = optional(string)<br>    region              = optional(string)<br>    project             = optional(string)<br>    metadata = optional(list(object({<br>      contents_delta_uri    = string<br>      is_complete_overwrite = optional(bool)<br>      config = optional(list(object({<br>        dimensions                  = number<br>        approximate_neighbors_count = optional(number)<br>        shard_size                  = optional(string)<br>        distance_measure_type       = optional(string)<br>        feature_norm_type           = optional(string)<br>        algorithm_config = optional(list(object({<br>          tree_ah_config = optional(list(object({<br>            leaf_node_embedding_count    = number<br>            leaf_nodes_to_search_percent = number<br>          })))<br>        })), [])<br>      })), [])<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_index_endpoint"></a> [index\_endpoint](#input\_index\_endpoint) | n/a | <pre>list(object({<br>    id                      = number<br>    display_name            = string<br>    description             = optional(string)<br>    labels                  = optional(map(string))<br>    network_id                 = optional(number)<br>    public_endpoint_enabled = optional(bool)<br>    project                 = optional(string)<br>    private_service_connect_config = optional(list(object({<br>      enable_private_service_connect = bool<br>      project_allowlist              = optional(list(string))<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_key_ring"></a> [key\_ring](#input\_key\_ring) | n/a | <pre>list(object({<br>    id   = number<br>    name = string<br>  }))</pre> | `[]` | no |
| <a name="input_kms_crypto_key_name"></a> [kms\_crypto\_key\_name](#input\_kms\_crypto\_key\_name) | n/a | `string` | `null` | no |
| <a name="input_kms_key_ring_name"></a> [kms\_key\_ring\_name](#input\_kms\_key\_ring\_name) | n/a | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `null` | no |
| <a name="input_metadata_store"></a> [metadata\_store](#input\_metadata\_store) | n/a | <pre>list(object({<br>    id          = number<br>    name        = optional(string)<br>    description = optional(string)<br>    region      = optional(string)<br>    project     = optional(string)<br>    encryption_spec = optional(list(object({<br>      kms_key_name = optional(string)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `null` | no |
| <a name="input_service_networking_connection"></a> [service\_networking\_connection](#input\_service\_networking\_connection) | n/a | <pre>list(object({<br>    id                = number<br>    network_id        = number<br>    global_address_id = number<br>  }))</pre> | `[]` | no |
| <a name="input_tensorboard"></a> [tensorboard](#input\_tensorboard) | n/a | <pre>list(object({<br>    id           = number<br>    display_name = string<br>    description  = optional(string)<br>    labels       = optional(map(string))<br>    region       = optional(string)<br>    project      = optional(string)<br>    encryption_spec = optional(list(object({<br>      kms_key_name = optional(string)<br>    })), [])<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dataset"></a> [dataset](#output\_dataset) | n/a |
| <a name="output_deployment_resource_pool"></a> [deployment\_resource\_pool](#output\_deployment\_resource\_pool) | n/a |
| <a name="output_feature_group"></a> [feature\_group](#output\_feature\_group) | n/a |
| <a name="output_feature_group_feature"></a> [feature\_group\_feature](#output\_feature\_group\_feature) | n/a |
| <a name="output_feature_online_store"></a> [feature\_online\_store](#output\_feature\_online\_store) | n/a |
| <a name="output_feature_online_store_featureview"></a> [feature\_online\_store\_featureview](#output\_feature\_online\_store\_featureview) | n/a |
| <a name="output_featurestore_entitytype"></a> [featurestore\_entitytype](#output\_featurestore\_entitytype) | n/a |
| <a name="output_featurestore_entitytype_feature"></a> [featurestore\_entitytype\_feature](#output\_featurestore\_entitytype\_feature) | n/a |
| <a name="output_index_endpoint"></a> [index\_endpoint](#output\_index\_endpoint) | n/a |
| <a name="output_metadata_store"></a> [metadata\_store](#output\_metadata\_store) | n/a |
| <a name="output_tensorboard"></a> [tensorboard](#output\_tensorboard) | n/a |
| <a name="output_vertex_ai_featurestore"></a> [vertex\_ai\_featurestore](#output\_vertex\_ai\_featurestore) | n/a |
| <a name="output_vertex_ai_index"></a> [vertex\_ai\_index](#output\_vertex\_ai\_index) | n/a |
