resource "google_compute_instance_group_manager" " instance_group_manager" {
  count              = length(var.instance_group_manager)
  base_instance_name = lookup(var.instance_group_manager[count.index], "base_instance_name")
  instance_template  = ""
  name               = lookup(var.instance_group_manager[count.index], "name")
  zone               = ""
  description        = lookup(var.instance_group_manager[count.index], "description")
  project            = ""
  target_size        = lookup(var.instance_group_manager[count.index], "target_size")
  target_pools       = lookup(var.instance_group_manager[count.index], "target_pools")
  wait_for_instances = lookup(var.instance_group_manager[count.index], "wait_for_instances")
  update_strategy    = lookup(var.instance_group_manager[count.index], "update_strategy")

  dynamic "named_port" {
    for_each = lookup(var.instance_group_manager[count.index], "named_port")
    content {
      name = lookup(named_port.value, "name")
      port = lookup(named_port.value, "port")
    }
  }

  dynamic "auto_healing_policies" {
    for_each = lookup(var.instance_group_manager[count.index], "auto_healing_policies")
    content {
      health_check      = lookup(auto_healing_policies.value, "health_check")
      initial_delay_sec = lookup(auto_healing_policies.value, "initial_delay_sec")
    }
  }

  dynamic "update_policy" {
    for_each = lookup(var.instance_group_manager[count.index], "update_policy")
    content {
      minimal_action          = lookup(update_policy.value, "minimal_action")
      type                    = lookup(update_policy.value, "type")
      max_surge_fixed         = lookup(update_policy.value, "max_surge_fixed")
      max_surge_percent       = lookup(update_policy.value, "max_surge_percent")
      max_unavailable_fixed   = lookup(update_policy.value, "max_unavailable_fixed")
      max_unavailable_percent = lookup(update_policy.value, "max_unavailable_percent")
      min_ready_sec           = lookup(update_policy.value, "min_ready_sec")
    }
  }

  dynamic "version" {
    for_each = lookup(var.instance_group_manager[count.index], "version") == null ? [] : [for i in lookup(var.instance_group_manager[count.index], "version") : {
      instance    = i.instance_template
      name        = i.name
      target_size = lookup(i, "target_size", null)
    }]
    content {
      instance_template = version.value.instance
      name              = version.value.name
      dynamic "target_size" {
        for_each = version.value.target_size == null ? [] : [for i in version.value.target_size : {
          fixed   = i.fixed
          percent = i.percent
        }]
        content {
          fixed   = target_size.value.fixed
          percent = target_size.value.percent
        }
      }
    }
  }
}