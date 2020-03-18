resource "aws_codedeploy_deployment_config" "deployment_config" {
  count                  = length(var.deployment_config)
  deployment_config_name = lookup(var.deployment_config[count.index], "deployment_config_name")

  dynamic "minimum_healthy_hosts" {
    for_each = lookup(var.deployment_config[count.index], "minimum_healthy_hosts") == null ? [] : lookup(var.deployment_config[count.index], "minimum_healthy_hosts")
    content {
      type  = lookup(minimum_healthy_hosts.value, "type")
      value = lookup(minimum_healthy_hosts.value, "value")
    }
  }

  dynamic "traffic_routing_config" {
    for_each = lookup(var.deployment_config[count.index], "traffic_routing_config") == null ? [] : [for i in lookup(var.deployment_config[count.index], "traffic_routing_config") : {
      type              = i.type
      time_based_canary = lookup(i, "time_based_canary", null)
      time_based_linear = lookup(i, "time_based_linear", null)
    }]
    content {
      type = traffic_routing_config.value.type

      dynamic "time_based_canary" {
        for_each = traffic_routing_config.value.time_based_canary == null ? [] : [for i in traffic_routing_config.value.time_based_canary : {
          interval   = i.interval
          percentage = i.percentage
        }]
        content {
          interval   = time_based_canary.value.interval
          percentage = time_based_canary.value.percentage
        }
      }
      dynamic "time_based_linear" {
        for_each = traffic_routing_config.value.time_based_linear == null ? [] : [for i in traffic_routing_config.value.time_base_linear : {
          interval   = i.interval
          percentage = i.percentage
        }]
        content {
          interval   = time_based_linear.value.interval
          percentage = time_based_linear.value.percentage
        }
      }
    }
  }
}