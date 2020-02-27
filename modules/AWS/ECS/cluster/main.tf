resource "aws_ecs_cluster" "cluster" {
  count              = length(var.cluster)
  name               = lookup(var.cluster[count.index], "name")
  //capacity_providers = element(var.capacity_provider_name, lookup(var.cluster[count.index], "capacity_provider_id"))


  dynamic "setting" {
    for_each = lookup(var.cluster[count.index], "setting")
    content {
      name  = lookup(setting.value, "name")
      value = lookup(setting.value, "value")
    }
  }

  dynamic "default_capacity_provider_strategy" {
    for_each = lookup(var.cluster[count.index], "default_capacity_provider_strategy")
    content {
      capacity_provider = element(var.capacity_provider_name, lookup(default_capacity_provider_strategy.value, "capacity_provider"))
      weight            = lookup(default_capacity_provider_strategy.value, "weight")
      base              = lookup(default_capacity_provider_strategy.value, "base")
    }
  }

  tags = var.tags
}