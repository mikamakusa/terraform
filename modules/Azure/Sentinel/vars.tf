variable "resource_group_name" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "logic_app_standard_name" {
  type    = string
  default = null
}

variable "logic_app_workflow_name" {
  type    = string
  default = null
}

variable "subscription_id" {
  type    = string
  default = null
}

variable "resource_group" {
  type = list(map(object({
    id       = number
    location = string
    name     = string
    tags     = optional(map(string))
  })))
  default = []
}

variable "log_analytics_workspace" {
  type = list(map(object({
    id                                 = number
    name                               = string
    resource_group_id                  = number
    allow_resource_only_permissions    = optional(bool, false)
    local_authentication_disabled      = optional(bool, false)
    sku                                = optional(string)
    retention_in_days                  = optional(number)
    daily_quota_gb                     = optional(number)
    cmk_for_query_forced               = optional(bool, false)
    internet_ingestion_enabled         = optional(bool, false)
    internet_query_enabled             = optional(bool, false)
    reservation_capacity_in_gb_per_day = optional(number)
    tags                               = optional(map(string))
  })))
  default = []
}

variable "log_analytics_solution" {
  type = list(map(object({
    id                = number
    resource_group_id = number
    solution_name     = string
    workspace_id      = number
    tags              = optional(map(string))
    plan = optional(list(object({
      product        = string
      publisher      = string
      promotion_code = optional(string)
    })), [])
  })))
  default = []
}

variable "sentinel_onboarding" {
  type = list(map(object({
    id                           = number
    resource_group_id            = number
    workspace_id                 = number
    customer_managed_key_enabled = optional(bool, false)
  })))
  default = []
}

variable "machine_learning_behavior_analytics" {
  type = list(map(object({
    id                       = number
    alert_rule_template_guid = string
    workspace_id             = number
    name                     = string
    enabled                  = optional(bool, false)
  })))
  default = []
}

variable "alert_rule_anomaly" {
  type = list(map(object({
    id           = number
    enabled      = bool
    workspace_id = number
    mode         = string
    name         = optional(string)
    display_name = optional(string)
  })))
  default = []
}

variable "alert_rule_anomaly_duplicate" {
  type = list(map(object({
    id               = number
    built_in_rule_id = number
    display_name     = string
    enabled          = bool
    workspace_id     = number
    mode             = string
    multi_select_observation = optional(list(object({
      name   = string
      values = list(string)
    })), [])
    prioritized_exclude_observation = optional(list(object({
      name       = string
      exclude    = optional(string)
      prioritize = optional(string)
    })), [])
    single_select_observation = optional(list(object({
      name  = string
      value = string
    })), [])
    threshold_observation = optional(list(object({
      name  = string
      value = string
    })), [])
  })))
  default = []
}

variable "alert_rule_fusion" {
  type = list(map(object({
    id           = number
    workspace_id = number
    name         = string
    enabled      = optional(bool, false)
    source = optional(list(object({
      name    = string
      enabled = optional(bool, false)
      sub_type = optional(list(object({
        name               = string
        severities_allowed = list(string)
        enabled            = optional(bool, false)
      })), [])
    })), [])
  })))
  default = []
}

variable "ms_security_incident" {
  type = list(map(object({
    id                          = number
    display_name                = string
    workspace_id                = string
    name                        = string
    product_filter              = string
    severity_filter             = list(string)
    description                 = optional(string)
    enabled                     = optional(bool, false)
    display_name_filter         = optional(list(string))
    display_name_exclude_filter = optional(list(string))
  })))
  default = []
}

variable "alert_rule_nrt" {
  type = list(map(object({
    id                          = number
    display_name                = string
    workspace_id                = number
    name                        = string
    query                       = string
    severity                    = string
    alert_rule_template_version = optional(string)
    custom_details              = optional(map(string))
    description                 = optional(string)
    enabled                     = optional(bool, false)
    suppression_duration        = optional(string)
    suppression_enabled         = optional(bool, false)
    tactics                     = optional(list(string))
    techniques                  = optional(list(string))
    alert_details_override = optional(list(object({
      description_format   = optional(string)
      display_name_format  = optional(string)
      severity_column_name = optional(string)
      tactics_column_name  = optional(string)
      dynamic_property = optional(list(object({
        name  = string
        value = string
      })), [])
    })), [])
    entity_mapping = optional(list(object({
      entity_type = string
      field_mapping = optional(list(object({
        column_name = string
        identifier  = string
      })), [])
    })), [])
    event_grouping = optional(list(object({
      aggregation_method = string
    })), [])
    incident = optional(list(object({
      create_incident_enabled = bool
      grouping = optional(list(object({
        enabled                 = optional(bool, false)
        lookback_duration       = optional(string)
        reopen_closed_incidents = optional(bool, false)
        entity_matching_method  = optional(string)
        by_entities             = optional(set(string))
        by_alert_details        = optional(set(string))
        by_custom_details       = optional(set(string))
      })), [])
    })), [])
    sentinel_entity_mapping = optional(list(object({
      column_name = string
    })), [])
  })))
  default = []
}

