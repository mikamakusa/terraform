resource "digitalocean_app" "this" {
  count = length(var.app)

  dynamic "spec" {
    for_each = lookup(var.app[count.index], "spec")
    content {
      name   = lookup(spec.value, "name")
      region = lookup(spec.value, "region")

      dynamic "domain" {
        for_each = lookup(spec.value, "domain") == null ? [] : ["domain"]
        content {
          name     = lookup(domain.value, "name")
          type     = lookup(domain.value, "type")
          wildcard = lookup(domain.value, "wildcard")
          zone     = lookup(domain.value, "zone")
        }
      }

      dynamic "env" {
        for_each = lookup(spec.value, "env") == null ? [] : ["env"]
        content {
          key   = lookup(env.value, "key")
          value = lookup(env.value, "value")
          scope = lookup(env.value, "scope")
          type  = lookup(env.value, "type")
        }
      }

      dynamic "alert" {
        for_each = lookup(spec.value, "alert") == null ? [] : ["alert"]
        content {
          rule     = lookup(alert.value, "rule")
          disabled = lookup(alert.value, "disabled")
        }
      }

      dynamic "ingress" {
        for_each = lookup(spec.value, "ingress") == null ? [] : ["ingress"]
        content {
          dynamic "rule" {
            for_each = lookup(ingress.value, "rule") == null ? [] : ["rule"]
            content {
              dynamic "component" {
                for_each = lookup(rule.value, "component") == null ? [] : ["component"]
                content {
                  name                 = lookup(component.value, "name")
                  preserve_path_prefix = lookup(component.value, "preserve_path_prefix")
                  rewrite              = lookup(component.value, "rewrite")
                }
              }

              dynamic "match" {
                for_each = lookup(rule.value, "match") == null ? [] : ["match"]
                content {
                  dynamic "path" {
                    for_each = lookup(match.value, "path") == null ? [] : ["path"]
                    content {
                      prefix = lookup(path.value, "prefix")
                    }
                  }
                }
              }

              dynamic "redirect" {
                for_each = lookup(rule.value, "redirect") == null ? [] : ["redirect"]
                content {
                  uri           = lookup(redirect.value, "uri")
                  authority     = lookup(redirect.value, "authority")
                  port          = lookup(redirect.value, "port")
                  scheme        = lookup(redirect.value, "scheme")
                  redirect_code = lookup(redirect.value, "redirect_code")
                }
              }

              dynamic "cors" {
                for_each = lookup(rule.value, "cors") == null ? [] : ["cors"]
                content {
                  allow_credentials = lookup(cors.value, "allow_credentials")
                  allow_headers     = lookup(cors.value, "allow_headers")
                  allow_methods     = lookup(cors.value, "allow_methods")
                  max_age           = lookup(cors.value, "max_age")
                  expose_headers    = lookup(cors.value, "expose_headers")

                  dynamic "allow_origins" {
                    for_each = lookup(cors.value, "allow_origins") == null ? [] : ["allow_origins"]
                    content {
                      exact  = lookup(allow_origins.value, "exact")
                      prefix = lookup(allow_origins.value, "prefix")
                      regex  = lookup(allow_origins.value, "regex")
                    }
                  }
                }
              }
            }
          }
        }
      }

      dynamic "service" {
        for_each = lookup(spec.value, "service") == null ? [] : ["service"]
        content {
          name               = lookup(spec.value, "name")
          build_command      = lookup(spec.value, "build_command")
          dockerfile_path    = lookup(spec.value, "dockerfile_path")
          source_dir         = lookup(spec.value, "source_dir")
          run_command        = lookup(spec.value, "run_command")
          environment_slug   = lookup(spec.value, "environment_slug")
          instance_count     = lookup(spec.value, "instance_count")
          http_port          = lookup(spec.value, "http_port")
          internal_ports     = lookup(spec.value, "internal_ports")
          instance_size_slug = lookup(spec.value, "instance_size_slug")

          dynamic "git" {
            for_each = lookup(service.value, "git") == null ? [] : ["git"]
            content {
              repo_clone_url = lookup(git.value, "repo_clone_url")
              branch         = lookup(git.value, "branch")
            }
          }

          dynamic "github" {
            for_each = lookup(service.value, "github") == null ? [] : ["github"]
            content {
              repo           = lookup(github.value, "repo")
              branch         = lookup(github.value, "branch")
              deploy_on_push = lookup(github.value, "deploy_on_push")
            }
          }

          dynamic "gitlab" {
            for_each = lookup(service.value, "gitlab") == null ? [] : ["gitlab"]
            content {
              repo           = lookup(gitlab.value, "repo")
              branch         = lookup(gitlab.value, "branch")
              deploy_on_push = lookup(gitlab.value, "deploy_on_push")
            }
          }

          dynamic "image" {
            for_each = lookup(service.value, "image") == null ? [] : ["image"]
            content {
              registry_type = lookup(image.value, "registry_type")
              repository    = lookup(image.value, "repository")
              registry      = lookup(image.value, "registry")
              tag           = lookup(image.value, "tag")
              deploy_on_push {
                enabled = true
              }
            }
          }

          dynamic "env" {
            for_each = lookup(service.value, "env") == null ? [] : ["env"]
            content {
              key   = lookup(env.value, "key")
              value = lookup(env.value, "value")
              scope = lookup(env.value, "scope")
            }
          }

          dynamic "health_check" {
            for_each = lookup(service.value, "health_check") == null ? [] : ["health_check"]
            content {
              http_path             = lookup(health_check.value, "http_path")
              initial_delay_seconds = lookup(health_check.value, "initial_delay_seconds")
              period_seconds        = lookup(health_check.value, "period_seconds")
              success_threshold     = lookup(health_check.value, "success_threshold")
              failure_threshold     = lookup(health_check.value, "failure_threshold")
            }
          }
        }
      }

      dynamic "static_site" {
        for_each = lookup(spec.value, "static_site") == null ? [] : ["static_site"]
        content {
          name              = lookup(static_site.value, "name")
          build_command     = lookup(static_site.value, "build_command")
          dockerfile_path   = lookup(static_site.value, "dockerfile_path")
          source_dir        = lookup(static_site.value, "source_dir")
          environment_slug  = lookup(static_site.value, "environment_slug")
          output_dir        = lookup(static_site.value, "output_dir")
          index_document    = lookup(static_site.value, "index_document")
          error_document    = lookup(static_site.value, "error_document")
          catchall_document = lookup(static_site.value, "catchall_document")

          dynamic "git" {
            for_each = lookup(static_site.value, "git") == null ? [] : ["git"]
            content {
              repo_clone_url = lookup(git.value, "repo_clone_url")
              branch         = lookup(git.value, "branch")
            }
          }

          dynamic "github" {
            for_each = lookup(static_site.value, "github") == null ? [] : ["github"]
            content {
              repo           = lookup(github.value, "repo")
              branch         = lookup(github.value, "branch")
              deploy_on_push = lookup(github.value, "deploy_on_push")
            }
          }

          dynamic "gitlab" {
            for_each = lookup(static_site.value, "gitlab") == null ? [] : ["gitlab"]
            content {
              repo           = lookup(gitlab.value, "repo")
              branch         = lookup(gitlab.value, "branch")
              deploy_on_push = lookup(gitlab.value, "deploy_on_push")
            }
          }

          dynamic "env" {
            for_each = lookup(static_site.value, "env") == null ? [] : ["env"]
            content {
              key   = lookup(env.value, "key")
              value = lookup(env.value, "value")
              scope = lookup(env.value, "scope")
            }
          }
        }
      }

      dynamic "job" {
        for_each = lookup(spec.value, "job") == null ? [] : ["job"]
        content {
          name               = lookup(job.value, "name")
          kind               = lookup(job.value, "kind")
          build_command      = lookup(job.value, "build_command")
          dockerfile_path    = lookup(job.value, "dockerfile_path")
          source_dir         = lookup(job.value, "source_dir")
          environment_slug   = lookup(job.value, "environment_slug")
          instance_count     = lookup(job.value, "instance_count")
          instance_size_slug = lookup(job.value, "instance_size_slug")

          dynamic "git" {
            for_each = lookup(job.value, "git") == null ? [] : ["git"]
            content {
              repo_clone_url = lookup(git.value, "repo_clone_url")
              branch         = lookup(git.value, "branch")
            }
          }

          dynamic "github" {
            for_each = lookup(job.value, "github") == null ? [] : ["github"]
            content {
              repo           = lookup(github.value, "repo")
              branch         = lookup(github.value, "branch")
              deploy_on_push = lookup(github.value, "deploy_on_push")
            }
          }

          dynamic "gitlab" {
            for_each = lookup(job.value, "gitlab") == null ? [] : ["gitlab"]
            content {
              repo           = lookup(gitlab.value, "repo")
              branch         = lookup(gitlab.value, "branch")
              deploy_on_push = lookup(gitlab.value, "deploy_on_push")
            }
          }

          dynamic "env" {
            for_each = lookup(job.value, "env") == null ? [] : ["env"]
            content {
              key   = lookup(env.value, "key")
              value = lookup(env.value, "value")
              scope = lookup(env.value, "scope")
            }
          }

          dynamic "alert" {
            for_each = lookup(job.value, "alert") == null ? [] : ["alert"]
            content {
              operator = lookup(alert.value, "operator")
              rule     = lookup(alert.value, "rule")
              value    = lookup(alert.value, "value")
              window   = lookup(alert.value, "window")
            }
          }

          dynamic "log_destination" {
            for_each = lookup(job.value, "log_destination") == null ? [] : ["log_destination"]
            content {
              name = lookup(log_destination.value, "name")

              dynamic "datadog" {
                for_each = lookup(log_destination.value, "datadog") == null ? [] : ["datadog"]
                content {
                  api_key  = lookup(datadog.value, "api_key")
                  endpoint = lookup(datadog.value, "endpoint")
                }
              }

              dynamic "logtail" {
                for_each = lookup(log_destination.value, "logtail") == null ? [] : ["logtail"]
                content {
                  token = lookup(logtail.value, "token")
                }
              }

              dynamic "papertrail" {
                for_each = lookup(log_destination.value, "papertrail") == null ? [] : ["papertrail"]
                content {
                  endpoint = lookup(papertrail.value, "endpoint")
                }
              }
            }
          }
        }
      }

      dynamic "function" {
        for_each = lookup(spec.value, "function") == null ? [] : ["function"]
        content {
          name       = lookup(function.value, "name")
          source_dir = lookup(function.value, "source_dir")

          dynamic "git" {
            for_each = lookup(function.value, "git") == null ? [] : ["git"]
            content {
              repo_clone_url = lookup(git.value, "repo_clone_url")
              branch         = lookup(git.value, "branch")
            }
          }

          dynamic "github" {
            for_each = lookup(function.value, "github") == null ? [] : ["github"]
            content {
              repo           = lookup(github.value, "repo")
              branch         = lookup(github.value, "branch")
              deploy_on_push = lookup(github.value, "deploy_on_push")
            }
          }

          dynamic "gitlab" {
            for_each = lookup(function.value, "gitlab") == null ? [] : ["gitlab"]
            content {
              repo           = lookup(gitlab.value, "repo")
              branch         = lookup(gitlab.value, "branch")
              deploy_on_push = lookup(gitlab.value, "deploy_on_push")
            }
          }

          dynamic "env" {
            for_each = lookup(function.value, "env") == null ? [] : ["env"]
            content {
              key   = lookup(env.value, "key")
              value = lookup(env.value, "value")
              scope = lookup(env.value, "scope")
            }
          }

          dynamic "alert" {
            for_each = lookup(function.value, "alert") == null ? [] : ["alert"]
            content {
              operator = lookup(alert.value, "operator")
              rule     = lookup(alert.value, "rule")
              value    = lookup(alert.value, "value")
              window   = lookup(alert.value, "window")
            }
          }

          dynamic "log_destination" {
            for_each = lookup(function.value, "log_destination") == null ? [] : ["log_destination"]
            content {
              name = lookup(log_destination.value, "name")

              dynamic "datadog" {
                for_each = lookup(log_destination.value, "datadog") == null ? [] : ["datadog"]
                content {
                  api_key  = lookup(datadog.value, "api_key")
                  endpoint = lookup(datadog.value, "endpoint")
                }
              }

              dynamic "logtail" {
                for_each = lookup(log_destination.value, "logtail") == null ? [] : ["logtail"]
                content {
                  token = lookup(logtail.value, "token")
                }
              }

              dynamic "papertrail" {
                for_each = lookup(log_destination.value, "papertrail") == null ? [] : ["papertrail"]
                content {
                  endpoint = lookup(papertrail.value, "endpoint")
                }
              }
            }
          }
        }
      }

      dynamic "database" {
        for_each = lookup(spec.value, "database") == null ? [] : ["database"]
        content {
          name         = lookup(database.value, "name")
          engine       = lookup(database.value, "engine")
          version      = lookup(database.value, "version")
          production   = lookup(database.value, "production")
          cluster_name = lookup(database.value, "cluster_name")
          db_name      = lookup(database.value, "db_name")
          db_user      = lookup(database.value, "db_user")
        }
      }

      dynamic "worker" {
        for_each = lookup(spec.value, "worker") == null ? [] : ["worker"]
        content {
          name               = lookup(worker.value, "name")
          build_command      = lookup(worker.value, "build_command")
          dockerfile_path    = lookup(worker.value, "dockerfile_path")
          source_dir         = lookup(worker.value, "source_dir")
          run_command        = lookup(worker.value, "run_command")
          environment_slug   = lookup(worker.value, "environment_slug")
          instance_size_slug = lookup(worker.value, "instance_size_slug")
          instance_count     = lookup(worker.value, "instance_count")
          http_port          = lookup(worker.value, "http_port")

          dynamic "git" {
            for_each = lookup(worker.value, "git") == null ? [] : ["git"]
            content {
              repo_clone_url = lookup(git.value, "repo_clone_url")
              branch         = lookup(git.value, "branch")
            }
          }

          dynamic "github" {
            for_each = lookup(worker.value, "github") == null ? [] : ["github"]
            content {
              repo           = lookup(github.value, "repo")
              branch         = lookup(github.value, "branch")
              deploy_on_push = lookup(github.value, "deploy_on_push")
            }
          }

          dynamic "gitlab" {
            for_each = lookup(worker.value, "gitlab") == null ? [] : ["gitlab"]
            content {
              repo           = lookup(gitlab.value, "repo")
              branch         = lookup(gitlab.value, "branch")
              deploy_on_push = lookup(gitlab.value, "deploy_on_push")
            }
          }

          dynamic "env" {
            for_each = lookup(worker.value, "env") == null ? [] : ["env"]
            content {
              key   = lookup(env.value, "key")
              value = lookup(env.value, "value")
              scope = lookup(env.value, "scope")
            }
          }

          dynamic "alert" {
            for_each = lookup(worker.value, "alert") == null ? [] : ["alert"]
            content {
              operator = lookup(alert.value, "operator")
              rule     = lookup(alert.value, "rule")
              value    = lookup(alert.value, "value")
              window   = lookup(alert.value, "window")
            }
          }

          dynamic "log_destination" {
            for_each = lookup(worker.value, "log_destination") == null ? [] : ["log_destination"]
            content {
              name = lookup(log_destination.value, "name")

              dynamic "datadog" {
                for_each = lookup(log_destination.value, "datadog") == null ? [] : ["datadog"]
                content {
                  api_key  = lookup(datadog.value, "api_key")
                  endpoint = lookup(datadog.value, "endpoint")
                }
              }

              dynamic "logtail" {
                for_each = lookup(log_destination.value, "logtail") == null ? [] : ["logtail"]
                content {
                  token = lookup(logtail.value, "token")
                }
              }

              dynamic "papertrail" {
                for_each = lookup(log_destination.value, "papertrail") == null ? [] : ["papertrail"]
                content {
                  endpoint = lookup(papertrail.value, "endpoint")
                }
              }
            }
          }
        }
      }
    }
  }
}

