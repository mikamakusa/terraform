resource "aws_codedeploy_deployment_group" "deployment_group" {
  count                 = length(var.deployment_group)
  app_name              = element(var.app_name, lookup(var.deployment_group[count.index], "app_id"))
  deployment_group_name = element(var.deployment_group_name, lookup(var.deployment_group[count.index], "deployment_group_id"))
  service_role_arn      = element(var.service_role_arn, lookup(var.deployment_group[count.index], "sevice_role_id"))

  dynamic "alarm_configuration" {
    for_each = lookup(var.deployment_group[count.index], "alarm_configuration") == null ? [] : lookup(var.deployment_group[count.index], "alarm_configuration")
    content {
      alarms                    = lookup(alarm_configuration.value, "alarms")
      enabled                   = lookup(alarm_configuration.value, "enabled")
      ignore_poll_alarm_failure = lookup(alarm_configuration.value, "ignore_poll_alarm_failure")
    }
  }

  dynamic "auto_rollback_configuration" {
    for_each = lookup(var.deployment_group[count.index], "auto_rollback_configuration") == null ? [] : lookup(var.deployment_group[count.index], "auto_rollback_configuration")
    content {
      enabled = lookup(auto_rollback_configuration.value, "enabled")
      events  = lookup(auto_rollback_configuration.value, "events")
    }
  }

  dynamic "blue_green_deployment_config" {
    for_each = lookup(var.deployment_group[count.index], "blue_green_deployment_config") == null ? [] : [for i in lookup(var.deployment_group[count.index], "blue_green_deployment_config") : {
      deployment_ready_option                        = lookup(i, "deployment_ready_option")
      terminate_blue_instances_on_deployment_success = lookup(i, "terminate_blue_instances_on_deployment_success")
      green_fleet_provisioning_option                = lookup(i, "green_fleet_provisioning_option")
    }]
    content {
      dynamic "deployment_ready_option" {
        for_each = blue_green_deployment_config.value.deployment_ready_option == null ? [] : [for dro in blue_green_deployment_config.value.deployment_ready_option : {
          action = dro.action_on_timeout
          wait   = dro.wait_time_in_minutes
        }]
        content {
          action_on_timeout    = deployment_ready_option.value.action
          wait_time_in_minutes = deployment_ready_option.value.wait
        }
      }
      dynamic "terminate_blue_instances_on_deployment_success" {
        for_each = blue_green_deployment_config.value.terminate_blue_instances_on_deployment_success == null ? [] : [for tbiods in blue_green_deployment_config.value.terminate_blue_instances_on_deployment_success : {
          action    = tbiods.action
          terminate = tbiods.termination_wait_time_in_minutes
        }]
        content {
          action                           = terminate_blue_instances_on_deployment_success.value.action
          termination_wait_time_in_minutes = terminate_blue_instances_on_deployment_success.value.terminate
        }
      }
      dynamic "green_fleet_provisioning_option" {
        for_each = blue_green_deployment_config.value.green_fleet_provisioning_option == null ? [] : [for gfpo in blue_green_deployment_config.value.green_fleet_provisioning_option : {
          action = gfpo.action
        }]
        content {
          action = green_fleet_provisioning_option.value.action
        }
      }
    }
  }

  dynamic "deployment_style" {
    for_each = lookup(var.deployment_group[count.index], "deployment_style") == null ? [] : lookup(var.deployment_group[count.index], "deployment_style")
    content {
      deployment_option = lookup(deployment_style.value, "deployment_option")
      deployment_type   = lookup(deployment_style.value, "deployment_type")
    }
  }

  dynamic "ec2_tag_filter" {
    for_each = lookup(var.deployment_group[count.index], "ec2_tag_filter") == null ? [] : lookup(var.deployment_group[count.index], "ec2_tag_filter")
    content {
      key   = lookup(ec2_tag_filter.value, "key")
      type  = lookup(ec2_tag_filter.value, "type")
      value = lookup(ec2_tag_filter.value, "value")
    }
  }

  dynamic "ec2_tag_set" {
    for_each = lookup(var.deployment_group[count.index], "ec2_tag_set") == null ? [] : lookup(var.deployment_group[count.index], "ec2_tag_set")
    content {
      variables = ec2_tag_set.value
    }
  }

  dynamic "ecs_service" {
    for_each = lookup(var.deployment_group[count.index], "ecs_service") == null ? [] : lookup(var.deployment_group[count.index], "ecs_service")
    content {
      cluster_name = element(var.cluster_name, lookup(ecs_service.value, "cluster_name"))
      service_name = element(var.service_name, lookup(ecs_service.value, "service_name"))
    }
  }

  dynamic "load_balancer_info" {
    for_each = lookup(var.deployment_group[count.index], "load_balancer_info") == null ? [] : [for i in lookup(var.deployment_group[count.index], "load_balancer_info") : {
      elb_info               = lookup(i, "elb_info")
      target_group_info      = lookup(i, "target_group_info")
      target_group_pair_info = lookup(i, "target_group_pair_info")
      prod_traffic_route     = lookup(i, "prod_traffic_route")
      target_group           = lookup(i, "target_group")
    }]
    content {
      dynamic "elb_info" {
        for_each = load_balancer_info.value.elb_info == null ? [] : [for elb in load_balancer_info.value.elb_info : {
          id = elb.id
        }]
        content {
          name = element(var.elb_name, elb_info.value.id)
        }
      }

      dynamic "target_group_info" {
        for_each = load_balancer_info.value.target_group_info == null ? [] : [for tgi in load_balancer_info.value.target_group_info : {
          id = tgi.id
        }]
        content {
          name = element(var.target_group_name, target_group_info.value.id)
        }
      }

      dynamic "target_group_pair_info" {
        for_each = load_balancer_info.value.target_group_pair_info == null ? [] : [for tgpi in load_balancer_info.value.target_group_pair_info : {
          prod   = lookup(tgpi, "prod_traffic_route")
          test   = lookup(tgpi, "test_traffic_route", null)
          target = lookup(tgpi, "target_group")
        }]
        content {
          dynamic "test_traffic_route" {
            for_each = target_group_pair_info.value.test == null ? [] : [for test in target_group_pair_info.value.test : {
              listener_id = test.listener_id
            }]
            content {
              listener_arns = element(var.listener_arns, test_traffic_route.value.listener_id)
            }
          }
          dynamic "target_group" {
            for_each = [for target in target_group_pair_info.value.target : {
              name = target.name
            }]
            content {
              name = target_group.value.name
            }
          }
          dynamic "prod_traffic_route" {
            for_each = [for prod in target_group_pair_info.value.prod : {
              listener_id = prod.listener_id
            }]
            content {
              listener_arns = element(var.listener_arns, prod_traffic_route.value.listener_id)
            }
          }
        }
      }
    }
  }


  dynamic "on_premises_instance_tag_filter" {
    for_each = lookup(var.deployment_group[count.index], "on_premises_instance_tag_filter") == null ? [] : lookup(var.deployment_group[count.index], "on_premises_instance_tag_filter")
    content {
      key   = lookup(on_premises_instance_tag_filter.value, "key")
      type  = lookup(on_premises_instance_tag_filter.value, "type")
      value = lookup(on_premises_instance_tag_filter.value, "value")
    }
  }

  dynamic "trigger_configuration" {
    for_each = lookup(var.deployment_group[count.index], "trigger_configuration") == null ? [] : lookup(var.deployment_group[count.index], "trigger_configuration")
    content {
      trigger_events     = lookup(trigger_configuration.value, "trigger_events")
      trigger_name       = lookup(trigger_configuration.value, "trigger_name")
      trigger_target_arn = element(var.trigger_target_arn, lookup(trigger_configuration.value, "trigger_target_id"))
    }
  }
}