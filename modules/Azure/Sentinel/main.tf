resource "azurerm_resource_group" "this" {
  count    = length(var.resource_group) && var.resource_group_name == null
  location = lookup(var.resource_group[count.index], "location")
  name     = lookup(var.resource_group[count.index], "name")
  tags = merge(
    var.tags,
    lookup(var.resource_group[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "azurerm_log_analytics_workspace" "this" {
  count = length(var.log_analytics_workspace)
  location = try(
    data.azurerm_resource_group.this.location,
    element(azurerm_resource_group.this.*.location, lookup(var.log_analytics_workspace[count.index], "resource_group_id"))
  )
  name = lookup(var.log_analytics_workspace[count.index], "name")
  resource_group_name = try(
    data.azurerm_resource_group.this.*.name,
    lookup(azurerm_resource_group.this.*.name, lookup(var.log_analytics_workspace[count.index], "resource_group_id"))
  )
  allow_resource_only_permissions    = lookup(var.log_analytics_workspace[count.index], "allow_resource_only_permissions")
  local_authentication_disabled      = lookup(var.log_analytics_workspace[count.index], "local_authentication_disabled")
  sku                                = lookup(var.log_analytics_workspace[count.index], "sku")
  retention_in_days                  = lookup(var.log_analytics_workspace[count.index], "retention_in_days")
  daily_quota_gb                     = lookup(var.log_analytics_workspace[count.index], "daily_quota_gb")
  cmk_for_query_forced               = lookup(var.log_analytics_workspace[count.index], "cmk_for_query_forced")
  internet_ingestion_enabled         = lookup(var.log_analytics_workspace[count.index], "internet_ingestion_enabled")
  internet_query_enabled             = lookup(var.log_analytics_workspace[count.index], "internet_query_enabled")
  reservation_capacity_in_gb_per_day = lookup(var.log_analytics_workspace[count.index], "reservation_capacity_in_gb_per_day")
  tags = merge(
    var.tags,
    lookup(var.log_analytics_workspace[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "azurerm_log_analytics_solution" "this" {
  count = length(var.log_analytics_solution)
  location = try(
    data.azurerm_resource_group.this.location,
    element(azurerm_resource_group.this.*.location, lookup(var.log_analytics_solution[count.index], "resource_group_id")
    )
  )
  resource_group_name = try(
    data.azurerm_resource_group.this.name,
    element(azurerm_resource_group.this.*.name, lookup(var.log_analytics_solution[count.index], "resource_group_id")
    )
  )
  solution_name = lookup(var.log_analytics_solution[count.index], "solution_name")
  workspace_name = try(
    data.azurerm_log_analytics_workspace.this.name,
    element(azurerm_log_analytics_workspace.this.*.name, lookup(var.log_analytics_solution[count.index], "workspace_id")
    )
  )
  workspace_resource_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.log_analytics_solution[count.index], "workspace_id")
    )
  )
  tags = merge(
    var.tags,
    lookup(var.log_analytics_solution[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )

  dynamic "plan" {
    for_each = lookup(var.log_analytics_solution[count.index], "plan") == null ? [] : ["plan"]
    content {
      product        = lookup(plan.value, "product")
      publisher      = lookup(plan.value, "publisher")
      promotion_code = lookup(plan.value, "promotion_code")
    }
  }
}

resource "azurerm_sentinel_log_analytics_workspace_onboarding" "this" {
  count = length(var.sentinel_onboarding)
  resource_group_name = try(
    data.azurerm_resource_group.this.name,
    element(azurerm_resource_group.this.*.name, lookup(var.sentinel_onboarding[count.index], "resource_group_id"))
  )
  workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.sentinel_onboarding[count.index], "workspace_id"))
  )
  customer_managed_key_enabled = lookup(var.sentinel_onboarding[count.index], "customer_managed_key_enabled")
}

resource "azurerm_sentinel_alert_rule_machine_learning_behavior_analytics" "this" {
  count                    = length(var.machine_learning_behavior_analytics)
  alert_rule_template_guid = lookup(var.machine_learning_behavior_analytics[count.index], "alert_rule_template_guid")
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.machine_learning_behavior_analytics[count.index], "workspace_id"))
  )
  name    = lookup(var.machine_learning_behavior_analytics[count.index], "name")
  enabled = lookup(var.machine_learning_behavior_analytics[count.index], "enabled")
}

resource "azurerm_sentinel_alert_rule_anomaly_built_in" "this" {
  count   = length(var.alert_rule_anomaly)
  enabled = lookup(var.alert_rule_anomaly[count.index], "enabled")
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.alert_rule_anomaly[count.index], "workspace_id"))
  )
  mode         = lookup(var.alert_rule_anomaly[count.index], "mode")
  name         = lookup(var.alert_rule_anomaly[count.index], "name")
  display_name = lookup(var.alert_rule_anomaly[count.index], "display_name")
}

