resource "google_compute_instance_group_manager" "group_manager" {
  count = length(var.group_manager)
  base_instance_name = lookup(var.group_manager[count.index], "base_instance_name")
  name = lookup(var.group_manager[count.index], "name")
  zone = var.zone
  project = var.project
  provider = "google-beta"

  description = lookup(var.group_manager[count.index], "description", null)
  target_size = lookup(var.group_manager[count.index], "target_size", null)
  target_pools = [element(var.target_pool_ids, lookup(var.group_manager[count.index], "target_pools_ids"))]
  wait_for_instances = lookup(var.group_manager[count.index], "wait_for_instances", false)

  dynamic "auto_healing_policies" {
    for_each = lookup(var.group_manager[count.index], "auto_healing_policies")
    content {
      health_check = lookup(auto_healing_policies.value, "healt_check")
      initial_delay_sec = lookup(auto_healing_policies.value, "initial_delay_sec")
    }
  }

  dynamic "stateful_disk" {
    for_each = lookup(var.group_manager[count.index], "stateful_disk")
    content {
      device_name = lookup(stateful_disk.value, "device_name")
      delete_rule = lookup(stateful_disk.value, "delete_rule")
    }
  }

  dynamic "update_policy" {
    for_each = lookup(var.group_manager[count.index], "update_policy")
    content {
      minimal_action = lookup(update_policy.value, "minimal_action")
      type = lookup(update_policy.value, "type")
      max_surge_percent = lookup(update_policy.value, "max_surge_percent")
      max_surge_fixed = lookup(update_policy.value, "max_surge_fixed")
      max_unavailable_fixed = lookup(update_policy.value, "max_unavailable_fixed")
      max_unavailable_percent = lookup(update_policy.value, "max_unavailable_percent")
      min_ready_sec = lookup(update_policy.value, "min_ready_sec")
    }
  }

  dynamic "named_port" {
    for_each = lookup(var.group_manager[count.index], "named_port")
    content {
      name = lookup(named_port.value, "name")
      port = lookup(named_port.value, "port")
    }
  }

  dynamic "version" {
    for_each = lookup(var.group_manager[count.index], "version") == null ? [] : [for i in lookup(var.group_manager[count.index], "version") : {
      instance_template = i.instance_template
      name = i.name
      target_size = lookup(i, "target_size", null)
    }]
    content {
      instance_template = version.value.instance_template
      name = version.value.name

      dynamic "target_size" {
        for_each = version.value.target_size == null ? [] : [for i in version.value.target_size : {
          fixed = i.fixed
          percent = i.percent
        }]
        content {
          fixed = target_size.value.fixed
          percent = target_size.value.percent
        }
      }
    }
  }
}
