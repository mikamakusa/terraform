resource "google_alloydb_backup" "this" {
  count        = length(var.backup) == "0" ? "0" : length(var.cluster)
  backup_id    = lookup(var.backup[count.index], "backup_id")
  cluster_name = try(element(google_alloydb_cluster.this.*.name, lookup(var.backup[count.index], "cluster_id")))
  location     = lookup(var.backup[count.index], "location")
  display_name = lookup(var.backup[count.index], "display_name")
  labels       = merge(var.labels, lookup(var.backup[count.index], "labels"))
  type         = lookup(var.backup[count.index], "type")
  description  = lookup(var.backup[count.index], "description")
  annotations  = lookup(var.backup[count.index], "annotations")
  project      = lookup(var.backup[count.index], "project")

  dynamic "encryption_config" {
    for_each = lookup(var.backup[count.index], "encryption_config") == null ? [] : ["encryption_config"]
    content {
      kms_key_name = lookup(encryption_config.value, "kms_key_name")
    }
  }
}

resource "google_alloydb_cluster" "this" {
  count            = length(var.cluster)
  cluster_id       = lookup(var.cluster[count.index], "cluster_id")
  location         = lookup(var.cluster[count.index], "location")
  labels           = merge(var.labels, lookup(var.cluster[count.index], "labels"))
  display_name     = lookup(var.cluster[count.index], "display_name")
  etag             = lookup(var.cluster[count.index], "etag")
  annotations      = lookup(var.cluster[count.index], "annotations")
  database_version = lookup(var.cluster[count.index], "database_version")
  cluster_type     = lookup(var.cluster[count.index], "cluster_type")
  project          = lookup(var.cluster[count.index], "project")
  deletion_policy  = lookup(var.cluster[count.index], "deletion_policy")

  dynamic "encryption_config" {
    for_each = lookup(var.cluster[count.index], "encryption_config") == null ? [] : ["encryption_config"]
    content {
      kms_key_name = lookup(encryption_config.value, "kms_key_name")
    }
  }

  dynamic "network_config" {
    for_each = lookup(var.cluster[count.index], "network_config") == null ? [] : ["network_config"]
    content {
      network            = lookup(network_config.value, "network")
      allocated_ip_range = lookup(network_config.value, "allocated_ip_range")
    }
  }

  dynamic "initial_user" {
    for_each = lookup(var.cluster[count.index], "initial_user") == null ? [] : ["initial_user"]
    content {
      password = sensitive(lookup(initial_user.value, password))
      user     = sensitive(lookup(initial_user.value, user))
    }
  }

  dynamic "restore_backup_source" {
    for_each = lookup(var.cluster[count.index], "restore_backup_source") == null ? [] : ["restore_backup_source"]
    content {
      backup_name = lookup(restore_backup_source.value, "backup_name")
    }
  }

  dynamic "restore_continuous_backup_source" {
    for_each = lookup(var.cluster[count.index], "restore_continuous_backup_source") == null ? [] : ["restore_continuous_backup_source"]
    content {
      cluster       = lookup(restore_continuous_backup_source.value, "cluster")
      point_in_time = lookup(restore_continuous_backup_source.value, "point_in_time")
    }
  }

  dynamic "continuous_backup_config" {
    for_each = lookup(var.cluster[count.index], "continuous_backup_config") == null ? [] : ["continuous_backup_config"]
    content {
      enabled              = lookup(continuous_backup_config.value, "enabled")
      recovery_window_days = lookup(continuous_backup_config.value, "recovery_window_days")

      dynamic "encryption_config" {
        for_each = lookup(continuous_backup_config.value, "encryption_config") == null ? [] : ["encryption_config"]
        content {
          kms_key_name = lookup(encryption_config.value, "kms_key_name")
        }
      }
    }
  }

  dynamic "automated_backup_policy" {
    for_each = lookup(var.cluster[count.index], "automated_backup_policy") == null ? [] : ["automated_backup_policy"]
    content {
      backup_window = lookup(automated_backup_policy.value, "backup_window")
      location      = lookup(automated_backup_policy.value, "location")
      labels        = lookup(automated_backup_policy.value, "labels")
      enabled       = lookup(automated_backup_policy.value, "enabled")

      dynamic "encryption_config" {
        for_each = lookup(automated_backup_policy.value[count.index], "encryption_config") == null ? [] : ["encryption_config"]
        content {
          kms_key_name = lookup(encryption_config.value, "kms_key_name")
        }
      }

      dynamic "weekly_schedule" {
        for_each = lookup(automated_backup_policy.value[count.index], "weekly_schedule") == null ? [] : ["weekly_schedule"]
        content {
          days_of_week = lookup(weekly_schedule.value, "days_of_week")
          dynamic "start_times" {
            for_each = lookup(weekly_schedule.value, "start_times") == null ? [] : ["start_times"]
            content {
              hours   = lookup(start_times.value, "hours")
              minutes = lookup(start_times.value, "minutes")
              seconds = lookup(start_times.value, "seconds")
              nanos   = lookup(start_times.value, "nanos")
            }
          }
        }
      }
      dynamic "time_based_retention" {
        for_each = lookup(automated_backup_policy.value[count.index], "time_based_retention") == null ? [] : ["time_based_retention"]
        content {
          retention_period = lookup(time_based_retention.value, "retention_period")
        }
      }
      dynamic "quantity_based_retention" {
        for_each = lookup(automated_backup_policy.value[count.index], "quantity_based_retention") == null ? [] : ["quantity_based_retention"]
        content {
          count = lookup(quantity_based_retention.value, "count")
        }
      }
    }
  }

  dynamic "secondary_config" {
    for_each = lookup(var.cluster[count.index], "secondary_config") == null ? [] : ["secondary_config"]
    content {
      primary_cluster_name = lookup(secondary_config.value, "primary_cluster_name")
    }
  }
}