resource "azurerm_sentinel_alert_rule_anomaly_duplicate" "this" {
  count = length(var.alert_rule_anomaly_duplicate)
  built_in_rule_id = try(
    element(azurerm_sentinel_alert_rule_anomaly_built_in.this.*.id, lookup(var.alert_rule_anomaly_duplicate[count.index], "built_in_rule_id"))
  )
  display_name = lookup(var.alert_rule_anomaly_duplicate[count.index], "display_name")
  enabled      = lookup(var.alert_rule_anomaly_duplicate[count.index], "enabled")
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.alert_rule_anomaly_duplicate[count.index], "workspace_id"))
  )
  mode = lookup(var.alert_rule_anomaly_duplicate[count.index], "mode")

  dynamic "multi_select_observation" {
    for_each = lookup(var.alert_rule_anomaly_duplicate[count.index], "multi_select_observation") == null ? [] : ["multi_select_observation"]
    content {
      name   = lookup(multi_select_observation.value, "name")
      values = lookup(multi_select_observation.value, "values")
    }
  }

  dynamic "prioritized_exclude_observation" {
    for_each = lookup(var.alert_rule_anomaly_duplicate[count.index], "prioritized_exclude_observation") == null ? [] : ["prioritized_exclude_observation"]
    content {
      name       = lookup(prioritized_exclude_observation.value, "name")
      exclude    = lookup(prioritized_exclude_observation.value, "exclude")
      prioritize = lookup(prioritized_exclude_observation.value, "prioritize")
    }
  }

  dynamic "single_select_observation" {
    for_each = lookup(var.alert_rule_anomaly_duplicate[count.index], "single_select_observation") == null ? [] : ["single_select_observation"]
    content {
      name  = lookup(single_select_observation.value, "name")
      value = lookup(single_select_observation.value, "value")
    }
  }

  dynamic "threshold_observation" {
    for_each = lookup(var.alert_rule_anomaly_duplicate[count.index], "threshold_observation") == null ? [] : ["threshold_observation"]
    content {
      name  = lookup(threshold_observation.value, "name")
      value = lookup(threshold_observation.value, "value")
    }
  }
}

resource "azurerm_sentinel_alert_rule_fusion" "this" {
  count                    = length(var.alert_rule_fusion)
  alert_rule_template_guid = data.azurerm_sentinel_alert_rule_template.this.id
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.alert_rule_fusion[count.index], "workspace_id"))
  )
  name    = lookup(var.alert_rule_fusion[count.index], "name")
  enabled = lookup(var.alert_rule_fusion[count.index], "enabled")

  dynamic "source" {
    for_each = lookup(var.alert_rule_fusion[count.index], "source") == null ? [] : ["source"]
    content {
      name    = lookup(source.value, "name")
      enabled = lookup(source.value, "enabled")

      dynamic "sub_type" {
        for_each = lookup(source.value, "sub_type") == null ? [] : ["sub_type"]
        content {
          name               = lookup(sub_type.value, "name")
          severities_allowed = lookup(sub_type.value, "severities_allowed")
          enabled            = lookup(sub_type.value, "enabled")
        }
      }
    }
  }
}