resource "digitalocean_cdn" "this" {
  count            = length(var.cdn)
  origin           = lookup(var.cdn[count.index], "origin")
  ttl              = lookup(var.cdn[count.index], "ttl")
  certificate_name = try(
    element(digitalocean_certificate.this.*.name, lookup(var.cdn[count.index], "certificate_id"))
  )
  custom_domain    = lookup(var.cdn[count.index], "custom_domain")
}

resource "digitalocean_certificate" "this" {
  count             = length(var.certificate)
  name              = lookup(var.certificate[count.index], "name")
  type              = lookup(var.certificate[count.index], "type")
  private_key       = lookup(var.certificate[count.index], "type") == "custom" ? lookup(var.certificate[count.index], "private_key") : null
  leaf_certificate  = lookup(var.certificate[count.index], "type") == "custom" ? lookup(var.certificate[count.index], "leaf_certificate") : null
  certificate_chain = lookup(var.certificate[count.index], "type") == "custom" ? lookup(var.certificate[count.index], "certificate_chain") : null
  domains           = lookup(var.certificate[count.index], "type") == "lets_encrypt" ? lookup(var.certificate[count.index], "domains") : null
}

resource "digitalocean_container_registry" "this" {
  count                  = length(var.container_registry)
  name                   = lookup(var.container_registry[count.index], "name")
  subscription_tier_slug = lookup(var.container_registry[count.index], "subscription_tier_slug")
  region                 = try(
    element(digitalocean_vpc.this.*.region, lookup(var.container_registry[count.index], "vpc_id"))
  )
}

