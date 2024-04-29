resource "oci_cloud_guard_cloud_guard_configuration" "this" {
  count                 = length(var.cloud_guard_configuration)
  compartment_id        = data.oci_identity_compartment.this.id
  reporting_region      = lookup(var.cloud_guard_configuration[count.index], "reporting_region")
  status                = lookup(var.cloud_guard_configuration[count.index], "status")
  self_manage_resources = lookup(var.cloud_guard_configuration[count.index], "self_manage_resources")
}

resource "oci_cloud_guard_data_mask_rule" "this" {
  count                 = length(var.data_mask_rule)
  compartment_id        = data.oci_identity_compartment.this.id
  data_mask_categories  = lookup(var.data_mask_rule[count.index], "data_mask_categories")
  display_name          = lookup(var.data_mask_rule[count.index], "display_name")
  iam_group_id          = lookup(var.data_mask_rule[count.index], "iam_group_id")
  data_mask_rule_status = lookup(var.data_mask_rule[count.index], "data_mask_rule_status")
  defined_tags          = merge(var.defined_tags, lookup(var.data_mask_rule[count.index], "defined_tags"))
  freeform_tags         = merge(var.freeform_tags, lookup(var.data_mask_rule[count.index], "freeform_tags"))
  description           = lookup(var.data_mask_rule[count.index], "description")
  state                 = lookup(var.data_mask_rule[count.index], "state")

  dynamic "target_selected" {
    for_each = lookup(var.data_mask_rule[count.index], "target_selected") == null ? [] : ["target_selected"]
    content {
      kind   = lookup(target_selected.value, "kind")
      values = lookup(target_selected.value, "kind") == "TARGETIDS" || "TARGETTYPES" ? lookup(target_selected.value, "values") : null
    }
  }
}

resource "oci_cloud_guard_data_source" "this" {
  count                     = length(var.data_source)
  compartment_id            = data.oci_identity_compartment.this.id
  data_source_feed_provider = lookup(var.data_source[count.index], "data_source_feed_provider")
  display_name              = lookup(var.data_source[count.index], "display_name")
  defined_tags              = merge(var.defined_tags, lookup(var.data_source[count.index], "defined_tags"))
  freeform_tags             = merge(var.freeform_tags, lookup(var.data_source[count.index], "freeform_tags"))

  dynamic "data_source_details" {
    for_each = lookup(var.data_source[count.index], "data_source_details") == null ? [] : ["data_source_details"]
    content {
      data_source_feed_provider = lookup(data_source_details.value, "data_source_feed_provider")
      additional_entities_count = lookup(data_source_details.value, "additional_entities_count")
      interval_in_minutes       = lookup(data_source_details.value, "interval_in_minutes")
      logging_query_type        = lookup(data_source_details.value, "logging_query_type")
      operator                  = lookup(data_source_details.value, "operator")
      query                     = lookup(data_source_details.value, "query")
      regions                   = lookup(data_source_details.value, "regions")
      threshold                 = lookup(data_source_details.value, "threshold")

      dynamic "logging_query_details" {
        for_each = lookup(data_source_details.value, "logging_query_details") == null ? [] : ["logging_query_details"]
        content {
          logging_query_type = lookup(logging_query_details.value, "logging_query_type")
          key_entities_count = lookup(logging_query_details.value, "key_entities_count")
        }
      }

      dynamic "query_start_time" {
        for_each = lookup(data_source_details.value, "query_start_time") == null ? [] : ["query_start_time"]
        content {
          start_policy_type = lookup(query_start_time.value, "start_policy_type")
          query_start_time  = lookup(query_start_time.value, "start_policy_type") == "ABSOLUTE_TIME_START_POLICY" ? lookup(query_start_time.value, "query_start_time") : null
        }
      }
    }
  }
}

