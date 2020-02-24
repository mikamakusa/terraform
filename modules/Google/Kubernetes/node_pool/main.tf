resource "google_container_node_pool" "node_pool" {
  count              = length(var.node_pool)
  cluster            = lookup(var.node_pool[count.index], "cluster")
  location           = lookup(var.node_pool[count.index], "location")
  initial_node_count = lookup(var.node_pool[count.index], "initial_node_count")
  max_pods_per_node  = lookup(var.node_pool[count.index], "max_pods_per_node")
  name               = lookup(var.node_pool[count.index], "name")
  name_prefix        = lookup(var.node_pool[count.index], "name_prefix")
  project            = lookup(var.node_pool[count.index], "project")
  provider           = lookup(var.node_pool[count.index], "provider")
  version            = lookup(var.node_pool[count.index], "version")

  dynamic "autoscaling" {
    for_each = lookup(var.node_pool[count.index], "autoscaling")
    content {
      max_node_count = lookup(autoscaling.value, "max_node_count")
      min_node_count = lookup(autoscaling.value, "min_node_count")
    }
  }

  dynamic "management" {
    for_each = lookup(var.node_pool[count.index], "management")
    content {
      auto_repair  = lookup(management.value, "auto_repair")
      auto_upgrade = lookup(management.value, "auto_upgrade")
    }
  }

  dynamic "upgrade_settings" {
    for_each = lookup(var.node_pool[count.index], "upgrade_settings")
    content {
      max_surge       = lookup(upgrade_settings.value, "max_surge")
      max_unavailable = lookup(upgrade_settings.value, "max_unavailable")
    }
  }

  dynamic "node_config" {
    for_each = [for i in lookup(var.node_pool[count.index], "node_config") : {
      guest    = lookup(i, "guest_accelerator")
      sandbox  = lookup(i, "sandbox_config")
      workload = lookup(i, "workload_metadata_config")
    }]
    content {
      disk_size_gb     = lookup(node_config.value, "disk_size_gb")
      disk_type        = lookup(node_config.value, "disk_type")
      local_ssd_count  = lookup(node_config.value, "local_ssd_count")
      image_type       = lookup(node_config.value, "image_type")
      machine_type     = lookup(node_config.value, "machine_type")
      min_cpu_platform = lookup(node_config.value, "min_cpu_platform")
      preemptible      = lookup(node_config.value, "preemptible")
      service_account  = lookup(node_config.value, "service_account")
      oauth_scopes     = [lookup(node_config.value, "oauth_scopes")]
      tags             = [lookup(node_config.value, "tags")]
      dynamic "guest_accelerator" {
        for_each = [for i in node_config.value.guest : {
          count = i.count
          type  = i.type
        }]
        content {
          count = guest_accelerator.value.count
          type  = guest_accelerator.value.type
        }
      }
      dynamic "sandbox_config" {
        for_each = [for i in node_config.value.sandbox : {
          type = i.sandbox_type
        }]
        content {
          sandbox_type = sandbox_config.value.type
        }
      }
      dynamic "workload_metadata_config" {
        for_each = [for i in node_config.value.workload : {
          metadata = i.node_metadata
        }]
        content {
          node_metadata = workload_metadata_config.value.metadata
        }
      }
    }
  }
}