resource "digitalocean_container_registry_docker_credentials" "this" {
  count          = length(var.container_registry_docker_credentials)
  registry_name  = try(
    element(digitalocean_container_registry.this.*.name, lookup(var.container_registry_docker_credentials[count.index], "registry_id"))
  )
  write          = lookup(var.container_registry_docker_credentials[count.index], "write")
  expiry_seconds = lookup(var.container_registry_docker_credentials[count.index], "expiry_seconds")
}

resource "digitalocean_custom_image" "this" {
  count        = length(var.custom_image)
  name         = lookup(var.custom_image[count.index], "name")
  regions      = try(
    element(digitalocean_vpc.this.*.region, lookup(var.custom_image[count.index], "vpc_id"))
  )
  url          = lookup(var.custom_image[count.index], "url")
  description  = lookup(var.custom_image[count.index], "description")
  distribution = lookup(var.custom_image[count.index], "distribution")
  tags         = try(
    element(digitalocean_tag.this.*.name, lookup(var.custom_image[count.index], "tags"))
  )
}

resource "digitalocean_database_cluster" "this" {
  count                = length(var.database_cluster)
  engine               = lookup(var.database_cluster[count.index], "engine")
  name                 = lookup(var.database_cluster[count.index], "name")
  node_count           = lookup(var.database_cluster[count.index], "node_count")
  region               = try(
    element(digitalocean_vpc.this.*.region, lookup(var.database_cluster[count.index], "vpc_id"))
  )
  size                 = lookup(var.database_cluster[count.index], "size")
  version              = lookup(var.database_cluster[count.index], "version")
  tags                 = try(
    element(digitalocean_tag.this.*.name, lookup(var.database_cluster[count.index], "tags"))
  )
  private_network_uuid = lookup(var.database_cluster[count.index], "private_network_uuid")
  project_id           = lookup(var.database_cluster[count.index], "project_id")
  eviction_policy      = lookup(var.database_cluster[count.index], "eviction_policy")
  sql_mode             = lookup(var.database_cluster[count.index], "sql_mode")
  storage_size_mib     = lookup(var.database_cluster[count.index], "storage_size_mib")

  dynamic "maintenance_window" {
    for_each = lookup(var.database_cluster[count.index], "maintenance_window") == null ? [] : ["maintenance_window"]
    content {
      day  = lookup(maintenance_window.value, "day")
      hour = lookup(maintenance_window.value, "hour")

      dynamic "backup_restore" {
        for_each = lookup(maintenance_window.value, "backup_restore") == null ? [] : ["backup_restore"]
        content {
          database_name     = lookup(backup_restore.value, "database_name")
          backup_created_at = lookup(backup_restore.value, "backup_created_at")
        }
      }
    }
  }
}