resource "azurerm_sentinel_alert_rule_ms_security_incident" "this" {
  count        = length(var.ms_security_incident)
  display_name = lookup(var.ms_security_incident[count.index], "display_name")
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.ms_security_incident[count.index], "workspace_id"))
  )
  name                        = lookup(var.ms_security_incident[count.index], "name")
  product_filter              = lookup(var.ms_security_incident[count.index], "product_filter")
  severity_filter             = lookup(var.ms_security_incident[count.index], "severity_filter")
  alert_rule_template_guid    = data.azurerm_sentinel_alert_rule_template.this.id
  description                 = lookup(var.ms_security_incident[count.index], "description")
  enabled                     = lookup(var.ms_security_incident[count.index], "enabled")
  display_name_filter         = lookup(var.ms_security_incident[count.index], "display_name_filter")
  display_name_exclude_filter = lookup(var.ms_security_incident[count.index], "display_name_exclude_filter")
}

resource "azurerm_sentinel_alert_rule_nrt" "this" {
  count        = length(var.alert_rule_nrt)
  display_name = lookup(var.alert_rule_nrt[count.index], "display_name")
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.alert_rule_nrt[count.index], "workspace_id"))
  )
  name                        = lookup(var.alert_rule_nrt[count.index], "name")
  query                       = lookup(var.alert_rule_nrt[count.index], "query")
  severity                    = lookup(var.alert_rule_nrt[count.index], "severity")
  alert_rule_template_guid    = data.azurerm_sentinel_alert_rule_template.this.id
  alert_rule_template_version = lookup(var.alert_rule_nrt[count.index], "alert_rule_template_version")
  custom_details              = lookup(var.alert_rule_nrt[count.index], "custom_details")
  description                 = lookup(var.alert_rule_nrt[count.index], "description")
  enabled                     = lookup(var.alert_rule_nrt[count.index], "enabled")
  suppression_duration        = lookup(var.alert_rule_nrt[count.index], "suppression_duration")
  suppression_enabled         = lookup(var.alert_rule_nrt[count.index], "suppression_enabled")
  tactics                     = lookup(var.alert_rule_nrt[count.index], "tactics")
  techniques                  = lookup(var.alert_rule_nrt[count.index], "techniques")

  dynamic "alert_details_override" {
    for_each = lookup(var.alert_rule_nrt[count.index], "alert_details_override") == null ? [] : ["alert_details_override"]
    content {
      description_format   = lookup(alert_details_override.value, "description_format")
      display_name_format  = lookup(alert_details_override.value, "display_name_format")
      severity_column_name = lookup(alert_details_override.value, "severity_column_name")
      tactics_column_name  = lookup(alert_details_override.value, "tactics_column_name")

      dynamic "dynamic_property" {
        for_each = lookup(alert_details_override.value, "dynamic_property") == null ? [] : ["dynamic_property"]
        content {
          name  = lookup(dynamic_property.value, "name")
          value = lookup(dynamic_property.value, "value")
        }
      }
    }
  }

  dynamic "entity_mapping" {
    for_each = lookup(var.alert_rule_nrt[count.index], "entity_mapping") == null ? [] : ["entity_mapping"]
    content {
      entity_type = lookup(entity_mapping.value, "entity_type")

      dynamic "field_mapping" {
        for_each = lookup(entity_mapping.value, "field_mapping") == null ? [] : ["field_mapping"]
        content {
          column_name = lookup(field_mapping.value, "column_name")
          identifier  = lookup(field_mapping.value, "identifier")
        }
      }
    }
  }

  dynamic "event_grouping" {
    for_each = lookup(var.alert_rule_nrt[count.index], "event_grouping") == null ? [] : ["event_grouping"]
    content {
      aggregation_method = lookup(event_grouping.value, "aggregation_method")
    }
  }

  dynamic "incident" {
    for_each = lookup(var.alert_rule_nrt[count.index], "incident") == null ? [] : ["incident"]
    content {
      create_incident_enabled = lookup(incident.value, "create_incident_enabled")

      dynamic "grouping" {
        for_each = lookup(incident.value, "grouping")
        content {
          enabled                 = lookup(grouping.value, "enabled")
          lookback_duration       = lookup(grouping.value, "lookback_duration")
          reopen_closed_incidents = lookup(grouping.value, "reopen_closed_incidents")
          entity_matching_method  = lookup(grouping.value, "entity_matching_method")
          by_entities             = lookup(grouping.value, "by_entities")
          by_alert_details        = lookup(grouping.value, "by_alert_details")
          by_custom_details       = lookup(grouping.value, "by_custom_details")
        }
      }
    }
  }

  dynamic "sentinel_entity_mapping" {
    for_each = lookup(var.alert_rule_nrt[count.index], "sentinel_entity_mapping") == null ? [] : ["sentinel_entity_mapping"]
    content {
      column_name = lookup(sentinel_entity_mapping.value, "column_name")
    }
  }
}

