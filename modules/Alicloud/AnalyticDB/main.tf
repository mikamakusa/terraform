resource "alicloud_adb_account" "this" {
  count                  = length(var.account) == "0" ? "0" : length(var.db_cluster)
  db_cluster_id          = try(element(alicloud_adb_db_cluster.this.*.id, lookup(var.account[count.index], "db_cluster_id")))
  account_name           = lookup(var.account[count.index], "account_name")
  account_password       = sensitive(lookup(var.account[count.index], "account_password"))
  kms_encrypted_password = sensitive(lookup(var.account[count.index], "kms_encrypted_password"))
  kms_encryption_context = lookup(var.account[count.index], "kms_encryption_context")
  account_description    = lookup(var.account[count.index], "account_description")
  account_type           = lookup(var.account[count.index], "account_type")
}

resource "alicloud_adb_backup_policy" "this" {
  count                   = length(var.backup_policy) == "0" ? "0" : length(var.db_cluster)
  db_cluster_id           = try(element(alicloud_adb_db_cluster.this.*.id, lookup(var.backup_policy[count.index], "db_cluster_id")))
  preferred_backup_period = lookup(var.backup_policy[count.index], "preferred_backup_period")
  preferred_backup_time   = lookup(var.backup_policy[count.index], "preferred_backup_time")
}

resource "alicloud_adb_cluster" "this" {
  count               = length(var.cluster)
  mode                = lookup(var.cluster[count.index], "mode")
  db_cluster_version  = lookup(var.cluster[count.index], "db_cluster_version")
  db_cluster_category = lookup(var.cluster[count.index], "db_cluster_category")
  db_node_class       = lookup(var.cluster[count.index], "db_node_class")
  db_node_count       = lookup(var.cluster[count.index], "db_node_count")
  db_node_storage     = lookup(var.cluster[count.index], "db_node_storage")
  zone_id             = data.alicloud_zones.this.id
  payment_type        = lookup(var.cluster[count.index], "payment_type")
  renewal_status      = lookup(var.cluster[count.index], "renewal_status")
  auto_renew_period   = lookup(var.cluster[count.index], "auto_renew_period")
  period              = lookup(var.cluster[count.index], "period")
  security_ips        = lookup(var.cluster[count.index], "security_ips")
  vswitch_id          = data.alicloud_vswitches.this.id
  maintain_time       = lookup(var.cluster[count.index], "maintain_time")
  description         = lookup(var.cluster[count.index], "description")
  tags                = merge(var.tags, lookup(var.cluster[count.index], "tags"))
}

resource "alicloud_adb_connection" "this" {
  count             = length(var.connection) == "0" ? "0" : length(var.db_cluster)
  db_cluster_id     = try(element(alicloud_adb_db_cluster.this.*.id, lookup(var.connection[count.index], "db_cluster_id")))
  connection_prefix = lookup(var.connection[count.index], "connection_prefix")
}

resource "alicloud_adb_db_cluster" "this" {
  count                    = length(var.db_cluster)
  db_cluster_category      = lookup(var.db_cluster[count.index], "db_cluster_category")
  mode                     = lookup(var.db_cluster[count.index], "mode")
  auto_renew_period        = lookup(var.db_cluster[count.index], "auto_renew_period")
  compute_resource         = lookup(var.db_cluster[count.index], "compute_resource")
  db_cluster_version       = lookup(var.db_cluster[count.index], "db_cluster_version")
  db_node_class            = lookup(var.db_cluster[count.index], "db_node_class")
  db_node_count            = lookup(var.db_cluster[count.index], "db_node_count")
  db_node_storage          = lookup(var.db_cluster[count.index], "db_node_storage")
  description              = lookup(var.db_cluster[count.index], "description")
  elastic_io_resource      = lookup(var.db_cluster[count.index], "elastic_io_resource")
  elastic_io_resource_size = lookup(var.db_cluster[count.index], "elastic_io_resource_size")
  maintain_time            = lookup(var.db_cluster[count.index], "maintain_time")
  modify_type              = lookup(var.db_cluster[count.index], "modify_type")
  payment_type             = lookup(var.db_cluster[count.index], "payment_type")
  period                   = lookup(var.db_cluster[count.index], "period")
  renewal_status           = lookup(var.db_cluster[count.index], "renewal_status")
  security_ips             = lookup(var.db_cluster[count.index], "security_ips")
  tags                     = merge(var.tags, lookup(var.db_cluster[count.index], "tags"))
  vpc_id                   = data.alicloud_vpcs.this.id
  vswitch_id               = data.alicloud_vswitches.this.id
  zone_id                  = data.alicloud_zones.this.id
}