resource "oci_cloud_guard_detector_recipe" "this" {
  count                     = length(var.detector_recipe)
  compartment_id            = data.oci_identity_compartment.this.id
  display_name              = lookup(var.detector_recipe[count.index], "display_name")
  defined_tags              = merge(var.defined_tags, lookup(var.detector_recipe[count.index], "defined_tags"))
  freeform_tags             = merge(var.freeform_tags, lookup(var.detector_recipe[count.index], "freeform_tags"))
  description               = lookup(var.detector_recipe[count.index], "description")
  detector                  = lookup(var.detector_recipe[count.index], "detector")
  source_detector_recipe_id = lookup(var.detector_recipe[count.index], "source_detector_recipe_id")

  dynamic "detector_rules" {
    for_each = lookup(var.detector_recipe[count.index], "detector_rules") == null ? [] : ["detector_rules"]
    content {
      detector_rule_id = lookup(detector_rules.value, "detector_rule_id")

      dynamic "details" {
        for_each = lookup(detector_rules.value, "details") == null ? [] : ["details"]
        content {
          is_enabled     = lookup(details.value, "is_enabled")
          risk_level     = lookup(details.value, "risk_level")
          condition      = lookup(details.value, "condition")
          data_source_id = lookup(details.value, "data_source_id")
          description    = lookup(details.value, "description")
          labels         = lookup(details.value, "labels")
          recommendation = lookup(details.value, "recommendation")

          dynamic "configurations" {
            for_each = lookup(details.value, "configurations") == null ? [] : ["configurations"]
            content {
              config_key = lookup(configurations.value, "config_key")
              name       = lookup(configurations.value, "name")
              data_type  = lookup(configurations.value, "data_type")
              value      = lookup(configurations.value, "value")

              dynamic "values" {
                for_each = lookup(configurations.value, "values") == null ? [] : ["values"]
                content {
                  list_type         = lookup(values.value, "list_type")
                  managed_list_type = lookup(values.value, "managed_list_type")
                  value             = lookup(values.value, "value")
                }
              }
            }
          }
          dynamic "entities_mappings" {
            for_each = lookup(details.value, "entities_mappings") == null ? [] : ["entities_mappings"]
            content {
              query_field  = lookup(entities_mappings.value, "query_field")
              entity_type  = lookup(entities_mappings.value, "entity_type")
              display_name = lookup(entities_mappings.value, "display_name")
            }
          }
        }
      }
    }
  }
}

resource "oci_cloud_guard_managed_list" "this" {
  count                  = length(var.managed_list)
  compartment_id         = data.oci_identity_compartment.this.id
  display_name           = lookup(var.managed_list[count.index], "display_name")
  defined_tags           = merge(var.defined_tags, lookup(var.managed_list[count.index], "defined_tags"))
  freeform_tags          = merge(var.freeform_tags, lookup(var.managed_list[count.index], "freeform_tags"))
  description            = lookup(var.managed_list[count.index], "description")
  list_items             = lookup(var.managed_list[count.index], "list_items")
  list_type              = lookup(var.managed_list[count.index], "list_type")
  source_managed_list_id = lookup(var.managed_list[count.index], "source_managed_list_id")
}

resource "oci_cloud_guard_responder_recipe" "this" {
  count                      = length(var.responder_recipe)
  compartment_id             = data.oci_identity_compartment.this.id
  display_name               = lookup(var.responder_recipe[count.index], "display_name")
  source_responder_recipe_id = lookup(var.responder_recipe[count.index], "source_responder_recipe_id")
  defined_tags               = merge(var.defined_tags, lookup(var.responder_recipe[count.index], "defined_tags"))
  freeform_tags              = merge(var.freeform_tags, lookup(var.responder_recipe[count.index], "freeform_tags"))
  description                = lookup(var.responder_recipe[count.index], "description")

  dynamic "responder_rules" {
    for_each = lookup(var.responder_recipe[count.index], "responder_rules") == null ? [] : ["responder_rules"]
    content {
      responder_rule_id = lookup(responder_rules.value, "responder_rule_id")
      details {
        is_enabled = true
      }
    }
  }
}