resource "digitalocean_database_connection_pool" "this" {
  count = length(var.database_connection_pool) == "0" ? "0" : length(var.database_cluster)
  cluster_id = try(
    element(digitalocean_database_cluster.this.*.id, lookup(var.database_connection_pool[count.index], "cluster_id"))
  )
  db_name = lookup(var.database_connection_pool[count.index], "db_name")
  mode    = lookup(var.database_connection_pool[count.index], "mode")
  name    = lookup(var.database_connection_pool[count.index], "name")
  size    = lookup(var.database_connection_pool[count.index], "size")
  user    = lookup(var.database_connection_pool[count.index], "user")
}

resource "digitalocean_database_db" "this" {
  count = length(var.database_db) == "0" ? "0" : length(var.database_cluster)
  cluster_id = try(
    element(digitalocean_database_cluster.this.*.id, lookup(var.database_db[count.index], "cluster_id"))
  )
  name = lookup(var.database_db[count.index], "name")
}

resource "digitalocean_database_firewall" "this" {
  count = length(var.database_firewall) == "0" ? "0" : length(var.database_cluster)
  cluster_id = try(
    element(digitalocean_database_cluster.this.*.id, lookup(var.database_firewall[count.index], "cluster_id"))
  )

  dynamic "rule" {
    for_each = lookup(var.database_firewall[count.index], "rule") == null ? [] : ["rule"]
    content {
      type  = lookup(rule.value, "type")
      value = lookup(rule.value, "value")
    }
  }
}

resource "digitalocean_database_kafka_topic" "this" {
  count = length(var.database_kafka_topic) == "0" ? "0" : length(var.database_cluster)
  cluster_id = try(
    element(digitalocean_database_cluster.this.*.id, lookup(var.database_kafka_topic[count.index], "cluster_id"))
  )
  name               = lookup(var.database_kafka_topic[count.index], "name")
  partition_count    = lookup(var.database_kafka_topic[count.index], "partition_count")
  replication_factor = lookup(var.database_kafka_topic[count.index], "replication_factor")

  dynamic "config" {
    for_each = lookup(var.database_kafka_topic[count.index], "config") == null ? [] : ["config"]
    content {
      cleanup_policy                      = lookup(config.value, "cleanup_policy")
      compression_type                    = lookup(config.value, "compression_type")
      delete_retention_ms                 = lookup(config.value, "delete_retention_ms")
      file_delete_delay_ms                = lookup(config.value, "file_delete_delay_ms")
      flush_messages                      = lookup(config.value, "flush_messages")
      flush_ms                            = lookup(config.value, "flush_ms")
      index_interval_bytes                = lookup(config.value, "index_interval_bytes")
      max_compaction_lag_ms               = lookup(config.value, "max_compaction_lag_ms")
      max_message_bytes                   = lookup(config.value, "max_message_bytes")
      message_down_conversion_enable      = lookup(config.value, "message_down_conversion_enable")
      message_format_version              = lookup(config.value, "message_format_version")
      message_timestamp_difference_max_ms = lookup(config.value, "message_timestamp_difference_max_ms")
      message_timestamp_type              = lookup(config.value, "message_timestamp_type")
      min_cleanable_dirty_ratio           = lookup(config.value, "min_cleanable_dirty_ratio")
      min_insync_replicas                 = lookup(config.value, "min_insync_replicas")
      preallocate                         = lookup(config.value, "preallocate")
      retention_bytes                     = lookup(config.value, "retention_bytes")
      retention_ms                        = lookup(config.value, "retention_ms")
      segment_bytes                       = lookup(config.value, "segment_bytes")
      segment_index_bytes                 = lookup(config.value, "segment_index_bytes")
      segment_jitter_ms                   = lookup(config.value, "segment_jitter_ms")
    }
  }
}

resource "digitalocean_database_mysql_config" "this" {
  count = length(var.database_mysql_config) == "0" ? "0" : length(var.database_cluster)
  cluster_id = try(
    element(digitalocean_database_cluster.this.*.id, lookup(var.database_mysql_config[count.index], "cluster_id"))
  )
  backup_hour                      = lookup(var.database_mysql_config[count.index], "backup_hour")
  backup_minute                    = lookup(var.database_mysql_config[count.index], "backup_minute")
  binlog_retention_period          = lookup(var.database_mysql_config[count.index], "binlog_retention_period")
  connect_timeout                  = lookup(var.database_mysql_config[count.index], "connect_timeout")
  default_time_zone                = lookup(var.database_mysql_config[count.index], "default_time_zone")
  group_concat_max_len             = lookup(var.database_mysql_config[count.index], "group_concat_max_len")
  information_schema_stats_expiry  = lookup(var.database_mysql_config[count.index], "information_schema_stats_expiry")
  innodb_ft_min_token_size         = lookup(var.database_mysql_config[count.index], "innodb_ft_min_token_size")
  innodb_ft_server_stopword_table  = lookup(var.database_mysql_config[count.index], "innodb_ft_server_stopword_table")
  innodb_lock_wait_timeout         = lookup(var.database_mysql_config[count.index], "innodb_lock_wait_timeout")
  innodb_log_buffer_size           = lookup(var.database_mysql_config[count.index], "innodb_log_buffer_size")
  innodb_online_alter_log_max_size = lookup(var.database_mysql_config[count.index], "innodb_online_alter_log_max_size")
  innodb_print_all_deadlocks       = lookup(var.database_mysql_config[count.index], "innodb_print_all_deadlocks")
  innodb_rollback_on_timeout       = lookup(var.database_mysql_config[count.index], "innodb_rollback_on_timeout")
  internal_tmp_mem_storage_engine  = lookup(var.database_mysql_config[count.index], "internal_tmp_mem_storage_engine")
  interactive_timeout              = lookup(var.database_mysql_config[count.index], "interactive_timeout")
  long_query_time                  = lookup(var.database_mysql_config[count.index], "long_query_time")
  max_allowed_packet               = lookup(var.database_mysql_config[count.index], "max_allowed_packet")
  max_heap_table_size              = lookup(var.database_mysql_config[count.index], "max_heap_table_size")
  net_read_timeout                 = lookup(var.database_mysql_config[count.index], "net_read_timeout")
  net_write_timeout                = lookup(var.database_mysql_config[count.index], "net_write_timeout")
  sort_buffer_size                 = lookup(var.database_mysql_config[count.index], "sort_buffer_size")
  slow_query_log                   = lookup(var.database_mysql_config[count.index], "slow_query_log")
  sql_mode                         = lookup(var.database_mysql_config[count.index], "sql_mode")
  sql_require_primary_key          = lookup(var.database_mysql_config[count.index], "sql_require_primary_key")
  tmp_table_size                   = lookup(var.database_mysql_config[count.index], "tmp_table_size")
  wait_timeout                     = lookup(var.database_mysql_config[count.index], "wait_timeout")
}