resource "alicloud_adb_db_cluster_lake_version" "this" {
  count                         = length(var.db_cluster_lake_version)
  compute_resource              = lookup(var.db_cluster_lake_version[count.index], "compute_resource")
  db_cluster_version            = lookup(var.db_cluster_lake_version[count.index], "db_cluster_version")
  enable_default_resource_group = lookup(var.db_cluster_lake_version[count.index], "enable_default_resource_group")
  payment_type                  = lookup(var.db_cluster_lake_version[count.index], "payment_type")
  storage_resource              = lookup(var.db_cluster_lake_version[count.index], "storage_resource")
  vpc_id                        = data.alicloud_vpcs.this.id
  vswitch_id                    = data.alicloud_vswitches.this.id
  zone_id                       = data.alicloud_zones.this.id
  restore_to_time               = lookup(var.db_cluster_lake_version[count.index], "restore_to_time")
  security_ips                  = lookup(var.db_cluster_lake_version[count.index], "security_ips")
  db_cluster_description        = lookup(var.db_cluster_lake_version[count.index], "db_cluster_description")
}

resource "alicloud_adb_lake_account" "this" {
  count               = length(var.lake_account) == "0" ? "0" : length(var.db_cluster_lake_version)
  account_name        = lookup(var.lake_account[count.index], "account_name")
  account_password    = sensitive(lookup(var.lake_account[count.index], "account_password"))
  db_cluster_id       = try(element(alicloud_adb_db_cluster_lake_version.this.*.id, lookup(var.lake_account[count.index], "db_cluster_id")))
  account_description = lookup(var.lake_account[count.index], "account_description")
  account_type        = lookup(var.lake_account[count.index], "account_type")

  dynamic "account_privileges" {
    for_each = lookup(var.lake_account[count.index], "account_privileges") == null ? [] : ["account_privileges"]
    content {
      privilege_type = lookup(account_privileges.value, "privilege_type")
      privileges     = lookup(account_privileges.value, "privileges")

      dynamic "privilege_object" {
        for_each = lookup(account_privileges.value, "privilege_object") == null ? [] : ["privilege_object"]
        content {
          column   = lookup(privilege_object.value, "column")
          database = lookup(privilege_object.value, "database")
          table    = lookup(privilege_object.value, "table")
        }
      }
    }
  }
}

resource "alicloud_adb_resource_group" "this" {
  count         = length(var.resource_group) == "0" ? "0" : length(var.db_cluster)
  db_cluster_id = try(element(alicloud_adb_db_cluster.this.*.id, lookup(var.resource_group[count.index], "db_cluster_id")))
  group_name    = lookup(var.resource_group[count.index], "group_name")
  group_type    = lookup(var.resource_group[count.index], "group_type")
  node_num      = lookup(var.resource_group[count.index], "node_num")
}

resource "alicloud_gpdb_account" "this" {
  count               = length(var.gpdb_account) == "0" ? "0" : length(var.gpdb_instance)
  account_name        = lookup(var.gpdb_account[count.index], "account_name")
  account_password    = sensitive(lookup(var.gpdb_account[count.index], "account_password"))
  db_instance_id      = try(element(alicloud_gpdb_instance.this.*.id, lookup(var.gpdb_account[count.index], "db_instance_id")))
  account_description = lookup(var.gpdb_account[count.index], "account_description")
}

