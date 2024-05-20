variable "app" {
  type = list(map(object({
    id = number
    spec = list(object({
      name   = string
      region = optional(string)
      domain = optional(list(object({
        name     = string
        type     = string
        wildcard = optional(bool)
        zone     = optional(string)
      })), [])
      env = optional(list(object({
        key   = string
        value = optional(string)
        scope = optional(string)
        type  = optional(string)
      })), [])
      alert = optional(list(object({
        rule     = string
        disabled = optional(bool)
      })), [])
      ingress = optional(list(object({
        rule = optional(list(object({
          component = optional(list(object({
            name                 = string
            preserve_path_prefix = optional(bool)
            rewrite              = optional(string)
          })), [])
          match = optional(list(object({
            path = optional(list(object({
              prefix = string
            })), [])
          })), [])
          redirect = optional(list(object({
            uri           = string
            authority     = optional(string)
            port          = optional(number)
            scheme        = optional(string)
            redirect_code = optional(number)
          })), [])
          cors = optional(list(object({
            allow_credentials = optional(bool)
            allow_headers     = optional(set(string))
            allow_methods     = optional(set(string))
            max_age           = optional(string)
            expose_headers    = optional(set(string))
            allow_origins = optional(list(object({
              exact  = optional(string)
              prefix = optional(string)
              regex  = optional(string)
            })), [])
          })), [])
        })), [])
      })), [])
      service = optional(list(object({
        name               = string
        build_command      = optional(string)
        dockerfile_path    = optional(string)
        source_dir         = optional(string)
        run_command        = optional(string)
        environment_slug   = optional(string)
        instance_count     = optional(number)
        http_port          = optional(number)
        internal_ports     = optional(set(number))
        instance_size_slug = optional(string)
        git = optional(list(object({
          repo_clone_url = string
          branch         = optional(string)
        })), [])
        github = optional(list(object({
          repo           = string
          branch         = optional(string)
          deploy_on_push = optional(bool)
        })), [])
        gitlab = optional(list(object({
          repo           = string
          branch         = optional(string)
          deploy_on_push = optional(bool)
        })), [])
        image = optional(list(object({
          registry_type = string
          repository    = string
          registry      = optional(string)
          tag           = optional(string)
        })), [])
        env = optional(list(object({
          key   = string
          value = optional(string)
          scope = optional(string)
        })), [])
        health_check = optional(list(object({
          http_path             = string
          initial_delay_seconds = optional(number)
          period_seconds        = optional(number)
          success_threshold     = optional(number)
          failure_threshold     = optional(number)
        })), [])
      })), [])
      static_site = optional(list(object({
        name              = string
        build_command     = optional(string)
        dockerfile_path   = optional(string)
        source_dir        = optional(string)
        environment_slug  = optional(string)
        output_dir        = optional(string)
        index_document    = optional(string)
        error_document    = optional(string)
        catchall_document = optional(string)
        git = optional(list(object({
          repo_clone_url = string
          branch         = optional(string)
        })), [])
        github = optional(list(object({
          repo           = string
          branch         = optional(string)
          deploy_on_push = optional(bool)
        })), [])
        gitlab = optional(list(object({
          repo           = string
          branch         = optional(string)
          deploy_on_push = optional(bool)
        })), [])
        image = optional(list(object({
          registry_type = string
          repository    = string
          registry      = optional(string)
          tag           = optional(string)
        })), [])
        env = optional(list(object({
          key   = string
          value = optional(string)
          scope = optional(string)
        })), [])
      })), [])
      job = optional(list(object({
        name               = string
        kind               = string
        build_command      = optional(string)
        dockerfile_path    = optional(string)
        source_dir         = optional(string)
        environment_slug   = optional(string)
        instance_count     = optional(number)
        instance_size_slug = optional(string)
        git = optional(list(object({
          repo_clone_url = string
          branch         = optional(string)
        })), [])
        github = optional(list(object({
          repo           = string
          branch         = optional(string)
          deploy_on_push = optional(bool)
        })), [])
        gitlab = optional(list(object({
          repo           = string
          branch         = optional(string)
          deploy_on_push = optional(bool)
        })), [])
        image = optional(list(object({
          registry_type = string
          repository    = string
          registry      = optional(string)
          tag           = optional(string)
        })), [])
        env = optional(list(object({
          key   = string
          value = optional(string)
          scope = optional(string)
        })), [])
        alert = optional(list(object({
          operator = string
          rule     = string
          value    = number
          window   = string
        })), [])
        log_destination = optional(list(object({
          name = string
          datadog = optional(list(object({
            api_key  = string
            endpoint = optional(string)
          })), [])
          logtail = optional(list(object({
            token = string
          })), [])
          papertrail = optional(list(object({
            endpoint = string
          })), [])
        })), [])
      })), [])
      function = optional(list(object({
        name       = string
        source_dir = optional(string)
        git = optional(list(object({
          repo_clone_url = string
          branch         = optional(string)
        })), [])
        github = optional(list(object({
          repo           = string
          branch         = optional(string)
          deploy_on_push = optional(bool)
        })), [])
        gitlab = optional(list(object({
          repo           = string
          branch         = optional(string)
          deploy_on_push = optional(bool)
        })), [])
        image = optional(list(object({
          registry_type = string
          repository    = string
          registry      = optional(string)
          tag           = optional(string)
        })), [])
        env = optional(list(object({
          key   = string
          value = optional(string)
          scope = optional(string)
        })), [])
        alert = optional(list(object({
          operator = string
          rule     = string
          value    = number
          window   = string
        })), [])
        log_destination = optional(list(object({
          name = string
          datadog = optional(list(object({
            api_key  = string
            endpoint = optional(string)
          })), [])
          logtail = optional(list(object({
            token = string
          })), [])
          papertrail = optional(list(object({
            endpoint = string
          })), [])
        })), [])
      })), [])
      database = optional(list(object({
        name         = string
        engine       = optional(string)
        version      = optional(string)
        production   = optional(bool)
        cluster_name = optional(string)
        db_name      = optional(string)
        db_user      = optional(string)
      })), [])
      worker = optional(list(object({
        name               = string
        build_command      = optional(string)
        dockerfile_path    = optional(string)
        source_dir         = optional(string)
        run_command        = optional(string)
        environment_slug   = optional(string)
        instance_size_slug = optional(string)
        instance_count     = optional(string)
        http_port          = optional(string)
        git = optional(list(object({
          repo_clone_url = string
          branch         = optional(string)
        })), [])
        github = optional(list(object({
          repo           = string
          branch         = optional(string)
          deploy_on_push = optional(bool)
        })), [])
        gitlab = optional(list(object({
          repo           = string
          branch         = optional(string)
          deploy_on_push = optional(bool)
        })), [])
        image = optional(list(object({
          registry_type = string
          repository    = string
          registry      = optional(string)
          tag           = optional(string)
        })), [])
        env = optional(list(object({
          key   = string
          value = optional(string)
          scope = optional(string)
        })), [])
        alert = optional(list(object({
          operator = string
          rule     = string
          value    = number
          window   = string
        })), [])
        log_destination = optional(list(object({
          name = string
          datadog = optional(list(object({
            api_key  = string
            endpoint = optional(string)
          })), [])
          logtail = optional(list(object({
            token = string
          })), [])
          papertrail = optional(list(object({
            endpoint = string
          })), [])
        })), [])
      })), [])
    }))
  })))
  default    = []
  decription = <<EOF
  EOF
}

