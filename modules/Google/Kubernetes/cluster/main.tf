resource "google_container_cluster" "this" {
  count                     = length(var.cluster)
  name                      = lookup(var.cluster[count.index], "name")
  location                  = lookup(var.cluster[count.index], "location")
  node_locations            = lookup(var.cluster[count.index], "node_locations")
  deletion_protection       = lookup(var.cluster[count.index], "deletion_protection")
  allow_net_admin           = lookup(var.cluster[count.index], "allow_net_admin")
  cluster_ipv4_cidr         = lookup(var.cluster[count.index], "cluster_ipv4_cidr")
  description               = lookup(var.cluster[count.index], "description")
  default_max_pods_per_node = lookup(var.cluster[count.index], "default_max_pods_per_node")
  enable_kubernetes_alpha   = lookup(var.cluster[count.index], "enable_kubernetes_alpha")
  enable_tpu                = lookup(var.cluster[count.index], "enable_tpu")
  enable_legacy_abac        = lookup(var.cluster[count.index], "enable_legacy_abac")
  enable_shielded_nodes     = lookup(var.cluster[count.index], "enable_shielded_nodes")
  enable_autopilot          = lookup(var.cluster[count.index], "enable_autopilot")
  initial_node_count        = lookup(var.cluster[count.index], "initial_node_count")
  networking_mode           = lookup(var.cluster[count.index], "networking_mode")
  min_master_version        = lookup(var.cluster[count.index], "min_master_version")
  monitoring_service        = lookup(var.cluster[count.index], "monitoring_service")
  network                   = lookup(var.cluster[count.index], "network")
  node_version              = lookup(var.cluster[count.index], "node_version")
  project                   = lookup(var.cluster[count.index], "project")
  remove_default_node_pool  = lookup(var.cluster[count.index], "remove_default_node_pool")
  resource_labels = merge(
    var.labels,
    lookup(var.cluster[count.index], "resource_labels")
  )
  subnetwork                  = lookup(var.cluster[count.index], "subnetwork")
  enable_intranode_visibility = lookup(var.cluster[count.index], "enable_intranode_visibility")
  enable_l4_ilb_subsetting    = lookup(var.cluster[count.index], "enable_l4_ilb_subsetting")
  enable_multi_networking     = lookup(var.cluster[count.index], "enable_multi_networking")
  enable_fqdn_network_policy  = lookup(var.cluster[count.index], "enable_fqdn_network_policy")
  private_ipv6_google_access  = lookup(var.cluster[count.index], "private_ipv6_google_access")
  datapath_provider           = lookup(var.cluster[count.index], "datapath_provider")

  dynamic "binary_authorization" {
    for_each = lookup(var.cluster[count.index], "binary_authorization") == null ? [] : ["binary_authorization"]
    content {
      enabled         = lookup(binary_authorization.value, "enabled")
      evaluation_mode = lookup(binary_authorization.value, "evaluation_mode")
    }
  }

  dynamic "addons_config" {
    for_each = lookup(var.cluster[count.index], "addons_config") == null ? [] : ["addons_config"]
    content {
      dynamic "horizontal_pod_autoscaling" {
        for_each = lookup(addons_config.value, "horizontal_pod_autoscaling") ? 1 : 0
        content {
          disabled = false
        }
      }
      dynamic "http_load_balancing" {
        for_each = lookup(addons_config.value, "http_load_balancing") ? 1 : 0
        content {
          disabled = false
        }
      }
      dynamic "network_policy_config" {
        for_each = lookup(addons_config.value, "network_policy_config") ? 1 : 0
        content {
          disabled = false
        }
      }
      dynamic "gcp_filestore_csi_driver_config" {
        for_each = lookup(addons_config.value, "network_policy_config") ? 1 : 0
        content {
          enabled = true
        }
      }
      dynamic "cloudrun_config" {
        for_each = lookup(addons_config.value, "cloudrun_config") ? 1 : 0
        content {
          disabled           = false
          load_balancer_type = lookup(addons_config.value, "load_balancer_type")
        }
      }
      dynamic "istio_config" {
        for_each = lookup(addons_config.value, "istio_config") ? 1 : 0
        content {
          disabled = false
          auth     = lookup(addons_config.value, "auth")
        }
      }
      dynamic "dns_cache_config" {
        for_each = lookup(addons_config.value, "dns_cache_config") ? 1 : 0
        content {
          enabled = true
        }
      }
      dynamic "gce_persistent_disk_csi_driver_config" {
        for_each = lookup(addons_config.value, "gce_persistent_disk_csi_driver_config") ? 1 : 0
        content {
          enabled = true
        }
      }
      dynamic "gke_backup_agent_config" {
        for_each = lookup(addons_config.value, "gke_backup_agent_config") ? 1 : 0
        content {
          enabled = true
        }
      }
      dynamic "kalm_config" {
        for_each = lookup(addons_config.value, "kalm_config") ? 1 : 0
        content {
          enabled = true
        }
      }
      dynamic "config_connector_config" {
        for_each = lookup(addons_config.value, "config_connector_config") ? 1 : 0
        content {
          enabled = true
        }
      }
    }
  }

  dynamic "cluster_autoscaling" {
    for_each = lookup(var.cluster[count.index], "cluster_autoscalling") == null ? [] : ["cluster_autoscalling"]
    content {
      enabled = lookup(cluster_autoscaling.value, "enabled")
      dynamic "resource_limits" {
        for_each = lookup(cluster_autoscaling.value, "resource_limits") == null ? [] : ["resource_limits"]
        content {
          resource_type = lookup(resource_limits.value, "resource_type")
          minimum       = lookup(resource_limits.value, "minimum")
          maximum       = lookup(resource_limits.value, "maximum")
        }
      }
      dynamic "auto_provisioning_defaults" {
        for_each = lookup(cluster_autoscaling.value, "auto_provisioning_defaults") == null ? [] : ["auto_provisioning_defaults"]
        content {
          min_cpu_platform  = lookup(auto_provisioning_defaults.value, "min_cpu_platform")
          oauth_scopes      = lookup(auto_provisioning_defaults.value, "oauth_scopes")
          service_account   = lookup(auto_provisioning_defaults.value, "service_account")
          boot_disk_kms_key = lookup(auto_provisioning_defaults.value, "boot_disk_kms_key")
          disk_size         = lookup(auto_provisioning_defaults.value, "disk_size")
          disk_type         = lookup(auto_provisioning_defaults.value, "disk_type")
          image_type        = lookup(auto_provisioning_defaults.value, "image_type")
          dynamic "shielded_instance_config" {
            for_each = lookup(auto_provisioning_defaults.value, "shielded_instance_config") == null ? [] : ["shielded_instance_config"]
            content {
              enable_secure_boot          = lookup(shielded_instance_config.value, "enable_secure_boot")
              enable_integrity_monitoring = lookup(shielded_instance_config.value, "enable_integrity_monitoring")
            }
          }
          dynamic "management" {
            for_each = lookup(cluster_autoscaling.value, "management") == null ? [] : ["management"]
            content {
              auto_repair  = lookup(management.value, "auto_repair")
              auto_upgrade = lookup(management.value, "auto_upgrade")
            }
          }
          dynamic "upgrade_settings" {
            for_each = lookup(cluster_autoscaling.value, "upgrade_settings") == null ? [] : ["upgrade_settings"]
            content {
              strategy        = lookup(upgrade_settings.value, "strategy")
              max_surge       = lookup(upgrade_settings.value, "max_surge")
              max_unavailable = lookup(upgrade_settings.value, "max_unavailable")
              dynamic "blue_green_settings" {
                for_each = lookup(upgrade_settings.value, "blue_green_settings") == null ? [] : ["blue_green_settings"]
                content {
                  node_pool_soak_duration = lookup(blue_green_settings.value, "node_pool_soak_duration")
                  dynamic "standard_rollout_policy" {
                    for_each = lookup(blue_green_settings.value, "standard_rollout_policy") == null ? [] : ["standard_rollout_policy"]
                    content {
                      batch_percentage    = lookup(standard_rollout_policy.value, "batch_percentage")
                      batch_node_count    = lookup(standard_rollout_policy.value, "batch_node_count")
                      batch_soak_duration = lookup(standard_rollout_policy.value, "batch_soak_duration")
                    }
                  }
                }
              }
            }
          }
        }
      }
      autoscaling_profile = lookup(cluster_autoscaling.value, "autoscaling_profile")
    }
  }

  dynamic "service_external_ips_config" {
    for_each = lookup(var.cluster[count.index], service_external_ips_config) == null ? [] : ["service_external_ips_config"]
    content {
      enabled = lookup(service_external_ips_config.value, "enabled")
    }
  }

  dynamic "mesh_certificates" {
    for_each = lookup(var.cluster[count.index], "mesh_certificates") == null ? [] : ["mesh_certificates"]
    content {
      enable_certificates = lookup(mesh_certificates.value, "enable_certificates")
    }
  }

  dynamic "database_encryption" {
    for_each = lookup(var.cluster[count.index], "database_encryption") == null ? [] : ["database_encryption"]
    content {
      state    = lookup(database_encryption.value, "state")
      key_name = lookup(database_encryption.value, "key_name")
    }
  }

  dynamic "enable_k8s_beta_apis" {
    for_each = lookup(var.cluster[count.index], "enable_k8s_beta_apis") == null ? [] : ["enable_k8s_beta_apis"]
    content {
      enabled_apis = lookup(enable_k8s_beta_apis.value, "enabled_apis")
    }
  }

  dynamic "ip_allocation_policy" {
    for_each = lookup(var.cluster[count.index], "ip_allocation_policy") == null ? [] : ["ip_allocation_policy"]
    content {
      cluster_secondary_range_name  = lookup(ip_allocation_policy.value, "cluster_secondary_range_name")
      services_secondary_range_name = lookup(ip_allocation_policy.value, "services_secondary_range_name")
      cluster_ipv4_cidr_block       = lookup(ip_allocation_policy.value, "cluster_ipv4_cidr_block")
      services_ipv4_cidr_block      = lookup(ip_allocation_policy.value, "services_ipv4_cidr_block")
      stack_type                    = lookup(ip_allocation_policy.value, "stack_type")
      dynamic "additional_pod_ranges_config" {
        for_each = lookup(ip_allocation_policy.value, "additional_pod_ranges_config") == null ? [] : ["additional_pod_ranges_config"]
        content {
          pod_range_names = lookup(additional_pod_ranges_config.value, "pod_range_names")
        }
      }
    }
  }

  dynamic "logging_config" {
    for_each = lookup(var.cluster[count.index], "logging_config") == null ? [] : ["logging_config"]
    content {
      enable_components = lookup(logging_config.value, "enable_components")
    }
  }

  dynamic "maintenance_policy" {
    for_each = lookup(var.cluster[count.index], "maintenance_policy") == null ? [] : ["maintenance_policy"]
    content {
      dynamic "daily_maintenance_window" {
        for_each = lookup(maintenance_policy.value, "daily_maintenance_window") == null ? [] : ["daily_maintenance_window"]
        content {
          start_time = lookup(daily_maintenance_window.value, "start_time")
        }
      }
      dynamic "recurring_window" {
        for_each = lookup(maintenance_policy.value, "recurring_window") == null ? [] : ["recurring_window"]
        content {
          end_time   = lookup(recurring_window.value, "end_time")
          recurrence = lookup(recurring_window.value, "recurrence")
          start_time = lookup(recurring_window.value, "start_time")
        }
      }
      dynamic "maintenance_exclusion" {
        for_each = lookup(maintenance_policy.value, "maintenance_exclusion") == null ? [] : ["maintenance_exclusion"]
        content {
          end_time       = lookup(maintenance_exclusion.value, "end_time")
          exclusion_name = lookup(maintenance_exclusion.value, "exclusion_time")
          start_time     = lookup(maintenance_exclusion.value, "start_time")
          dynamic "exclusion_options" {
            for_each = lookup(maintenance_exclusion.value, "exclusion_options") == null ? [] : ["exclusion_options"]
            content {
              scope = lookup(exclusion_options.value, "scope")
            }
          }
        }
      }
    }
  }

  dynamic "master_auth" {
    for_each = lookup(var.cluster[count.index], "mast_auth") == null ? [] : ["master_auth"]
    content {
      client_certificate_config {
        issue_client_certificate = true
      }
    }
  }

  dynamic "master_authorized_networks_config" {
    for_each = lookup(var.cluster[count.index], "master_authorized_networks_config") == null ? [] : ["master_authorized_networks_config"]
    content {
      cidr_blocks {
        cidr_block   = lookup(master_authorized_networks_config.value, "cidr_block")
        display_name = lookup(master_authorized_networks_config.value, "display_name")
      }
      gcp_public_cidrs_access_enabled = lookup(master_authorized_networks_config.value, "gcp_public_cidrs_access_enabled")
    }
  }

  dynamic "monitoring_config" {
    for_each = lookup(var.cluster[count.index], "monitoring_config")
    content {
      enable_components = lookup(monitoring_config.value, "enable_components")
      dynamic "managed_prometheus" {
        for_each = lookup(monitoring_config.value, "managed_prometheus") == null ? [] : ["managed_prometheus"]
        content {
          enabled = lookup(managed_prometheus.value, "enabled")
        }
      }
      dynamic "advanced_datapath_observability_config" {
        for_each = lookup(monitoring_config.value, "advanced_datapath_observability_config") == null ? [] : ["advanced_datapath_observability_config"]
        content {
          enable_metrics = lookup(advanced_datapath_observability_config.value, "enable_metrics")
          relay_mode     = lookup(advanced_datapath_observability_config.value, "relay_mode")
          enable_relay   = lookup(advanced_datapath_observability_config.value, "enable_relay")
        }
      }
    }
  }

  dynamic "network_policy" {
    for_each = lookup(var.cluster[count.index], "network_policy") == null ? [] : ["network_policy"]
    content {
      enabled  = lookup(network_policy.value, "enabled")
      provider = lookup(network_policy.value, "provider")
    }
  }

  dynamic "node_config" {
    for_each = lookup(var.cluster[count.index], "node_config") == null ? [] : ["node_config"]
    content {
      disk_size_gb                = lookup(node_config.value, "disk_size_gb")
      disk_type                   = lookup(node_config.value, "disk_type")
      enable_confidential_storage = lookup(node_config.value, "enable_confidential_storage")
      logging_variant             = lookup(node_config.value, "logging_variant")
      image_type                  = lookup(node_config.value, "image_type")
      labels                      = merge(
        var.node_labels,
        lookup(node_config.value, "labels")
      )
      resource_labels             = lookup(node_config.value, "resource_labels")
      local_ssd_count             = lookup(node_config.value, "local_ssd_count")
      machine_type                = lookup(node_config.value, "machine_type")
      metadata                    = lookup(node_config.value, "metadata")
      min_cpu_platform            = lookup(node_config.value, "min_cpu_platform")
      oauth_scopes                = lookup(node_config.value, "oauth_scopes")
      preemptible                 = lookup(node_config.value, "preemptible")
      spot                        = lookup(node_config.value, "spot")
      boot_disk_kms_key           = lookup(node_config.value, "boot_disk_kms_key")
      service_account             = lookup(node_config.value, "service_account")
      tags                        = lookup(node_config.value, "tags")
      node_group                  = lookup(node_config.value, "node_group")

      dynamic "ephemeral_storage_config" {
        for_each = lookup(node_config.value, "ephemeral_storage_config") == null ? [] : ["ephemeral_storage_config"]
        content {
          local_ssd_count = lookup(ephemeral_storage_config.value, "local_ssd_count")
        }
      }
      dynamic "ephemeral_storage_local_ssd_config" {
        for_each = lookup(node_config.value, "ephemeral_storage_local_ssd_config") == null ? [] : ["ephemeral_storage_local_ssd_config"]
        content {
          local_ssd_count = lookup(ephemeral_storage_local_ssd_config.value, "local_ssd_count")
        }
      }
      dynamic "fast_socket" {
        for_each = lookup(node_config.value, "fast_socket") == null ? [] : ["fast_socket"]
        content {
          enabled = lookup(fast_socket.value, "enabled")
        }
      }
      dynamic "local_nvme_ssd_block_config" {
        for_each = lookup(node_config.value, "local_nvme_ssd_block_config") == null ? [] : ["local_nvme_ssd_block_config"]
        content {
          local_ssd_count = lookup(local_nvme_ssd_block_config.value, "local_ssd_count")
        }
      }

      dynamic "gcfs_config" {
        for_each = lookup(node_config.value, "gcfs_config") == null ? [] : ["gcfs_config"]
        content {
          enabled = lookup(gcfs_config.value, "enabled")
        }
      }
      dynamic "gvnic" {
        for_each = lookup(node_config.value, "gvnic") == null ? [] : ["gvnic"]
        content {
          enabled = lookup(gvnic.value, "enabled")
        }
      }
      dynamic "guest_accelerator" {
        for_each = lookup(node_config.value, "guest_accelerator") == null ? [] : ["guest_accelerator"]
        content {
          type  = lookup(guest_accelerator.value, "type")
          count = lookup(guest_accelerator.value, "count")
        }
      }

      dynamic "reservation_affinity" {
        for_each = lookup(node_config.value, "reservation_affinity") == null ? [] : ["reservation_affinity"]
        content {
          consume_reservation_type = lookup(reservation_affinity.value, "consume_reservation_type")
          key                      = lookup(reservation_affinity.value, "key")
          values                   = lookup(reservation_affinity.value, "values")
        }
      }

      dynamic "sandbox_config" {
        for_each = lookup(node_config.value, "sandbox_config") == null ? [] : ["sandbox_config"]
        content {
          sandbox_type = lookup(sandbox_config.value, "sandbox_type")
        }
      }

      dynamic "shielded_instance_config" {
        for_each = lookup(node_config.value, "shielded_instance_config") == null ? [] : ["shielded_instance_config"]
        content {
          enable_secure_boot          = lookup(shielded_instance_config.value, "enable_secure_boot")
          enable_integrity_monitoring = lookup(shielded_instance_config.value, "enable_integrity_monitoring")
        }
      }

      dynamic "taint" {
        for_each = lookup(node_config.value, "taint") == null ? [] : ["taint"]
        content {
          effect = lookup(taint.value, "effect")
          key    = lookup(taint.value, "key")
          value  = lookup(taint.value, "value")
        }
      }
      dynamic "workload_metadata_config" {
        for_each = lookup(node_config.value, "workload_metadata_config") == null ? [] : ["workload_metadata_config"]
        content {
          mode = lookup(workload_metadata_config.value, "mode")
        }
      }
      dynamic "kubelet_config" {
        for_each = lookup(node_config.value, "kubelet_config") == null ? [] : ["kubelet_config"]
        content {
          cpu_manager_policy   = lookup(kubelet_config.value, "cpu_manager_policy")
          cpu_cfs_quota        = lookup(kubelet_config.value, "cpu_cfs_quota")
          cpu_cfs_quota_period = lookup(kubelet_config.value, "cpu_cfs_quota_period")
          pod_pids_limit       = lookup(kubelet_config.value, "pod_pids_limit")
        }
      }
      dynamic "linux_node_config" {
        for_each = lookup(node_config.value, "linux_node_config") == null ? [] : ["linux_node_config"]
        content {
          sysctls     = lookup(linux_node_config.value, "sysctls")
          cgroup_mode = lookup(linux_node_config.value, "cgroup_mode")
        }
      }

      dynamic "sole_tenant_config" {
        for_each = lookup(node_config.value, "sole_tenant_config") == null ? [] : ["sole_tenant_config"]
        content {
          node_affinity {
            key      = lookup(sole_tenant_config.value, "key")
            operator = lookup(sole_tenant_config.value, "operator")
            values   = lookup(sole_tenant_config.value, "values")
          }
        }
      }
      dynamic "advanced_machine_features" {
        for_each = lookup(node_config.value, "advanced_machine_features") == null ? [] : ["advanced_machine_features"]
        content {
          threads_per_core = lookup(advanced_machine_features.value, "threads_per_core")
          network_performance_config {
            total_egress_bandwidth_tier = lookup(advanced_machine_features.value, "total_egress_bandwidth_tier")
          }
        }
      }
    }
  }

  dynamic "node_pool_auto_config" {
    for_each = lookup(var.cluster[count.index], "node_pool_auto_config") == null ? [] : ["node_pool_auto_config"]
    content {
      network_tags {
        tags = lookup(node_pool_auto_config.value, "tags")
      }
    }
  }

  dynamic "node_pool_defaults" {
    for_each = lookup(var.cluster[count.index], "node_pool_defaults") == null ? [] : ["node_pool_defaults"]
    content {
      node_config_defaults {
        logging_variant = lookup(node_pool_defaults.value, "logging_variants")
        gcfs_config {
          enabled = lookup(node_pool_defaults.value, "gcfs_config")
        }
      }
    }
  }

  dynamic "notification_config" {
    for_each = lookup(var.cluster[count.index], "notification_config") == null ? [] : ["notification_config"]
    content {
      pubsub {
        enabled = lookup(notification_config.value, "enabled")
        topic   = lookup(notification_config.value, "topic")
        filter {
          event_type = lookup(notification_config.value, "event_type")
        }
      }
    }
  }

  dynamic "confidential_nodes" {
    for_each = lookup(var.cluster[count.index], "confidential_nodes") == null ? [] : ["confidential_nodes"]
    content {
      enabled = lookup(confidential_nodes.value, "enabled")
    }
  }

  dynamic "pod_security_policy_config" {
    for_each = lookup(var.cluster[count.index], "pod_security_policy_config") == null ? [] : ["pod_security_policy_config"]
    content {
      enabled = lookup(pod_security_policy_config.value, "enabled")
    }
  }

  dynamic "authenticator_groups_config" {
    for_each = lookup(var.cluster[count.index], "authenticator_groups_config") == null ? [] : ["authenticator_groups_config"]
    content {
      security_group = lookup(authenticator_groups_config.value, "security_group")
    }
  }

  dynamic "private_cluster_config" {
    for_each = lookup(var.cluster[count.index], "private_cluster_config") == null ? [] : ["private_cluster_config"]
    content {
      enable_private_endpoint = lookup(private_cluster_config.value, "enable_private_endpoint")
      enable_private_nodes    = lookup(private_cluster_config.value, "enable_private_nodes")
      master_ipv4_cidr_block  = lookup(private_cluster_config.value, "master_ipv4_cidr_block")
      master_global_access_config {
        enabled = lookup(private_cluster_config.value, "master_global_access")
      }
    }
  }

  dynamic "cluster_telemetry" {
    for_each = lookup(var.cluster[count.index], "cluster_telemetry") == null ? [] : ["cluster_telemetry"]
    content {
      type = lookup(cluster_telemetry.value, "type")
    }
  }

  dynamic "release_channel" {
    for_each = lookup(var.cluster[count.index], "release_channel") == null ? [] : ["release_channel"]
    content {
      channel = lookup(release_channel.value, "channel")
    }
  }

  dynamic "cost_management_config" {
    for_each = lookup(var.cluster[count.index], "cost_management_config") == null ? [] : ["cost_management_config"]
    content {
      enabled = lookup(cost_management_config.value, "enabled")
    }
  }

  dynamic "resource_usage_export_config" {
    for_each = lookup(var.cluster[count.index], "resource_usage_export_config") == null ? [] : ["resource_usage_export_config"]
    content {
      enable_network_egress_metering       = lookup(resource_usage_export_config.value, "enable_network_egress_metering")
      enable_resource_consumption_metering = lookup(resource_usage_export_config.value, "enable_resource_consumption_metering")
      bigquery_destination {
        dataset_id = lookup(resource_usage_export_config.value, "dataset_id")
      }
    }
  }

  dynamic "vertical_pod_autoscaling" {
    for_each = lookup(var.cluster[count.index], "vertical_pod_autoscaling") == null ? [] : ["vertical_pod_autoscaling"]
    content {
      enabled = lookup(vertical_pod_autoscaling.value, "enabled")
    }
  }

  dynamic "workload_identity_config" {
    for_each = lookup(var.cluster[count.index], "workload_identity_config") == null ? [] : ["workload_identity_config"]
    content {
      workload_pool = lookup(workload_identity_config.value, "workload_pool")
    }
  }

  dynamic "identity_service_config" {
    for_each = lookup(var.cluster[count.index], "identity_service_config") == null ? [] : ["identity_service_config"]
    content {
      enabled = lookup(identity_service_config.value, "enabled")
    }
  }

  dynamic "default_snat_status" {
    for_each = lookup(var.cluster[count.index], "default_snat_status") == null ? [] : ["default_snat_status"]
    content {
      disabled = lookup(default_snat_status.value, "disabled")
    }
  }

  dynamic "dns_config" {
    for_each = lookup(var.cluster[count.index], "dns_config") == null ? [] : ["dns_config"]
    content {
      cluster_dns        = lookup(dns_config.value, "cluster_dns")
      cluster_dns_domain = lookup(dns_config.value, "cluster_dns_domain")
      cluster_dns_scope  = lookup(dns_config.value, "cluster_dns_scope")
    }
  }

  dynamic "gateway_api_config" {
    for_each = lookup(var.cluster[count.index], "gateway_api_config") == null ? [] : ["gateway_api_config"]
    content {
      channel = lookup(gateway_api_config.value, "channel")
    }
  }

  dynamic "protect_config" {
    for_each = lookup(var.cluster[count.index], "protect_config") == null ? [] : ["protect_config"]
    content {
      workload_config {
        audit_mode = lookup(protect_config.value, "workload_config_audit_mode")
      }
      workload_vulnerability_mode = lookup(protect_config.value, "workload_vulnerability_mode")
    }
  }

  dynamic "security_posture_config" {
    for_each = lookup(var.cluster[count.index], "security_posture_config") == null ? [] : ["security_posture_config"]
    content {
      mode               = lookup(security_posture_config.value, "mode")
      vulnerability_mode = lookup(security_posture_config.value, "vulnerability_mode")
    }
  }

  dynamic "fleet" {
    for_each = lookup(var.cluster[count.index], "fleet") == null ? [] : ["fleet"]
    content {
      project = lookup(fleet.value, "project")
    }
  }

  dynamic "workload_alts_config" {
    for_each = lookup(var.cluster[count.index], "workload_alts_config") == null ? [] : ["workload_alts_config"]
    content {
      enable_alts = lookup(workload_alts_config.value, "enable_alts")
    }
  }
}