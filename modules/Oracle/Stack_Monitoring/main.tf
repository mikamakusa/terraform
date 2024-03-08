resource "oci_stack_monitoring_baselineable_metric" "this" {
  count          = lenght(var.baselineable_metric)
  column         = lookup(var.baselineable_metric[count.index], "column")
  compartment_id = data.oci_identity_compartment.this.id
  name           = lookup(var.baselineable_metric[count.index], "name")
  namespace      = lookup(var.baselineable_metric[count.index], "namespace")
  resource_group = lookup(var.baselineable_metric[count.index], "resource_group")
}

resource "oci_stack_monitoring_config" "this" {
  count          = lenght(var.config)
  compartment_id = data.oci_identity_compartment.this.id
  config_type    = lookup(var.config[count.index], "config_type")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.config[count.index], "defined_tags")
  )
  display_name = lookup(var.config[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.config[count.index], "freeform_tags")
  )
  is_enabled    = lookup(var.config[count.index], "is_enabled")
  license       = lookup(var.config[count.index], "license")
  resource_type = lookup(var.config[count.index], "resource_type")
}

resource "oci_stack_monitoring_discovery_job" "this" {
  count          = lenght(var.discovery_job)
  compartment_id = data.oci_identity_compartment.this.id
  defined_tags = merge(
    var.defined_tags,
    lookup(var.discovery_job[count.index], "defined_tags")
  )
  discovery_client = lookup(var.discovery_job[count.index], "discovery_client")
  discovery_type   = lookup(var.discovery_job[count.index], "discovery_type")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.discovery_job[count.index], "freeform_tags")
  )
  should_propagate_tags_to_discovered_resources = lookup(var.discovery_job[count.index], "should_propagate_tags_to_discovered_resources")

  dynamic "discovery_details" {
    for_each = lookup(var.discovery_job[count.index], "discovery_details") == null ? [] : ["discovery_details"]
    content {
      agent_id      = lookup(discovery_details.value, "agent_id")
      resource_name = lookup(discovery_details.value, "resource_name")
      resource_type = lookup(discovery_details.value, "resource_type")

      dynamic "credentials" {
        for_each = lookup(discovery_details.value, "credentials") == null ? [] : ["credentials"]
        content {
          dynamic "items" {
            for_each = lookup(credentials.value, "items") == null ? [] : ["items"]
            content {
              credential_name = lookup(items.value, "credential_name")
              credential_type = lookup(items.value, "credential_type")

              dynamic "properties" {
                for_each = lookup(items.value, "properties") == null ? [] : ["properties"]
                content {
                  properties_map = lookup(properties.value, "properties_map")
                }
              }
            }
          }
        }
      }
      dynamic "properties" {
        for_each = lookup(discovery_details.value, "properties") == null ? [] : ["properties"]
        content {
          properties_map = lookup(properties.value, "properties_map")
        }
      }
      dynamic "tags" {
        for_each = lookup(discovery_details.value, "tags") == null ? [] : ["tags"]
        content {
          properties_map = lookup(tags.value, "properties_map")
        }
      }
    }
  }
}