variable "cdn" {
  type = list(map(object({
    id               = number
    origin           = string
    ttl              = optional(number)
    certificate_name = optional(string)
    custom_domain    = optional(string)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
origin - (Required) The fully qualified domain name, (FQDN) for a Space.
ttl - (Optional) The time to live for the CDN Endpoint, in seconds. Default is 3600 seconds.
certificate_name- (Optional) The unique name of a DigitalOcean managed TLS certificate used for SSL when a custom subdomain is provided.
custom_domain - (Optional) The fully qualified domain name (FQDN) of the custom subdomain used with the CDN Endpoint.
  EOF
}

variable "certificate" {
  type = list(map(object({
    id                = number
    name              = string
    type              = optional(string)
    private_key       = optional(string)
    leaf_certificate  = optional(string)
    certificate_chain = optional(string)
    domains           = optional(set(string))
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
name - (Required) The name of the certificate for identification.
type - (Optional) The type of certificate to provision. Can be either custom or lets_encrypt. Defaults to custom.
private_key - (Optional) The contents of a PEM-formatted private-key corresponding to the SSL certificate. Only valid when type is custom.
leaf_certificate - (Optional) The contents of a PEM-formatted public TLS certificate. Only valid when type is custom.
certificate_chain - (Optional) The full PEM-formatted trust chain between the certificate authority's certificate and your domain's TLS certificate. Only valid when type is custom.
domains - (Optional) List of fully qualified domain names (FQDNs) for which the certificate will be issued. The domains must be managed using DigitalOcean's DNS. Only valid when type is lets_encrypt.
  EOF
}

variable "container_registry" {
  type = list(map(object({
    id                     = number
    name                   = string
    subscription_tier_slug = string
    vpc_id                 = optional(number)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
name - (Required) The name of the container_registry
subscription_tier_slug - (Required) The slug identifier for the subscription tier to use (starter, basic, or professional)
region - (Optional) The slug identifier of for region where registry data will be stored. When not provided, a region will be selected automatically.
  EOF

  validation {
    condition     = contains(["starter", "basic", "professional"], var.container_registry[0].subscription_tier_slug)
    error_message = "Valid values : starter, basic, or professional."
  }
}

variable "container_registry_docker_credentials" {
  type = list(map(object({
    id             = number
    registry_id    = number
    write          = optional(bool)
    expiry_seconds = optional(number)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
registry_name - (Required) The name of the container registry.
write - (Optional) Allow for write access to the container registry. Defaults to false.
expiry_seconds - (Optional) The amount of time to pass before the Docker credentials expire in seconds. Defaults to 1576800000, or roughly 50 years. Must be greater than 0 and less than 1576800000.
  EOF
}

variable "custom_image" {
  type = list(map(object({
    id           = number
    name         = string
    vpc_id       = set(number)
    url          = string
    description  = optional(string)
    distribution = optional(string)
    tags         = optional(set(number))
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
name - (Required) A name for the Custom Image.
url - (Required) A URL from which the custom Linux virtual machine image may be retrieved.
regions - (Required) A list of regions. (Currently only one is supported).
description - An optional description for the image.
distribution - An optional distribution name for the image. Valid values are documented here
tags - A list of optional tags for the image.
  EOF
}

variable "database_cluster" {
  type = list(map(object({
    id                   = number
    engine               = string
    name                 = string
    node_count           = number
    region               = number
    size                 = string
    version              = optional(string)
    tags                 = optional(set(number))
    private_network_uuid = optional(string)
    project_id           = optional(string)
    eviction_policy      = optional(string)
    sql_mode             = optional(string)
    storage_size_mib     = optional(string)
    maintenance_window = optional(list(object({
      day  = string
      hour = string
      backup_restore = optional(list(object({
        database_name     = string
        backup_created_at = string
      })), [])
    })), [])
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
name - (Required) The name of the database cluster.
engine - (Required) Database engine used by the cluster (ex. pg for PostreSQL, mysql for MySQL, redis for Redis, mongodb for MongoDB, or kafka for Kafka).
size - (Required) Database Droplet size associated with the cluster (ex. db-s-1vcpu-1gb). See here for a list of valid size slugs.
region - (Required) DigitalOcean region where the cluster will reside.
node_count - (Required) Number of nodes that will be included in the cluster. For kafka clusters, this must be 3.
version - (Required) Engine version used by the cluster (ex. 14 for PostgreSQL 14). When this value is changed, a call to the Upgrade major Version for a Database API operation is made with the new version.
tags - (Optional) A list of tag names to be applied to the database cluster.
private_network_uuid - (Optional) The ID of the VPC where the database cluster will be located.
project_id - (Optional) The ID of the project that the database cluster is assigned to. If excluded when creating a new database cluster, it will be assigned to your default project.
eviction_policy - (Optional) A string specifying the eviction policy for a Redis cluster. Valid values are: noeviction, allkeys_lru, allkeys_random, volatile_lru, volatile_random, or volatile_ttl.
sql_mode - (Optional) A comma separated string specifying the SQL modes for a MySQL cluster.
maintenance_window - (Optional) Defines when the automatic maintenance should be performed for the database cluster.
storage_size_mib - (Optional) Defines the disk size, in MiB, allocated to the cluster. This can be adjusted on MySQL and PostreSQL clusters based on predefined ranges for each slug/droplet size.

maintenance_window supports the following:
day - (Required) The day of the week on which to apply maintenance updates.
hour - (Required) The hour in UTC at which maintenance updates will be applied in 24 hour format.
backup_restore - (Optional) Create a new database cluster based on a backup of an existing cluster.

backup_restore supports the following:
database_name - (Required) The name of an existing database cluster from which the backup will be restored.
backup_created_at - (Optional) The timestamp of an existing database cluster backup in ISO8601 combined date and time format. The most recent backup will be used if excluded.
  EOF

  validation {
    condition     = contains(["pg", "mysql", "redis", "mongodb", "kafka"], var.database_cluster[0].engine)
    error_message = "Database engine used by the cluster (ex. pg for PostreSQL, mysql for MySQL, redis for Redis, mongodb for MongoDB, or kafka for Kafka)."
  }
}

variable "database_connection_pool" {
  type = list(map(object({
    id         = number
    cluster_id = number
    db_name    = string
    mode       = string
    name       = string
    size       = number
    user       = optional(string)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
cluster_id - (Required) The ID of the source database cluster. Note: This must be a PostgreSQL cluster.
name - (Required) The name for the database connection pool.
mode - (Required) The PGBouncer transaction mode for the connection pool. The allowed values are session, transaction, and statement.
size - (Required) The desired size of the PGBouncer connection pool.
db_name - (Required) The database for use with the connection pool.
user - (Optional) The name of the database user for use with the connection pool. When excluded, all sessions connect to the database as the inbound user.
  EOF
}

variable "database_db" {
  type = list(map(object({
    id         = number
    cluster_id = number
    name       = string
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
cluster_id - (Required) The ID of the original source database cluster.
name - (Required) The name for the database.
  EOF
}

variable "database_firewall" {
  type = list(map(object({
    id         = number
    cluster_id = number
    rule = list(object({
      type  = string
      value = string
    }))
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
cluster_id - (Required) The ID of the target database cluster.
rule - (Required) A rule specifying a resource allowed to access the database cluster. The following arguments must be specified:
type - (Required) The type of resource that the firewall rule allows to access the database cluster. The possible values are: droplet, k8s, ip_addr, tag, or app.
value - (Required) The ID of the specific resource, the name of a tag applied to a group of resources, or the IP address that the firewall rule allows to access the database cluster.
  EOF
}

variable "database_kafka_topic" {
  type = list(map(object({
    id                 = number
    cluster_id         = number
    name               = string
    partition_count    = optional(number)
    replication_factor = optional(number)
    config = optional(list(object({
      cleanup_policy                      = optional(string)
      compression_type                    = optional(string)
      delete_retention_ms                 = optional(string)
      file_delete_delay_ms                = optional(string)
      flush_messages                      = optional(string)
      flush_ms                            = optional(string)
      index_interval_bytes                = optional(string)
      max_compaction_lag_ms               = optional(string)
      max_message_bytes                   = optional(string)
      message_down_conversion_enable      = optional(bool)
      message_format_version              = optional(string)
      message_timestamp_difference_max_ms = optional(string)
      message_timestamp_type              = optional(string)
      min_cleanable_dirty_ratio           = optional(number)
      min_insync_replicas                 = optional(number)
      preallocate                         = optional(bool)
      retention_bytes                     = optional(string)
      retention_ms                        = optional(string)
      segment_bytes                       = optional(string)
      segment_index_bytes                 = optional(string)
      segment_jitter_ms                   = optional(string)
    })), [])
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
cluster_id - (Required) The ID of the source database cluster. Note: This must be a Kafka cluster.
name - (Required) The name for the topic.
partition_count - (Optional) The number of partitions for the topic. Default and minimum set at 3, maximum is 2048.
replication_factor - (Optional) The number of nodes that topics are replicated across. Default and minimum set at 2, maximum is the number of nodes in the cluster.
config - (Optional) A set of advanced configuration parameters. Defaults will be set for any of the parameters that are not included. The config block is documented below.

config supports the following:
cleanup_policy - (Optional) The topic cleanup policy that decribes whether messages should be deleted, compacted, or both when retention policies are violated. This may be one of "delete", "compact", or "compact_delete".
compression_type - (Optional) The topic compression codecs used for a given topic. This may be one of "uncompressed", "gzip", "snappy", "lz4", "producer", "zstd". "uncompressed" indicates that there is no compression and "producer" retains the original compression codec set by the producer.
delete_retention_ms - (Optional) The amount of time, in ms, that deleted records are retained.
file_delete_delay_ms - (Optional) The amount of time, in ms, to wait before deleting a topic log segment from the filesystem.
flush_messages - (Optional) The number of messages accumulated on a topic partition before they are flushed to disk.
flush_ms - (Optional) The maximum time, in ms, that a topic is kept in memory before being flushed to disk.
index_interval_bytes - (Optional) The interval, in bytes, in which entries are added to the offset index.
max_compaction_lag_ms - (Optional) The maximum time, in ms, that a particular message will remain uncompacted. This will not apply if the compression_type is set to "uncompressed" or it is set to producer and the producer is not using compression.
max_message_bytes - (Optional) The maximum size, in bytes, of a message.
message_down_conversion_enable - (Optional) Determines whether down-conversion of message formats for consumers is enabled.
message_format_version - (Optional) The version of the inter-broker protocol that will be used. This may be one of "0.8.0", "0.8.1", "0.8.2", "0.9.0", "0.10.0", "0.10.0-IV0", "0.10.0-IV1", "0.10.1", "0.10.1-IV0", "0.10.1-IV1", "0.10.1-IV2", "0.10.2", "0.10.2-IV0", "0.11.0", "0.11.0-IV0", "0.11.0-IV1", "0.11.0-IV2", "1.0", "1.0-IV0", "1.1", "1.1-IV0", "2.0", "2.0-IV0", "2.0-IV1", "2.1", "2.1-IV0", "2.1-IV1", "2.1-IV2", "2.2", "2.2-IV0", "2.2-IV1", "2.3", "2.3-IV0", "2.3-IV1", "2.4", "2.4-IV0", "2.4-IV1", "2.5", "2.5-IV0", "2.6", "2.6-IV0", "2.7", "2.7-IV0", "2.7-IV1", "2.7-IV2", "2.8", "2.8-IV0", "2.8-IV1", "3.0", "3.0-IV0", "3.0-IV1", "3.1", "3.1-IV0", "3.2", "3.2-IV0", "3.3", "3.3-IV0", "3.3-IV1", "3.3-IV2", "3.3-IV3", "3.4", "3.4-IV0", "3.5", "3.5-IV0", "3.5-IV1", "3.5-IV2", "3.6", "3.6-IV0", "3.6-IV1", "3.6-IV2".
message_timestamp_difference_max_ms - (Optional) The maximum difference, in ms, between the timestamp specific in a message and when the broker receives the message.
message_timestamp_type - (Optional) Specifies which timestamp to use for the message. This may be one of "create_time" or "log_append_time".
min_cleanable_dirty_ratio - (Optional) A scale between 0.0 and 1.0 which controls the frequency of the compactor. Larger values mean more frequent compactions. This is often paired with max_compaction_lag_ms to control the compactor frequency.
min_insync_replicas - (Optional) The number of replicas that must acknowledge a write before it is considered successful. -1 is a special setting to indicate that all nodes must ack a message before a write is considered successful. Default is 1, indicating at least 1 replica must acknowledge a write to be considered successful.
preallocate - (Optional) Determines whether to preallocate a file on disk when creating a new log segment within a topic.
retention_bytes - (Optional) The maximum size, in bytes, of a topic before messages are deleted. -1 is a special setting indicating that this setting has no limit.
retention_ms - (Optional) The maximum time, in ms, that a topic log file is retained before deleting it. -1 is a special setting indicating that this setting has no limit.
segment_bytes - (Optional) The maximum size, in bytes, of a single topic log file.
segment_index_bytes - (Optional) The maximum size, in bytes, of the offset index.
segment_jitter_ms - (Optional) The maximum time, in ms, subtracted from the scheduled segment disk flush time to avoid the thundering herd problem for segment flushing.
segment_ms - (Optional) The maximum time, in ms, before the topic log will flush to disk.
  EOF
}

variable "database_mysql_config" {
  type = list(map(object({
    id                               = number
    cluster_id                       = number
    backup_hour                      = optional(number)
    backup_minute                    = optional(number)
    binlog_retention_period          = optional(number)
    connect_timeout                  = optional(number)
    default_time_zone                = optional(string)
    group_concat_max_len             = optional(number)
    information_schema_stats_expiry  = optional(number)
    innodb_ft_min_token_size         = optional(number)
    innodb_ft_server_stopword_table  = optional(string)
    innodb_lock_wait_timeout         = optional(number)
    innodb_log_buffer_size           = optional(number)
    innodb_online_alter_log_max_size = optional(number)
    innodb_print_all_deadlocks       = optional(bool)
    innodb_rollback_on_timeout       = optional(bool)
    internal_tmp_mem_storage_engine  = optional(string)
    interactive_timeout              = optional(number)
    long_query_time                  = optional(number)
    max_allowed_packet               = optional(number)
    max_heap_table_size              = optional(number)
    net_read_timeout                 = optional(number)
    net_write_timeout                = optional(number)
    sort_buffer_size                 = optional(number)
    slow_query_log                   = optional(number)
    sql_mode                         = optional(string)
    sql_require_primary_key          = optional(bool)
    tmp_table_size                   = optional(number)
    wait_timeout                     = optional(number)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported :
cluster_id - (Required) The ID of the target MySQL cluster.
connect_timeout - (Optional) The number of seconds that the mysqld server waits for a connect packet before responding with bad handshake.
default_time_zone - (Optional) Default server time zone, in the form of an offset from UTC (from -12:00 to +12:00), a time zone name (EST), or SYSTEM to use the MySQL server default.
innodb_log_buffer_size - (Optional) The size of the buffer, in bytes, that InnoDB uses to write to the log files. on disk.
innodb_online_alter_log_max_size - (Optional) The upper limit, in bytes, of the size of the temporary log files used during online DDL operations for InnoDB tables.
innodb_lock_wait_timeout - (Optional) The time, in seconds, that an InnoDB transaction waits for a row lock. before giving up.
interactive_timeout - (Optional) The time, in seconds, the server waits for activity on an interactive. connection before closing it.
max_allowed_packet - (Optional) The size of the largest message, in bytes, that can be received by the server. Default is 67108864 (64M).
net_read_timeout - (Optional) The time, in seconds, to wait for more data from an existing connection. aborting the read.
sort_buffer_size - (Optional) The sort buffer size, in bytes, for ORDER BY optimization. Default is 262144. (256K).
sql_mode - (Optional) Global SQL mode. If empty, uses MySQL server defaults. Must only include uppercase alphabetic characters, underscores, and commas.
sql_require_primary_key - (Optional) Require primary key to be defined for new tables or old tables modified with ALTER TABLE and fail if missing. It is recommended to always have primary keys because various functionality may break if any large table is missing them.
wait_timeout - (Optional) The number of seconds the server waits for activity on a noninteractive connection before closing it.
net_write_timeout - (Optional) The number of seconds to wait for a block to be written to a connection before aborting the write.
group_concat_max_len - (Optional) The maximum permitted result length, in bytes, for the GROUP_CONCAT() function.
information_schema_stats_expiry - (Optional) The time, in seconds, before cached statistics expire.
innodb_ft_min_token_size - (Optional) The minimum length of words that an InnoDB FULLTEXT index stores.
innodb_ft_server_stopword_table - (Optional) The InnoDB FULLTEXT index stopword list for all InnoDB tables.
innodb_print_all_deadlocks - (Optional) When enabled, records information about all deadlocks in InnoDB user transactions in the error log. Disabled by default.
innodb_rollback_on_timeout - (Optional) When enabled, transaction timeouts cause InnoDB to abort and roll back the entire transaction.
internal_tmp_mem_storage_engine - (Optional) The storage engine for in-memory internal temporary tables. Supported values are: TempTable, MEMORY.
max_heap_table_size - (Optional) The maximum size, in bytes, of internal in-memory tables. Also set tmp_table_size. Default is 16777216 (16M)
tmp_table_size - (Optional) The maximum size, in bytes, of internal in-memory tables. Also set max_heap_table_size. Default is 16777216 (16M).
slow_query_log - (Optional) When enabled, captures slow queries. When disabled, also truncates the mysql.slow_log table. Default is false.
long_query_time - (Optional) The time, in seconds, for a query to take to execute before being captured by slow_query_logs. Default is 10 seconds.
backup_hour - (Optional) The hour of day (in UTC) when backup for the service starts. New backup only starts if previous backup has already completed.
backup_minute - (Optional) The minute of the backup hour when backup for the service starts. New backup only starts if previous backup has already completed.
binlog_retention_period - (Optional) The minimum amount of time, in seconds, to keep binlog entries before deletion. This may be extended for services that require binlog entries for longer than the default, for example if using the MySQL Debezium Kafka connector.
  EOF
}

variable "database_redis_config" {
  type = list(map(object({
    id                                = number
    cluster_id                        = number
    acl_channels_default              = optional(string)
    io_threads                        = optional(number)
    lfu_decay_time                    = optional(number)
    lfu_log_factor                    = optional(number)
    maxmemory_policy                  = optional(string)
    notify_keyspace_events            = optional(string)
    number_of_databases               = optional(number)
    persistence                       = optional(string)
    pubsub_client_output_buffer_limit = optional(number)
    ssl                               = optional(bool)
    timeout                           = optional(number)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported :
cluster_id - (Required) The ID of the target Redis cluster.
maxmemory_policy - (Optional) A string specifying the desired eviction policy for the Redis cluster.Supported values are: noeviction, allkeys-lru, allkeys-random, volatile-lru, volatile-random, volatile-ttl
pubsub_client_output_buffer_limit - (Optional) The output buffer limit for pub/sub clients in MB. The value is the hard limit, the soft limit is 1/4 of the hard limit. When setting the limit, be mindful of the available memory in the selected service plan.
number_of_databases - (Optional) The number of Redis databases. Changing this will cause a restart of Redis service.
io_threads - (Optional) The Redis IO thread count.
lfu_log_factor - (Optional) The counter logarithm factor for volatile-lfu and allkeys-lfu maxmemory policies.
lfu_decay_time - (Optional) The LFU maxmemory policy counter decay time in minutes.
ssl - (Optional) A boolean indicating whether to require SSL to access Redis.
timeout - (Optional) The Redis idle connection timeout in seconds.
notify_keyspace_events - (Optional) The notify-keyspace-events option. Requires at least K or E.
persistence - (Optional) When persistence is rdb, Redis does RDB dumps each 10 minutes if any key is changed. Also RDB dumps are done according to backup schedule for backup purposes. When persistence is off, no RDB dumps and backups are done, so data can be lost at any moment if service is restarted for any reason, or if service is powered off. Also service can't be forked.
acl_channels_default - (Optional) Determines default pub/sub channels' ACL for new users if an ACL is not supplied. When this option is not defined, allchannels is assumed to keep backward compatibility. This option doesn't affect Redis' acl-pubsub-default configuration. Supported values are: allchannels and resetchannels
  EOF
}

variable "database_replica" {
  type = list(map(object({
    id                   = number
    cluster_id           = number
    name                 = string
    size                 = optional(string)
    region               = optional(string)
    tags                 = optional(set(string))
    private_network_uuid = optional(string)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
cluster_id - (Required) The ID of the original source database cluster.
name - (Required) The name for the database replica.
size - (Required) Database Droplet size associated with the replica (ex. db-s-1vcpu-1gb). Note that when resizing an existing replica, its size can only be increased. Decreasing its size is not supported.
region - (Required) DigitalOcean region where the replica will reside.
tags - (Optional) A list of tag names to be applied to the database replica.
private_network_uuid - (Optional) The ID of the VPC where the database replica will be located.
  EOF
}

variable "database_user" {
  type = list(map(object({
    id                = number
    cluster_id        = number
    name              = string
    mysql_auth_plugin = optional(string)
    settings = optional(list(object({
      acl = optional(list(object({
        topic      = string
        permission = string
      })), [])
    })), [])
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
cluster_id - (Required) The ID of the original source database cluster.
name - (Required) The name for the database user.
mysql_auth_plugin - (Optional) The authentication method to use for connections to the MySQL user account. The valid values are mysql_native_password or caching_sha2_password (this is the default).
settings - (Optional) Contains optional settings for the user. The settings block is documented below.

settings supports the following:
acl - (Optional) A set of ACLs (Access Control Lists) specifying permission on topics with a Kafka cluster. The properties of an individual ACL are described below:

An individual ACL includes the following:
topic - (Required) A regex for matching the topic(s) that this ACL should apply to. The regex can assume one of 3 patterns: "", "", or "". "" is a special value indicating a wildcard that matches on all topics. "" defines a regex that matches all topics with the prefix. "" performs an exact match on a topic name and only applies to that topic.
permission - (Required) The permission level applied to the ACL. This includes "admin", "consume", "produce", and "produceconsume". "admin" allows for producing and consuming as well as add/delete/update permission for topics. "consume" allows only for reading topic messages. "produce" allows only for writing topic messages. "produceconsume" allows for both reading and writing topic messages.
  EOF
}

variable "domain" {
  type = list(map(object({
    id         = number
    name       = string
    droplet_id = optional(number)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
name - (Required) The name of the domain
ip_address - (Optional) The IP address of the domain. If specified, this IP is used to created an initial A record for the domain.
  EOF
}

variable "droplet" {
  type = list(map(object({
    id                = number
    image             = string
    name              = string
    size              = string
    backups           = optional(bool)
    monitoring        = optional(bool)
    ipv6              = optional(bool)
    vpc_uuid          = optional(number)
    ssh_keys          = optional(set(number))
    resize_disk       = optional(bool)
    tags              = optional(set(number))
    user_data         = optional(string)
    volume_ids        = optional(set(number))
    droplet_agent     = optional(bool)
    graceful_shutdown = optional(bool)
    vpc_id            = optional(number)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
image - (Required) The Droplet image ID or slug. This could be either image ID or droplet snapshot ID.
name - (Required) The Droplet name.
region - The region where the Droplet will be created.
size - (Required) The unique slug that indentifies the type of Droplet. You can find a list of available slugs on DigitalOcean API documentation.
backups - (Optional) Boolean controlling if backups are made. Defaults to false.
monitoring - (Optional) Boolean controlling whether monitoring agent is installed. Defaults to false. If set to true, you can configure monitor alert policies monitor alert resource
ipv6 - (Optional) Boolean controlling if IPv6 is enabled. Defaults to false. Once enabled for a Droplet, IPv6 can not be disabled. When enabling IPv6 on an existing Droplet, additional OS-level configuration is required.
vpc_uuid - (Optional) The ID of the VPC where the Droplet will be located.
private_networking - (Optional) Deprecated Boolean controlling if private networking is enabled. This parameter has been deprecated. Use vpc_uuid instead to specify a VPC network for the Droplet. If no vpc_uuid is provided, the Droplet will be placed in your account's default VPC for the region.
ssh_keys - (Optional) A list of SSH key IDs or fingerprints to enable in the format [12345, 123456]. To retrieve this info, use the DigitalOcean API or CLI (doctl compute ssh-key list). Once a Droplet is created keys can not be added or removed via this provider. Modifying this field will prompt you to destroy and recreate the Droplet.
resize_disk - (Optional) Boolean controlling whether to increase the disk size when resizing a Droplet. It defaults to true. When set to false, only the Droplet's RAM and CPU will be resized. Increasing a Droplet's disk size is a permanent change. Increasing only RAM and CPU is reversible.
tags - (Optional) A list of the tags to be applied to this Droplet.
user_data (Optional) - A string of the desired User Data for the Droplet.
volume_ids (Optional) - A list of the IDs of each block storage volume to be attached to the Droplet.
droplet_agent (Optional) - A boolean indicating whether to install the DigitalOcean agent used for providing access to the Droplet web console in the control panel. By default, the agent is installed on new Droplets but installation errors (i.e. OS not supported) are ignored. To prevent it from being installed, set to false. To make installation errors fatal, explicitly set it to true.
graceful_shutdown (Optional) - A boolean indicating whether the droplet should be gracefully shut down before it is deleted.
  EOF
}

variable "droplet_snapshot" {
  type = list(map(object({
    id         = number
    droplet_id = number
    name       = string
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
name - (Required) A name for the Droplet snapshot.
droplet_id - (Required) The ID of the Droplet from which the snapshot will be taken.
  EOF
}

variable "firewall" {
  type = list(map(object({
    id          = number
    name        = string
    droplet_ids = optional(set(number))
    tags        = optional(set(number))
    inbound_rule = optional(list(object({
      protocol                  = string
      port_range                = optional(string)
      source_addresses          = optional(set(string))
      source_droplet_ids        = optional(set(string))
      source_kubernetes_ids     = optional(set(string))
      source_load_balancer_uids = optional(set(string))
      source_tags               = optional(set(number))
    })), [])
    outbound_rule = optional(list(object({
      protocol                       = string
      port_range                     = optional(string)
      destination_addresses          = optional(set(string))
      destination_droplet_ids        = optional(set(string))
      destination_kubernetes_ids     = optional(set(string))
      destination_load_balancer_uids = optional(set(string))
      destination_tags               = optional(set(number))
    })), [])
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
name - (Required) The Firewall name
droplet_ids (Optional) - The list of the IDs of the Droplets assigned to the Firewall.
tags (Optional) - The names of the Tags assigned to the Firewall.
inbound_rule - (Optional) The inbound access rule block for the Firewall. The inbound_rule block is documented below.
outbound_rule - (Optional) The outbound access rule block for the Firewall. The outbound_rule block is documented below.

inbound_rule supports the following:
protocol - (Required) The type of traffic to be allowed. This may be one of "tcp", "udp", or "icmp".
port_range - (Optional) The ports on which traffic will be allowed specified as a string containing a single port, a range (e.g. "8000-9000"), or "1-65535" to open all ports for a protocol. Required for when protocol is tcp or udp.
source_addresses - (Optional) An array of strings containing the IPv4 addresses, IPv6 addresses, IPv4 CIDRs, and/or IPv6 CIDRs from which the inbound traffic will be accepted.
source_droplet_ids - (Optional) An array containing the IDs of the Droplets from which the inbound traffic will be accepted.
source_tags - (Optional) An array containing the names of Tags corresponding to groups of Droplets from which the inbound traffic will be accepted.
source_load_balancer_uids - (Optional) An array containing the IDs of the Load Balancers from which the inbound traffic will be accepted.
source_kubernetes_ids - (Optional) An array containing the IDs of the Kubernetes clusters from which the inbound traffic will be accepted.

outbound_rule supports the following:
protocol - (Required) The type of traffic to be allowed. This may be one of "tcp", "udp", or "icmp".
port_range - (Optional) The ports on which traffic will be allowed specified as a string containing a single port, a range (e.g. "8000-9000"), or "1-65535" to open all ports for a protocol. Required for when protocol is tcp or udp.
destination_addresses - (Optional) An array of strings containing the IPv4 addresses, IPv6 addresses, IPv4 CIDRs, and/or IPv6 CIDRs to which the outbound traffic will be allowed.
destination_droplet_ids - (Optional) An array containing the IDs of the Droplets to which the outbound traffic will be allowed.
destination_kubernetes_ids - (Optional) An array containing the IDs of the Kubernetes clusters to which the outbound traffic will be allowed.
destination_tags - (Optional) An array containing the names of Tags corresponding to groups of Droplets to which the outbound traffic will be allowed.
destination_load_balancer_uids - (Optional) An array containing the IDs of the Load Balancers to which the outbound traffic will be allowed.
  EOF
}

variable "floating_ip" {
  type = list(map(object({
    id         = number
    region     = string
    droplet_id = optional(number)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
region - (Required) The region that the Floating IP is reserved to.
droplet_id - (Optional) The ID of Droplet that the Floating IP will be assigned to.
  EOF
}

variable "floating_ip_assignment" {
  type = list(map(object({
    id            = number
    droplet_id    = number
    ip_address_id = number
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
ip_address - (Required) The Floating IP to assign to the Droplet.
droplet_id - (Optional) The ID of Droplet that the Floating IP will be assigned to.
  EOF
}

variable "kubernetes_cluster" {
  type = list(map(object({
    id                               = number
    name                             = string
    region                           = string
    version                          = string
    vpc_uuid                         = optional(string)
    auto_upgrade                     = optional(bool)
    surge_upgrade                    = optional(bool)
    ha                               = optional(bool)
    registry_integration             = optional(bool)
    tags                             = optional(set(string))
    destroy_all_associated_resources = optional(bool)
    node_pool = optional(list(object({
      name       = optional(string)
      size       = optional(string)
      node_count = optional(number)
      auto_scale = optional(bool)
      min_nodes  = optional(number)
      max_nodes  = optional(number)
      tags       = optional(set(string))
      labels     = optional(map(string))
      taint = optional(list(object({
        effect = string
        key    = string
        value  = string
      })), [])
    })), [])
    maintenance_policy = optional(list(object({
      day        = optional(string)
      start_time = optional(string)
    })), [])
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
name - (Required) A name for the Kubernetes cluster.
region - (Required) The slug identifier for the region where the Kubernetes cluster will be created.
version - (Required) The slug identifier for the version of Kubernetes used for the cluster. Use doctl to find the available versions doctl kubernetes options versions. (Note: A cluster may only be upgraded to newer versions in-place. If the version is decreased, a new resource will be created.)
vpc_uuid - (Optional) The ID of the VPC where the Kubernetes cluster will be located.
auto_upgrade - (Optional) A boolean value indicating whether the cluster will be automatically upgraded to new patch releases during its maintenance window.
surge_upgrade - (Optional) Enable/disable surge upgrades for a cluster. Default: false
ha - (Optional) Enable/disable the high availability control plane for a cluster. Once enabled for a cluster, high availability cannot be disabled. Default: false
registry_integration - (optional) Enables or disables the DigitalOcean container registry integration for the cluster. This requires that a container registry has first been created for the account. Default: false
node_pool - (Required) A block representing the cluster's default node pool. Additional node pools may be added to the cluster using the digitalocean_kubernetes_node_pool resource. The following arguments may be specified:
name - (Required) A name for the node pool.
size - (Required) The slug identifier for the type of Droplet to be used as workers in the node pool.
node_count - (Optional) The number of Droplet instances in the node pool. If auto-scaling is enabled, this should only be set if the desired result is to explicitly reset the number of nodes to this value. If auto-scaling is enabled, and the node count is outside of the given min/max range, it will use the min nodes value.
auto_scale - (Optional) Enable auto-scaling of the number of nodes in the node pool within the given min/max range.
min_nodes - (Optional) If auto-scaling is enabled, this represents the minimum number of nodes that the node pool can be scaled down to.
max_nodes - (Optional) If auto-scaling is enabled, this represents the maximum number of nodes that the node pool can be scaled up to.
tags - (Optional) A list of tag names applied to the node pool.
labels - (Optional) A map of key/value pairs to apply to nodes in the pool. The labels are exposed in the Kubernetes API as labels in the metadata of the corresponding Node resources.
tags - (Optional) A list of tag names to be applied to the Kubernetes cluster.
maintenance_policy - (Optional) A block representing the cluster's maintenance window. Updates will be applied within this window. If not specified, a default maintenance window will be chosen. auto_upgrade must be set to true for this to have an effect.
day - (Required) The day of the maintenance window policy. May be one of "monday" through "sunday", or "any" to indicate an arbitrary week day.
start_time (Required) The start time in UTC of the maintenance window policy in 24-hour clock format / HH:MM notation (e.g., 15:00).
destroy_all_associated_resources - (Optional) Use with caution. When set to true, all associated DigitalOcean resources created via the Kubernetes API (load balancers, volumes, and volume snapshots) will be destroyed along with the cluster when it is destroyed.
  EOF
}

variable "kubernetes_node_pool" {
  type = list(map(object({
    id         = number
    cluster_id = number
    name       = string
    size       = string
    node_count = optional(number)
    auto_scale = optional(bool)
    min_nodes  = optional(number)
    max_nodes  = optional(number)
    tags       = optional(set(string))
    labels     = optional(map(string))
    taint = optional(list(object({
      effect = string
      key    = string
      value  = string
    })), [])
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
cluster_id - (Required) The ID of the Kubernetes cluster to which the node pool is associated.
name - (Required) A name for the node pool.
size - (Required) The slug identifier for the type of Droplet to be used as workers in the node pool.
node_count - (Optional) The number of Droplet instances in the node pool. If auto-scaling is enabled, this should only be set if the desired result is to explicitly reset the number of nodes to this value. If auto-scaling is enabled, and the node count is outside of the given min/max range, it will use the min nodes value.
auto_scale - (Optional) Enable auto-scaling of the number of nodes in the node pool within the given min/max range.
min_nodes - (Optional) If auto-scaling is enabled, this represents the minimum number of nodes that the node pool can be scaled down to.
max_nodes - (Optional) If auto-scaling is enabled, this represents the maximum number of nodes that the node pool can be scaled up to.
tags - (Optional) A list of tag names to be applied to the Kubernetes cluster.
labels - (Optional) A map of key/value pairs to apply to nodes in the pool. The labels are exposed in the Kubernetes API as labels in the metadata of the corresponding Node resources.
taint - (Optional) A list of taints applied to all nodes in the pool.
  EOF
}

variable "loadbalancer" {
  type = list(map(object({
    id                               = number
    name                             = string
    vpc_id                           = optional(number)
    size                             = optional(string)
    size_unit                        = optional(number)
    redirect_http_to_https           = optional(bool)
    enable_proxy_protocol            = optional(bool)
    enable_backend_keepalive         = optional(bool)
    disable_lets_encrypt_dns_records = optional(bool)
    project_id                       = optional(string)
    vpc_uuid                         = optional(string)
    droplet_ids                      = optional(set(number))
    forwarding_rule = optional(list(object({
      entry_port       = number
      entry_protocol   = string
      target_port      = number
      target_protocol  = string
      certificate_name = optional(string)
      tls_passthrough  = optional(bool)
    })), [])
    healthcheck = optional(list(object({
      port                     = number
      protocol                 = string
      path                     = optional(string)
      check_interval_seconds   = optional(number)
      response_timeout_seconds = optional(number)
      unhealthy_threshold      = optional(number)
      healthy_threshold        = optional(number)
    })), [])
    sticky_sessions = optional(list(object({
      type               = optional(string)
      cookie_name        = optional(string)
      cookie_ttl_seconds = optional(number)
    })), [])
    firewall = optional(list(object({
      deny  = optional(set(string))
      allow = optional(set(string))
    })), [])
    domains = optional(list(object({
      name           = optional(string)
      is_managed     = optional(bool)
      certificate_id = optional(number)
    })), [])
    glb_settings = optional(list(object({
      target_protocol = string
      target_port     = string
    })), [])
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
name - (Required) The Load Balancer name
region - (Required) The region to start in
size - (Optional) The size of the Load Balancer. It must be either lb-small, lb-medium, or lb-large. Defaults to lb-small. Only one of size or size_unit may be provided.
size_unit - (Optional) The size of the Load Balancer. It must be in the range (1, 100). Defaults to 1. Only one of size or size_unit may be provided.
algorithm - (Optional) Deprecated This field has been deprecated. You can no longer specify an algorithm for load balancers. or least_connections. The default value is round_robin.
forwarding_rule - (Required) A list of forwarding_rule to be assigned to the Load Balancer. The forwarding_rule block is documented below.
healthcheck - (Optional) A healthcheck block to be assigned to the Load Balancer. The healthcheck block is documented below. Only 1 healthcheck is allowed.
sticky_sessions - (Optional) A sticky_sessions block to be assigned to the Load Balancer. The sticky_sessions block is documented below. Only 1 sticky_sessions block is allowed.
redirect_http_to_https - (Optional) A boolean value indicating whether HTTP requests to the Load Balancer on port 80 will be redirected to HTTPS on port 443. Default value is false.
enable_proxy_protocol - (Optional) A boolean value indicating whether PROXY Protocol should be used to pass information from connecting client requests to the backend service. Default value is false.
enable_backend_keepalive - (Optional) A boolean value indicating whether HTTP keepalive connections are maintained to target Droplets. Default value is false.
http_idle_timeout_seconds - (Optional) Specifies the idle timeout for HTTPS connections on the load balancer in seconds.
disable_lets_encrypt_dns_records - (Optional) A boolean value indicating whether to disable automatic DNS record creation for Let's Encrypt certificates that are added to the load balancer. Default value is false.
project_id - (Optional) The ID of the project that the load balancer is associated with. If no ID is provided at creation, the load balancer associates with the user's default project.
vpc_uuid - (Optional) The ID of the VPC where the load balancer will be located.
droplet_ids (Optional) - A list of the IDs of each droplet to be attached to the Load Balancer.
droplet_tag (Optional) - The name of a Droplet tag corresponding to Droplets to be assigned to the Load Balancer.
firewall (Optional) - A block containing rules for allowing/denying traffic to the Load Balancer. The firewall block is documented below. Only 1 firewall is allowed.
domains (Optional) - A list of domains required to ingress traffic to a Global Load Balancer. The domains block is documented below. NOTE: this is a closed beta feature and not available for public use.
glb_settings (Optional) - A block containing glb_settings required to define target rules for a Global Load Balancer. The glb_settings block is documented below. NOTE: this is a closed beta feature and not available for public use.
target_load_balancer_ids (Optional) - A list of Load Balancer IDs to be attached behind a Global Load Balancer. NOTE: this is a closed beta feature and not available for public use.

forwarding_rule supports the following:
entry_protocol - (Required) The protocol used for traffic to the Load Balancer. The possible values are: http, https, http2, http3, tcp, or udp.
entry_port - (Required) An integer representing the port on which the Load Balancer instance will listen.
target_protocol - (Required) The protocol used for traffic from the Load Balancer to the backend Droplets. The possible values are: http, https, http2, tcp, or udp.
target_port - (Required) An integer representing the port on the backend Droplets to which the Load Balancer will send traffic.
certificate_name - (Optional) The unique name of the TLS certificate to be used for SSL termination.
certificate_id - (Optional) Deprecated The ID of the TLS certificate to be used for SSL termination.
tls_passthrough - (Optional) A boolean value indicating whether SSL encrypted traffic will be passed through to the backend Droplets. The default value is false.

sticky_sessions supports the following:
type - (Required) An attribute indicating how and if requests from a client will be persistently served by the same backend Droplet. The possible values are cookies or none. If not specified, the default value is none.
cookie_name - (Optional) The name to be used for the cookie sent to the client. This attribute is required when using cookies for the sticky sessions type.
cookie_ttl_seconds - (Optional) The number of seconds until the cookie set by the Load Balancer expires. This attribute is required when using cookies for the sticky sessions type.

healthcheck supports the following:
protocol - (Required) The protocol used for health checks sent to the backend Droplets. The possible values are http, https or tcp.
port - (Optional) An integer representing the port on the backend Droplets on which the health check will attempt a connection.
path - (Optional) The path on the backend Droplets to which the Load Balancer instance will send a request.
check_interval_seconds - (Optional) The number of seconds between two consecutive health checks. If not specified, the default value is 10.
response_timeout_seconds - (Optional) The number of seconds the Load Balancer instance will wait for a response until marking a health check as failed. If not specified, the default value is 5.
unhealthy_threshold - (Optional) The number of times a health check must fail for a backend Droplet to be marked "unhealthy" and be removed from the pool. If not specified, the default value is 3.
healthy_threshold - (Optional) The number of times a health check must pass for a backend Droplet to be marked "healthy" and be re-added to the pool. If not specified, the default value is 5.

firewall supports the following:
deny - (Optional) A list of strings describing deny rules. Must be colon delimited strings of the form {type}:{source}
allow - (Optional) A list of strings describing allow rules. Must be colon delimited strings of the form {type}:{source}
Ex. deny = ["cidr:1.2.0.0/16", "ip:2.3.4.5"] or allow = ["ip:1.2.3.4", "cidr:2.3.4.0/24"]

domains supports the following:
name - (Required) The domain name to be used for ingressing traffic to a Global Load Balancer.
is_managed - (Optional) Control flag to specify whether the domain is managed by DigitalOcean.
certificate_id - (Optional) The certificate ID to be used for TLS handshaking.

glb_settings supports the following:
target_protocol - (Required) The protocol used for traffic from the Load Balancer to the backend Droplets. The possible values are: http and https.
target_port - (Required) An integer representing the port on the backend Droplets to which the Load Balancer will send traffic. The possible values are: 80 for http and 443 for https.
cdn - (Optional) CDN configuration supporting the following:
is_enabled - (Optional) Control flag to specify if caching is enabled.
  EOF
}

variable "monitor_alert" {
  type = list(map(object({
    id          = number
    compare     = string
    description = string
    type        = string
    value       = number
    window      = string
    enabled     = optional(bool)
    entities    = optional(set(string))
    tags        = optional(set(string))
    alerts = list(object({
      email  = optional(set(string))
      chanel = string
      url    = string
    }))
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
alerts - (Required) How to send notifications about the alerts. This is a list with one element, . Note that for Slack, the DigitalOcean app needs to have permissions for your workspace. You can read more in Slack's documentation
description - (Required) The description of the alert.
compare - (Required) The comparison for value. This may be either GreaterThan or LessThan.
type - (Required) The type of the alert. This may be one of v1/insights/droplet/load_1, v1/insights/droplet/load_5, v1/insights/droplet/load_15, v1/insights/droplet/memory_utilization_percent, v1/insights/droplet/disk_utilization_percent, v1/insights/droplet/cpu, v1/insights/droplet/disk_read, v1/insights/droplet/disk_write, v1/insights/droplet/public_outbound_bandwidth, v1/insights/droplet/public_inbound_bandwidth, v1/insights/droplet/private_outbound_bandwidth, v1/insights/droplet/private_inbound_bandwidth, v1/insights/lbaas/avg_cpu_utilization_percent, v1/insights/lbaas/connection_utilization_percent, v1/insights/lbaas/droplet_health, v1/insights/lbaas/tls_connections_per_second_utilization_percent, v1/insights/lbaas/increase_in_http_error_rate_percentage_5xx, v1/insights/lbaas/increase_in_http_error_rate_percentage_4xx, v1/insights/lbaas/increase_in_http_error_rate_count_5xx, v1/insights/lbaas/increase_in_http_error_rate_count_4xx, v1/insights/lbaas/high_http_request_response_time, v1/insights/lbaas/high_http_request_response_time_50p, v1/insights/lbaas/high_http_request_response_time_95p, v1/insights/lbaas/high_http_request_response_time_99p, v1/dbaas/alerts/load_15_alerts, v1/dbaas/alerts/cpu_alerts, v1/dbaas/alerts/memory_utilization_alerts, or v1/dbaas/alerts/disk_utilization_alerts.
enabled - (Required) The status of the alert.
entities - A list of IDs for the resources to which the alert policy applies.
tags - A list of tags. When an included tag is added to a resource, the alert policy will apply to it.
value - (Required) The value to start alerting at, e.g., 90% or 85Mbps. This is a floating-point number. DigitalOcean will show the correct unit in the web panel.
window - (Required) The time frame of the alert. Either 5m, 10m, 30m, or 1h.
  EOF
}

variable "project" {
  type = list(map(object({
    id          = number
    name        = string
    description = optional(string)
    purpose     = optional(string)
    environment = optional(string)
    resources   = optional(set(string))
    is_default  = optional(bool)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
name - (Required) The name of the Project
description - (Optional) the description of the project
purpose - (Optional) the purpose of the project, (Default: "Web Application")
environment - (Optional) the environment of the project's resources. The possible values are: Development, Staging, Production)
resources - a list of uniform resource names (URNs) for the resources associated with the project
is_default - (Optional) a boolean indicating whether or not the project is the default project. (Default: "false")
  EOF
}

variable "project_resources" {
  type = list(map(object({
    id        = number
    project   = number
    resources = set(number)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
project - (Required) the ID of the project
resources - (Required) a list of uniform resource names (URNs) for the resources associated with the project
  EOF
}

variable "record" {
  type = list(map(object({
    id        = number
    domain_id = number
    name      = string
    type      = string
    value     = string
    port      = optional(number)
    priority  = optional(number)
    weight    = optional(number)
    ttl       = optional(number)
    flags     = optional(number)
    tag       = optional(string)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
type - (Required) The type of record. Must be one of A, AAAA, CAA, CNAME, MX, NS, TXT, or SRV.
domain - (Required) The domain to add the record to.
value - (Required) The value of the record.
name - (Required) The hostname of the record. Use @ for records on domain's name itself.
port - (Optional) The port of the record. Only valid when type is SRV. Must be between 1 and 65535.
priority - (Optional) The priority of the record. Only valid when type is MX or SRV. Must be between 0 and 65535.
weight - (Optional) The weight of the record. Only valid when type is SRV. Must be between 0 and 65535.
ttl - (Optional) The time to live for the record, in seconds. Must be at least 0. Defaults to 1800.
flags - (Optional) The flags of the record. Only valid when type is CAA. Must be between 0 and 255.
tag - (Optional) The tag of the record. Only valid when type is CAA. Must be one of issue, issuewild, or iodef.
  EOF

  validation {
    condition     = contains(["A", "AAAA", "CAA", "CNAME", "MX", "NS", "TXT", "SRV"], var.record[0].type)
    error_message = "The type of record. Must be one of A, AAAA, CAA, CNAME, MX, NS, TXT, or SRV."
  }
}

variable "reserved_ip" {
  type = list(map(object({
    id         = number
    vpc_id     = number
    droplet_id = optional(number)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
region - (Required) The region that the reserved IP is reserved to.
droplet_id - (Optional) The ID of Droplet that the reserved IP will be assigned to.
  EOF
}

variable "reserved_ip_assignment" {
  type = list(map(object({
    id            = number
    droplet_id    = number
    ip_address_id = number
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
ip_address - (Required) The reserved IP to assign to the Droplet.
droplet_id - (Optional) The ID of Droplet that the reserved IP will be assigned to.
  EOF
}

variable "spaces_bucket" {
  type = list(map(object({
    id     = number
    name   = string
    vpc_id = optional(number)
    acl    = optional(string)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
name - (Required) The name of the bucket
region - The region where the bucket resides (Defaults to nyc3)
acl - Canned ACL applied on bucket creation (private or public-read)
  EOF
}

variable "spaces_bucket_cors_configuration" {
  type = list(map(object({
    id        = number
    bucket_id = number
    vpc_id    = number
    cors_rule = list(object({
      allowed_methods = set(string)
      allowed_origins = set(string)
      allowed_headers = optional(set(string))
      expose_headers  = optional(set(string))
      id              = optional(string)
      max_age_seconds = optional(number)
    }))
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
bucket - (Required) The name of the bucket to which to apply the CORS configuration.
region - (Required) The region where the bucket resides.
cors_rule - (Required) Set of origins and methods (cross-origin access that you want to allow). See below. You can configure up to 100 rules.

cors_rule supports the following:
allowed_headers - (Optional) Set of Headers that are specified in the Access-Control-Request-Headers header.
allowed_methods - (Required) Set of HTTP methods that you allow the origin to execute. Valid values are GET, PUT, HEAD, POST, and DELETE.
allowed_origins - (Required) Set of origins you want customers to be able to access the bucket from.
expose_headers - (Optional) Set of headers in the response that you want customers to be able to access from their applications (for example, from a JavaScript XMLHttpRequest object).
id - (Optional) Unique identifier for the rule. The value cannot be longer than 255 characters.
max_age_seconds - (Optional) Time in seconds that your browser is to cache the preflight response for the specified resource.
  EOF
}

variable "spaces_bucket_object" {
  type = list(map(object({
    id                  = number
    bucket_id           = number
    key                 = string
    vpc_id              = number
    acl                 = optional(string)
    cache_control       = optional(string)
    content             = optional(string)
    content_base64      = optional(string)
    content_disposition = optional(string)
    content_encoding    = optional(string)
    content_language    = optional(string)
    content_type        = optional(string)
    etag                = optional(string)
    force_destroy       = optional(bool)
    metadata            = optional(map(string))
    source              = optional(string)
    website_redirect    = optional(string)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:

region - The region where the bucket resides (Defaults to nyc3)
bucket - (Required) The name of the bucket to put the file in.
key - (Required) The name of the object once it is in the bucket.
source - (Optional, conflicts with content and content_base64) The path to a file that will be read and uploaded as raw bytes for the object content.
content - (Optional, conflicts with source and content_base64) Literal string value to use as the object content, which will be uploaded as UTF-8-encoded text.
content_base64 - (Optional, conflicts with source and content) Base64-encoded data that will be decoded and uploaded as raw bytes for the object content. This allows safely uploading non-UTF8 binary data, but is recommended only for small content such as the result of the gzipbase64 function with small text strings. For larger objects, use source to stream the content from a disk file.
acl - (Optional) The canned ACL to apply. DigitalOcean supports "private" and "public-read". (Defaults to "private".)
cache_control - (Optional) Specifies caching behavior along the request/reply chain Read w3c cache_control for further details.
content_disposition - (Optional) Specifies presentational information for the object. Read w3c content_disposition for further information.
content_encoding - (Optional) Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field. Read w3c content encoding for further information.
content_language - (Optional) The language the content is in e.g. en-US or en-GB.
content_type - (Optional) A standard MIME type describing the format of the object data, e.g. application/octet-stream. All Valid MIME Types are valid for this input.
website_redirect - (Optional) Specifies a target URL for website redirect.
etag - (Optional) Used to trigger updates.
metadata - (Optional) A mapping of keys/values to provision metadata (will be automatically prefixed by x-amz-meta-, note that only lowercase label are currently supported by the AWS Go API).
force_destroy - (Optional) Allow the object to be deleted by removing any legal hold on any object version. Default is false. This value should be set to true only if the bucket has S3 object lock enabled.
  EOF
}

variable "spaces_bucket_policy" {
  type = list(map(object({
    id        = number
    bucket_id = number
    policy    = string
    vpc_id    = string
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
region - (Required) The region where the bucket resides.
bucket - (Required) The name of the bucket to which to apply the policy.
policy - (Required) The text of the policy.
  EOF
}

variable "ssh_key" {
  type = list(map(object({
    id         = number
    name       = string
    public_key = string
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
name - (Required) The name of the SSH key for identification
public_key - (Required) The public key. If this is a file, it can be read using the file interpolation function
  EOF
}

variable "tag" {
  type = list(map(object({
    id   = number
    name = string
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
name - (Required) The name of the tag
  EOF
}

variable "uptime_alert" {
  type = list(map(object({
    id         = number
    check_id   = number
    name       = string
    type       = string
    threshold  = optional(number)
    comparison = optional(string)
    period     = optional(string)
    notifications = list(object({
      email   = optional(set(string))
      channel = string
      url     = string
    }))
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
check_id - (Required) A unique identifier for a check
name - (Required) A human-friendly display name.
notifications (Required) - The notification settings for a trigger alert.
type (Required) - The type of health check to perform. Must be one of latency, down, down_global or ssl_expiry.
threshold - The threshold at which the alert will enter a trigger state. The specific threshold is dependent on the alert type.
comparison - The comparison operator used against the alert's threshold. Must be one of greater_than or less_than.
period - Period of time the threshold must be exceeded to trigger the alert. Must be one of 2m, 3m, 5m, 10m, 15m, 30m or 1h.

notifications supports the following:
email - List of email addresses to sent notifications to.
slack
channel (Required) - The Slack channel to send alerts to.
url (Required) - The webhook URL for Slack.
EOF
}

variable "uptime_check" {
  type = list(map(object({
    id      = number
    name    = string
    target  = string
    type    = optional(string)
    vpc_id  = optional(set(number))
    enabled = optional(bool)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
name - (Required) A human-friendly display name for the check.
target - (Required) The endpoint to perform healthchecks on.
type - The type of health check to perform: 'ping' 'http' 'https'.
regions - An array containing the selected regions to perform healthchecks from: "us_east", "us_west", "eu_west", "se_asia"
enabled - A boolean value indicating whether the check is enabled/disabled.
  EOF
}

variable "volume" {
  type = list(map(object({
    id                       = number
    name                     = string
    vpc_id                   = number
    size                     = number
    description              = optional(string)
    snapshot_id              = optional(number)
    initial_filesystem_label = optional(string)
    initial_filesystem_type  = optional(string)
    tags                     = optional(set(string))
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
region - (Required) The region that the block storage volume will be created in.
name - (Required) A name for the block storage volume. Must be lowercase and be composed only of numbers, letters and "-", up to a limit of 64 characters. The name must begin with a letter.
size - (Required) The size of the block storage volume in GiB. If updated, can only be expanded.
description - (Optional) A free-form text field up to a limit of 1024 bytes to describe a block storage volume.
snapshot_id - (Optional) The ID of an existing volume snapshot from which the new volume will be created. If supplied, the region and size will be limitied on creation to that of the referenced snapshot
initial_filesystem_type - (Optional) Initial filesystem type (xfs or ext4) for the block storage volume.
initial_filesystem_label - (Optional) Initial filesystem label for the block storage volume.
tags - (Optional) A list of the tags to be applied to this Volume.
  EOF
}

variable "volume_attachment" {
  type = list(map(object({
    id         = number
    droplet_id = number
    volume_id  = number
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
droplet_id - (Required) ID of the Droplet to attach the volume to.
volume_id - (Required) ID of the Volume to be attached to the Droplet.
  EOF
}

variable "volume_snapshot" {
  type = list(map(object({
    id        = number
    name      = string
    volume_id = number
    tags      = optional(set(string))
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
name - (Required) A name for the volume snapshot.
volume_id - (Required) The ID of the volume from which the volume snapshot originated.
tags - (Optional) A list of the tags to be applied to this volume snapshot.
  EOF
}

variable "vpc" {
  type = list(map(object({
    id          = number
    name        = string
    region      = string
    description = optional(string)
    ip_range    = optional(string)
  })))
  default    = []
  decription = <<EOF
The following arguments are supported:
name - (Required) A name for the VPC. Must be unique and contain alphanumeric characters, dashes, and periods only.
region - (Required) The DigitalOcean region slug for the VPC's location.
description - (Optional) A free-form text field up to a limit of 255 characters to describe the VPC.
ip_range - (Optional) The range of IP addresses for the VPC in CIDR notation. Network ranges cannot overlap with other networks in the same account and must be in range of private addresses as defined in RFC1918. It may not be larger than /16 or smaller than /24.
  EOF
}