resource "alicloud_gpdb_backup_policy" "this" {
  count                   = length(var.gpdb_backup_policy) == "0" ? "0" : length(var.gpdb_instance)
  preferred_backup_period = lookup(var.gpdb_backup_policy[count.index], "preferred_backup_period")
  preferred_backup_time   = lookup(var.gpdb_backup_policy[count.index], "preferred_backup_time")
  db_instance_id          = try(element(alicloud_gpdb_instance.this.*.id, lookup(var.gpdb_backup_policy[count.index], "db_instance_id")))
  backup_retention_period = lookup(var.gpdb_backup_policy[count.index], "backup_retention_period")
  enable_recovery_point   = lookup(var.gpdb_backup_policy[count.index], "enable_recovery_point")
  recovery_point_period   = lookup(var.gpdb_backup_policy[count.index], "recovery_point_period")
}

resource "alicloud_gpdb_connection" "this" {
  count             = length(var.gpdb_connection) == "0" ? "0" : length(var.gpdb_instance)
  instance_id       = try(element(alicloud_gpdb_instance.this.*.id, ))
  connection_prefix = lookup(var.gpdb_connection[count.index], "connection_prefix")
  port              = lookup(var.gpdb_connection[count.index], "port")
}

resource "alicloud_gpdb_db_instance_plan" "this" {
  count                 = length(var.gpdb_db_instance_plan) == "0" ? "0" : length(var.gpdb_instance)
  plan_schedule_type    = lookup(var.gpdb_db_instance_plan[count.index], "plan_schedule_type")
  plan_type             = lookup(var.gpdb_db_instance_plan[count.index], "plan_type")
  db_instance_plan_name = lookup(var.gpdb_db_instance_plan[count.index], "db_instance_plan_name")
  db_instance_id        = try(element(alicloud_gpdb_instance.this.*.id, lookup(var.gpdb_db_instance_plan[count.index], "db_instance_id")))
  plan_desc             = lookup(var.gpdb_db_instance_plan[count.index], "plan_desc")
  plan_end_date         = lookup(var.gpdb_db_instance_plan[count.index], "plan_end_date")
  plan_start_date       = lookup(var.gpdb_db_instance_plan[count.index], "plan_start_date")
  status                = lookup(var.gpdb_db_instance_plan[count.index], "status")

  dynamic "plan_config" {
    for_each = lookup(var.gpdb_db_instance_plan[count.index], "plan_config")
    content {
      dynamic "pause" {
        for_each = lookup(plan_config.value, "pause") == null ? [] : ["pause"]
        content {
          execute_time   = lookup(pause.value, "execute_time")
          plan_cron_time = lookup(pause.value, "plan_cron_time")
        }
      }

      dynamic "resume" {
        for_each = lookup(plan_config.value, "resume") == null ? [] : ["resume"]
        content {
          execute_time   = lookup(resume.value, "execute_time")
          plan_cron_time = lookup(resume.value, "plan_cron_time")
        }
      }

      dynamic "scale_in" {
        for_each = lookup(plan_config.value, "scale_in") == null ? [] : ["scale_in"]
        content {
          execute_time     = lookup(scale_in.value, "execute_time")
          plan_cron_time   = lookup(scale_in.value, "plan_cron_time")
          segment_node_num = lookup(scale_in.value, "segment_node_num")
        }
      }

      dynamic "scale_out" {
        for_each = lookup(plan_config.value, "scale_out") == null ? [] : ["scale_out"]
        content {
          execute_time     = lookup(scale_out.value, "execute_time")
          plan_cron_time   = lookup(scale_out.value, "plan_cron_time")
          segment_node_num = lookup(scale_out.value, "segment_node_num")
        }
      }
    }
  }
}

