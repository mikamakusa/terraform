resource "azurerm_stream_analytics_cluster" "this" {
  count               = length(var.cluster)
  location            = data.azurerm_resource_group.this.location
  name                = lookup(var.cluster[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  streaming_capacity  = lookup(var.cluster[count.index], "streaming_capacity")
  tags                = merge(var.tags, lookup(var.cluster[count.index], "tags"))
}

resource "azurerm_stream_analytics_function_javascript_uda" "this" {
  count                   = length(var.job) == 0 ? 0 : length(var.function_javascript_uda)
  name                    = lookup(var.function_javascript_uda[count.index], "name")
  script                  = lookup(var.function_javascript_uda[count.index], "script")
  stream_analytics_job_id = try(element(azurerm_stream_analytics_job.this.*.id, lookup(var.function_javascript_uda[count.index], "stream_analytics_job_id")))

  dynamic "input" {
    for_each = lookup(var.function_javascript_uda[count.index], "input") == null ? [] : ["input"]
    content {
      type                    = lookup(input.value, "type")
      configuration_parameter = lookup(input.value, "configuration_parameter")
    }
  }

  dynamic "output" {
    for_each = lookup(var.function_javascript_uda[count.index], "output") == null ? [] : ["output"]
    content {
      type = lookup(output.value, "type")
    }
  }
}

resource "azurerm_stream_analytics_function_javascript_udf" "this" {
  count                     = length(var.job) == 0 ? 0 : length(var.function_javascript_udf)
  name                      = lookup(var.function_javascript_udf[count.index], "name")
  resource_group_name       = try(element(azurerm_stream_analytics_job.this.*.resource_group_name, lookup(var.function_javascript_udf[count.index], "stream_analytics_job_id")))
  script                    = lookup(var.function_javascript_udf[count.index], "script")
  stream_analytics_job_name = try(element(azurerm_stream_analytics_job.this.*.name, lookup(var.function_javascript_udf[count.index], "stream_analytics_job_id")))

  dynamic "input" {
    for_each = lookup(var.function_javascript_udf[count.index], "input") == null ? [] : ["input"]
    content {
      type                    = lookup(input.value, "type")
      configuration_parameter = lookup(input.value, "configuration_parameter")
    }
  }

  dynamic "output" {
    for_each = lookup(var.function_javascript_udf[count.index], "output") == null ? [] : ["output"]
    content {
      type = lookup(output.value, "type")
    }
  }
}

resource "azurerm_stream_analytics_job" "this" {
  count                                    = length(var.job)
  location                                 = data.azurerm_resource_group.this.location
  name                                     = lookup(var.job[count.index], "name")
  resource_group_name                      = data.azurerm_resource_group.this.name
  transformation_query                     = lookup(var.job[count.index], "transformation_query")
  compatibility_level                      = lookup(var.job[count.index], "compatibility_level")
  content_storage_policy                   = lookup(var.job[count.index], "content_storage_policy")
  data_locale                              = lookup(var.job[count.index], "data_locale")
  events_late_arrival_max_delay_in_seconds = lookup(var.job[count.index], "events_late_arrival_max_delay_in_seconds")
  events_out_of_order_max_delay_in_seconds = lookup(var.job[count.index], "events_out_of_order_max_delay_in_seconds")
  events_out_of_order_policy               = lookup(var.job[count.index], "events_out_of_order_policy")
  output_error_policy                      = lookup(var.job[count.index], "output_error_policy")
  stream_analytics_cluster_id              = try(element(azurerm_stream_analytics_cluster.this.*.id, lookup(var.job[count.index], "stream_analytics_cluster_id")))
  streaming_units                          = lookup(var.job[count.index], "streaming_units")
  tags                                     = merge(var.tags, lookup(var.job[count.index], "tags"))
  type                                     = lookup(var.job[count.index], "type")

  dynamic "identity" {
    for_each = lookup(var.job[count.index], "identity") == null ? [] : ["identity"]
    content {
      type         = lookup(identity.value, "type")
      identity_ids = lookup(identity.value, "identity_ids")
    }
  }

  dynamic "job_storage_account" {
    for_each = lookup(var.job[count.index], "job_storage_account") == null ? [] : ["job_storage_account"]
    content {
      account_key         = lookup(job_storage_account.value, "account_key")
      account_name        = lookup(job_storage_account.value, "account_name")
      authentication_mode = lookup(job_storage_account.value, "authentication_mode")
    }
  }
}

resource "azurerm_stream_analytics_job_schedule" "this" {
  count                   = length(var.job) == 0 ? 0 : length(var.job_schedule)
  start_mode              = lookup(var.job_schedule[count.index], "start_mode")
  stream_analytics_job_id = try(element(azurerm_stream_analytics_job.this.*.id, lookup(var.job_schedule[count.index], "stream_analytics_job_id")))
  start_time              = lookup(var.job_schedule[count.index], "start_time")
}

resource "azurerm_stream_analytics_managed_private_endpoint" "this" {
  count                         = length(var.cluster) == 0 ? 0 : length(var.managed_private_endpoint)
  name                          = lookup(var.managed_private_endpoint[count.index], "name")
  resource_group_name           = data.azurerm_resource_group.this.name
  stream_analytics_cluster_name = try(element(azurerm_stream_analytics_cluster.this.*.name, lookup(var.managed_private_endpoint[count.index], "stream_analytics_cluster_id")))
  subresource_name              = lookup(var.managed_private_endpoint[count.index], "subresource_name")
  target_resource_id            = data.azurerm_storage_account.this.id
}

resource "azurerm_stream_analytics_output_blob" "this" {
  count                     = (length(var.job) && var.storage_container_name) == 0 ? 0 : length(var.output_blob)
  date_format               = lookup(var.output_blob[count.index], "date_format")
  name                      = lookup(var.output_blob[count.index], "name")
  path_pattern              = lookup(var.output_blob[count.index], "path_pattern")
  resource_group_name       = data.azurerm_resource_group.this.name
  storage_account_name      = data.azurerm_storage_account.this.name
  storage_container_name    = data.azurerm_storage_container.this.name
  stream_analytics_job_name = try(element(azurerm_stream_analytics_job.this.*.name, lookup(var.output_blob[count.index], "stream_analytics_job_id")))
  time_format               = lookup(var.output_blob[count.index], "time_format")
  authentication_mode       = lookup(var.output_blob[count.index], "authentication_mode")
  batch_max_wait_time       = lookup(var.output_blob[count.index], "batch_max_wait_time")
  batch_min_rows            = lookup(var.output_blob[count.index], "batch_min_rows")
  storage_account_key       = lookup(var.output_blob[count.index], "storage_account_key")

  dynamic "serialization" {
    for_each = lookup(var.output_blob[count.index], "serialization") == null ? [] : ["serialization"]
    content {
      type            = lookup(serialization.value, "type")
      encoding        = lookup(serialization.value, "encoding")
      field_delimiter = lookup(serialization.value, "field_delimiter")
      format          = lookup(serialization.value, "format")
    }
  }
}

resource "azurerm_cosmosdb_sql_container" "this" {
  count               = length(var.cosmosdb_sql_container)
  account_name        = data.azurerm_cosmosdb_account.this.name
  database_name       = data.azurerm_cosmosdb_sql_database.this.name
  name                = lookup(var.cosmosdb_sql_container[count.index], "name")
  partition_key_path  = lookup(var.cosmosdb_sql_container[count.index], "partition_key_path")
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_stream_analytics_output_cosmosdb" "this" {
  count                    = (length(var.job) && length(var.cosmosdb_sql_container)) == 0 ? 0 : length(var.output_cosmosdb)
  container_name           = try(element(azurerm_cosmosdb_sql_container.this.*.name, lookup(var.output_cosmosdb[count.index], "container_id")))
  cosmosdb_account_key     = data.azurerm_cosmosdb_account.this.primary_key
  cosmosdb_sql_database_id = data.azurerm_cosmosdb_sql_database.this.id
  name                     = lookup(var.output_cosmosdb[count.index], "name")
  stream_analytics_job_id  = try(element(azurerm_stream_analytics_job.this.*.id, lookup(var.output_cosmosdb[count.index], "stream_analytics_job_id")))
  document_id              = lookup(var.output_cosmosdb[count.index], "document_id")
  partition_key            = lookup(var.output_cosmosdb[count.index], "partition_key")
}

resource "azurerm_stream_analytics_output_eventhub" "this" {
  count                     = (length(var.job) && var.eventhub_name) == 0 ? 0 : length(var.output_eventhub)
  eventhub_name             = data.azurerm_eventhub.this.name
  name                      = lookup(var.output_eventhub[count.index], "name")
  resource_group_name       = data.azurerm_resource_group.this.name
  servicebus_namespace      = data.azurerm_eventhub_namespace.this.name
  stream_analytics_job_name = try(element(azurerm_stream_analytics_job.this.*.name, lookup(var.output_eventhub[count.index], "stream_analytics_job_id")))
  shared_access_policy_key  = lookup(var.output_eventhub[count.index], "shared_access_policy_key")
  shared_access_policy_name = lookup(var.output_eventhub[count.index], "shared_access_policy_name")
  property_columns          = lookup(var.output_eventhub[count.index], "property_columns")
  authentication_mode       = lookup(var.output_eventhub[count.index], "authentication_mode")
  partition_key             = lookup(var.output_eventhub[count.index], "partition_key")

  dynamic "serialization" {
    for_each = lookup(var.output_eventhub[count.index], "serialization")
    content {
      type            = lookup(serialization.value, "type")
      encoding        = lookup(serialization.value, "encoding")
      field_delimiter = lookup(serialization.value, "field_delimiter")
      format          = lookup(serialization.value, "format")
    }
  }
}

resource "azurerm_stream_analytics_output_function" "this" {
  count                     = (length(var.job) && var.function_app_name) == 0 ? 0 : length(var.output_function)
  api_key                   = lookup(var.output_function[count.index], "api_key")
  function_app              = data.azurerm_function_app.this.name
  function_name             = lookup(var.output_function[count.index], "function_name")
  name                      = lookup(var.output_function[count.index], "name")
  resource_group_name       = data.azurerm_resource_group.this.name
  stream_analytics_job_name = try(element(azurerm_stream_analytics_job.this.*.name, lookup(var.output_function[count.index], "stream_analytics_job_id")))
  batch_max_count           = lookup(var.output_function[count.index], "batch_max_count")
  batch_max_in_bytes        = lookup(var.output_function[count.index], "batch_max_in_bytes")
}

resource "azurerm_stream_analytics_output_mssql" "this" {
  count                     = (length(var.job) && var.sql_database_name) == 0 ? 0 : length(var.output_mssql)
  database                  = data.azurerm_sql_database.this.name
  name                      = lookup(var.output_mssql[count.index], "name")
  resource_group_name       = data.azurerm_resource_group.this.name
  server                    = data.azurerm_sql_server.this.name
  stream_analytics_job_name = try(element(azurerm_stream_analytics_job.this.*.name, lookup(var.output_mssql[count.index], "stream_analytics_job_id")))
  table                     = lookup(var.output_mssql[count.index], "table")
  authentication_mode       = lookup(var.output_mssql[count.index], "authentication_mode")
  max_batch_count           = lookup(var.output_mssql[count.index], "max_batch_count")
  max_writer_count          = lookup(var.output_mssql[count.index], "max_writer_count")
  password                  = sensitive(lookup(var.output_mssql[count.index], "password"))
  user                      = sensitive(lookup(var.output_mssql[count.index], "user"))
}

resource "azurerm_stream_analytics_output_powerbi" "this" {
  count                     = length(var.job) == 0 ? 0 : length(var.output_powerbi)
  dataset                   = lookup(var.output_powerbi[count.index], "dataset")
  group_id                  = lookup(var.output_powerbi[count.index], "group_id")
  group_name                = lookup(var.output_powerbi[count.index], "group_name")
  name                      = lookup(var.output_powerbi[count.index], "name")
  stream_analytics_job_id   = try(element(azurerm_stream_analytics_job.this.*.id, lookup(var.output_powerbi[count.index], "stream_analytics_job_id")))
  table                     = lookup(var.output_powerbi[count.index], "table")
  token_user_display_name   = lookup(var.output_powerbi[count.index], "token_user_display_name")
  token_user_principal_name = lookup(var.output_powerbi[count.index], "token_user_principal_name")
}

resource "azurerm_stream_analytics_output_servicebus_queue" "this" {
  count                     = (length(var.job) && var.servicebus_queue_name) == 0 ? 0 : length(var.output_servicebus_queue)
  name                      = lookup(var.output_servicebus_queue[count.index], "name")
  queue_name                = data.azurerm_servicebus_queue.this.name
  resource_group_name       = data.azurerm_resource_group.this.name
  servicebus_namespace      = data.azurerm_servicebus_namespace.this.name
  stream_analytics_job_name = try(element(azurerm_stream_analytics_job.this.*.name, lookup(var.output_servicebus_queue[count.index], "stream_analytics_job_id")))
  authentication_mode       = lookup(var.output_servicebus_queue[count.index], "authentication_mode")
  property_columns          = lookup(var.output_servicebus_queue[count.index], "property_columns")
  shared_access_policy_key  = sensitive(data.azurerm_servicebus_namespace.this.default_primary_key)
  shared_access_policy_name = lookup(var.output_servicebus_queue[count.index], "shared_access_policy_name")
  system_property_columns   = lookup(var.output_servicebus_queue[count.index], "system_property_columns")

  dynamic "serialization" {
    for_each = lookup(var.output_servicebus_queue[count.index], "serialization")
    content {
      type            = lookup(serialization.value, "type")
      encoding        = lookup(serialization.value, "encoding")
      field_delimiter = lookup(serialization.value, "field_delimiter")
      format          = lookup(serialization.value, "format")
    }
  }
}

resource "azurerm_stream_analytics_output_servicebus_topic" "this" {
  count                     = (length(var.job) && var.servicebus_topic_name) == 0 ? 0 : length(var.output_servicebus_topic)
  name                      = lookup(var.output_servicebus_topic[count.index], "name")
  resource_group_name       = data.azurerm_resource_group.this.name
  servicebus_namespace      = data.azurerm_servicebus_namespace.this.name
  stream_analytics_job_name = lookup(var.output_servicebus_topic[count.index], "stream_analytics_job_name")
  topic_name                = data.azurerm_servicebus_topic.this.name
  authentication_mode       = lookup(var.output_servicebus_topic[count.index], "authentication_mode")
  property_columns          = lookup(var.output_servicebus_topic[count.index], "property_columns")
  shared_access_policy_key  = sensitive(data.azurerm_servicebus_namespace.this.default_primary_key)
  shared_access_policy_name = lookup(var.output_servicebus_topic[count.index], "shared_access_policy_name")
  system_property_columns   = lookup(var.output_servicebus_topic[count.index], "system_property_columns")

  dynamic "serialization" {
    for_each = lookup(var.servicebus_topic_name[count.index], "serialization")
    content {
      type            = lookup(serialization.value, "type")
      encoding        = lookup(serialization.value, "encoding")
      field_delimiter = lookup(serialization.value, "field_delimiter")
      format          = lookup(serialization.value, "format")
    }
  }
}

resource "azurerm_storage_data_lake_gen2_filesystem" "this" {
  count              = length(var.synapse_workspace)
  name               = join("-", [lookup(var.synapse_workspace[count.index], "name"), "data_lake"])
  storage_account_id = data.azurerm_storage_account.this.id
}

resource "azurerm_synapse_workspace" "this" {
  count                                = length(var.synapse_workspace)
  location                             = data.azurerm_resource_group.this.location
  name                                 = lookup(var.synapse_workspace[count.index], "name")
  resource_group_name                  = data.azurerm_resource_group.this.name
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.this.id
  sql_administrator_login              = sensitive(lookup(var.synapse_workspace[count.index], "sql_administrator_login"))
  sql_administrator_login_password     = sensitive(lookup(var.synapse_workspace[count.index], "sql_administrator_login_password"))
}

resource "azurerm_stream_analytics_output_synapse" "this" {
  count                     = (length(var.synapse_workspace) && length(var.job)) == 0 ? 0 : length(var.output_synapse)
  database                  = lookup(var.output_synapse[count.index], "database")
  name                      = lookup(var.output_synapse[count.index], "name")
  password                  = sensitive(try(element(azurerm_synapse_workspace.this.*.sql_administrator_login_password, lookup(var.output_synapse[count.index], "synapse_workspace_id"))))
  resource_group_name       = data.azurerm_resource_group.this.name
  server                    = try(element(azurerm_synapse_workspace.this.*.connectivity_endpoints["sqlOnDemand"], lookup(var.output_synapse[count.index], "synapse_workspace_id")))
  stream_analytics_job_name = try(element(azurerm_stream_analytics_job.this.*.name, lookup(var.output_synapse[count.index], "stream_analytics_job_id")))
  table                     = lookup(var.output_synapse[count.index], "table")
  user                      = sensitive(try(element(azurerm_synapse_workspace.this.*.sql_administrator_login, lookup(var.output_synapse[count.index], "synapse_workspace_id"))))
}

resource "azurerm_stream_analytics_output_table" "this" {
  count                     = (length(var.job) && var.storage_table_name) == 0 ? 0 : length(var.output_table)
  batch_size                = lookup(var.output_table[count.index], "batch_size")
  name                      = lookup(var.output_table[count.index], "name")
  partition_key             = lookup(var.output_table[count.index], "partition_key")
  resource_group_name       = data.azurerm_resource_group.this.name
  row_key                   = lookup(var.output_table[count.index], "row_key")
  storage_account_key       = sensitive(data.azurerm_storage_account.this.primary_access_key)
  storage_account_name      = data.azurerm_storage_account.this.name
  stream_analytics_job_name = lookup(var.output_table[count.index], "stream_analytics_job_name")
  table                     = data.azurerm_storage_table.this.name
  columns_to_remove         = lookup(var.output_table[count.index], "columns_to_remove")
}

resource "azurerm_stream_analytics_reference_input_blob" "this" {
  count                     = (length(var.job) && var.storage_container_name) == 0 ? 0 : length(var.reference_input_blob)
  date_format               = lookup(var.reference_input_blob[count.index], "date_format")
  name                      = ""
  path_pattern              = ""
  resource_group_name       = data.azurerm_resource_group.this.name
  storage_account_name      = data.azurerm_storage_account.this.name
  storage_container_name    = data.azurerm_storage_container.this.name
  stream_analytics_job_name = try(element(azurerm_stream_analytics_job.this.*.name, lookup(var.reference_input_blob[count.index], "stream_analytics_job_id")))
  time_format               = lookup(var.reference_input_blob[count.index], "time_format")
  storage_account_key       = sensitive(data.azurerm_storage_account.this.primary_access_key)
  authentication_mode       = lookup(var.reference_input_blob[count.index], "authentication_mode")

  dynamic "serialization" {
    for_each = lookup(var.reference_input_blob[count.index], "serialization")
    content {
      type            = lookup(serialization.value, "type")
      encoding        = lookup(serialization.value, "encoding")
      field_delimiter = lookup(serialization.value, "field_delimiter")
    }
  }
}

resource "azurerm_stream_analytics_reference_input_mssql" "this" {
  count                     = (length(var.job) && var.sql_database_name && var.sql_server_name) == 0 ? 0 : length(var.reference_input_mssql)
  database                  = data.azurerm_sql_database.this.name
  full_snapshot_query       = lookup(var.reference_input_mssql[count.index], "full_snapshot_query")
  name                      = lookup(var.reference_input_mssql[count.index], "name")
  password                  = sensitive(lookup(var.reference_input_mssql[count.index], "password"))
  refresh_type              = lookup(var.reference_input_mssql[count.index], "refresh_type")
  resource_group_name       = data.azurerm_resource_group.this.name
  server                    = data.azurerm_sql_server.this.fqdn
  stream_analytics_job_name = try(element(azurerm_stream_analytics_job.this.*.name, lookup(var.reference_input_mssql[count.index], "stream_analytics_job_id")))
  username                  = sensitive(lookup(var.reference_input_mssql[count.index], "username"))
  refresh_interval_duration = lookup(var.reference_input_mssql[count.index], "refresh_interval_duration")
  delta_snapshot_query      = lookup(var.reference_input_mssql[count.index], "delta_snapshot_query")
  table                     = lookup(var.reference_input_mssql[count.index], "table")
}

resource "azurerm_stream_analytics_stream_input_blob" "this" {
  count                     = (length(var.job) && var.storage_container_name) == 0 ? 0 : length(var.stream_input_blob)
  date_format               = lookup(var.stream_input_blob[count.index], "date_format")
  name                      = lookup(var.stream_input_blob[count.index], "name")
  path_pattern              = lookup(var.stream_input_blob[count.index], "path_pattern")
  resource_group_name       = data.azurerm_resource_group.this.name
  storage_account_key       = sensitive(data.azurerm_storage_account.this.primary_access_key)
  storage_account_name      = data.azurerm_storage_account.this.name
  storage_container_name    = data.azurerm_storage_container.this.name
  stream_analytics_job_name = try(element(azurerm_stream_analytics_job.this.*.name, lookup(var.stream_input_blob[count.index], "stream_analytics_job_id")))
  time_format               = lookup(var.stream_input_blob[count.index], "time_format")

  dynamic "serialization" {
    for_each = lookup(var.stream_input_blob[count.index], "serialization")
    content {
      type            = lookup(serialization.value, "type")
      encoding        = lookup(serialization.value, "encoding")
      field_delimiter = lookup(serialization.value, "field_delimiter")
    }
  }
}

resource "azurerm_stream_analytics_stream_input_eventhub" "this" {
  count                        = (length(var.job) && (var.eventhub_name && var.eventhub_namespace_name && var.eventhub_consumer_group_name) || var.servicebus_namespace_name) == 0 ? 0 : length(var.stream_input_eventhub)
  eventhub_name                = data.azurerm_eventhub.this.name
  name                         = lookup(var.stream_input_eventhub[count.index], "name")
  resource_group_name          = data.azurerm_resource_group.this.name
  servicebus_namespace         = try(data.azurerm_servicebus_namespace, data.azurerm_eventhub_namespace)
  stream_analytics_job_name    = try(element(azurerm_stream_analytics_job.this.*.name, lookup(var.stream_input_eventhub[count.index], "stream_analytics_job_id")))
  authentication_mode          = lookup(var.stream_input_eventhub[count.index], "authentication_mode")
  eventhub_consumer_group_name = data.azurerm_eventhub_consumer_group.this.name
  partition_key                = lookup(var.stream_input_eventhub[count.index], "partition_key")
  shared_access_policy_key     = sensitive(data.azurerm_eventhub_namespace.this.default_primary_key)
  shared_access_policy_name    = lookup(var.stream_input_eventhub[count.index], "shared_access_policy_name")

  dynamic "serialization" {
    for_each = lookup(var.stream_input_eventhub[count.index], "serialization")
    content {
      type            = lookup(serialization.value, "type")
      encoding        = lookup(serialization.value, "encoding")
      field_delimiter = lookup(serialization.value, "field_delimiter")
    }
  }
}

resource "azurerm_iothub" "this" {
  count                         = length(var.iothub)
  name                          = lookup(var.iothub[count.index], "name")
  resource_group_name           = data.azurerm_resource_group.this.name
  location                      = data.azurerm_resource_group.this.location
  local_authentication_enabled  = lookup(var.iothub[count.index], "local_authentication_enabled")
  event_hub_partition_count     = lookup(var.iothub[count.index], "event_hub_partition_count")
  event_hub_retention_in_days   = lookup(var.iothub[count.index], "event_hub_retention_in_days")
  endpoint                      = lookup(var.iothub[count.index], "endpoint")
  public_network_access_enabled = lookup(var.iothub[count.index], "public_network_access_enabled")
  min_tls_version               = lookup(var.iothub[count.index], "min_tls_version")
  tags                          = merge(var.tags, lookup(var.iothub[count.index], "tags"))

  dynamic "sku" {
    for_each = lookup(var.iothub[count.index], "sku")
    content {
      name     = lookup(sku.value, "name")
      capacity = lookup(sku.value, "capacity")
    }
  }

  dynamic "cloud_to_device" {
    for_each = try(lookup(var.iothub[count.index], "cloud_to_device")) == null ? [] : ["cloud_to_device"]
    content {
      default_ttl        = lookup(cloud_to_device.value, "default_ttl")
      max_delivery_count = lookup(cloud_to_device.value, "max_delivery_count")

      dynamic "feedback" {
        for_each = lookup(cloud_to_device.value, "feedback") == null ? [] : ["feedback"]
        content {
          time_to_live       = lookup(feedback.value, "time_to_live")
          max_delivery_count = lookup(feedback.value, "max_delivery_count")
          lock_duration      = lookup(feedback.value, "lock_duration")
        }
      }
    }
  }

  dynamic "endpoint" {
    for_each = try(lookup(var.iothub[count.index], "endpoint")) == null ? [] : ["endpoint"]
    content {
      authentication_type        = lookup(endpoint.value, "authentication_type")
      batch_frequency_in_seconds = lookup(endpoint.value, "batch_frequency_in_seconds")
      connection_string          = lookup(endpoint.value, "connection_string")
      container_name             = lookup(endpoint.value, "container_name")
      encoding                   = lookup(endpoint.value, "encoding")
      endpoint_uri               = lookup(endpoint.value, "endpoint_uri")
      entity_path                = lookup(endpoint.value, "entity_path")
      file_name_format           = lookup(endpoint.value, "file_name_format")
      identity_id                = lookup(endpoint.value, "identity_id")
      max_chunk_size_in_bytes    = lookup(endpoint.value, "max_chunk_size_in_bytes")
      name                       = lookup(endpoint.value, "name")
      resource_group_name        = lookup(endpoint.value, "resource_group_name")
      type                       = lookup(endpoint.value, "type")
    }
  }

  dynamic "enrichment" {
    for_each = try(lookup(var.iothub[count.index], "enrichment")) == null ? [] : ["enrichment"]
    content {
      key            = lookup(enrichment.value, "key")
      value          = lookup(enrichment.value, "value")
      endpoint_names = lookup(enrichment.value, "endpoint_names")
    }
  }

  dynamic "fallback_route" {
    for_each = try(lookup(var.iothub[count.index], "fallback_route")) == null ? [] : ["fallback_route"]
    content {
      source         = lookup(fallback_route.value, "source")
      condition      = lookup(fallback_route.value, "condition")
      enabled        = lookup(fallback_route.value, "enabled")
      endpoint_names = lookup(fallback_route.value, "endpoint_names")
    }
  }

  dynamic "file_upload" {
    for_each = try(lookup(var.iothub[count.index], "file_upload")) == null ? [] : ["file_upload"]
    content {
      connection_string   = lookup(file_upload.value, "connection_string")
      container_name      = lookup(file_upload.value, "container_name")
      authentication_type = lookup(file_upload.value, "authentication_type")
      default_ttl         = lookup(file_upload.value, "default_ttl")
      lock_duration       = lookup(file_upload.value, "lock_duration")
      max_delivery_count  = lookup(file_upload.value, "max_delivery_count")
      notifications       = lookup(file_upload.value, "notifications")
      sas_ttl             = lookup(file_upload.value, "sas_ttl")
    }
  }

  dynamic "identity" {
    for_each = try(lookup(var.iothub[count.index], "identity")) == null ? [] : ["identity"]
    content {
      type         = lookup(identity.value, "type")
      identity_ids = lookup(identity.value, "identity_ids")
    }
  }

  dynamic "network_rule_set" {
    for_each = try(lookup(var.iothub[count.index], "network_rule_set")) == null ? [] : ["network_rule_set"]
    content {
      default_action                     = lookup(network_rule_set.value, "default_action")
      apply_to_builtin_eventhub_endpoint = lookup(network_rule_set.value, "apply_to_builtin_eventhub_endpoint")

      dynamic "ip_rule" {
        for_each = lookup(network_rule_set.value, "ip_rule") == null ? [] : ["ip_rule"]
        content {
          ip_mask = lookup(ip_rule.value, "ip_mask")
          name    = lookup(ip_rule.value, "name")
          action  = lookup(ip_rule.value, "action")
        }
      }
    }
  }

  dynamic "route" {
    for_each = try(lookup(var.iothub[count.index], "route")) == null ? [] : ["route"]
    content {
      name           = lookup(route.value, "name")
      source         = lookup(route.value, "source")
      condition      = lookup(route.value, "condition")
      endpoint_names = lookup(route.value, "endpoint_names")
      enabled        = lookup(route.value, "enabled")
    }
  }
}

resource "azurerm_stream_analytics_stream_input_iothub" "this" {
  count                        = (length(var.job) && length(var.iothub)) == 0 ? 0 : length(var.stream_input_iothub)
  endpoint                     = lookup(var.stream_input_iothub[count.index], "endpoint")
  eventhub_consumer_group_name = lookup(var.stream_input_iothub[count.index], "eventhub_consumer_group_name")
  iothub_namespace             = try(element(azurerm_iothub.this.*.name, lookup(var.stream_input_iothub[count.index], "iothub_id")))
  name                         = lookup(var.stream_input_iothub[count.index], "name")
  resource_group_name          = try(element(azurerm_stream_analytics_job.this.*.resource_group_name, lookup(var.stream_input_iothub[count.index], "stream_analytics_job_id")))
  shared_access_policy_key     = try(element(azurerm_iothub.this.*.shared_access_policy[0].primary_key, lookup(var.stream_input_iothub[count.index], "iothub_id")))
  shared_access_policy_name    = lookup(var.stream_input_iothub[count.index], "shared_access_policy_name")
  stream_analytics_job_name    = try(element(azurerm_stream_analytics_job.this.*.name, lookup(var.stream_input_iothub[count.index], "stream_analytics_job_id")))

  dynamic "serialization" {
    for_each = lookup(var.stream_input_iothub[count.index], "serialization")
    content {
      type = lookup(serialization.value, "type")
      encoding = lookup(serialization.value, "encoding")
      field_delimiter = lookup(serialization.value, "field_delimiter")
    }
  }
}