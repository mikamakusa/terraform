resource "ibm_app_config_collection" "this" {
  count         = length(var.collection)
  collection_id = lookup(var.collection[count.index], "collection_id")
  guid          = lookup(var.collection[count.index], "guid")
  name          = lookup(var.collection[count.index], "name")
  description   = lookup(var.collection[count.index], "description")
  tags          = lookup(var.collection[count.index], "tags")
}

resource "ibm_app_config_environment" "this" {
  count          = length(var.environment)
  environment_id = lookup(var.environment[count.index], "environment_id")
  guid           = lookup(var.environment[count.index], "guid")
  name           = lookup(var.environment[count.index], "name")
  description    = lookup(var.environment[count.index], "description")
  tags           = lookup(var.environment[count.index], "tags")
  color_code     = lookup(var.environment[count.index], "color_code")
}

resource "ibm_app_config_feature" "this" {
  count              = length(var.feature) == "0" ? "0" : (length(var.environment) || data.ibm_app_config_environment)
  disabled_value     = lookup(var.feature[count.index], "disabled_value")
  enabled_value      = lookup(var.feature[count.index], "enabled_value")
  environment_id     = try(
    data.ibm_app_config_environment.this.environment_id,
    element(ibm_app_config_environment.this.*.environment_id, lookup(var.feature[count.index], "environment_id"))
  )
  feature_id         = lookup(var.feature[count.index], "feature_id")
  guid               = lookup(var.feature[count.index], "guid")
  name               = lookup(var.feature[count.index], "name")
  type               = lookup(var.feature[count.index], "type")
  description        = lookup(var.feature[count.index], "description")
  tags               = lookup(var.feature[count.index], "tags")
  rollout_percentage = lookup(var.feature[count.index], "rollout_percentage")

  dynamic "segment_rules" {
    for_each = lookup(var.feature[count.index], "segment_rules") == null ? [] : ["segment_rules"]
    content {
      order              = lookup(segment_rules.value, "order")
      value              = lookup(segment_rules.value, "value")
      rollout_percentage = lookup(segment_rules.value, "rollout_percentage")

      dynamic "rules" {
        for_each = lookup(segment_rules.value, "rules") == null ? [] : ["rules"]
        content {
          segments = lookup(rules.value, "segments")
        }
      }
    }
  }

  dynamic "collections" {
    for_each = lookup(var.feature[count.index], "collections")
    content {
      collection_id = try(
        data.ibm_app_config_collection.this.collection_id,
        element(ibm_app_config_collection.this.*.collection_id, lookup(collections.value, "collection_id"))
      )
    }
  }
}

resource "ibm_app_config_property" "this" {
  count          = length(var.property) == "0" ? "0" : (length(var.environment) || data.ibm_app_config_environment)
  environment_id = try(
    data.ibm_app_config_environment.this.environment_id,
    element(ibm_app_config_environment.this.*.environment_id, lookup(var.property[count.index], "environment_id"))
  )
  guid           = lookup(var.property[count.index], "guid")
  name           = lookup(var.property[count.index], "name")
  property_id    = lookup(var.property[count.index], "property_id")
  type           = lookup(var.property[count.index], "type")
  value          = lookup(var.property[count.index], "value")
  description    = lookup(var.property[count.index], "description")
  tags           = lookup(var.property[count.index], "tags")
  format         = lookup(var.property[count.index], "format")

  dynamic "segment_rules" {
    for_each = lookup(var.property[count.index], "segment_rules") == null ? [] : ["segment_rules"]
    content {
      order = lookup(segment_rules.value, "order")
      value = lookup(segment_rules.value, "value")

      dynamic "rules" {
        for_each = lookup(segment_rules.value, "rules")
        content {
          segments = lookup(rules.value, "segments")
        }
      }
    }
  }

  dynamic "collections" {
    for_each = lookup(var.property[count.index], "collections") == null ? [] : ["collections"]
    content {
      collection_id = try(
        data.ibm_app_config_collection.this.collection_id,
        element(ibm_app_config_collection.this.*.collection_id, lookup(collections.value, "collection_id"))
      )
    }
  }
}

resource "ibm_app_config_segment" "this" {
  count       = length(var.segment)
  guid        = lookup(var.segment[count.index], "guid")
  name        = lookup(var.segment[count.index], "name")
  segment_id  = lookup(var.segment[count.index], "segment_id")
  description = lookup(var.segment[count.index], "description")
  tags        = lookup(var.segment[count.index], "tags")

  dynamic "rules" {
    for_each = lookup(var.segment[count.index], "rules") == null ? [] : ["rules"]
    content {
      attribute_name = lookup(rules.value, "attribute_name")
      operator       = lookup(rules.value, "operator")
      values         = lookup(rules.value, "values")
    }
  }
}

resource "ibm_app_config_snapshot" "this" {
  count           = length(var.snapshot) == "0" ? "0" : ((length(var.collection) || data.ibm_app_config_collection) && (length(var.environment) || data.ibm_app_config_environment))
  collection_id   = try(
    data.ibm_app_config_collection.this.collection_id,
    element(ibm_app_config_collection.this.*.collection_id, lookup(var.snapshot, "collection_id"))
  )
  environment_id  = try(
    data.ibm_app_config_environment.this.environment_id,
    element(ibm_app_config_environment.this.*.environment_id, lookup(var.feature[count.index], "environment_id"))
  )
  git_branch      = lookup(var.snapshot[count.index], "git_branch")
  git_config_id   = lookup(var.snapshot[count.index], "git_config_id")
  git_config_name = lookup(var.snapshot[count.index], "git_config_name")
  git_file_path   = lookup(var.snapshot[count.index], "git_file_path")
  git_token       = lookup(var.snapshot[count.index], "git_token")
  git_url         = lookup(var.snapshot[count.index], "git_url")
  guid            = lookup(var.snapshot[count.index], "guid")
}