resource "digitalocean_database_redis_config" "this" {
  count = length(var.database_redis_config) == "0" ? "0" : length(var.database_cluster)
  cluster_id = try(
    element(digitalocean_database_cluster.this.*.id, lookup(var.database_redis_config[count.index], "cluster_id"))
  )
  acl_channels_default              = lookup(var.database_redis_config[count.index], "acl_channels_default")
  io_threads                        = lookup(var.database_redis_config[count.index], "io_threads")
  lfu_decay_time                    = lookup(var.database_redis_config[count.index], "lfu_decay_time")
  lfu_log_factor                    = lookup(var.database_redis_config[count.index], "lfu_log_factor")
  maxmemory_policy                  = lookup(var.database_redis_config[count.index], "maxmemory_policy")
  notify_keyspace_events            = lookup(var.database_redis_config[count.index], "notify_keyspace_events")
  number_of_databases               = lookup(var.database_redis_config[count.index], "number_of_databases")
  persistence                       = lookup(var.database_redis_config[count.index], "persistence")
  pubsub_client_output_buffer_limit = lookup(var.database_redis_config[count.index], "pubsub_client_output_buffer_limit")
  ssl                               = lookup(var.database_redis_config[count.index], "ssl")
  timeout                           = lookup(var.database_redis_config[count.index], "timeout")
}

resource "digitalocean_database_replica" "this" {
  count = length(var.database_replica) == "0" ? "0" : length(var.database_cluster)
  cluster_id = try(
    element(digitalocean_database_cluster.this.*.id, lookup(var.database_replica[count.index], "cluster_id"))
  )
  name                 = lookup(var.database_replica[count.index], "name")
  size                 = lookup(var.database_replica[count.index], "size")
  region               = lookup(var.database_replica[count.index], "region")
  tags                 = merge(
    try(
      element(digitalocean_tag.this.*.name, lookup(var.database_replica[count.index], "tags"))
    ),
    lookup(var.database_replica[count.index], "tags")
  )
  private_network_uuid = lookup(var.database_replica[count.index], "private_network_uuid")
}

resource "digitalocean_database_user" "this" {
  count = length(var.database_user) == "0" ? "0" : length(var.database_cluster)
  cluster_id = try(
    element(digitalocean_database_cluster.this.*.id, lookup(var.database_user[count.index], "cluster_id"))
  )
  name              = lookup(var.database_user[count.index], "name")
  mysql_auth_plugin = lookup(var.database_user[count.index], "mysql_auth_plugin")

  dynamic "settings" {
    for_each = lookup(var.database_user[count.index], "settings") == null ? [] : ["settings"]
    content {
      dynamic "acl" {
        for_each = lookup(settings.value, "acl") == null ? [] : ["acl"]
        content {
          topic      = lookup(acl.value, "topic")
          permission = lookup(acl.value, "permission")
        }
      }
    }
  }
}

resource "digitalocean_domain" "this" {
  count      = length(var.domain)
  name       = lookup(var.domain[count.index], "name")
  ip_address = try(element(digitalocean_droplet.this.*.ipv4_address, lookup(var.domain[count.index], "droplet_id")))
}

resource "digitalocean_droplet" "this" {
  count             = length(var.droplet)
  image             = lookup(var.droplet[count.index], "image")
  name              = lookup(var.droplet[count.index], "name")
  size              = lookup(var.droplet[count.index], "size")
  backups           = lookup(var.droplet[count.index], "backups")
  monitoring        = lookup(var.droplet[count.index], "monitoring")
  ipv6              = lookup(var.droplet[count.index], "ipv6")
  region = try(
    element(digitalocean_vpc.this.*.region, lookup(var.droplet[count.index], "vpc_id"))
  )
  vpc_uuid          = try(
    element(digitalocean_vpc.this.*.id, lookup(var.droplet[count.index], "vpc_uuid"))
  )
  ssh_keys          = try(
    element(digitalocean_ssh_key.this.*.id, lookup(var.droplet[count.index], "ssh_keys"))
  )
  resize_disk       = lookup(var.droplet[count.index], "resize_disk")
  tags              = try(
    element(digitalocean_tag.this.*.name, lookup(var.droplet[count.index], "tags"))
  )
  user_data         = lookup(var.droplet[count.index], "user_data")
  volume_ids        = try(
    element(digitalocean_volume.this.*.id, lookup(var.droplet[count.index], "volume_ids"))
  )
  droplet_agent     = lookup(var.droplet[count.index], "droplet_agent")
  graceful_shutdown = lookup(var.droplet[count.index], "graceful_shutdown")
}

resource "digitalocean_droplet_snapshot" "this" {
  count = length(var.droplet_snapshot) == "0" ? "0" : length(var.droplet)
  droplet_id = try(
    element(digitalocean_droplet.this.*.id, lookup(var.droplet_snapshot[count.index], "droplet_id"))
  )
  name = lookup(var.droplet_snapshot[count.index], "name")
}

resource "digitalocean_firewall" "this" {
  count = length(var.firewall)
  name  = lookup(var.firewall[count.index], "name")
  droplet_ids = try(
    element(digitalocean_droplet.this.*.id, lookup(var.firewall[count.index], "droplet_ids"))
  )
  tags = merge(
    try(
      element(digitalocean_tag.this.*.name, lookup(var.firewall[count.index], "tags"))
    ),
    lookup(var.firewall[count.index], "tags")
  )

  dynamic "inbound_rule" {
    for_each = lookup(var.firewall[count.index], "inbound_rule") == null ? [] : ["inbound_rule"]
    content {
      protocol                  = lookup(inbound_rule.value, "protocol")
      port_range                = lookup(inbound_rule.value, "port_range")
      source_addresses          = lookup(inbound_rule.value, "source_addresses")
      source_droplet_ids        = lookup(inbound_rule.value, "source_droplet_ids")
      source_kubernetes_ids     = lookup(inbound_rule.value, "source_kubernetes_ids")
      source_load_balancer_uids = lookup(inbound_rule.value, "source_load_balancer_uids")
      source_tags               = try(
        element(digitalocean_tag.this.*.name, lookup(inbound_rule.value, "source_tags"))
      )
    }
  }

  dynamic "outbound_rule" {
    for_each = lookup(var.firewall[count.index], "outbound_rule") == null ? [] : ["outbound_rule"]
    content {
      protocol                       = lookup(outbound_rule.value, "protocol")
      port_range                     = lookup(outbound_rule.value, "port_range")
      destination_addresses          = lookup(outbound_rule.value, "destination_addresses")
      destination_droplet_ids        = lookup(outbound_rule.value, "destination_droplet_ids")
      destination_kubernetes_ids     = lookup(outbound_rule.value, "destination_kubernetes_ids")
      destination_load_balancer_uids = lookup(outbound_rule.value, "destination_load_balancer_uids")
      destination_tags               = try(
        element(digitalocean_tag.this.*.name, lookup(outbound_rule.value, "destination_tags"))
      )
    }
  }
}

