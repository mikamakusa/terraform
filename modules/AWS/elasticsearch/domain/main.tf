resource "aws_elasticsearch_domain" "elasticsearch" {
  count                 = length(var.elasticsearch)
  domain_name           = lookup(var.elasticsearch[count.index], "domain_name")
  elasticsearch_version = lookup(var.elasticsearch[count.index], "elasticsearch_version")

    vpc_options {
      security_group_ids = [var.elasticsearch_security_group_ids]
      subnet_ids         = [var.elasticsearch_subnet_ids]
    }

  dynamic "cluster_config" {
    for_each = lookup(var.elasticsearch[count.index], "cluster_config")
    content {
      dedicated_master_count   = lookup(cluster_config.value, "dedicated_master_count", null)
      dedicated_master_enabled = lookup(cluster_config.value, "dedicated_master_enabled", null)
      dedicated_master_type    = lookup(cluster_config.value, "dedicated_master_type", null)
      instance_count           = lookup(cluster_config.value, "instance_count", null)
      instance_type            = lookup(cluster_config.value, "instance_type", null)
      zone_awareness_enabled   = lookup(cluster_config.value, "zone_awareness_enabled", null)

      dynamic "zone_awareness_config" {
        for_each = lookup(cluster_config.value, "zone_awareness_config", [])
        content {
          availability_zone_count = lookup(zone_awareness_config.value, "availability_zone_count", null)
        }
      }
    }
  }

  dynamic "ebs_options" {
    for_each = lookup(var.elasticsearch[count.index], "ebs_options")
    content {
      ebs_enabled = lookup(ebs_options.value, "ebs_enabled", true)
      iops        = lookup(ebs_options.value, "iops", null)
      volume_size = lookup(ebs_options.value, "volume_size", null)
      volume_type = lookup(ebs_options.value, "volume_type", null)
    }
  }

  dynamic "encrypt_at_rest" {
    for_each = lookup(var.elasticsearch[count.index], "encrypt_at_rest")
    content {
      enabled    = lookup(encrypt_at_rest.value, "enabled", false)
      kms_key_id = element(var.elasticsearch_kms_key_id, lookup(encrypt_at_rest.value, "kms_key_id"))
    }
  }

  dynamic "log_publishing_options" {
    for_each = lookup(var.elasticsearch[count.index], "log_publishing_options")
    content {
      log_type                 = lookup(log_publishing_options.value, "log_type", null)
      cloudwatch_log_group_arn = element(var.elasticsearch_cloudwatch_log_group_arn, lookup(log_publishing_options.value, "cloudwatch_log_group_id"))
      enabled                  = lookup(log_publishing_options.value, "enabled", true)
    }
  }

  dynamic "snapshot_options" {
    for_each = lookup(var.elasticsearch[count.index], "snapshot_options")
    content {
      automated_snapshot_start_hour = lookup(snapshot_options.value, "automated_snapshot_start_hour", null)
    }
  }
}