resource "azurerm_sentinel_alert_rule_scheduled" "this" {
  count        = length(var.alert_rule_scheduled)
  display_name = lookup(var.alert_rule_scheduled[count.index], "display_name")
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.alert_rule_scheduled[count.index], "workspace_id"))
  )
  name                        = lookup(var.alert_rule_scheduled[count.index], "name")
  query                       = lookup(var.alert_rule_scheduled[count.index], "query")
  severity                    = lookup(var.alert_rule_scheduled[count.index], "severity")
  alert_rule_template_guid    = data.azurerm_sentinel_alert_rule_template.this.id
  alert_rule_template_version = lookup(var.alert_rule_scheduled[count.index], "alert_rule_template_version")
  custom_details              = lookup(var.alert_rule_scheduled[count.index], "custom_details")
  description                 = lookup(var.alert_rule_scheduled[count.index], "description")
  enabled                     = lookup(var.alert_rule_scheduled[count.index], "enabled")
  suppression_duration        = lookup(var.alert_rule_scheduled[count.index], "suppression_duration")
  suppression_enabled         = lookup(var.alert_rule_scheduled[count.index], "suppression_enabled")
  tactics                     = lookup(var.alert_rule_scheduled[count.index], "tactics")
  techniques                  = lookup(var.alert_rule_scheduled[count.index], "techniques")

  dynamic "alert_details_override" {
    for_each = lookup(var.alert_rule_scheduled[count.index], "alert_details_override") == null ? [] : ["alert_details_override"]
    content {
      description_format   = lookup(alert_details_override.value, "description_format")
      display_name_format  = lookup(alert_details_override.value, "display_name_format")
      severity_column_name = lookup(alert_details_override.value, "severity_column_name")
      tactics_column_name  = lookup(alert_details_override.value, "tactics_column_name")

      dynamic "dynamic_property" {
        for_each = lookup(alert_details_override.value, "dynamic_property") == null ? [] : ["dynamic_property"]
        content {
          name  = lookup(dynamic_property.value, "name")
          value = lookup(dynamic_property.value, "value")
        }
      }
    }
  }

  dynamic "entity_mapping" {
    for_each = lookup(var.alert_rule_scheduled[count.index], "entity_mapping") == null ? [] : ["entity_mapping"]
    content {
      entity_type = lookup(entity_mapping.value, "entity_type")

      dynamic "field_mapping" {
        for_each = lookup(entity_mapping.value, "field_mapping") == null ? [] : ["field_mapping"]
        content {
          column_name = lookup(field_mapping.value, "column_name")
          identifier  = lookup(field_mapping.value, "identifier")
        }
      }
    }
  }

  dynamic "event_grouping" {
    for_each = lookup(var.alert_rule_scheduled[count.index], "event_grouping") == null ? [] : ["event_grouping"]
    content {
      aggregation_method = lookup(event_grouping.value, "aggregation_method")
    }
  }

  dynamic "incident" {
    for_each = lookup(var.alert_rule_scheduled[count.index], "incident") == null ? [] : ["incident"]
    content {
      create_incident_enabled = lookup(incident.value, "create_incident_enabled")

      dynamic "grouping" {
        for_each = lookup(incident.value, "grouping")
        content {
          enabled                 = lookup(grouping.value, "enabled")
          lookback_duration       = lookup(grouping.value, "lookback_duration")
          reopen_closed_incidents = lookup(grouping.value, "reopen_closed_incidents")
          entity_matching_method  = lookup(grouping.value, "entity_matching_method")
          by_entities             = lookup(grouping.value, "by_entities")
          by_alert_details        = lookup(grouping.value, "by_alert_details")
          by_custom_details       = lookup(grouping.value, "by_custom_details")
        }
      }
    }
  }

  dynamic "sentinel_entity_mapping" {
    for_each = lookup(var.alert_rule_scheduled[count.index], "sentinel_entity_mapping") == null ? [] : ["sentinel_entity_mapping"]
    content {
      column_name = lookup(sentinel_entity_mapping.value, "column_name")
    }
  }
}