resource "oci_stack_monitoring_metric_extension" "this" {
  count                  = lenght(var.metric_extension)
  collection_recurrences = lookup(var.metric_extension[count.index], "collection_recurrences")
  compartment_id         = data.oci_identity_compartment.this.id
  display_name           = lookup(var.metric_extension[count.index], "display_name")
  name                   = lookup(var.metric_extension[count.index], "name")
  resource_type          = lookup(var.metric_extension[count.index], "resource_type")
  publish_trigger        = lookup(var.metric_extension[count.index], "publish_trigger")

  dynamic "metric_list" {
    for_each = lookup(var.metric_extension[count.index], "metric_list")
    content {
      data_type       = lookup(metric_list.value, "data_type")
      name            = lookup(metric_list.value, "name")
      is_dimension    = lookup(metric_list.value, "is_dimension")
      is_hidden       = lookup(metric_list.value, "is_hidden")
      metric_category = lookup(metric_list.value, "metric_category")
      unit            = lookup(metric_list.value, "unit")
    }
  }

  dynamic "query_properties" {
    for_each = lookup(var.metric_extension[count.index], "query_properties")
    content {
      collection_method         = lookup(query_properties.value, "collection_method")
      arguments                 = lookup(query_properties.value, "collection_method") == "OS_COMMAND" ? lookup(query_properties.value, "arguments") : null
      auto_row_prefix           = lookup(query_properties.value, "collection_method") == "JMX" ? lookup(query_properties.value, "auto_row_prefix") : null
      command                   = lookup(query_properties.value, "collection_method") == "OS_COMMAND" ? lookup(query_properties.value, "command") : null
      delimiter                 = lookup(query_properties.value, "collection_method") == "OS_COMMAND" ? lookup(query_properties.value, "delimiter") : null
      identity_metric           = lookup(query_properties.value, "collection_method") == "JMX" ? lookup(query_properties.value, "identity_metric") : null
      is_metric_service_enabled = lookup(query_properties.value, "collection_method") == "JMX" ? lookup(query_properties.value, "is_metric_service_enabled") : null
      jmx_attributes            = lookup(query_properties.value, "collection_method") == "JMX" ? lookup(query_properties.value, "jmx_attributes") : null
      managed_bean_query        = lookup(query_properties.value, "collection_method") == "JMX" ? lookup(query_properties.value, "managed_bean_query") : null
      sql_type                  = lookup(query_properties.value, "collection_method") == "SQL" ? lookup(query_properties.value, "sql_type") : null
      starts_with               = lookup(query_properties.value, "collection_method") == "OS_COMMAND" ? lookup(query_properties.value, "starts_with") : null

      dynamic "in_param_details" {
        for_each = lookup(query_properties.value, "collection_method") == "SQL" ? lookup(query_properties.value, "in_param_details") : []
        content {
          in_param_position = lookup(in_param_details.value, "in_param_position")
          in_param_value    = lookup(in_param_details.value, "in_param_value")
        }
      }

      dynamic "out_param_details" {
        for_each = lookup(query_properties.value, "collection_method") == "SQL" ? lookup(query_properties.value, "out_param_details") : null
        content {
          out_param_position = lookup(out_param_details.value, "out_param_position")
          out_param_type     = lookup(out_param_details.value, "out_param_type")
        }
      }

      dynamic "script_details" {
        for_each = lookup(query_properties.value, "collection_method") == "OS_COMMAND" ? lookup(query_properties.value, "script_details") : null
        content {
          content = lookup(script_details.value, "content")
          name    = lookup(script_details.value, "name")
        }
      }

      dynamic "sql_details" {
        for_each = lookup(query_properties.value, "collection_method") == "SQL" ? lookup(query_properties.value, "sql_details") : null
        content {
          content          = lookup(sql_details.value, "content")
          script_file_name = lookup(sql_details.value, "script_file_name")
        }
      }
    }
  }
}

resource "oci_stack_monitoring_metric_extension_metric_extension_on_given_resources_management" "this" {
  count                                      = lenght(var.metric_extension_metric_extension_on_given_resources_management)
  enable_metric_extension_on_given_resources = false
  metric_extension_id = try(
    element(oci_stack_monitoring_metric_extension.this.*.id, lookup(var.metric_extension_metric_extension_on_given_resources_management[count.index], "metric_extension_id"))
  )
  resource_ids = lookup(var.metric_extension_metric_extension_on_given_resources_management[count.index], "resource_ids")
}

resource "oci_stack_monitoring_metric_extensions_test_management" "this" {
  count = lenght(var.metric_extensions_test_management)
  metric_extension_id = try(
    element(oci_stack_monitoring_metric_extension.this.*.id, lookup(var.metric_extensions_test_management[count.index], "metric_extension_id"))
  )
  resource_ids = lookup(var.metric_extensions_test_management[count.index], "resource_ids")
}

