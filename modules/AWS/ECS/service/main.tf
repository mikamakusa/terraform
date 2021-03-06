resource "aws_ecs_service" "service" {
  count           = length(var.service)
  name            = lookup(var.service[count.index], "name")
  cluster         = element(var.cluster_id, lookup(var.service[count.index], "cluster_id"))
  desired_count   = lookup(var.service[count.index], "desired_count")
  launch_type     = lookup(var.service[count.index], "launch_type")
  task_definition = element(var.task_definition_arn, lookup(var.service[count.index], "task_definition_id"))
  //iam_role        = element(var.iam_role_arn, lookup(var.service[count.index], "iam_role_id"))

  dynamic "capacity_provider_strategy" {
    for_each = lookup(var.service[count.index], "capacity_provider_strategy")
    content {
      capacity_provider = element(var.capacity_provider_name, lookup(capacity_provider_strategy.value, "capacity_provider_id"))
      weight            = lookup(capacity_provider_strategy.value, "weight")
      base              = lookup(capacity_provider_strategy.value, "base")
    }
  }

  dynamic "ordered_placement_strategy" {
    for_each = lookup(var.service[count.index], "ordered_placement_strategy")
    content {
      type  = lookup(ordered_placement_strategy.value, "type")
      field = lookup(ordered_placement_strategy.value, "field")
    }
  }

  dynamic "load_balancer" {
    for_each = lookup(var.service[count.index], "load_balancer")
    content {
      container_name   = lookup(load_balancer.value, "container_name")
      container_port   = lookup(load_balancer.value, "container_port")
      //elb_name         = element(var.elb_name, lookup(load_balancer.value, "elb_id"))
      target_group_arn = element(var.target_group_arn, lookup(load_balancer.value, "target_group_id"))
    }
  }

  dynamic "placement_constraints" {
    for_each = lookup(var.service[count.index], "placement_constraints")
    content {
      type       = lookup(placement_constraints.value, "type")
      expression = lookup(placement_constraints.value, "expression")
    }
  }

  dynamic "network_configuration" {
    for_each = lookup(var.service[count.index], "network_configuration")
    content {
      subnets          = var.subnet
      security_groups  = [var.security_group]
      assign_public_ip = lookup(network_configuration.value, "assign_public_ip", true)
    }
  }

  dynamic "service_registries" {
    for_each = lookup(var.service[count.index], "service_registries")
    content {
      registry_arn   = element(var.registry_arn, lookup(service_registries.value, "registry_id"))
      port           = lookup(service_registries.value, "port")
      container_port = lookup(service_registries.value, "container_port")
      container_name = lookup(service_registries.value, "container_name")
    }
  }

  dynamic "deployment_controller" {
    for_each = lookup(var.service[count.index], "deployment_controller")
    content {
      type = lookup(deployment_controller.value, "type")
    }
  }
}