resource "oci_cloud_guard_security_recipe" "this" {
  count             = length(var.security_recipe)
  compartment_id    = data.oci_identity_compartment.this.id
  display_name      = lookup(var.security_recipe[count.index], "display_name")
  security_policies = lookup(var.security_recipe[count.index], "security_policies")
  defined_tags      = merge(var.defined_tags, lookup(var.security_recipe[count.index], "defined_tags"))
  freeform_tags     = merge(var.freeform_tags, lookup(var.security_recipe[count.index], "freeform_tags"))
  description       = lookup(var.security_recipe[count.index], "description")
}

resource "oci_cloud_guard_security_zone" "this" {
  count                   = length(var.security_zone)
  compartment_id          = data.oci_identity_compartment.this.id
  display_name            = lookup(var.security_zone[count.index], "display_name")
  security_zone_recipe_id = lookup(var.security_zone[count.index], "security_zone_recipe_id")
  defined_tags            = merge(var.defined_tags, lookup(var.security_zone[count.index], "defined_tags"))
  freeform_tags           = merge(var.freeform_tags, lookup(var.security_zone[count.index], "freeform_tags"))
  description             = lookup(var.security_zone[count.index], "description")
}

resource "oci_cloud_guard_target" "this" {
  count                = length(var.target)
  compartment_id       = data.oci_identity_compartment.this.id
  display_name         = lookup(var.target[count.index], "display_name")
  target_resource_id   = lookup(var.target[count.index], "target_resource_id")
  target_resource_type = lookup(var.target[count.index], "target_resource_type")
  defined_tags         = merge(var.defined_tags, lookup(var.target[count.index], "defined_tags"))
  freeform_tags        = merge(var.freeform_tags, lookup(var.target[count.index], "freeform_tags"))
  description          = lookup(var.target[count.index], "description")
  state                = lookup(var.target[count.index], "state")

  dynamic "target_detector_recipes" {
    for_each = lookup(var.target[count.index], "target_detector_recipes") == null ? [] : ["target_detector_recipes"]
    content {
      detector_recipe_id = lookup(target_detector_recipes.value, "detector_recipe_id")

      dynamic "detector_rules" {
        for_each = lookup(detector_recipe_id.value, "detector_rules") == null ? [] : ["detector_rules"]
        content {
          detector_rule_id = lookup(detector_rules.value, "detector_rule_id")

          dynamic "details" {
            for_each = lookup(detector_rules.value, "details") == null ? [] : ["detector_rules"]
            content {
              dynamic "condition_groups" {
                for_each = lookup(details.value, "condition_groups") == null ? [] : ["condition_groups"]
                content {
                  compartment_id = lookup(condition_groups.value, "compartment_id")
                  condition      = lookup(condition_groups.value, "condition")
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "target_responder_recipes" {
    for_each = lookup(var.target[count.index], "target_responder_recipes") == null ? [] : ["target_responder_recipes"]
    content {
      responder_recipe_id = lookup(target_responder_recipes.value, "responder_recipe_id")

      dynamic "responder_rules" {
        for_each = lookup(responder_recipe_id.value, "responder_rules") == null ? [] : ["responder_rules"]
        content {
          responder_rule_id = lookup(responder_rules.value, "responder_rule_id")

          dynamic "details" {
            for_each = lookup(responder_rules.value, "details") == null ? [] : ["responder_rules"]
            content {
              condition = lookup(details.value, "condition")
              mode      = lookup(details.value, "mode")

              dynamic "configurations" {
                for_each = lookup(details.value, "configurations") == null ? [] : ["configurations"]
                content {
                  config_key = lookup(configurations.value, "config_key")
                  name       = lookup(configurations.value, "name")
                  value      = lookup(configurations.value, "value")
                }
              }
            }
          }
        }
      }
    }
  }
}