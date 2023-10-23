resource "alicloud_ram_role" "this" {
  count                = length(var.ram_roles)
  name                 = lookup(var.ram_roles[count.index], "name")
  services             = lookup(var.ram_roles[count.index], "services")
  ram_users            = lookup(var.ram_roles[count.index], "ram_users")
  version              = lookup(var.ram_roles[count.index], "version")
  document             = lookup(var.ram_roles[count.index], "document")
  description          = lookup(var.ram_roles[count.index], "description")
  force                = lookup(var.ram_roles[count.index], "force")
  max_session_duration = lookup(var.ram_roles[count.index], "max_session_duration")
}

resource "alicloud_ram_policy" "this" {
  count       = length(var.ram_policy)
  policy_name = lookup(var.ram_policy[count.index], "policy_name")
  dynamic "statement" {
    for_each = lookup(var.ram_policy[count.index], "statement") == null ? [] : ["statement"]
    content {
      resource = lookup(statement.value, "resource")
      action   = lookup(statement.value, "action")
      effect   = lookup(statement.value, "effect")
    }
  }
  version         = lookup(var.ram_policy[count.index], "version")
  description     = lookup(var.ram_policy[count.index], "description")
  rotate_strategy = lookup(var.ram_policy[count.index], "rotate_strategy")
  force           = lookup(var.ram_policy[count.index], "force")
}

resource "alicloud_ram_role_policy_attachment" "this" {
  count       = length(var.role_policy_attachement)
  policy_name = element(alicloud_ram_policy.this.*.name, lookup(var.role_policy_attachement[count.index], "policy_id"))
  policy_type = element(alicloud_ram_policy.this.*.type, lookup(var.role_policy_attachement[count.index], "policy_id"))
  role_name   = element(alicloud_ram_role.this.*.name, lookup(var.role_policy_attachement[count.index], "role_id"))
}

resource "alicloud_oss_bucket" "this" {
  count            = length(var.oss_bucket)
  bucket           = lookup(var.oss_bucket[count.index], "bucket")
  logging_isenable = true
  acl              = "private"
  tags = merge(
    var.tags,
    lookup(var.buckets[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
  logging {
    target_bucket = join("-", [lookup(var.oss_bucket[count.index], "bucket"), "logging"])
  }
  versioning {
    status = "Enabled"
  }
}

resource "alicloud_mns_topic" "this" {
  count                = length(var.mns_topics)
  name                 = lookup(var.mns_topics[count.index], "name")
  maximum_message_size = lookup(var.mns_topics[count.index], "maximum_message_size")
  logging_enabled      = lookup(var.mns_topics[count.index], "logging_enabled")
}

resource "alicloud_log_project" "this" {
  count       = length(var.log_projects)
  name        = lookup(var.log_projects[count.index], "name")
  description = lookup(var.log_projects[count.index], "description")
  tags = merge(
    var.tags,
    lookup(var.log_projects[count.index], "tags"),
    {
      deploy = "terraform"
    }
  )
}

resource "alicloud_actiontrail" "this" {
  count              = length(var.actiontrail)
  name               = lookup(var.actiontrail[count.index], "name")
  event_rw           = lookup(var.actiontrail[count.index], "event_rw")
  oss_bucket_name    = var.buckets != null ? data.alicloud_oss_buckets.this.buckets : element(alicloud_oss_bucket.this.*.bucket, lookup(var.actiontrail[count.index], "oss_bucket_id"))
  role_name          = var.roles != null ? data.alicloud_ram_roles.this.names : element(alicloud_ram_role.this.*.name, lookup(var.actiontrail[count.index], "role_id"))
  oss_key_prefix     = lookup(var.actiontrail[count.index], "oss_key_prefix")
  sls_project_arn    = lookup(var.actiontrail[count.index], "sls_project_arn")
  sls_write_role_arn = lookup(var.actiontrail[count.index], "sls_write_role_arn")
}

resource "alicloud_actiontrail_global_events_storage_region" "this" {
  count          = var.storage_region ? 1 : 0
  storage_region = var.storage_region
}

resource "alicloud_actiontrail_history_delivery_job" "this" {
  count      = length(var.delivery_job)
  trail_name = element(alicloud_actiontrail.this.*.name, lookup(var.delivery_job[count.index], "trail_id"))
}

resource "alicloud_actiontrail_trail" "this" {
  count                 = length(var.trail)
  trail_name            = lookup(var.trail[count.index], "trail_name")
  event_rw              = lookup(var.trail[count.index], "event_rw")
  oss_bucket_name       = element(alicloud_oss_bucket.this.*.bucket, lookup(var.trail[count.index], "bucket_id"))
  oss_key_prefix        = lookup(var.trail[count.index], "oss_key_prefix")
  role_name             = element(alicloud_ram_role.this.*.name, lookup(var.trail[count.index], "role_id"))
  sls_project_arn       = join(":", ["acs:log", data.alicloud_regions.this.regions.0.id, data.alicloud_account.this.id, join("/", ["project", var.log_project != null ? data.alicloud_log_projects.this.names.0.name : element(alicloud_log_project.this.*.name, lookup(var.trail[count.index], "sls_project_id"))])])
  sls_write_role_arn    = var.log_project ? data.alicloud_ram_roles.sls_role.roles.0.arn : element(alicloud_ram_role.this.*.arn, lookup(var.trail[count.index], "role_id"))
  mns_topic_arn         = var.topics ? data.alicloud_mns_topics.this.topics.0.arn : element(alicloud_mns_topic.this.*.name, lookup(var.trail[count.index], "mns_topic_id"))
  status                = lookup(var.trail[count.index], "status")
  is_organization_trail = lookup(var.trail[count.index], "is_organization_trail")
}