resource "digitalocean_floating_ip" "this" {
  count  = length(var.floating_ip) == "0" ? "0" : length(var.droplet)
  region = try(
    element(digitalocean_droplet.this.*.region, lookup(var.floating_ip[count.index], "droplet_id"))
  )
  droplet_id = try(
    element(digitalocean_droplet.this.*.id, lookup(var.floating_ip[count.index], "droplet_id"))
  )
}

resource "digitalocean_floating_ip_assignment" "this" {
  count = length(var.floating_ip_assignment) == "0" ? "0" : length(var.droplet)
  droplet_id = try(
    element(digitalocean_droplet.this.*.id, lookup(var.floating_ip_assignment[count.index], "droplet_id"))
  )
  ip_address = try(
    element(digitalocean_floating_ip.this.*.ip_address, lookup(var.floating_ip_assignment[count.index], "ip_address_id"))
  )
}

resource "digitalocean_kubernetes_cluster" "this" {
  count                            = length(var.kubernetes_cluster)
  name                             = lookup(var.kubernetes_cluster[count.index], "name")
  region                           = lookup(var.kubernetes_cluster[count.index], "region")
  version                          = lookup(var.kubernetes_cluster[count.index], "version")
  vpc_uuid                         = try(
    element(digitalocean_vpc.this.*.id, lookup(var.kubernetes_cluster[count.index], "vpc_uuid"))
  )
  auto_upgrade                     = lookup(var.kubernetes_cluster[count.index], "auto_upgrade")
  surge_upgrade                    = lookup(var.kubernetes_cluster[count.index], "surge_upgrade")
  ha                               = lookup(var.kubernetes_cluster[count.index], "ha")
  registry_integration             = lookup(var.kubernetes_cluster[count.index], "registry_integration")
  tags                             = try(
    element(digitalocean_tag.this.*.name, lookup(var.kubernetes_cluster[count.index], "tags"))
  )
  destroy_all_associated_resources = lookup(var.kubernetes_cluster[count.index], "destroy_all_associated_resources")

  dynamic "node_pool" {
    for_each = lookup(var.kubernetes_cluster[count.index], "node_pool") == null ? [] : ["node_pool"]
    content {
      name       = lookup(node_pool.value, "name")
      size       = lookup(node_pool.value, "size")
      node_count = lookup(node_pool.value, "node_count")
      auto_scale = lookup(node_pool.value, "auto_scale")
      min_nodes  = lookup(node_pool.value, "min_nodes")
      max_nodes  = lookup(node_pool.value, "max_nodes")
      tags       = try(
        element(digitalocean_tag.this.*.name, lookup(node_pool.value, "tags"))
      )
      labels     = lookup(node_pool.value, "labels")

      dynamic "taint" {
        for_each = lookup(node_pool.value, "taint") == null ? [] : ["taint"]
        content {
          effect = lookup(taint.value, "effect")
          key    = lookup(taint.value, "key")
          value  = lookup(taint.value, "value")
        }
      }
    }
  }

  dynamic "maintenance_policy" {
    for_each = lookup(var.kubernetes_cluster[count.index], "maintenance_policy") == null ? [] : ["maintenance_policy"]
    content {
      day        = lookup(maintenance_policy.value, "day")
      start_time = lookup(maintenance_policy.value, "start_time")
    }
  }
}

resource "digitalocean_kubernetes_node_pool" "this" {
  count = length(var.kubernetes_node_pool) == "0" ? "0" : length(var.kubernetes_cluster)
  cluster_id = try(
    element(digitalocean_kubernetes_cluster.this.*.id, lookup(var.kubernetes_node_pool[count.index], "cluster_id"))
  )
  name       = lookup(var.kubernetes_node_pool[count.index], "name")
  size       = lookup(var.kubernetes_node_pool[count.index], "size")
  node_count = lookup(var.kubernetes_node_pool[count.index], "node_count")
  auto_scale = lookup(var.kubernetes_node_pool[count.index], "auto_scale")
  min_nodes  = lookup(var.kubernetes_node_pool[count.index], "min_nodes")
  max_nodes  = lookup(var.kubernetes_node_pool[count.index], "max_nodes")
  tags       = try(
    element(digitalocean_tag.this.*.name, lookup(var.kubernetes_node_pool[count.index], "tags"))
  )
  labels     = lookup(var.kubernetes_node_pool[count.index], "labels")

  dynamic "taint" {
    for_each = lookup(var.kubernetes_node_pool[count.index], "taint") == null ? [] : ["taint"]
    content {
      effect = lookup(taint.value, "effect")
      key    = lookup(taint.value, "key")
      value  = lookup(taint.value, "value")
    }
  }
}