resource "azurerm_sentinel_alert_rule_threat_intelligence" "this" {
  count                    = length(var.alert_rule_threat_intelligence)
  alert_rule_template_guid = azurerm_sentinel_alert_rule_anomaly_built_in.this.id
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.alert_rule_threat_intelligence[count.index], "workspace_id"))
  )
  name    = lookup(var.alert_rule_threat_intelligence[count.index], "name")
  enabled = lookup(var.alert_rule_threat_intelligence[count.index], "enabled")
}

resource "azurerm_sentinel_automation_rule" "this" {
  count        = length(var.automation_rule)
  display_name = lookup(var.automation_rule[count.index], "display_name")
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.automation_rule[count.index], "workspace_id"))
  )
  name           = lookup(var.automation_rule[count.index], "name")
  order          = lookup(var.automation_rule[count.index], "order")
  condition_json = lookup(var.automation_rule[count.index], "condition_json")
  enabled        = lookup(var.automation_rule[count.index], "enabled")
  expiration     = lookup(var.automation_rule[count.index], "expiration")
  triggers_on    = lookup(var.automation_rule[count.index], "triggers_on")
  triggers_when  = lookup(var.automation_rule[count.index], "triggers_when")

  dynamic "action_incident" {
    for_each = lookup(var.automation_rule[count.index], "action_incident") == null ? [] : ["action_incident"]
    content {
      order                  = lookup(action_incident.value, "order")
      status                 = lookup(action_incident.value, "status")
      classification         = lookup(action_incident.value, "classification")
      classification_comment = lookup(action_incident.value, "classification_comment")
      labels                 = lookup(action_incident.value, "labels")
      owner_id               = lookup(action_incident.value, "owner_id")
      severity               = lookup(action_incident.value, "severity")
    }
  }

  dynamic "action_playbook" {
    for_each = lookup(var.automation_rule[count.index], "action_playbook") == null ? [] : ["action_playbook"]
    content {
      logic_app_id = try(
        data.azurerm_logic_app_standard.this.id,
        data.azurerm_logic_app_workflow.this.id
      )
      order     = lookup(action_playbook.value, "order")
      tenant_id = lookup(action_playbook.value, "tenant_id")
    }
  }
}

resource "azurerm_sentinel_data_connector_aws_cloud_trail" "this" {
  count        = length(length(var.data_connector_cloud_trail))
  aws_role_arn = lookup(var.data_connector_cloud_trail[count.index], "aws_role_arn")
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_cloud_trail[count.index], "workspace_id"))
  )
  name = lookup(var.data_connector_cloud_trail[count.index], "name")
}

resource "azurerm_sentinel_data_connector_aws_s3" "this" {
  count             = length(var.data_connector_s3)
  aws_role_arn      = lookup(var.data_connector_s3[count.index], "aws_role_arn")
  destination_table = lookup(var.data_connector_s3[count.index], "destination_table")
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_s3[count.index], "workspace_id"))
  )
  name     = lookup(var.data_connector_s3[count.index], "name")
  sqs_urls = lookup(var.data_connector_s3[count.index], "sqs_urls")
}

resource "azurerm_sentinel_data_connector_azure_active_directory" "this" {
  count = length(var.data_connect_aad)
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connect_aad[count.index], "workspace_id"))
  )
  name      = lookup(var.data_connect_aad[count.index], "name")
  tenant_id = try(data.azurerm_subscription.this.tenant_id)
}

resource "azurerm_sentinel_data_connector_azure_security_center" "this" {
  count = length(var.data_connector_azure_security_center)
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_azure_security_center[count.index], "workspace_id"))
  )
  name            = lookup(var.data_connector_azure_security_center[count.index], "name")
  subscription_id = try(data.azurerm_subscription.this.id)
}

