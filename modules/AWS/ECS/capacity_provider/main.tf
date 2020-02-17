resource "aws_ecs_capacity_provider" "capacity_provider" {
  count = length(var.capacity_provider)
  name  = lookup(var.capacity_provider[count.index], "name")

  dynamic "auto_scaling_group_provider" {
    for_each = lookup(var.capacity_provider[count.index], "auto_scaling_group_provider")
    content {
      auto_scaling_group_arn         = element(var.autoscaling_group_arn, lookup(auto_scaling_group_provider.value, "autoscaling_group_id"))
      managed_termination_protection = lookup(auto_scaling_group_provider.value, "managed_termination_protection", "ENABLED")

      managed_scaling {
        maximum_scaling_step_size = lookup(auto_scaling_group_provider.value, "maximum_scaling_step_size")
        minimum_scaling_step_size = lookup(auto_scaling_group_provider.value, "minimum_scaling_step_size")
        status                    = lookup(auto_scaling_group_provider.value, "status", "ENABLED")
        target_capacity           = lookup(auto_scaling_group_provider.value, "target_capacity")
      }
    }
  }
  tags = var.tags
}