resource "digitalocean_loadbalancer" "this" {
  count                            = length(var.loadbalancer)
  name                             = lookup(var.loadbalancer[count.index], "name")
  region                           = try(
    element(digitalocean_vpc.this.*.region, lookup(var.loadbalancer[count.index], "vpc_id"))
  )
  size                             = lookup(var.loadbalancer[count.index], "size")
  size_unit                        = lookup(var.loadbalancer[count.index], "size_unit")
  redirect_http_to_https           = lookup(var.loadbalancer[count.index], "redirect_http_to_https")
  enable_proxy_protocol            = lookup(var.loadbalancer[count.index], "enable_proxy_protocol")
  enable_backend_keepalive         = lookup(var.loadbalancer[count.index], "enable_backend_keepalive")
  disable_lets_encrypt_dns_records = lookup(var.loadbalancer[count.index], "disable_lets_encrypt_dns_records")
  project_id                       = lookup(var.loadbalancer[count.index], "project_id")
  vpc_uuid                         = try(
    element(digitalocean_vpc.this.*.id, lookup(var.loadbalancer[count.index], "vpc_uuid"))
  )
  droplet_ids = try(
    element(digitalocean_droplet.this.*.id, lookup(var.loadbalancer[count.index], "droplet_ids"))
  )
  droplet_tag = try(
    element(digitalocean_droplet.this.*.tags, lookup(var.loadbalancer[count.index], "droplet_ids"))
  )

  dynamic "forwarding_rule" {
    for_each = lookup(var.loadbalancer[count.index], "forwarding_rule") == null ? [] : ["forwarding_rule"]
    content {
      entry_port       = lookup(forwarding_rule.value, "entry_port")
      entry_protocol   = lookup(forwarding_rule.value, "entry_protocol")
      target_port      = lookup(forwarding_rule.value, "target_port")
      target_protocol  = lookup(forwarding_rule.value, "target_protocol")
      certificate_name = lookup(forwarding_rule.value, "certificate_name")
      tls_passthrough  = lookup(forwarding_rule.value, "tls_passthrough")
    }
  }

  dynamic "healthcheck" {
    for_each = lookup(var.loadbalancer[count.index], "healthcheck") == null ? [] : ["healthcheck"]
    content {
      port                     = lookup(healthcheck.value, "port")
      protocol                 = lookup(healthcheck.value, "protocol")
      path                     = lookup(healthcheck.value, "path")
      check_interval_seconds   = lookup(healthcheck.value, "check_interval_seconds")
      response_timeout_seconds = lookup(healthcheck.value, "response_timeout_seconds")
      unhealthy_threshold      = lookup(healthcheck.value, "unhealthy_threshold")
      healthy_threshold        = lookup(healthcheck.value, "healthy_threshold")
    }
  }

  dynamic "sticky_sessions" {
    for_each = lookup(var.loadbalancer[count.index], "sticky_sessions") == null ? [] : ["sticky_sessions"]
    content {
      type               = lookup(sticky_sessions.value, "type")
      cookie_name        = lookup(sticky_sessions.value, "cookie_name")
      cookie_ttl_seconds = lookup(sticky_sessions.value, "cookie_ttl_seconds")
    }
  }

  dynamic "firewall" {
    for_each = lookup(var.loadbalancer[count.index], "firewall") == null ? [] : ["firewall"]
    content {
      deny  = lookup(firewall.value, "deny")
      allow = lookup(firewall.value, "allow")
    }
  }

  dynamic "domains" {
    for_each = lookup(var.loadbalancer[count.index], "domains") == null ? [] : ["domains"]
    content {
      name       = lookup(domains.value, "name")
      is_managed = lookup(domains.value, "is_managed")
      certificate_id = try(
        element(digitalocean_certificate.this.*.id, lookup(domains.value, "certificate_id"))
      )
    }
  }

  dynamic "glb_settings" {
    for_each = lookup(var.loadbalancer[count.index], "glb_settings") == null ? [] : ["glb_settings"]
    content {
      target_protocol = lookup(glb_settings.value, "target_protocol")
      target_port     = lookup(glb_settings.value, "target_port")
      cdn {
        is_enabled = true
      }
    }
  }
}

resource "digitalocean_monitor_alert" "this" {
  count       = length(var.monitor_alert)
  compare     = lookup(var.monitor_alert[count.index], "compare")
  description = lookup(var.monitor_alert[count.index], "description")
  type        = lookup(var.monitor_alert[count.index], "type")
  value       = lookup(var.monitor_alert[count.index], "value")
  window      = lookup(var.monitor_alert[count.index], "window")
  enabled     = lookup(var.monitor_alert[count.index], "enabled")
  entities    = lookup(var.monitor_alert[count.index], "entities")
  tags        = try(
    element(digitalocean_tag.this.*.name, lookup(var.monitor_alert[count.index], "tags"))
  )

  dynamic "alerts" {
    for_each = lookup(var.monitor_alert[count.index], "alerts") == null ? [] : ["alerts"]
    content {
      email = lookup(alerts.value, "email")
      slack {
        channel = lookup(alerts.value, "channel")
        url     = lookup(alerts.value, "url")
      }
    }
  }
}

resource "digitalocean_project" "this" {
  count       = length(var.project)
  name        = lookup(var.project[count.index], "name")
  description = lookup(var.project[count.index], "description")
  purpose     = lookup(var.project[count.index], "purpose")
  environment = lookup(var.project[count.index], "environment")
  resources   = lookup(var.project[count.index], "resources")
  is_default  = lookup(var.project[count.index], "is_default")
}

resource "digitalocean_project_resources" "this" {
  count = length(var.project_resources) == "0" ? "0" : length(var.project)
  project = try(
    element(digitalocean_project.this.*.id, lookup(var.project_resources[count.index], "project_id"))
  )
  resources = lookup(var.project_resources[count.index], "resources")
}

resource "digitalocean_record" "this" {
  count = length(var.record) == "0" ? "0" : length(var.domain)
  domain = try(
    element(digitalocean_domain.this.*.id, lookup(var.record[count.index], "domain_id"))
  )
  name     = lookup(var.record[count.index], "name")
  type     = lookup(var.record[count.index], "type")
  value    = lookup(var.record[count.index], "value")
  port     = lookup(var.record[count.index], "port")
  priority = lookup(var.record[count.index], "priority")
  weight   = lookup(var.record[count.index], "weight")
  ttl      = lookup(var.record[count.index], "ttl")
  flags    = lookup(var.record[count.index], "flags")
  tag      = try(
    element(digitalocean_tag.this.*.name, lookup(var.record[count.index], "tag"))
  )
}

resource "digitalocean_reserved_ip" "this" {
  count  = length(var.reserved_ip)
  region = try(
    element(digitalocean_vpc.this.*.region, lookup(var.reserved_ip[count.index], "vpc_id"))
  )
  droplet_id = try(
    element(digitalocean_droplet.this.*.id, lookup(var.reserved_ip[count.index], "droplet_id"))
  )
}

resource "digitalocean_reserved_ip_assignment" "this" {
  count = length(var.reserved_ip_assignment) == "0" ? "0" : (length(var.droplet) && length(var.reserved_ip))
  droplet_id = try(
    element(digitalocean_droplet.this.*.id, lookup(var.reserved_ip_assignment[count.index], "droplet_id"))
  )
  ip_address = try(
    element(digitalocean_reserved_ip.this.*.ip_address, lookup(var.reserved_ip_assignment[count.index], "ip_address_id"))
  )
}

resource "digitalocean_spaces_bucket" "this" {
  count  = length(var.spaces_bucket)
  name   = lookup(var.spaces_bucket[count.index], "name")
  region = try(
    element(digitalocean_vpc.this.*.region, lookup(var.spaces_bucket[count.index], "vpc_id"))
  )
  acl    = lookup(var.spaces_bucket[count.index], "acl")
}

