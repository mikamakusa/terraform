resource "azurerm_kubernetes_cluster" "this" {
  count                               = var.cluster == null ? 0 : 1
  location                            = data.azurerm_resource_group.this.location
  name                                = join("-", ["aks", var.cluster.name])
  resource_group_name                 = data.azurerm_resource_group.this.name
  automatic_channel_upgrade           = var.cluster.automatic_channel_upgrade
  azure_policy_enabled                = var.cluster.azure_policy_enabled
  disk_encryption_set_id              = var.cluster.disk_encryption_set_id
  dns_prefix                          = var.cluster.dns_prefix
  http_application_routing_enabled    = var.cluster.http_application_routing_enabled
  kubernetes_version                  = var.cluster.kubernetes_version
  local_account_disabled              = var.cluster.local_account_disabled
  node_resource_group                 = var.cluster.node_resource_group
  oidc_issuer_enabled                 = var.cluster.oidc_issuer_enabled
  open_service_mesh_enabled           = var.cluster.open_service_mesh_enabled
  private_cluster_enabled             = var.cluster.private_cluster_enabled
  private_cluster_public_fqdn_enabled = var.cluster.private_cluster_public_fqdn_enabled
  private_dns_zone_id                 = var.cluster.private_dns_zone_id
  public_network_access_enabled       = var.cluster.public_network_access_enabled
  role_based_access_control_enabled   = var.cluster.role_based_access_control_enabled
  sku_tier                            = var.cluster.sku_tier
  edge_zone                           = var.cluster.edge_zone
  image_cleaner_enabled               = var.cluster.image_cleaner_enabled
  image_cleaner_interval_hours        = var.cluster.image_cleaner_interval_hours
  node_os_channel_upgrade             = var.cluster.node_os_channel_upgrade
  workload_identity_enabled           = var.cluster.workload_identity_enabled
  run_command_enabled                 = var.cluster.run_command_enabled
  tags = merge(
    var.tags,
    var.cluster.tags, {
      deploy = "terraform"
    }
  )

  dynamic "service_mesh_profile" {
    for_each = var.service_mesh_profile
    content {
      mode = var.service_mesh_profile.mode
    }
  }

  dynamic "service_principal" {
    for_each = var.service_principal
    content {
      client_id     = var.service_principal.client_id
      client_secret = var.service_principal.client_secret
    }
  }

  dynamic "default_node_pool" {
    for_each = var.default_node_pool
    content {
      name                         = var.default_node_pool.name
      vm_size                      = var.default_node_pool.vm_size
      enable_auto_scaling          = var.default_node_pool.enable_auto_scaling
      enable_host_encryption       = var.default_node_pool.enable_host_encryption
      enable_node_public_ip        = var.default_node_pool.enable_node_public_ip
      max_count                    = var.default_node_pool.max_count
      max_pods                     = var.default_node_pool.max_pods
      node_count                   = var.default_node_pool.node_count
      node_labels                  = var.default_node_pool.node_labels
      node_taints                  = var.default_node_pool.node_taints
      only_critical_addons_enabled = var.default_node_pool.only_critical_addons_enabled
      orchestrator_version         = var.default_node_pool.orchestrator_version
      os_disk_size_gb              = var.default_node_pool.os_disk_size_gb
      os_disk_type                 = var.default_node_pool.os_disk_type
      os_sku                       = var.default_node_pool.os_sku
      pod_subnet_id                = var.default_node_pool.pod_subnet_id
      proximity_placement_group_id = var.default_node_pool.proximity_placement_group_id
      scale_down_mode              = var.default_node_pool.scale_down_mode
      tags = merge(
        var.tags,
        var.default_node_pool.tags, {
          deploy = "terraform"
        }
      )
      temporary_name_for_rotation = var.default_node_pool.temporary_name_for_rotation
      type                        = var.default_node_pool.type
      ultra_ssd_enabled           = var.default_node_pool.ultra_ssd_enabled
      vnet_subnet_id              = var.default_node_pool.vnet_subnet_id
      zones                       = var.default_node_pool.zones
      workload_runtime            = var.default_node_pool.workload_runtime

      dynamic "kubelet_config" {
        for_each = var.kubelet_config
        content {
          allowed_unsafe_sysctls    = var.kubelet_config.allowed_unsafe_sysctls
          container_log_max_line    = var.kubelet_config.container_log_max_line
          container_log_max_size_mb = var.kubelet_config.container_log_max_size_mb
          cpu_cfs_quota_enabled     = var.kubelet_config.cpu_cfs_quota_enabled
          cpu_cfs_quota_period      = var.kubelet_config.cpu_cfs_quota_period
          cpu_manager_policy        = var.kubelet_config.cpu_manager_policy
          image_gc_high_threshold   = var.kubelet_config.image_gc_high_threshold
          image_gc_low_threshold    = var.kubelet_config.image_gc_low_threshold
          pod_max_pid               = var.kubelet_config.pod_max_pid
          topology_manager_policy   = var.kubelet_config.topology_manager_policy
        }
      }
      dynamic "linux_os_config" {
        for_each = var.linux_os_config
        iterator = os_config
        content {
          swap_file_size_mb             = var.linux_os_config.swap_file_size_mb
          transparent_huge_page_defrag  = var.linux_os_config.transparent_huge_page_defrag
          transparent_huge_page_enabled = var.linux_os_config.transparent_huge_page_enabled

          dynamic "sysctl_config" {
            for_each = os_config.value.sysctl_configs == null ? [] : os_config.value.sysctl_configs
            content {
              fs_aio_max_nr                      = sysctl_config.value.fs_aio_max_nr
              fs_file_max                        = sysctl_config.value.fs_file_max
              fs_inotify_max_user_watches        = sysctl_config.value.fs_inotify_max_user_watches
              fs_nr_open                         = sysctl_config.value.fs_nr_open
              kernel_threads_max                 = sysctl_config.value.kernel_threads_max
              net_core_netdev_max_backlog        = sysctl_config.value.net_core_netdev_max_backlog
              net_core_optmem_max                = sysctl_config.value.net_core_optmem_max
              net_core_rmem_default              = sysctl_config.value.net_core_rmem_default
              net_core_rmem_max                  = sysctl_config.value.net_core_rmem_max
              net_core_somaxconn                 = sysctl_config.value.net_core_somaxconn
              net_core_wmem_default              = sysctl_config.value.net_core_wmem_default
              net_core_wmem_max                  = sysctl_config.value.net_core_wmem_max
              net_ipv4_ip_local_port_range_max   = sysctl_config.value.net_ipv4_ip_local_port_range_max
              net_ipv4_ip_local_port_range_min   = sysctl_config.value.net_ipv4_ip_local_port_range_min
              net_ipv4_neigh_default_gc_thresh1  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh1
              net_ipv4_neigh_default_gc_thresh2  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh2
              net_ipv4_neigh_default_gc_thresh3  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh3
              net_ipv4_tcp_fin_timeout           = sysctl_config.value.net_ipv4_tcp_fin_timeout
              net_ipv4_tcp_keepalive_intvl       = sysctl_config.value.net_ipv4_tcp_keepalive_intvl
              net_ipv4_tcp_keepalive_probes      = sysctl_config.value.net_ipv4_tcp_keepalive_probes
              net_ipv4_tcp_keepalive_time        = sysctl_config.value.net_ipv4_tcp_keepalive_time
              net_ipv4_tcp_max_syn_backlog       = sysctl_config.value.net_ipv4_tcp_max_syn_backlog
              net_ipv4_tcp_max_tw_buckets        = sysctl_config.value.net_ipv4_tcp_max_tw_buckets
              net_ipv4_tcp_tw_reuse              = sysctl_config.value.net_ipv4_tcp_tw_reuse
              net_netfilter_nf_conntrack_buckets = sysctl_config.value.net_netfilter_nf_conntrack_buckets
              net_netfilter_nf_conntrack_max     = sysctl_config.value.net_netfilter_nf_conntrack_max
              vm_max_map_count                   = sysctl_config.value.vm_max_map_count
              vm_swappiness                      = sysctl_config.value.vm_swappiness
              vm_vfs_cache_pressure              = sysctl_config.value.vm_vfs_cache_pressure
            }
          }
        }
      }
      dynamic "upgrade_settings" {
        for_each = var.upgrade_settings
        content {
          max_surge = var.upgrade_settings.max_surge
        }
      }
    }
  }

  dynamic "aci_connector_linux" {
    for_each = var.aci_connector_linux
    content {
      subnet_name = var.aci_connector_linux.subnet_name
    }
  }

  dynamic "api_server_access_profile" {
    for_each = var.api_server_access_profile
    content {
      authorized_ip_ranges     = var.api_server_access_profile.authorized_ip_ranges
      subnet_id                = var.api_server_access_profile.subnet_id
      vnet_integration_enabled = var.api_server_access_profile.vnet_integration_enabled
    }
  }

  dynamic "auto_scaler_profile" {
    for_each = var.auto_scaler_profile
    content {
      balance_similar_node_groups      = var.auto_scaler_profile.balance_similar_node_groups
      expander                         = var.auto_scaler_profile.expander
      max_graceful_termination_sec     = var.auto_scaler_profile.max_graceful_termination_sec
      max_node_provisioning_time       = var.auto_scaler_profile.max_node_provisioning_time
      max_unready_nodes                = var.auto_scaler_profile.max_unready_nodes
      max_unready_percentage           = var.auto_scaler_profile.max_unready_percentage
      new_pod_scale_up_delay           = var.auto_scaler_profile.new_pod_scale_up_delay
      scale_down_delay_after_add       = var.auto_scaler_profile.scale_down_delay_after_add
      scale_down_delay_after_delete    = var.auto_scaler_profile.scale_down_delay_after_delete
      scale_down_delay_after_failure   = var.auto_scaler_profile.scale_down_delay_after_failure
      scan_interval                    = var.auto_scaler_profile.scan_interval
      scale_down_unneeded              = var.auto_scaler_profile.scale_down_unneeded
      scale_down_unready               = var.auto_scaler_profile.scale_down_unready
      scale_down_utilization_threshold = var.auto_scaler_profile.scale_down_utilization_threshold
      empty_bulk_delete_max            = var.auto_scaler_profile.empty_bulk_delete_max
      skip_nodes_with_system_pods      = var.auto_scaler_profile.skip_nodes_with_system_pods
      skip_nodes_with_local_storage    = var.auto_scaler_profile.skip_nodes_with_local_storage
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.azure_active_directory_role_based_access_control
    iterator = aad
    content {
      managed                = aad.value.managed
      admin_group_object_ids = aad.value.admin_group_object_ids
      azure_rbac_enabled     = aad.value.azure_rbac_enabled
      client_app_id          = aad.value.client_app_id
      server_app_id          = aad.value.server_app_id
      server_app_secret      = sensitive(aad.value.server_app_secret)
      tenant_id              = aad.value.tenant_id
    }
  }

  dynamic "confidential_computing" {
    for_each = var.confidential_computing
    content {
      sgx_quote_helper_enabled = var.confidential_computing.sgx_quote_helper_enabled
    }
  }

  dynamic "http_proxy_config" {
    for_each = var.http_proxy_config
    content {
      http_proxy  = var.http_proxy_config.http_proxy
      https_proxy = var.http_proxy_config.https_proxy
      no_proxy    = var.http_proxy_config.no_proxy
    }
  }

  dynamic "workload_autoscaler_profile" {
    for_each = var.workload_autoscaler_profile
    content {
      keda_enabled                    = var.workload_autoscaler_profile.keda_enabled
      vertical_pod_autoscaler_enabled = var.workload_autoscaler_profile.vertical_pod_autoscaler_enabled
    }
  }

  dynamic "identity" {
    for_each = var.identity
    content {
      type         = var.identity.type
      identity_ids = var.identity.identity_ids
    }
  }

  dynamic "ingress_application_gateway" {
    for_each = var.ingress_application_gateway
    content {
      gateway_id   = var.ingress_application_gateway.gateway_id
      gateway_name = var.ingress_application_gateway.gateway_name
      subnet_cidr  = var.ingress_application_gateway.subnet_cidr
      subnet_id    = var.ingress_application_gateway.subnet_id
    }
  }

  dynamic "key_management_service" {
    for_each = var.key_management_service ? ["key_management_service"] : []
    content {
      key_vault_key_id         = var.key_management_service.key_vault_key_id
      key_vault_network_access = var.key_management_service.key_vault_network_access
    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = var.key_vault_secrets_provider ? ["key_vault_secrets_provider"] : []
    content {
      secret_rotation_enabled  = var.key_vault_secrets_provider.secret_rotation_enabled
      secret_rotation_interval = var.key_vault_secrets_provider.secret_rotation_interval
    }
  }

  dynamic "kubelet_identity" {
    for_each = var.kubelet_identity
    content {
      client_id                 = var.kubelet_identity.client_id
      object_id                 = var.kubelet_identity.object_id
      user_assigned_identity_id = var.kubelet_identity.user_assigned_identity_id
    }
  }

  dynamic "linux_profile" {
    for_each = var.linux_profile
    content {
      admin_username = var.linux_profile.admin_username
      ssh_key {
        key_data = var.linux_profile.ssh_key
      }
    }
  }

  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? ["maintenance_window"] : []
    content {
      dynamic "allowed" {
        for_each = var.maintenance_window.allowed
        content {
          day   = allowed.value.day
          hours = allowed.value.hours
        }
      }
      dynamic "not_allowed" {
        for_each = var.maintenance_window.not_allowed
        content {
          end   = not_allowed.value.end
          start = not_allowed.value.start
        }
      }
    }
  }

  dynamic "microsoft_defender" {
    for_each = var.microsoft_defender ? ["microsoft_defender"] : []
    content {
      log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
    }
  }

  dynamic "monitor_metrics" {
    for_each = var.monitor_metrics != null ? ["monitor_metrics"] : []
    content {
      annotations_allowed = var.monitor_metrics.annotations_allowed
      labels_allowed      = var.monitor_metrics.labels_allowed
    }
  }

  dynamic "network_profile" {
    for_each = var.network_profile != null ? ["network_profile"] : []
    content {
      network_plugin      = var.network_profile.network_plugin
      network_mode        = var.network_profile.network_mode
      dns_service_ip      = var.network_profile.dns_service_ip
      ebpf_data_plane     = var.network_profile.ebpf_data_plane
      load_balancer_sku   = var.network_profile.load_balancer_sku
      network_plugin_mode = var.network_profile.network_plugin_mode
      network_policy      = var.network_profile.network_policy
      outbound_type       = var.network_profile.outbound_type
      pod_cidr            = var.network_profile.pod_cidr
      service_cidr        = var.network_profile.service_cidr

      dynamic "load_balancer_profile" {
        for_each = var.network_profile.load_balancer_profile != null ? ["load_balancer_profile"] : []
        content {
          idle_timeout_in_minutes     = var.network_profile.load_balancer_profile.idle_timeout_in_minutes
          managed_outbound_ip_count   = var.network_profile.load_balancer_profile.managed_outbound_ip_count
          managed_outbound_ipv6_count = var.network_profile.load_balancer_profile.managed_outbound_ipv6_count
          outbound_ip_address_ids     = var.network_profile.load_balancer_profile.outbound_ip_address_ids
          outbound_ip_prefix_ids      = var.network_profile.load_balancer_profile.outbound_ip_prefix_ids
          outbound_ports_allocated    = var.network_profile.load_balancer_profile.outbound_ports_allocated
        }
      }
    }
  }

  dynamic "oms_agent" {
    for_each = var.oms_agent ? ["oms_agent"] : []
    content {
      log_analytics_workspace_id      = data.azurerm_log_analytics_workspace.this.id
      msi_auth_for_monitoring_enabled = true
    }
  }

  dynamic "web_app_routing" {
    for_each = var.web_app_routing == null ? [] : ["web_app_routing"]
    content {
      dns_zone_id = var.web_app_routing.dns_zone_id
    }
  }

  dynamic "storage_profile" {
    for_each = var.storage_profile
    content {
      blob_driver_enabled         = var.storage_profile.blob_driver_enabled
      disk_driver_enabled         = var.storage_profile.disk_driver_enabled
      disk_driver_version         = var.storage_profile.disk_driver_version
      file_driver_enabled         = var.storage_profile.file_driver_enabled
      snapshot_controller_enabled = var.storage_profile.snapshot_controller_enabled
    }
  }

  lifecycle {
    ignore_changes = [var.cluster.kubernetes_version]
    precondition {
      condition     = (var.service_principal.client_id != "" && var.service_principal.client_secret != "") || (var.identity.type != "")
      error_message = "Either `client_id` and `client_secret` or `identity_type` must be set."
    }
    precondition {
      # Why don't use var.identity_ids != null && length(var.identity_ids)>0 ? Because bool expression in Terraform is not short circuit so even var.identity_ids is null Terraform will still invoke length function with null and cause error. https://github.com/hashicorp/terraform/issues/24128
      condition     = (var.service_principal.client_id != "" && var.service_principal.client_secret != "") || (var.identity.type == "SystemAssigned") || (var.identity.identity_ids == null ? false : length(var.identity.identity_ids) > 0)
      error_message = "If use identity and `UserAssigned` is set, an `identity_ids` must be set as well."
    }
  }
}

resource "azapi_update_resource" "this" {
  type = join("-", ["Microsoft.ContainerService/managedCluster", formatdate("YYYY-MMM-DD", timestamp()), "preview"])
  body = jsonencode({
    properties = {
      kubernetesVersion = var.cluster.kubernetes_version
    }
  })
  resource_id = azurerm_kubernetes_cluster.this.id
}

resource "azurerm_kubernetes_cluster_node_pool" "this" {
  count                         = var.node_pool == null ? 0 : 1
  kubernetes_cluster_id         = azurerm_kubernetes_cluster.this.id
  name                          = var.node_pool.name
  vm_size                       = var.node_pool.vm_size
  capacity_reservation_group_id = var.node_pool.capacity_reservation_group_id
  custom_ca_trust_enabled       = var.node_pool.custom_ca_trust_enabled
  enable_auto_scaling           = var.node_pool.enable_auto_scaling
  enable_host_encryption        = var.node_pool.enable_host_encryption
  enable_node_public_ip         = var.node_pool.enable_node_public_ip
  eviction_policy               = var.node_pool.eviction_policy
  fips_enabled                  = var.node_pool.fips_enabled
  host_group_id                 = var.node_pool.host_group_id
  kubelet_disk_type             = var.node_pool.kubelet_disk_type
  max_count                     = var.node_pool.max_count
  max_pods                      = var.node_pool.max_pods
  message_of_the_day            = var.node_pool.message_of_the_day
  min_count                     = var.node_pool.min_count
  mode                          = var.node_pool.mode
  node_labels                   = var.node_pool.node_labels
  node_public_ip_prefix_id      = var.node_pool.node_public_ip_prefix_id
  node_taints                   = var.node_pool.node_taints
  orchestrator_version          = var.node_pool.orchestrator_version
  os_disk_size_gb               = var.node_pool.os_disk_size_gb
  os_disk_type                  = var.node_pool.os_disk_type
  os_sku                        = var.node_pool.os_sku
  os_type                       = var.node_pool.os_type
  pod_subnet_id                 = var.node_pool.pod_subnet_id
  priority                      = var.node_pool.priority
  proximity_placement_group_id  = var.node_pool.proximity_placement_group_id
  snapshot_id                   = var.node_pool.snapshot_id
  spot_max_price                = var.node_pool.spot_max_price
  tags = merge(
    var.tags,
    var.node_pool.tags, {
      deploy = "terraform"
    }
  )
  ultra_ssd_enabled = var.node_pool.ultra_ssd_enabled
  vnet_subnet_id    = var.node_pool.vnet_subnet_id
  workload_runtime  = var.node_pool.workload_runtime
  zones             = var.node_pool.zones

  dynamic "kubelet_config" {
    for_each = var.node_pool_kubelet_config ? ["kubelet_config"] : []
    content {
      allowed_unsafe_sysctls    = var.node_pool_kubelet_config.allowed_unsafe_sysctls
      container_log_max_line    = var.node_pool_kubelet_config.container_log_max_line
      container_log_max_size_mb = var.node_pool_kubelet_config.container_log_max_size_mb
      cpu_cfs_quota_enabled     = var.node_pool_kubelet_config.cpu_cfs_quota_enabled
      cpu_cfs_quota_period      = var.node_pool_kubelet_config.cpu_cfs_quota_period
      cpu_manager_policy        = var.node_pool_kubelet_config.cpu_manager_policy
      image_gc_high_threshold   = var.node_pool_kubelet_config.image_gc_high_threshold
      image_gc_low_threshold    = var.node_pool_kubelet_config.image_gc_low_threshold
      pod_max_pid               = var.node_pool_kubelet_config.pod_max_pid
      topology_manager_policy   = var.node_pool_kubelet_config.topology_manager_policy
    }
  }

  dynamic "linux_os_config" {
    for_each = var.node_pool_linux_os_config
    iterator = os_config
    content {
      swap_file_size_mb             = var.node_pool_linux_os_config.swap_file_size_mb
      transparent_huge_page_defrag  = var.node_pool_linux_os_config.transparent_huge_page_defrag
      transparent_huge_page_enabled = var.node_pool_linux_os_config.transparent_huge_page_enabled

      dynamic "sysctl_config" {
        for_each = os_config.value.sysctl_config == null ? [] : os_config.value.sysctl_configs
        content {
          fs_aio_max_nr                      = sysctl_config.value.fs_aio_max_nr
          fs_file_max                        = sysctl_config.value.fs_file_max
          fs_inotify_max_user_watches        = sysctl_config.value.fs_inotify_max_user_watches
          fs_nr_open                         = sysctl_config.value.fs_nr_open
          kernel_threads_max                 = sysctl_config.value.kernel_threads_max
          net_core_netdev_max_backlog        = sysctl_config.value.net_core_netdev_max_backlog
          net_core_optmem_max                = sysctl_config.value.net_core_optmem_max
          net_core_rmem_default              = sysctl_config.value.net_core_rmem_default
          net_core_somaxconn                 = sysctl_config.value.net_core_somaxconn
          net_core_wmem_default              = sysctl_config.value.net_core_wmem_default
          net_core_wmem_max                  = sysctl_config.value.net_core_wmem_max
          net_ipv4_ip_local_port_range_max   = sysctl_config.value.net_ipv4_ip_local_port_range_max
          net_ipv4_ip_local_port_range_min   = sysctl_config.value.net_ipv4_ip_local_port_range_min
          net_ipv4_neigh_default_gc_thresh1  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh1
          net_ipv4_neigh_default_gc_thresh2  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh2
          net_ipv4_neigh_default_gc_thresh3  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh3
          net_ipv4_tcp_fin_timeout           = sysctl_config.value.net_ipv4_tcp_fin_timeout
          net_ipv4_tcp_keepalive_intvl       = sysctl_config.value.net_ipv4_tcp_keepalive_intvl
          net_ipv4_tcp_keepalive_probes      = sysctl_config.value.net_ipv4_tcp_keepalive_probes
          net_ipv4_tcp_keepalive_time        = sysctl_config.value.net_ipv4_tcp_keepalive_time
          net_ipv4_tcp_max_syn_backlog       = sysctl_config.value.net_ipv4_tcp_max_syn_backlog
          net_ipv4_tcp_max_tw_buckets        = sysctl_config.value.net_ipv4_tcp_max_tw_buckets
          net_ipv4_tcp_tw_reuse              = sysctl_config.value.net_ipv4_tcp_tw_reuse
          net_netfilter_nf_conntrack_buckets = sysctl_config.value.net_netfilter_nf_conntrack_buckets
          net_netfilter_nf_conntrack_max     = sysctl_config.value.net_netfilter_nf_conntrack_max
          vm_max_map_count                   = sysctl_config.value.vm_max_map_count
          vm_swappiness                      = sysctl_config.value.vm_swappiness
          vm_vfs_cache_pressure              = sysctl_config.value.vm_vfs_cache_pressure
        }
      }
    }
  }

  dynamic "node_network_profile" {
    for_each = var.node_pool_node_network_profile == null ? [] : ["node_network_profile"]
    content {
      node_public_ip_tags = var.node_pool_node_network_profile.node_public_ip_tags
    }
  }

  dynamic "upgrade_settings" {
    for_each = var.node_pool_upgrade_settings == null ? [] : ["upgrade_settings"]
    content {
      max_surge = var.node_pool_upgrade_settings.max_surge
    }
  }

  dynamic "windows_profile" {
    for_each = var.node_pool_windows_profile == null ? [] : ["windows_profile"]
    content {
      outbound_nat_enabled = var.node_pool_windows_profile.outbound_nat_enabled
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      var.node_pool.name,
      var.node_pool.tags
    ]
  }
}

resource "azurerm_log_analytics_solution" "this" {
  location              = data.azurerm_resource_group.this.location
  resource_group_name   = data.azurerm_resource_group.this.name
  solution_name         = join("-", ["aks", var.cluster.name, "ContainerInsights"])
  workspace_name        = data.azurerm_log_analytics_workspace.this.name
  workspace_resource_id = data.azurerm_log_analytics_workspace.this.id
  tags = merge(
    var.tags, {
      deploy = "terraform"
    }
  )
  plan {
    product   = "OMSGallery/ContainerInsights"
    publisher = "Microsoft"
  }
}

resource "azurerm_role_assignment" "this" {
  for_each                         = var.role_assignemnt
  principal_id                     = each.value.principal_id
  scope                            = each.value.scope
  role_definition_name             = each.key
  skip_service_principal_aad_check = each.value.skip_service_principal_aad_check

  dynamic "lifecycle" {
    for_each = ""
    content {}
  }
}

resource "azurerm_user_assigned_identity" "this" {
  count               = (var.service_principal.client_id == "" || var.service_principal.client_secret == "") && var.identity.type == "UserAssigned" ? 1 : 0
  location            = data.azurerm_resource_group.this.location
  name                = split("/", var.identity.identity_ids[0])[8]
  resource_group_name = split("/", var.identity.identity_ids[0])[4]
}
