resource "google_compute_autoscaler" "autoscaler" {
  count    = length(var.autoscaler)
  name     = lookup(var.autoscaler[count.index], "name")
  target   = element(var.target_id, lookup(var.autoscaler[count.index], "target_id"))
  provider = "google-beta"
  project  = var.project
  zone     = var.zone

  dynamic "autoscaling_policy" {
    for_each = [for i in lookup(var.autoscaler[count.index], "autoscaling_policy") : {
      max                        = i.max_replicas
      min                        = i.min_replicas
      cooldown                   = i.cooldown_period
      mode                       = i.mode
      metric                     = lookup(i, "metric", null)
      load_balancing_utilization = lookup(i, "load_balancing_utilization", null)
      scale_down_control         = lookup(i, "scale_down_control", null)
      cpu_utilization            = lookup(i, "cpu_utilization", null)
    }]
    content {
      max_replicas    = autoscaling_policy.value.max
      min_replicas    = autoscaling_policy.value.min
      cooldown_period = autoscaling_policy.value.cooldown
      mode            = autoscaling_policy.value.mode

      dynamic "metric" {
        for_each = autoscaling_policy.value.metric == null ? [] : [for i in autoscaling_policy.value.metric : {
          name                       = i.name
          single_instance_assignment = i.single_instance_assignment
          target                     = i.target
          type                       = i.type
          filter                     = i.filter
        }]
        content {
          name                       = metric.value.name
          single_instance_assignment = metric.value.single_instance_assignment
          target                     = metric.value.target
          type                       = metric.value.type
          filter                     = metric.value.filter
        }
      }

      dynamic "load_balancing_utilization" {
        for_each = autoscaling_policy.value.load_balancing_utilization == null ? [] : [for i in autoscaling_policy.value.load_balancing_utilization : {
          target = i.target
        }]
        content {
          target = load_balancing_utilization.value.target
        }
      }

      dynamic "scale_down_control" {
        for_each = autoscaling_policy.value.scale_down_control == null ? [] : [for i in autoscaling_policy.value.scale_down_control : {
          time = i.time
          max_scaled = lookup(i, "max_scaled_down_replicas", null)
        }]
        content {
          time_window_sec = scale_down_control.value.time

          dynamic "max_scaled_down_replicas" {
            for_each = scale_down_control.value.max_scaled == null ? [] : [for i in scale_down_control.value.max_scaled : {
              fixed = i.fixed
              percent = i.percent
            }]
            content {
              fixed = max_scaled_down_replicas.value.fixed
              percent = max_scaled_down_replicas.value.percent
            }
          }
        }
      }

      dynamic "cpu_utilization" {
        for_each = autoscaling_policy.value.cpu_utilization == null ? [] : [for i in autoscaling_policy.value.cpu_utilization : {
          target = i.target
        }]
        content {
          target = cpu_utilization.value.target
        }
      }
    }
  }
}
