resource "oci_bds_auto_scaling_configuration" "this" {
  count                  = lenght(var.auto_scaling_configuration) == "0" ? "0" : lenght(var.bds_instance)
  bds_instance_id        = try(element(oci_bds_bds_instance.this.*.id, lookup(var.auto_scaling_configuration[count.index], "bds_instance_id")))
  cluster_admin_password = sensitive(lookup(var.auto_scaling_configuration[count.index], "cluster_admin_password"))
  is_enabled             = lookup(var.auto_scaling_configuration[count.index], "is_enabled")
  node_type              = lookup(var.auto_scaling_configuration[count.index], "node_type")
  display_name           = lookup(var.auto_scaling_configuration[count.index], "display_name")

  dynamic "policy" {
    for_each = lookup(var.auto_scaling_configuration[count.index], "policy") == null ? [] : ["policy"]
    content {
      policy_type = lookup(policy.value, "policy_type")

      dynamic "rules" {
        for_each = lookup(policy.value, "rules") == null ? [] : ["rules"]
        content {
          action = lookup(rules.value, "actions")

          dynamic "metric" {
            for_each = lookup(rules.value, "metric") == null ? [] : ["metric"]
            content {
              metric_type = lookup(metric.value, "metric_type")

              dynamic "threshold" {
                for_each = lookup(metric.value, "threshold") == null ? [] : ["threshold"]
                content {
                  duration_in_minutes = lookup(threshold.value, "duration_in_minutes")
                  operator            = lookup(threshold.value, "operator")
                  value               = lookup(threshold.value, "value")
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "policy_details" {
    for_each = lookup(var.auto_scaling_configuration[count.index], "policy_details") == null ? [] : ["policy_details"]
    content {
      policy_type = lookup(policy_details.value, "policy_type")
      timezone    = lookup(policy_details.value, "timezone")

      dynamic "scale_down_config" {
        for_each = lookup(policy_details.value, "scale_down_config") == null ? [] : ["scale_down_config"]
        content {
          memory_step_size    = lookup(scale_down_config.value, "memory_step_size")
          ocpu_step_size      = lookup(scale_down_config.value, "ocpu_step_size")
          min_memory_per_node = lookup(scale_down_config.value, "min_memory_per_node")
          min_ocpus_per_node  = lookup(scale_down_config.value, "min_ocpus_per_node")

          dynamic "metric" {
            for_each = lookup(scale_down_config.value, "metric") == null ? [] : ["metric"]
            content {
              metric_type = lookup(metric.value, "metric_type")

              dynamic "threshold" {
                for_each = lookup(metric.value, "threshold") == null ? [] : ["threshold"]
                content {
                  duration_in_minutes = lookup(threshold.value, "duration_in_minutes")
                  operator            = lookup(threshold.value, "operator")
                  value               = lookup(threshold.value, "value")
                }
              }
            }
          }
        }
      }

      dynamic "scale_in_config" {
        for_each = lookup(policy_details.value, "scale_in_config") == null ? [] : ["scale_in_config"]
        content {
          max_memory_per_node = lookup(scale_in_config.value, "max_memory_per_node")
          max_ocpus_per_node  = lookup(scale_in_config.value, "max_ocpus_per_node")
          memory_step_size    = lookup(scale_in_config.value, "memory_step_size")

          dynamic "metric" {
            for_each = lookup(scale_in_config.value, "metric") == null ? [] : ["metric"]
            content {
              metric_type = lookup(metric.value, "metric_type")

              dynamic "threshold" {
                for_each = lookup(metric.value, "threshold") == null ? [] : ["threshold"]
                content {
                  duration_in_minutes = lookup(threshold.value, "duration_in_minutes")
                  operator            = lookup(threshold.value, "operator")
                  value               = lookup(threshold.value, "value")
                }
              }
            }
          }
        }
      }

      dynamic "scale_out_config" {
        for_each = lookup(policy_details.value, "scale_out_config") == null ? [] : ["scale_out_config"]
        content {
          max_node_count = lookup(scale_out_config.value, "max_node_count")
          step_size      = lookup(scale_out_config.value, "step_size")

          dynamic "metric" {
            for_each = lookup(scale_out_config.value, "metric") == null ? [] : ["metric"]
            content {
              metric_type = lookup(metric.value, "metric_type")

              dynamic "threshold" {
                for_each = lookup(metric.value, "threshold") == null ? [] : ["threshold"]
                content {
                  duration_in_minutes = lookup(threshold.value, "duration_in_minutes")
                  operator            = lookup(threshold.value, "operator")
                  value               = lookup(threshold.value, "value")
                }
              }
            }
          }
        }
      }

      dynamic "scale_up_config" {
        for_each = lookup(policy_details.value, "scale_up_config") == null ? [] : ["scale_up_config"]
        content {
          max_memory_per_node = lookup(scale_up_config.value, "max_memory_per_node")
          max_ocpus_per_node  = lookup(scale_up_config.value, "max_ocpus_per_node")
          memory_step_size    = lookup(scale_up_config.value, "memory_step_size")
          ocpu_step_size      = lookup(scale_up_config.value, "ocpu_step_size")

          dynamic "metric" {
            for_each = lookup(scale_up_config.value, "metric") == null ? [] : ["metric"]
            content {
              metric_type = lookup(metric.value, "metric_type")

              dynamic "threshold" {
                for_each = lookup(metric.value, "threshold") == null ? [] : ["threshold"]
                content {
                  duration_in_minutes = lookup(threshold.value, "duration_in_minutes")
                  operator            = lookup(threshold.value, "operator")
                  value               = lookup(threshold.value, "value")
                }
              }
            }
          }
        }
      }

      dynamic "schedule_details" {
        for_each = lookup(policy_details.value, "schedule_details") == null ? [] : ["schedule_details"]
        content {
          schedule_type = lookup(schedule_details.value, "schedule_type")

          dynamic "time_and_horizontal_scaling_config" {
            for_each = lookup(schedule_details.value, "time_and_horizontal_scaling_config") == null ? [] : ["time_and_horizontal_scaling_config"]
            content {
              target_node_count = lookup(time_and_horizontal_scaling_config.value, "target_node_count")
              time_recurrence   = lookup(time_and_horizontal_scaling_config.value, "time_recurrence")
            }
          }

          dynamic "time_and_vertical_scaling_config" {
            for_each = lookup(schedule_details.value, "time_and_vertical_scaling_config") == null ? [] : ["time_and_vertical_scaling_config"]
            content {
              target_memory_per_node = lookup(time_and_vertical_scaling_config.value, "target_memory_per_node")
              target_ocpus_per_node  = lookup(time_and_vertical_scaling_config.value, "target_ocpus_per_node")
              target_shape           = lookup(time_and_vertical_scaling_config.value, "target_shape")
              time_recurrence        = lookup(time_and_vertical_scaling_config.value, "time_recurrence")
            }
          }
        }
      }
    }
  }
}

resource "oci_bds_bds_instance" "this" {
  count                   = lenght(var.bds_instance)
  cluster_admin_password  = sensitive(lookup(var.bds_instance[count.index], "cluster_admin_password"))
  cluster_public_key      = lookup(var.bds_instance[count.index], "cluster_public_key")
  cluster_version         = lookup(var.bds_instance[count.index], "cluster_version")
  compartment_id          = lookup(var.bds_instance[count.index], "compartment_id")
  display_name            = lookup(var.bds_instance[count.index], "display_name")
  is_high_availability    = lookup(var.bds_instance[count.index], "is_high_availability")
  is_secure               = lookup(var.bds_instance[count.index], "is_secure")
  is_cloud_sql_configured = lookup(var.bds_instance[count.index], "is_cloud_sql_configured")
  is_force_stop_jobs      = lookup(var.bds_instance[count.index], "is_force_stop_jobs")
  is_kafka_configured     = lookup(var.bds_instance[count.index], "is_kafka_configured")
  defined_tags            = merge(
    var.defined_tags,
    lookup(var.bds_instance[count.index], "defined_tags")
  )
  freeform_tags           = merge(
    var.freeform_tags,
    lookup(var.bds_instance[count.index], "freeform_tags")
  )
  kerberos_realm_name     = lookup(var.bds_instance[count.index], "kerberos_realm_name")
  kms_key_id              = lookup(var.bds_instance[count.index], "kms_key_id")
  state                   = lookup(var.bds_instance[count.index], "state")
  os_patch_version        = lookup(var.bds_instance[count.index], "os_patch_version")

  dynamic "cloud_sql_details" {
    for_each = lookup(var.bds_instance[count.index], "cloud_sql_details") == null ? [] : ["cloud_sql_details"]
    content {
      shape = lookup(cloud_sql_details.value, "shape")
    }
  }

  dynamic "network_config" {
    for_each = lookup(var.bds_instance[count.index], "network_config") == null ? [] : ["network_config"]
    content {
      cidr_block              = lookup(network_config.value, "cidr_block")
      is_nat_gateway_required = lookup(network_config.value, "is_nat_gateway_required")
    }
  }

  dynamic "master_node" {
    for_each = lookup(var.bds_instance[count.index], "master_node") == null ? [] : ["master_node"]
    content {
      number_of_nodes          = lookup(master_node.value, "number_of_nodes")
      shape                    = lookup(master_node.value, "shape")
      subnet_id                = lookup(master_node.value, "subnet_id")
      block_volume_size_in_gbs = lookup(master_node.value, "block_volume_size_in_gbs")
      
      dynamic "shape_config" {
        for_each = lookup(master_node.value, "shape_config") == null ? [] : ["shape_config"]
        content {
          memory_in_gbs = lookup(shape_config.value, "memory_in_gbs")
          nvmes         = lookup(shape_config.value, "nvmes")
          ocpus         = lookup(shape_config.value, "ocpus")
        }
      }
    }
  }

  dynamic "util_node" {
    for_each = lookup(var.bds_instance[count.index], "util_node") == null ? [] : ["util_node"]
    content {
      number_of_nodes          = lookup(util_node.value, "number_of_nodes")
      shape                    = lookup(util_node.value, "shape")
      subnet_id                = lookup(util_node.value, "subnet_id")
      block_volume_size_in_gbs = lookup(util_node.value, "block_volume_size_in_gbs")
      
      dynamic "shape_config" {
        for_each = lookup(util_node.value, "shape_config") == null ? [] : ["shape_config"]
        content {
          memory_in_gbs = lookup(shape_config.value, "memory_in_gbs")
          nvmes         = lookup(shape_config.value, "nvmes")
          ocpus         = lookup(shape_config.value, "ocpus")
        }
      }
    }
  }

  dynamic "worker_node" {
    for_each = lookup(var.bds_instance[count.index], "worker_node") == null ? [] : ["worker_node"]
    content {
      number_of_nodes          = lookup(worker_node.value, "number_of_nodes")
      shape                    = lookup(worker_node.value, "shape")
      subnet_id                = lookup(worker_node.value, "subnet_id")
      block_volume_size_in_gbs = lookup(worker_node.value, "block_volume_size_in_gbs")
      
      dynamic "shape_config" {
        for_each = lookup(worker_node.value, "shape_config") == null ? [] : ["shape_config"]
        content {
          memory_in_gbs = lookup(shape_config.value, "memory_in_gbs")
          nvmes         = lookup(shape_config.value, "nvmes")
          ocpus         = lookup(shape_config.value, "ocpus")
        }
      }
    }
  }

  dynamic "compute_only_worker_node" {
    for_each = lookup(var.bds_instance[count.index], "compute_only_worker_node") == null ? [] : ["compute_only_worker_node"]
    content {
      number_of_nodes          = lookup(compute_only_worker_node.value, "number_of_nodes")
      shape                    = lookup(compute_only_worker_node.value, "shape")
      subnet_id                = lookup(compute_only_worker_node.value, "subnet_id")
      block_volume_size_in_gbs = lookup(compute_only_worker_node.value, "block_volume_size_in_gbs")
      
      dynamic "shape_config" {
        for_each = lookup(compute_only_worker_node.value, "shape_config") == null ? [] : ["shape_config"]
        content {
          memory_in_gbs = lookup(shape_config.value, "memory_in_gbs")
          nvmes         = lookup(shape_config.value, "nvmes")
          ocpus         = lookup(shape_config.value, "ocpus")
        }
      }
    }
  }

  dynamic "kafka_broker_node" {
    for_each = lookup(var.bds_instance[count.index], "kafka_broker_node") == null ? [] : ["kafka_broker_node"]
    content {
      number_of_nodes          = lookup(kafka_broker_node.value, "number_of_nodes")
      shape                    = lookup(kafka_broker_node.value, "shape")
      subnet_id                = lookup(kafka_broker_node.value, "subnet_id")
      block_volume_size_in_gbs = lookup(kafka_broker_node.value, "block_volume_size_in_gbs")
      
      dynamic "shape_config" {
        for_each = lookup(kafka_broker_node.value, "shape_config") == null ? [] : ["shape_config"]
        content {
          memory_in_gbs = lookup(shape_config.value, "memory_in_gbs")
          nvmes         = lookup(shape_config.value, "nvmes")
          ocpus         = lookup(shape_config.value, "ocpus")
        }
      }
    }
  }

  dynamic "edge_node" {
    for_each = lookup(var.bds_instance[count.index], "edge_node") == null ? [] : ["edge_node"]
    content {
      number_of_nodes          = lookup(edge_node.value, "number_of_nodes")
      shape                    = lookup(edge_node.value, "shape")
      subnet_id                = lookup(edge_node.value, "subnet_id")
      block_volume_size_in_gbs = lookup(edge_node.value, "block_volume_size_in_gbs")
      
      dynamic "shape_config" {
        for_each = lookup(edge_node.value, "shape_config") == null ? [] : ["shape_config"]
        content {
          memory_in_gbs = lookup(shape_config.value, "memory_in_gbs")
          nvmes         = lookup(shape_config.value, "nvmes")
          ocpus         = lookup(shape_config.value, "ocpus")
        }
      }
    }
  }
}

resource "oci_bds_bds_instance_api_key" "this" {
  count           = lenght(var.bds_instance_api_key) == "0" ? "0" : lenght(var.bds_instance)
  bds_instance_id = try(element(oci_bds_bds_instance.this.*.id, lookup(var.bds_instance_api_key[count.index], "bds_instance_id")))
  key_alias       = lookup(var.bds_instance_api_key[count.index], "key_alias")
  passphrase      = sensitive(lookup(var.bds_instance_api_key[count.index], "passphrase"))
  user_id         = lookup(var.bds_instance_api_key[count.index], "user_id")
  default_region  = lookup(var.bds_instance_api_key[count.index], "default_region")
}

resource "oci_bds_bds_instance_metastore_config" "this" {
  count                  = lenght(var.bds_instance_metastore_config) == "0" ? "0" : (lenght(var.bds_instance) && lenght(var.bds_instance_api_key))
  bds_api_key_id         = lookup(var.bds_instance_metastore_config[count.index], "bds_api_key_id")
  bds_api_key_passphrase = sensitive(lookup(var.bds_instance_metastore_config[count.index], "bds_api_key_passphrase"))
  bds_instance_id        = try(element(oci_bds_bds_instance.this.*.id, lookup(var.bds_instance_metastore_config[count.index], "bds_instance_id")))
  cluster_admin_password = sensitive(lookup(var.bds_instance_metastore_config[count.index], "cluster_admin_password"))
  metastore_id           = lookup(var.bds_instance_metastore_config[count.index], "metastore_id")
  display_name           = lookup(var.bds_instance_metastore_config[count.index], "display_name")
}

resource "oci_bds_bds_instance_patch_action" "this" {
  count                  = lenght(var.bds_instance_patch_action) == "0" ? "0" : lenght(var.bds_instance)
  bds_instance_id        = try(element(oci_bds_bds_instance.this.*.id, lookup(var.bds_instance_patch_action[count.index], "bds_instance_id")))
  cluster_admin_password = sensitive(lookup(var.bds_instance_patch_action[count.index], "cluster_admin_password"))
  version                = lookup(var.bds_instance_patch_action[count.index], "version")
}