resource "alicloud_gpdb_elastic_instance" "this" {
  count                   = length(var.gpdb_elastic_instance)
  seg_node_num            = lookup(var.gpdb_elastic_instance[count.index], "seg_node_num")
  seg_storage_type        = lookup(var.gpdb_elastic_instance[count.index], "seg_storage_type")
  storage_size            = lookup(var.gpdb_elastic_instance[count.index], "storage_size")
  instance_spec           = lookup(var.gpdb_elastic_instance[count.index], "instance_spec")
  engine                  = lookup(var.gpdb_elastic_instance[count.index], "engine")
  engine_version          = lookup(var.gpdb_elastic_instance[count.index], "engine_version")
  vswitch_id              = data.alicloud_vswitches.this.id
  db_instance_category    = lookup(var.gpdb_elastic_instance[count.index], "db_instance_category")
  db_instance_description = lookup(var.gpdb_elastic_instance[count.index], "db_instance_description")
  encryption_key          = sensitive(lookup(var.gpdb_elastic_instance[count.index], "encryption_key"))
  encryption_type         = lookup(var.gpdb_elastic_instance[count.index], "encryption_type")
  instance_network_type   = lookup(var.gpdb_elastic_instance[count.index], "instance_network_type")
  payment_duration        = lookup(var.gpdb_elastic_instance[count.index], "payment_duration")
  payment_duration_unit   = lookup(var.gpdb_elastic_instance[count.index], "payment_duration_unit")
  payment_type            = lookup(var.gpdb_elastic_instance[count.index], "payment_type")
  security_ip_list        = lookup(var.gpdb_elastic_instance[count.index], "security_ip_list")
  tags                    = merge(var.tags, lookup(var.gpdb_elastic_instance[count.index], "tags"))
  zone_id                 = data.alicloud_zones.this.id
}

resource "alicloud_gpdb_instance" "this" {
  count                       = length(var.gpdb_instance)
  db_instance_mode            = lookup(var.gpdb_instance[count.index], "db_instance_mode")
  engine_version              = lookup(var.gpdb_instance[count.index], "engine_version")
  engine                      = lookup(var.gpdb_instance[count.index], "engine")
  vswitch_id                  = data.alicloud_vswitches.this.id
  create_sample_data          = lookup(var.gpdb_instance[count.index], "create_sample_data")
  db_instance_category        = lookup(var.gpdb_instance[count.index], "db_instance_category")
  db_instance_class           = lookup(var.gpdb_instance[count.index], "db_instance_class")
  encryption_key              = sensitive(lookup(var.gpdb_instance[count.index], "encryption_key"))
  encryption_type             = lookup(var.gpdb_instance[count.index], "encryption_type")
  instance_group_count        = lookup(var.gpdb_instance[count.index], "instance_group_count")
  instance_network_type       = lookup(var.gpdb_instance[count.index], "instance_network_type")
  instance_spec               = lookup(var.gpdb_instance[count.index], "instance_spec")
  maintain_end_time           = lookup(var.gpdb_instance[count.index], "maintain_end_time")
  maintain_start_time         = lookup(var.gpdb_instance[count.index], "maintain_start_time")
  master_cu                   = lookup(var.gpdb_instance[count.index], "master_cu")
  payment_type                = lookup(var.gpdb_instance[count.index], "payment_type")
  period                      = lookup(var.gpdb_instance[count.index], "period")
  seg_node_num                = lookup(var.gpdb_instance[count.index], "seg_node_num")
  seg_storage_type            = lookup(var.gpdb_instance[count.index], "seg_storage_type")
  ssl_enabled                 = lookup(var.gpdb_instance[count.index], "ssl_enabled")
  storage_size                = lookup(var.gpdb_instance[count.index], "storage_size")
  tags                        = merge(var.tags, lookup(var.gpdb_instance[count.index], "tags"))
  used_time                   = lookup(var.gpdb_instance[count.index], "used_time")
  vector_configuration_status = lookup(var.gpdb_instance[count.index], "vector_configuration_status")
  vpc_id                      = data.alicloud_vpcs.this.id
  zone_id                     = data.alicloud_zones.this.id

  dynamic "ip_whitelist" {
    for_each = lookup(var.gpdb_instance[count.index], "ip_whitelist") == null ? [] : ["ip_whitelist"]
    content {
      ip_group_attribute = lookup(ip_whitelist.value, "ip_group_attribute")
      ip_group_name      = lookup(ip_whitelist.value, "ip_group_name")
      security_ip_list   = lookup(ip_whitelist.value, "security_ip_list")
    }
  }
}