resource "aws_autoscaling_group" "autoscalling_group" {
  count                   = length(var.autoscalling_group)
  name                    = lookup(var.autoscalling_group[count.index], "name")
  max_size                = lookup(var.autoscalling_group[count.index], "max_size")
  min_size                = lookup(var.autoscalling_group[count.index], "min_size")
  desired_capacity        = lookup(var.autoscalling_group[count.index], "desired_capacity", null)
  force_delete            = lookup(var.autoscalling_group[count.index], "force_delete", false)
  target_group_arns       = [lookup(var.autoscalling_group[count.index], "target_group_arns", null)]
  service_linked_role_arn = element(var.service_linked_role_arn, lookup(var.autoscalling_group[count.index], "service_linked_role_id"))
  launch_configuration    = element(var.launch_configuration, lookup(var.autoscalling_group[count.index], "configuration_name"))
  protect_from_scale_in   = lookup(var.autoscalling_group[count.index], "protect_from-scale_in", null)
  suspended_processes     = lookup(var.autoscalling_group[count.index], "suspended_processes", null)
  enabled_metrics         = lookup(var.autoscalling_group[count.index], "enabled_metrics", null)
  placement_group         = lookup(var.autoscalling_group[count.index], "placement_group", null)
  termination_policies    = lookup(var.autoscalling_group[count.index], "termination_policies", null)

  dynamic "initial_lifecycle_hook" {
    for_each = lookup(var.autoscalling_group[count.index], "initial_lifecycle_hook")
    content {
      lifecycle_transition = lookup(initial_lifecycle_hook.value, "lifecycle_transition")
      name                 = lookup(initial_lifecycle_hook.value, "name")
    }
  }

  dynamic "mixed_instances_policy" {
    for_each = lookup(var.autoscalling_group[count.index], "mixed_instances_policy")
    content {
      launch_template {
        launch_template_specification {
          launch_template_id   = lookup(mixed_instances_policy.value, "launch_template_id", null)
          launch_template_name = lookup(mixed_instances_policy.value, "launch_template_name", null)
          version              = lookup(mixed_instances_policy.value, "version", null)
        }
      }
      instances_distribution {
        on_demand_allocation_strategy            = lookup(mixed_instances_policy.value, "on_demand_allocation_strategy", null)
        on_demand_base_capacity                  = lookup(mixed_instances_policy.value, "on_demand_base_capacity", null)
        on_demand_percentage_above_base_capacity = lookup(mixed_instances_policy.value, "on_demand_percentage_above_base_capacity", null)
        spot_allocation_strategy                 = lookup(mixed_instances_policy.value, "spot_allocation_strategy", null)
        spot_instance_pools                      = lookup(mixed_instances_policy.value, "spot_instance_pools", null)
        spot_max_price                           = lookup(mixed_instances_policy.value, "spot_max_price", null)
      }
    }
  }

  dynamic "lifecycle" {
    for_each = lookup(var.autoscalling_group[count.index], "lifecycle")
    content {
      create_before_destroy = lookup(lifecycle.value, "create_before_destroy", null)
      prevent_destroy       = lookup(lifecycle.value, "prevent_destrot", null)
    }
  }
}