resource "google_container_cluster" "cluster" {
  count                     = length(var.cluster)
  provider                  = "google-beta"
  name                      = lookup(var.cluster[count.index], "name")
  location                  = lookup(var.cluster[count.index], "location")
  node_locations            = lookup(var.cluster[count.index], "node_locations")
  min_master_version        = lookup(var.cluster[count.index], "min_master_version")
  monitoring_service        = lookup(var.cluster[count.index], "monitoring_service")
  default_max_pods_per_node = lookup(var.cluster[count.index], "default_max_pods_per_node")
  node_version              = lookup(var.cluster[count.index], "node_version")
  remove_default_node_pool  = lookup(var.cluster[count.index], "remove_default_node_pool")
  initial_node_count        = lookup(var.cluster[count.index], "initial_node_count")

  dynamic "addons_config" {
    for_each = [for i in lookup(var.cluster[count.index], "addons_config") : {
      hpa      = lookup(i, "horizontal_pod_autoscaling")
      hlb      = lookup(i, "http_load_balancing")
      kd       = lookup(i, "kubernetes_dashboard")
      npc      = lookup(i, "network_policy_config")
      istio    = lookup(i, "istio_config")
      cloudrun = lookup(i, "cloudrun_config")
    }]
    content {
      dynamic "horizontal_pod_autoscaling" {
        for_each = [for i in addons_config.value.hpa : {
          disabled = i.disabled
        }]
        content {
          disabled = horizontal_pod_autoscaling.value.disabled
        }
      }
      dynamic "http_load_balancing" {
        for_each = [for i in addons_config.value.hlb : {
          disabled = i.disabled
        }]
        content {
          disabled = http_load_balancing.value.disabled
        }
      }
      dynamic "kubernetes_dashboard" {
        for_each = [for i in addons_config.value.kb : {
          disabled = i.disabled
        }]
        content {
          disabled = kubernetes_dashboard.value.disabled
        }
      }
      dynamic "network_policy_config" {
        for_each = [for i in addons_config.value.npc : {
          disabled = i.disabled
        }]
        content {
          disabled = network_policy_config.value.disabled
        }
      }
      dynamic "istio_config" {
        for_each = [for i in addons_config.value.istio : {
          disabled = i.disabled
        }]
        content {
          disabled = istio_config.value.disabled
        }
      }
      dynamic "cloudrun_config" {
        for_each = [for i in addons_config.value.cloudrun : {
          disabled = i.disabled
        }]
        content {
          disabled = cloudrun_config.value.disabled
        }
      }
    }
  }

  dynamic "ip_allocation_policy" {
    for_each = lookup(var.cluster[count.index], "ip_allocation_policy")
    content {
      cluster_secondary_range_name = lookup(ip_allocation_policy.value, "cluster_secondary_range_name")
      cluster_ipv4_cidr_block      = lookup(ip_allocation_policy.value, "cluster_ipv4_cidr_block")
      create_subnetwork            = lookup(ip_allocation_policy.value, "create_subnetwork")
      subnetwork_name              = lookup(ip_allocation_policy.value, "subnetwork_name")
      node_ipv4_cidr_block         = lookup(ip_allocation_policy.value, "node_ipv4_cidr_block")
    }
  }

  dynamic "maintenance_policy" {
    for_each = [for i in lookup(var.cluster[count.index], "maintenance_policy") : {
      dmw = lookup(i, "daily_maintenance_window")
    }]
    content {
      dynamic "daily_maintenance_window" {
        for_each = [for i in maintenance_policy.value.dmw : {
          start = i.start_time
        }]
        content {
          start_time = daily_maintenance_window.value.start
        }
      }
    }
  }

  dynamic "master_auth" {
    for_each = [for i in lookup(var.cluster[count.index], "master_auth") : {
      ccc = lookup(i, "client_certificate_config")
    }]
    content {
      username = lookup(master_auth.value, "username")
      password = lookup(master_auth.value, "password")
      dynamic "client_certificate_config" {
        for_each = [for i in master_auth.value.ccc : {
          issue = i.issue
        }]
        content {
          issue_client_certificate = client_certificate_config.value.issue
        }
      }
    }
  }

  dynamic "master_authorized_networks_config" {
    for_each = [for i in lookup(var.cluster[count.index], "master_authorized_networks_config") : {
      cidr = lookup(i, "cidr_blocks")
    }]
    content {
      dynamic "cidr_blocks" {
        for_each = [for i in master_authorized_networks_config.value.cidr : {
          cidr    = i.cidr
          display = i.display
        }]
        content {
          cidr_block   = cidr_blocks.value.cidr
          display_name = cidr_blocks.value.display
        }
      }
    }
  }

  dynamic "network_policy" {
    for_each = lookup(var.cluster[count.index], "network_policy")
    content {
      provider = lookup(network_policy.value, "provider")
      enabled  = lookup(network_policy.value, "enabled", true)
    }
  }

  dynamic "node_config" {
    for_each = [for i in lookup(var.cluster[count.index], "node_config") : {
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

  dynamic "node_pool" {
    for_each = [for i in lookup(var.cluster[count.index], "node_pool") : {
      config      = lookup(i, "node_config")
      autoscaling = lookup(i, "autoscaling")
      management  = lookup(i, "management")
    }]
    content {
      initial_node_count = lookup(node_pool.value, "initial_node_count")
      max_pods_per_node  = lookup(node_pool.value, "max_pods_per_node")
      name               = lookup(node_pool.value, "name")
      name_prefix        = lookup(node_pool.value, "name_prefix")
      node_count         = lookup(node_pool.value, "node_count")
      version            = lookup(node_pool.value, "version")
      dynamic "node_config" {
        for_each = [for i in node_pool.value.config : {
          image     = i.image
          machine   = i.machine
          min_cpu   = i.min_cpu
          disk_size = i.disk_size
          disk_type = i.disk_type
          ssd_count = i.ssd_count
        }]
        content {
          image_type       = node_pool.image
          machine_type     = node_pool.machine
          min_cpu_platform = node_pool.min_cpu
          disk_size_gb     = node_pool.disk_size
          disk_type        = node_pool.disk_type
          local_ssd_count  = node_pool.ssd_count
        }
      }
      dynamic "autoscaling" {
        for_each = [for i in node_pool.value.autoscaling : {
          min = i.min
          max = i.max
        }]
        content {
          max_node_count = autoscaling.value.max
          min_node_count = autoscaling.value.min
        }
      }
      dynamic "management" {
        for_each = [for i in node_pool.value.management : {
          repair  = i.repair
          upgrade = i.upgrade
        }]
        content {
          auto_repair  = management.value.repair
          auto_upgrade = management.value.upgrade
        }
      }
    }
  }

  dynamic "pod_security_policy_config" {
    for_each = lookup(var.cluster[count.index], "pod_security_policy_config")
    content {
      enabled = lookup(pod_security_policy_config.value, "enabled", true)
    }
  }

  dynamic "private_cluster_config" {
    for_each = lookup(var.cluster[count.index], "private_cluster_config")
    content {
      enable_private_endpoint = lookup(private_cluster_config.value, "enable_private_endpoint")
      enable_private_nodes    = lookup(private_cluster_config.value, "enable_private_nodes")
      master_ipv4_cidr_block  = lookup(private_cluster_config.value, "master_ipv4_cidr_block")
    }
  }
}