resource "google_alloydb_instance" "this" {
  count             = length(var.instance)
  cluster           = try(element(google_alloydb_cluster.this.*.name, lookup(var.instance[count.index], "cluster_id")))
  instance_id       = lookup(var.instance[count.index], "instance_id")
  instance_type     = lookup(var.instance[count.index], "instance_type")
  labels            = merge(var.labels, lookup(var.instance[count.index], "labels"))
  annotations       = lookup(var.instance[count.index], "annotations")
  display_name      = lookup(var.instance[count.index], "display_name")
  gce_zone          = lookup(var.instance[count.index], "gce_zone")
  database_flags    = lookup(var.instance[count.index], "database_flags")
  availability_type = lookup(var.instance[count.index], "availability_type")

  dynamic "query_insights_config" {
    for_each = lookup(var.instance[count.index], "query_insights_config") == null ? [] : ["query_insights_config"]
    content {
      query_string_length     = lookup(query_insights_config.value, "query_string_length")
      record_application_tags = lookup(query_insights_config.value, "record_application_tags")
      record_client_address   = lookup(query_insights_config.value, "record_client_address")
      query_plans_per_minute  = lookup(query_insights_config.value, "query_plans_per_minute")
    }
  }

  dynamic "read_pool_config" {
    for_each = lookup(var.instance[count.index], "read_pool_config") == null ? [] : ["read_pool_config"]
    content {
      node_count = lookup(read_pool_config.value, "node_count")
    }
  }

  dynamic "machine_config" {
    for_each = lookup(var.instance[count.index], "machine_config") == null ? [] : ["machine_config"]
    content {
      cpu_count = lookup(machine_config.value, "cpu_count")
    }
  }

  dynamic "client_connection_config" {
    for_each = lookup(var.instance[count.index], "client_connection_config") == null ? [] : ["client_connection_config"]
    content {
      require_connectors = lookup(client_connection_config.value, "require_connectors")
      dynamic "ssl_config" {
        for_each = lookup(client_connection_config.value, "ssl_config") == null ? [] : ["ssl_config"]
        content {
          ssl_mode = lookup(ssl_config.value, "ssl_mode")
        }
      }
    }
  }
}

resource "google_alloydb_user" "this" {
  count          = length(var.user)
  cluster        = try(element(google_alloydb_cluster.this.*.name, lookup(var.user[count.index], "cluster_id")))
  user_id        = lookup(var.user[count.index], "user_id")
  user_type      = lookup(var.user[count.index], "user_type")
  password       = sensitive(lookup(var.user[count.index], "password"))
  database_roles = lookup(var.user[count.index], "database_roles")
}