resource "oci_stack_monitoring_monitored_resource" "this" {
  count          = lenght(var.monitored_resource)
  compartment_id = data.oci_identity_compartment.this.id
  name           = lookup(var.monitored_resource[count.index], "name")
  type           = lookup(var.monitored_resource[count.index], "type")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.monitored_resource[count.index], "defined_tags")
  )
  display_name         = lookup(var.monitored_resource[count.index], "display_name")
  external_id          = lookup(var.monitored_resource[count.index], "external_id")
  external_resource_id = lookup(var.monitored_resource[count.index], "external_resource_id")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.monitored_resource[count.index], "freeform_tags")
  )
  host_name           = lookup(var.monitored_resource[count.index], "host_name")
  license             = lookup(var.monitored_resource[count.index], "license")
  management_agent_id = lookup(var.monitored_resource[count.index], "management_agent_id")
  resource_time_zone  = lookup(var.monitored_resource[count.index], "resource_time_zone")

  dynamic "additional_aliases" {
    for_each = lookup(var.monitored_resource[count.index], "additional_aliases") == null ? [] : ["additional_aliases"]
    content {
      name   = lookup(additional_aliases.value, "name")
      source = lookup(additional_aliases.value, "source")

      dynamic "credential" {
        for_each = lookup(additional_aliases.value, "credential")
        content {
          name    = lookup(credential.value, "name")
          service = lookup(credential.value, "service")
          source  = lookup(credential.value, "source")
        }
      }
    }
  }

  dynamic "additional_credentials" {
    for_each = lookup(var.monitored_resource[count.index], "additional_credentials") == null ? [] : ["additional_credentials"]
    content {
      credential_type = lookup(additional_credentials.value, "credential_type")
      description     = lookup(additional_credentials.value, "description")
      source          = lookup(additional_credentials.value, "source")
      key_id          = lookup(additional_credentials.value, "credential_type") == "ENCRYPTED" ? lookup(additional_credentials.value, "key_id") : null
      name            = lookup(additional_credentials.value, "name")
      type            = lookup(additional_credentials.value, "type")

      dynamic "properties" {
        for_each = lookup(additional_credentials.value, "credential_type") == "ENCRYPTED" || "PLAINTEXT" ? lookup(additional_credentials.value, "properties") : []
        content {
          name  = lookup(properties.value, "name")
          value = lookup(properties.value, "value")
        }
      }
    }
  }

  dynamic "aliases" {
    for_each = lookup(var.monitored_resource[count.index], "aliases") == null ? [] : ["aliases"]
    content {
      name   = lookup(aliases.value, "name")
      source = lookup(aliases.value, "source")

      dynamic "credential" {
        for_each = lookup(aliases.value, "credential")
        content {
          name    = lookup(credential.value, "name")
          service = lookup(credential.value, "service")
          source  = lookup(credential.value, "source")
        }
      }
    }
  }

  dynamic "credentials" {
    for_each = lookup(var.monitored_resource[count.index], "credentials") == null ? [] : ["credentials"]
    content {
      credential_type = lookup(credentials.value, "credential_type")
      description     = lookup(credentials.value, "description")
      key_id          = lookup(credentials.value, "credential_type") == "ENCRYPTED" ? lookup(credentials.value, "key_id") : null
      name            = lookup(credentials.value, "name")
      source          = lookup(credentials.value, "source")
      type            = lookup(credentials.value, "type")

      dynamic "properties" {
        for_each = lookup(credentials.value, "credential_type") == "ENCRYPTED" || "PLAINTEXT" ? lookup(credentials.value, "properties") : []
        content {
          name  = lookup(properties.value, "name")
          value = lookup(properties.value, "value")
        }
      }
    }
  }

  dynamic "database_connection_details" {
    for_each = lookup(var.monitored_resource[count.index], "database_connection_details") == null ? [] : ["database_connection_details"]
    content {
      port           = lookup(database_connection_details.value, "port")
      protocol       = lookup(database_connection_details.value, "protocol")
      service_name   = lookup(database_connection_details.value, "service_name")
      connector_id   = lookup(database_connection_details.value, "connector_id")
      db_id          = lookup(database_connection_details.value, "db_id")
      db_unique_name = lookup(database_connection_details.value, "db_unique_name")
      ssl_secret_id  = lookup(database_connection_details.value, "ssl_secret_id")
    }
  }

  dynamic "properties" {
    for_each = lookup(var.monitored_resource[count.index], "properties") == null ? [] : ["properties"]
    content {
      name  = lookup(properties.value, "name")
      value = lookup(properties.value, "value")
    }
  }
}

resource "oci_stack_monitoring_monitored_resource_task" "this" {
  count          = lenght(var.monitored_resource_task)
  compartment_id = data.oci_identity_compartment.this.id
  defined_tags = merge(
    var.defined_tags,
    lookup(var.monitored_resource_task[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.monitored_resource_task[count.index], "freeform_tags")
  )
  name = lookup(var.monitored_resource_task[count.index], "name")

  dynamic "task_details" {
    for_each = lookup(var.monitored_resource_task[count.index], "task_details")
    content {
      namespace                                     = lookup(var.monitored_resource_task[count.index], "namespace")
      source                                        = lookup(var.monitored_resource_task[count.index], "source")
      type                                          = lookup(var.monitored_resource_task[count.index], "type")
      availability_proxy_metric_collection_interval = lookup(var.monitored_resource_task[count.index], "availability_proxy_metric_collection_interval")
      availability_proxy_metrics                    = lookup(var.monitored_resource_task[count.index], "availability_proxy_metrics")
      resource_group                                = lookup(var.monitored_resource_task[count.index], "resource_group")
    }
  }
}

resource "oci_stack_monitoring_monitored_resource_type" "this" {
  count          = lenght(var.monitored_resource_type)
  compartment_id = data.oci_identity_compartment.this.id
  name           = lookup(var.monitored_resource_type[count.index], "name")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.monitored_resource_type[count.index], "defined_tags")
  )
  description  = lookup(var.monitored_resource_type[count.index], "description")
  display_name = lookup(var.monitored_resource_type[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.monitored_resource_type[count.index], "freeform_tags")
  )
  metric_namespace = lookup(var.monitored_resource_type[count.index], "metric_namespace")

  dynamic "metadata" {
    for_each = lookup(var.monitored_resource_type[count.index], "metadata") == null ? [] : ["metadata"]
    content {
      format                      = lookup(metadata.value, "format")
      agent_properties            = lookup(metadata.value, "agent_properties")
      required_properties         = lookup(metadata.value, "required_properties")
      valid_properties_for_create = lookup(metadata.value, "valid_properties_for_create")
      valid_properties_for_update = lookup(metadata.value, "valid_properties_for_update")
      valid_property_values       = lookup(metadata.value, "valid_property_values")

      dynamic "unique_property_sets" {
        for_each = lookup(metadata.value, "unique_property_sets") == null ? [] : ["unique_property_sets"]
        content {
          properties = lookup(unique_property_sets.value, "properties")
        }
      }
    }
  }
}