variable "alert_rule_scheduled" {
  type = list(map(object({
    id                          = number
    display_name                = string
    workspace_id                = number
    name                        = string
    query                       = string
    severity                    = string
    alert_rule_template_version = optional(string)
    custom_details              = optional(map(string))
    description                 = optional(string)
    enabled                     = optional(bool, false)
    suppression_duration        = optional(string)
    suppression_enabled         = optional(bool, false)
    tactics                     = optional(list(string))
    techniques                  = optional(list(string))
    alert_details_override = optional(list(object({
      description_format   = optional(string)
      display_name_format  = optional(string)
      severity_column_name = optional(string)
      tactics_column_name  = optional(string)
      dynamic_property = optional(list(object({
        name  = string
        value = string
      })), [])
    })), [])
    entity_mapping = optional(list(object({
      entity_type = string
      field_mapping = optional(list(object({
        column_name = string
        identifier  = string
      })), [])
    })), [])
    event_grouping = optional(list(object({
      aggregation_method = string
    })), [])
    incident = optional(list(object({
      create_incident_enabled = bool
      grouping = optional(list(object({
        enabled                 = optional(bool, false)
        lookback_duration       = optional(string)
        reopen_closed_incidents = optional(bool, false)
        entity_matching_method  = optional(string)
        by_entities             = optional(set(string))
        by_alert_details        = optional(set(string))
        by_custom_details       = optional(set(string))
      })), [])
    })), [])
    sentinel_entity_mapping = optional(list(object({
      column_name = string
    })), [])
  })))
  default = []
}

variable "alert_rule_threat_intelligence" {
  type = list(map(object({
    id           = number
    workspace_id = number
    name         = string
    enabled      = optional(bool, false)
  })))
  default = []
}

variable "automation_rule" {
  type = list(map(object({
    id             = number
    display_name   = string
    workspace_id   = number
    name           = string
    order          = number
    condition_json = optional(string)
    enabled        = optional(bool, false)
    expiration     = optional(string)
    triggers_on    = optional(string)
    triggers_when  = optional(string)
    action_incident = optional(list(object({
      order                  = number
      status                 = optional(string)
      classification         = optional(string)
      classification_comment = optional(string)
      labels                 = optional(list(string))
      owner_id               = optional(string)
      severity               = optional(string)
    })), [])
    action_playbook = optional(list(object({
      logic_app_id = string
      order        = number
      tenant_id    = optional(string)
    })), [])
  })))
  default = []
}

variable "data_connector_cloud_trail" {
  type = list(map(object({
    id           = number
    aws_role_arn = string
    workspace_id = number
    name         = string
  })))
  default = []
}

variable "data_connector_s3" {
  type = list(map(object({
    id                = number
    aws_role_arn      = string
    destination_table = string
    workspace_id      = number
    name              = string
    sqs_urls          = list(string)
  })))
  default = []
}

variable "data_connect_aad" {
  type = list(map(object({
    id           = number
    workspace_id = number
    name         = string
  })))
  default = []
}

variable "data_connector_azure_security_center" {
  type = list(map(object({
    id           = number
    workspace_id = number
    name         = string
  })))
  default = []
}

variable "data_connector_iot" {
  type = list(map(object({
    id           = number
    workspace_id = number
    name         = string
  })))
  default = []
}

variable "data_connector_cloud_app_security" {
  type = list(map(object({
    id                     = number
    workspace_id           = number
    name                   = string
    alerts_enabled         = optional(bool, false)
    discovery_logs_enabled = optional(bool, false)
  })))
  default = []
}

variable "data_connector_dynamics_365" {
  type = list(map(object({
    id           = number
    workspace_id = number
    name         = string
  })))
  default = []
}