resource "digitalocean_spaces_bucket_cors_configuration" "this" {
  count = length(var.spaces_bucket_cors_configuration)
  bucket = try(
    element(digitalocean_spaces_bucket.this.*.id, lookup(var.spaces_bucket_cors_configuration[count.index], "bucket_id"))
  )
  region = try(
    element(digitalocean_vpc.this.*.region, lookup(var.spaces_bucket_cors_configuration[count.index], "vpc_id"))
  )

  dynamic "cors_rule" {
    for_each = lookup(var.spaces_bucket_cors_configuration[count.index], "cors_rule")
    content {
      allowed_methods = lookup(cors_rule.value, "allowed_methods")
      allowed_origins = lookup(cors_rule.value, "allowed_origins")
      allowed_headers = lookup(cors_rule.value, "allowed_headers")
      expose_headers  = lookup(cors_rule.value, "expose_headers")
      id              = lookup(cors_rule.value, "id")
      max_age_seconds = lookup(cors_rule.value, "max_age_seconds")
    }
  }
}

resource "digitalocean_spaces_bucket_object" "this" {
  count = length(var.spaces_bucket_object)
  bucket = try(
    element(digitalocean_spaces_bucket.this.*.name, lookup(var.spaces_bucket_object[count.index], "bucket_id"))
  )
  key                 = lookup(var.spaces_bucket_object[count.index], "key")
  region              = try(
    element(digitalocean_vpc.this.*.region, lookup(var.spaces_bucket_object[count.index], "vpc_id"))
  )
  acl                 = lookup(var.spaces_bucket_object[count.index], "acl")
  cache_control       = lookup(var.spaces_bucket_object[count.index], "cache_control")
  content             = lookup(var.spaces_bucket_object[count.index], "content")
  content_base64      = lookup(var.spaces_bucket_object[count.index], "content_base64")
  content_disposition = lookup(var.spaces_bucket_object[count.index], "content_disposition")
  content_encoding    = lookup(var.spaces_bucket_object[count.index], "content_encoding")
  content_language    = lookup(var.spaces_bucket_object[count.index], "content_language")
  content_type        = lookup(var.spaces_bucket_object[count.index], "content_type")
  etag                = lookup(var.spaces_bucket_object[count.index], "etag")
  force_destroy       = lookup(var.spaces_bucket_object[count.index], "force_destroy")
  metadata            = lookup(var.spaces_bucket_object[count.index], "metadata")
  source              = lookup(var.spaces_bucket_object[count.index], "source")
  website_redirect    = lookup(var.spaces_bucket_object[count.index], "website_redirect")
}

resource "digitalocean_spaces_bucket_policy" "this" {
  count  = length(var.spaces_bucket_policy)
  bucket = try(digitalocean_spaces_bucket.this.*.name, lookup(var.spaces_bucket_policy[count.index], "bucket_id"))
  policy = lookup(var.spaces_bucket_policy[count.index], "policy")
  region = try(
    element(digitalocean_vpc.this.*.region, lookup(var.spaces_bucket_policy[count.index], "vpc_id"))
  )
}

resource "digitalocean_ssh_key" "this" {
  count      = length(var.ssh_key)
  name       = lookup(var.ssh_key[count.index], "name")
  public_key = lookup(var.ssh_key[count.index], "public_key")
}

resource "digitalocean_tag" "this" {
  count = length(var.tag)
  name  = lookup(var.tag[count.index], "name")
}

resource "digitalocean_uptime_alert" "this" {
  count      = length(var.uptime_alert) == "0" ? "0" : length(var.uptime_check)
  check_id   = try(element(digitalocean_uptime_check.this.*.id, lookup(var.uptime_alert[count.index], "check_id")))
  name       = lookup(var.uptime_alert[count.index], "name")
  type       = lookup(var.uptime_alert[count.index], "type")
  threshold  = lookup(var.uptime_alert[count.index], "threshold")
  comparison = lookup(var.uptime_alert[count.index], "comparison")
  period     = lookup(var.uptime_alert[count.index], "period")

  dynamic "notifications" {
    for_each = lookup(var.uptime_alert[count.index], "notifications") == null ? [] : ["notifications"]
    content {
      email = lookup(notifications.value, "email")
      slack {
        channel = lookup(notifications.value, "channel")
        url     = lookup(notifications.value, "url")
      }
    }
  }
}

resource "digitalocean_uptime_check" "this" {
  count   = length(var.uptime_check)
  name    = lookup(var.uptime_check[count.index], "name")
  target  = lookup(var.uptime_check[count.index], "target")
  type    = lookup(var.uptime_check[count.index], "type")
  regions = try(
    element(digitalocean_vpc.this.*.region, lookup(var.uptime_check[count.index], "vpc_id"))
  )
  enabled = lookup(var.uptime_check[count.index], "enabled")
}

resource "digitalocean_volume" "this" {
  count       = length(var.volume)
  name        = lookup(var.volume[count.index], "name")
  region      = try(
    element(digitalocean_vpc.this.*.region, lookup(var.volume[count.index], "vpc_id"))
  )
  size        = lookup(var.volume[count.index], "size")
  description = lookup(var.volume[count.index], "description")
  snapshot_id = try(
    element(digitalocean_volume_snapshot.this.*.id, lookup(var.volume[count.index], "snapshot_id"))
  )
  initial_filesystem_label = lookup(var.volume[count.index], "initial_filesystem_label")
  initial_filesystem_type  = lookup(var.volume[count.index], "initial_filesystem_type")
  tags                     = try(
    element(digitalocean_tag.this.*.name, lookup(var.volume[count.index], "tags"))
  )
}

resource "digitalocean_volume_attachment" "this" {
  count = length(var.volume_attachment)
  droplet_id = try(
    element(digitalocean_droplet.this.*.id, lookup(var.volume_attachment[count.index], "droplet_id"))
  )
  volume_id = try(
    element(digitalocean_volume.this.*.id, lookup(var.volume_attachment[count.index], "volume_id"))
  )
}

resource "digitalocean_volume_snapshot" "this" {
  count = length(var.volume_snapshot)
  name  = lookup(var.volume_snapshot[count.index], "name")
  volume_id = try(
    element(digitalocean_volume.this.*.id, lookup(var.volume_snapshot[count.index], "volume_id"))
  )
  tags = try(
    element(digitalocean_tag.this.*.name, lookup(var.volume_snapshot[count.index], "tags"))
  )
}

resource "digitalocean_vpc" "this" {
  count       = length(var.vpc)
  name        = lookup(var.vpc[count.index], ["name"])
  region      = lookup(var.vpc[count.index], ["region"])
  description = lookup(var.vpc[count.index], ["description"])
  ip_range    = lookup(var.vpc[count.index], ["ip_range"])
}