resource "azurerm_sentinel_data_connector_iot" "this" {
  count = length(var.data_connector_iot)
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_iot[count.index], "workspace_id"))
  )
  name            = lookup(var.data_connector_iot[count.index], "name")
  subscription_id = try(data.azurerm_subscription.this.id)
}

resource "azurerm_sentinel_data_connector_microsoft_cloud_app_security" "this" {
  count = length(var.data_connector_cloud_app_security)
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_cloud_app_security[count.index], "workspace_id"))
  )
  name                   = lookup(var.data_connector_cloud_app_security[count.index], "name")
  alerts_enabled         = lookup(var.data_connector_cloud_app_security[count.index], "alerts_enabled")
  discovery_logs_enabled = lookup(var.data_connector_cloud_app_security[count.index], "discovery_logs_enabled")
  tenant_id              = try(data.azurerm_subscription.this.tenant_id)
}

resource "azurerm_sentinel_data_connector_dynamics_365" "this" {
  count = length(var.data_connector_dynamics_365)
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_dynamics_365[count.index], "workspace_id"))
  )
  name      = lookup(var.data_connector_dynamics_365[count.index], "name")
  tenant_id = try(data.azurerm_subscription.this.tenant_id)
}

resource "azurerm_sentinel_data_connector_microsoft_defender_advanced_threat_protection" "this" {
  count = length(var.data_connector_defender_advanced_threat_protection)
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_defender_advanced_threat_protection[count.index], "workspace_id"))
  )
  name      = lookup(var.data_connector_defender_advanced_threat_protection[count.index], "name")
  tenant_id = try(data.azurerm_subscription.this.tenant_id)
}

resource "azurerm_sentinel_data_connector_azure_advanced_threat_protection" "this" {
  count = length(var.data_connector_azure_advanced_threat_protection)
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_azure_advanced_threat_protection[count.index], "workspace_id"))
  )
  name      = lookup(var.data_connector_azure_advanced_threat_protection[count.index], "name")
  tenant_id = try(data.azurerm_subscription.this.tenant_id)
}

resource "azurerm_sentinel_data_connector_microsoft_threat_intelligence" "this" {
  count = length(var.data_connector_azure_advanced_threat_intelligence)
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_azure_advanced_threat_intelligence[count.index], "workspace_id"))
  )
  name                                         = lookup(var.data_connector_azure_advanced_threat_intelligence[count.index], "name")
  microsoft_emerging_threat_feed_lookback_date = timestamp()
  tenant_id                                    = try(data.azurerm_subscription.this.tenant_id)
}

resource "azurerm_sentinel_data_connector_microsoft_threat_protection" "this" {
  count = length(var.data_connector_microsoft_threat_protection)
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_microsoft_threat_protection[count.index], "workspace_id"))
  )
  name      = lookup(var.data_connector_microsoft_threat_protection[count.index], "name")
  tenant_id = try(data.azurerm_subscription.this.tenant_id)
}

resource "azurerm_sentinel_data_connector_office_365" "this" {
  count = length(var.data_connector_office_365)
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_office_365[count.index], "workspace_id"))
  )
  name               = lookup(var.data_connector_office_365[count.index], "name")
  teams_enabled      = lookup(var.data_connector_office_365[count.index], "teams_enabled")
  sharepoint_enabled = lookup(var.data_connector_office_365[count.index], "sharepoint_enabled")
  exchange_enabled   = lookup(var.data_connector_office_365[count.index], "exchange_enabled")
  tenant_id          = try(data.azurerm_subscription.this.tenant_id)
}

resource "azurerm_sentinel_data_connector_office_365_project" "this" {
  count = length(var.data_connector_office_365_project)
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_office_365_project[count.index], "workspace_id"))
  )
  name      = lookup(var.data_connector_office_365_project[count.index], "name")
  tenant_id = try(data.azurerm_subscription.this.tenant_id)
}

resource "azurerm_sentinel_data_connector_office_atp" "this" {
  count = length(var.data_connector_office_atp)
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_office_atp[count.index], "workspace_id"))
  )
  name      = lookup(var.data_connector_office_atp[count.index], "name")
  tenant_id = try(data.azurerm_subscription.this.tenant_id)
}