resource "oci_stack_monitoring_monitored_resources_associate_monitored_resource" "this" {
  count                   = lenght(var.monitored_resources_associate_monitored_resource)
  association_type        = lookup(var.monitored_resources_associate_monitored_resource[count.index], "association_type")
  compartment_id          = data.oci_identity_compartment.this.id
  destination_resource_id = lookup(var.monitored_resources_associate_monitored_resource[count.index], "destination_resource_id")
  source_resource_id      = lookup(var.monitored_resources_associate_monitored_resource[count.index], "source_resource_id")
}

resource "oci_stack_monitoring_monitored_resources_list_member" "this" {
  count                   = lenght(var.monitored_resources_list_member)
  monitored_resource_id   = lookup(var.monitored_resources_list_member[count.index], "monitored_resource_id")
  destination_resource_id = lookup(var.monitored_resources_list_member[count.index], "destination_resource_id")
  limit_level             = lookup(var.monitored_resources_list_member[count.index], "limit_level")
}

resource "oci_stack_monitoring_monitored_resources_search" "this" {
  count                                 = lenght(var.monitored_resources_search)
  compartment_id                        = data.oci_identity_compartment.this.id
  exclude_fields                        = lookup(var.monitored_resources_search[count.index], "exclude_fields")
  external_id                           = lookup(var.monitored_resources_search[count.index], "external_id")
  fields                                = lookup(var.monitored_resources_search[count.index], "fields")
  host_name                             = lookup(var.monitored_resources_search[count.index], "host_name")
  host_name_contains                    = lookup(var.monitored_resources_search[count.index], "host_name_contains")
  license                               = lookup(var.monitored_resources_search[count.index], "license")
  management_agent_id                   = lookup(var.monitored_resources_search[count.index], "management_agent_id")
  name                                  = lookup(var.monitored_resources_search[count.index], "name")
  name_contains                         = lookup(var.monitored_resources_search[count.index], "name_contains")
  property_equals                       = lookup(var.monitored_resources_search[count.index], "property_equals")
  resource_time_zone                    = lookup(var.monitored_resources_search[count.index], "resource_time_zone")
  state                                 = lookup(var.monitored_resources_search[count.index], "state")
  time_created_greater_than_or_equal_to = lookup(var.monitored_resources_search[count.index], "time_created_greater_than_or_equal_to")
  time_created_less_than                = lookup(var.monitored_resources_search[count.index], "time_created_less_than")
  time_updated_greater_than_or_equal_to = lookup(var.monitored_resources_search[count.index], "time_updated_greater_than_or_equal_to")
  time_updated_less_than                = lookup(var.monitored_resources_search[count.index], "time_updated_less_than")
  type                                  = lookup(var.monitored_resources_search[count.index], "type")
}

resource "oci_stack_monitoring_monitored_resources_search_association" "this" {
  count                     = lenght(var.monitored_resources_search_association)
  compartment_id            = data.oci_identity_compartment.this.id
  association_type          = lookup(var.monitored_resources_search_association[count.index], "association_type")
  destination_resource_id   = lookup(var.monitored_resources_search_association[count.index], "destination_resource_id")
  destination_resource_name = lookup(var.monitored_resources_search_association[count.index], "destination_resource_name")
  destination_resource_type = lookup(var.monitored_resources_search_association[count.index], "destination_resource_type")
  source_resource_id        = lookup(var.monitored_resources_search_association[count.index], "source_resource_id")
  source_resource_name      = lookup(var.monitored_resources_search_association[count.index], "source_resource_name")
  source_resource_type      = lookup(var.monitored_resources_search_association[count.index], "source_resource_type")
}