variable "data_connector_defender_advanced_threat_protection" {
  type = list(map(object({
    id           = number
    workspace_id = number
    name         = string
  })))
  default = []
}

variable "data_connector_azure_advanced_threat_protection" {
  type = list(map(object({
    id           = number
    workspace_id = number
    name         = string
  })))
  default = []
}

variable "data_connector_azure_advanced_threat_intelligence" {
  type = list(map(object({
    id                                           = number
    workspace_id                                 = number
    name                                         = string
    microsoft_emerging_threat_feed_lookback_date = optional(string)
  })))
  default = []
}

variable "data_connector_microsoft_threat_protection" {
  type = list(map(object({
    id           = number
    workspace_id = number
    name         = string
  })))
  default = []
}

variable "data_connector_office_365" {
  type = list(map(object({
    id                 = number
    workspace_id       = number
    name               = string
    teams_enabled      = optional(bool, false)
    sharepoint_enabled = optional(bool, false)
    exchange_enabled   = optional(bool, false)
  })))
  default = []
}

variable "data_connector_office_365_project" {
  type = list(map(object({
    id           = number
    workspace_id = number
    name         = string
  })))
  default = []
}

variable "data_connector_office_atp" {
  type = list(map(object({
    id           = number
    workspace_id = number
    name         = string
  })))
  default = []
}

variable "data_connector_office_irm" {
  type = list(map(object({
    id           = number
    workspace_id = number
    name         = string
  })))
  default = []
}

variable "data_connector_office_power_bi" {
  type = list(map(object({
    id           = number
    workspace_id = number
    name         = string
  })))
  default = []
}

variable "data_connector_threat_intelligence_taxii" {
  type = list(map(object({
    id                = number
    workspace_id      = number
    name              = string
    api_root_url      = string
    collection_id     = string
    display_name      = string
    user_name         = optional(string)
    password          = optional(string)
    polling_frequency = optional(string)
    lookback_date     = optional(string)
  })))
  default = []
}

variable "sentinel_metadata" {
  type = list(map(object({
    id                         = number
    alert_id                   = number
    kind                       = string
    name                       = string
    workspace_id               = number
    content_schema_version     = optional(string)
    custom_version             = optional(string)
    dependency                 = optional(string)
    first_publish_date         = optional(string)
    icon_id                    = optional(string)
    last_publish_date          = optional(string)
    preview_images             = optional(list(string))
    preview_images_dark        = optional(list(string))
    providers                  = optional(list(string))
    threat_analysis_tactics    = optional(list(string))
    threat_analysis_techniques = optional(list(string))
    source = optional(list(object({
      kind = string
      name = optional(string)
      id   = optional(string)
    })), [])
    support = optional(list(object({
      tier  = string
      email = optional(string)
      link  = optional(string)
      name  = optional(string)
    })), [])
    author = optional(list(object({
      name  = optional(string)
      email = optional(string)
      link  = optional(string)
    })), [])
    category = optional(list(object({
      domains   = optional(list(string))
      verticals = optional(list(string))
    })), [])
  })))
  default = []
}

variable "threat_intelligence_indicator" {
  type = list(map(object({
    id                  = number
    display_name        = string
    pattern             = string
    pattern_type        = string
    source              = string
    validate_from_utc   = string
    workspace_id        = number
    confidence          = optional(number)
    created_by          = optional(string)
    description         = optional(string)
    extension           = optional(string)
    tags                = optional(list(string))
    language            = optional(string)
    object_marking_refs = optional(list(string))
    pattern_version     = optional(string)
    revoked             = optional(bool, false)
    threat_types        = optional(list(string))
    validate_until_utc  = optional(string)
    external_reference = optional(list(object({
      description = optional(string)
      hashes      = optional(map(string))
      source_name = optional(string)
      url         = optional(string)
    })), [])
    granular_marking = optional(list(object({
      language    = optional(string)
      marking_ref = optional(string)
      selectors   = optional(list(string))
    })), [])
    kill_chain_phase = optional(list(object({
      name = optional(string)
    })), [])
  })))
  default = []
}

variable "sentinel_watchlist" {
  type = list(map(object({
    id               = number
    display_name     = string
    item_search_key  = string
    workspace_id     = number
    name             = string
    default_duration = optional(string)
    description      = optional(string)
    labels           = optional(list(string))
  })))
  default = []
}

variable "watchlist_items" {
  type = list(map(object({
    id           = number
    properties   = map(string)
    watchlist_id = number
    name         = optional(string)
  })))
  default = []
}