resource "azurerm_sentinel_data_connector_office_irm" "this" {
  count = length(var.data_connector_office_irm)
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_office_irm[count.index], "workspace_id"))
  )
  name      = lookup(var.data_connector_office_irm[count.index], "name")
  tenant_id = try(data.azurerm_subscription.this.tenant_id)
}

resource "azurerm_sentinel_data_connector_office_power_bi" "this" {
  count = length(var.data_connector_office_power_bi)
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_office_power_bi[count.index], "workspace_id"))
  )
  name      = lookup(var.data_connector_office_power_bi[count.index], "name")
  tenant_id = try(data.azurerm_subscription.this.tenant_id)
}

resource "azurerm_sentinel_data_connector_threat_intelligence_taxii" "this" {
  count         = length(var.data_connector_threat_intelligence_taxii)
  api_root_url  = lookup(var.data_connector_threat_intelligence_taxii[count.index], "api_root_url")
  collection_id = lookup(var.data_connector_threat_intelligence_taxii[count.index], "collection_id")
  display_name  = lookup(var.data_connector_threat_intelligence_taxii[count.index], "display_name")
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_threat_intelligence_taxii[count.index], "workspace_id"))
  )
  name              = lookup(var.data_connector_threat_intelligence_taxii[count.index], "name")
  user_name         = lookup(var.data_connector_threat_intelligence_taxii[count.index], "user_name")
  password          = sensitive(lookup(var.data_connector_threat_intelligence_taxii[count.index], "password"))
  polling_frequency = lookup(var.data_connector_threat_intelligence_taxii[count.index], "polling_frequency")
  lookback_date     = lookup(var.data_connector_threat_intelligence_taxii[count.index], "lookback_date")
  tenant_id         = try(data.azurerm_subscription.this.tenant_id)
}

resource "azurerm_sentinel_metadata" "this" {
  count      = length(var.sentinel_metadata)
  content_id = element(local.content_id, lookup(var.sentinel_metadata[count.index], "alert_id"))
  kind       = lookup(var.sentinel_metadata[count.index], "kind")
  name       = lookup(var.sentinel_metadata[count.index], "name")
  parent_id  = element(local.parent_id, lookup(var.sentinel_metadata[count.index], "alert_id"))
  workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.data_connector_threat_intelligence_taxii[count.index], "workspace_id"))
  )
  content_schema_version     = lookup(var.sentinel_metadata[count.index], "content_schema_version")
  custom_version             = lookup(var.sentinel_metadata[count.index], "custom_version")
  dependency                 = lookup(var.sentinel_metadata[count.index], "dependency")
  first_publish_date         = lookup(var.sentinel_metadata[count.index], "first_publish_date")
  icon_id                    = lookup(var.sentinel_metadata[count.index], "icon_id")
  last_publish_date          = lookup(var.sentinel_metadata[count.index], "last_publish_date")
  preview_images             = lookup(var.sentinel_metadata[count.index], "preview_images")
  preview_images_dark        = lookup(var.sentinel_metadata[count.index], "preview_images_dark")
  providers                  = lookup(var.sentinel_metadata[count.index], "providers")
  threat_analysis_tactics    = lookup(var.sentinel_metadata[count.index], "threat_analysis_tactics")
  threat_analysis_techniques = lookup(var.sentinel_metadata[count.index], "threat_analysis_techniques")

  dynamic "source" {
    for_each = lookup(var.sentinel_metadata[count.index], "source") == null ? [] : ["source"]
    content {
      kind = lookup(source.value, "kind")
      name = lookup(source.value, "name")
      id   = lookup(source.value, "id")
    }
  }

  dynamic "support" {
    for_each = lookup(var.sentinel_metadata[count.index], "support") == null ? [] : ["support"]
    content {
      tier  = lookup(support.value, "tier")
      email = lookup(support.value, "email")
      link  = lookup(support.value, "link")
      name  = lookup(support.value, "name")
    }
  }

  dynamic "author" {
    for_each = lookup(var.sentinel_metadata[count.index], "author") == null ? [] : ["author"]
    content {
      name  = lookup(author.value, "name")
      email = lookup(author.value, "email")
      link  = lookup(author.value, "link")
    }
  }

  dynamic "category" {
    for_each = lookup(var.sentinel_metadata[count.index], "category") == null ? [] : ["category"]
    content {
      domains   = lookup(category.value, "domains")
      verticals = lookup(category.value, "verticals")
    }
  }
}

resource "azurerm_sentinel_threat_intelligence_indicator" "this" {
  count             = length(var.threat_intelligence_indicator)
  display_name      = lookup(var.threat_intelligence_indicator[count.index], "display_name")
  pattern           = lookup(var.threat_intelligence_indicator[count.index], "pattern")
  pattern_type      = lookup(var.threat_intelligence_indicator[count.index], "pattern_type")
  source            = lookup(var.threat_intelligence_indicator[count.index], "source")
  validate_from_utc = lookup(var.threat_intelligence_indicator[count.index], "validate_from_utc")
  workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.threat_intelligence_indicator[count.index], "workspace_id"))
  )
  confidence          = lookup(var.threat_intelligence_indicator[count.index], "confidence")
  created_by          = lookup(var.threat_intelligence_indicator[count.index], "created_by")
  description         = lookup(var.threat_intelligence_indicator[count.index], "description")
  extension           = lookup(var.threat_intelligence_indicator[count.index], "extension")
  tags                = lookup(var.threat_intelligence_indicator[count.index], "tags")
  language            = lookup(var.threat_intelligence_indicator[count.index], "language")
  object_marking_refs = lookup(var.threat_intelligence_indicator[count.index], "object_marking_refs")
  pattern_version     = lookup(var.threat_intelligence_indicator[count.index], "pattern_version")
  revoked             = lookup(var.threat_intelligence_indicator[count.index], "revoked")
  threat_types        = lookup(var.threat_intelligence_indicator[count.index], "threat_types")
  validate_until_utc  = lookup(var.threat_intelligence_indicator[count.index], "validate_until_utc")


  dynamic "external_reference" {
    for_each = lookup(var.threat_intelligence_indicator[count.index], "external_reference") == null ? [] : ["external_reference"]
    content {
      description = lookup(external_reference.value, "description")
      hashes      = lookup(external_reference.value, "hashes")
      source_name = lookup(external_reference.value, "source_name")
      url         = lookup(external_reference.value, "url")
    }
  }

  dynamic "granular_marking" {
    for_each = lookup(var.threat_intelligence_indicator[count.index], "granular_marking") == null ? [] : ["granular_marking"]
    content {
      language    = lookup(granular_marking.value, "language")
      marking_ref = lookup(granular_marking.value, "marking_ref")
      selectors   = lookup(granular_marking.value, "selectors")
    }
  }

  dynamic "kill_chain_phase" {
    for_each = lookup(var.threat_intelligence_indicator[count.index], "kill_chain_phase") == null ? [] : ["kill_chain_phase"]
    content {
      name = lookup(kill_chain_phase.value, "name")
    }
  }
}

resource "azurerm_sentinel_watchlist" "this" {
  count           = length(var.sentinel_watchlist)
  display_name    = lookup(var.sentinel_watchlist[count.index], "display_name")
  item_search_key = lookup(var.sentinel_watchlist[count.index], "item_search_key")
  log_analytics_workspace_id = try(
    data.azurerm_log_analytics_workspace.this.id,
    element(azurerm_log_analytics_workspace.this.*.id, lookup(var.sentinel_watchlist[count.index], "workspace_id"))
  )
  name             = lookup(var.sentinel_watchlist[count.index], "name")
  default_duration = lookup(var.sentinel_watchlist[count.index], "default_duration")
  description      = lookup(var.sentinel_watchlist[count.index], "description")
  labels           = lookup(var.sentinel_watchlist[count.index], "labels")
}

resource "azurerm_sentinel_watchlist_item" "this" {
  count        = length(var.watchlist_items)
  properties   = lookup(var.watchlist_items[count.index], "properties")
  watchlist_id = element(azurerm_sentinel_watchlist.this.*.id, lookup(var.watchlist_items[count.index], "watchlist_id"))
  name         = lookup(var.watchlist_items[count.index], "name")
}