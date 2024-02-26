variable "labels" {
  type    = map(string)
  default = {}
}

variable "node_labels" {
  type = map(string)
  default = {}
}

variable "cluster" {
  type = list(map(object({
    id                          = number
    name                        = string
    location                    = optional(string)
    node_locations              = optional(list(string))
    deletion_protection         = optional(bool)
    allow_net_admin             = optional(bool)
    cluster_ipv4_cidr           = optional(string)
    description                 = optional(string)
    default_max_pods_per_node   = optional(number)
    enable_kubernetes_alpha     = optional(bool)
    enable_tpu                  = optional(bool)
    enable_legacy_abac          = optional(bool)
    enable_shielded_nodes       = optional(bool)
    enable_autopilot            = optional(bool)
    initial_node_count          = optional(number)
    networking_mode             = optional(string)
    min_master_version          = optional(string)
    monitoring_service          = optional(string)
    network                     = optional(string)
    node_version                = optional(string)
    project                     = optional(string)
    remove_default_node_pool    = optional(bool)
    resource_labels             = optional(map(string))
    subnetwork                  = optional(string)
    enable_intranode_visibility = optional(bool)
    enable_l4_ilb_subsetting    = optional(bool)
    enable_multi_networking     = optional(bool)
    enable_fqdn_network_policy  = optional(bool)
    private_ipv6_google_access  = optional(string)
    datapath_provider           = optional(string)
    addons_config = optional(list(object({
      horizontal_pod_autoscaling            = optional(bool)
      http_load_balancing                   = optional(bool)
      network_policy_config                 = optional(bool)
      gcp_filestore_csi_driver_config       = optional(bool)
      cloudrun_config                       = optional(bool)
      load_balancer_type                    = optional(string)
      istio_config                          = optional(bool)
      auth                                  = optional(bool)
      dns_cache_config                      = optional(bool)
      gce_persistent_disk_csi_driver_config = optional(bool)
      gke_backup_agent_config               = optional(bool)
      kalm_config                           = optional(bool)
      config_connector_config               = optional(bool)
    })), [])
    cluster_autoscaling = optional(list(object({
      enabled             = bool
      autoscaling_profile = optional(string)
      resource_limits = optional(list(object({
        resource_type = optional(string)
        minimum       = optional(number)
        maximum       = optional(number)
      })), [])
      auto_provisioning_defaults = optional(list(object({
        min_cpu_platform  = ""
        oauth_scopes      = []
        service_account   = ""
        boot_disk_kms_key = ""
        disk_size         = 0
        disk_type         = ""
        image_type        = ""
        shielded_instance_config = optional(list(object({
          enable_secure_boot          = true
          enable_integrity_monitoring = true
        })))
        management = optional(list(object({
          auto_repair  = true
          auto_upgrade = true
        })), [])
        upgrade_settings = optional(list(object({
          strategy        = ""
          max_surge       = 0
          max_unavailable = 0
          blue_green_settings = optional(list(object({
            node_pool_soak_duration = optional(string)
            standard_rollout_policy = optional(list(object({
              batch_percentage    = 0
              batch_node_count    = 0
              batch_soak_duration = ""
            })), [])
          })), [])
        })), [])
      })), [])
    })), [])
    service_external_ips_config = optional(list(object({
      enabled = bool
    })))
    mesh_certificates = optional(list(object({
      enable_certificates = optional(bool)
    })), [])
    database_encryption = optional(list(object({
      state    = string
      key_name = optional(string)
    })), [])
    enable_k8s_beta_apis = optional(list(object({
      enabled_apis = list(string)
    })), [])
    ip_allocation_policy = optional(list(object({
      cluster_secondary_range_name  = string
      services_secondary_range_name = optional(string)
      cluster_ipv4_cidr_block       = optional(string)
      services_ipv4_cidr_block      = optional(string)
      stack_type                    = optional(string)
      additional_pod_ranges_config = optional(list(object({
        pod_range_names = optional(list(string))
      })), [])
    })), [])
    logging_config = optional(list(object({
      enable_components = list(string)
    })), [])
    maintenance_policy = optional(list(object({
      daily_maintenance_window = optional(list(object({
        start_time = string
      })), [])
      recurring_window = optional(list(object({
        end_time   = string
        recurrence = string
        start_time = string
      })), [])
      maintenance_exclusion = optional(list(object({
        end_time       = string
        exclusion_name = string
        start_time     = string
        exclusion_options = optional(list(object({
          scope = optional(string)
        })), [])
      })), [])
    })), [])
    master_auth = optional(list(object({
      issue_client_certificate = bool
    })), [])
    master_authorized_networks_config = optional(list(object({
      cidr_block                      = string
      display_name                    = optional(string)
      gcp_public_cidrs_access_enabled = bool
    })), [])
    monitoring_config = optional(list(object({
      enable_components = list(string)
      managed_prometheus = optional(list(object({
        enabled = bool
      })), [])
      advanced_datapath_observability_config = optional(list(object({
        enable_metrics = optional(bool)
        relay_mode     = optional(string)
        enable_relay   = optional(bool)
      })), [])
    })), [])
    network_policy = optional(list(object({
      enabled  = bool
      provider = optional(string)
    })), [])
    node_config = optional(list(object({
      disk_size_gb                = optional(number)
      disk_type                   = optional(string)
      enable_confidential_storage = optional(bool)
      logging_variant             = optional(string)
      image_type                  = optional(string)
      labels                      = optional(map(string))
      resource_labels             = optional(map(string))
      local_ssd_count             = optional(number)
      machine_type                = optional(string)
      metadata                    = optional(map(string))
      min_cpu_platform            = optional(string)
      oauth_scopes                = optional(list(string))
      preemptible                 = optional(bool)
      spot                        = optional(bool)
      boot_disk_kms_key           = optional(string)
      service_account             = optional(string)
      tags                        = optional(list(string))
      node_group                  = optional(string)
      ephemeral_storage_config = optional(list(object({
        local_ssd_count = number
      })), [])
      ephemeral_storage_local_ssd_config = optional(list(object({
        local_ssd_count = number
      })), [])
      fast_socket = optional(list(object({
        enabled = bool
      })), [])
      local_nvme_ssd_block_config = optional(list(object({
        local_ssd_count = number
      })), [])
      gcfs_config = optional(list(object({
        enabled = bool
      })), [])
      gvnic = optional(list(object({
        enabled = bool
      })), [])
      guest_accelerator = optional(list(object({
        type  = optional(string)
        count = optional(number)
      })), [])
      reservation_affinity = optional(list(object({
        consume_reservation_type = string
        key                      = optional(string)
        values                   = optional(list(string))
      })), [])
      sandbox_config = optional(list(object({
        sandbox_type = string
      })), [])
      shielded_instance_config = optional(list(object({
        enable_secure_boot          = optional(bool)
        enable_integrity_monitoring = optional(bool)
      })), [])
      taint = optional(list(object({
        effect = string
        key    = string
        value  = string
      })), [])
      workload_metadata_config = optional(list(object({
        mode = string
      })), [])
      kubelet_config = optional(list(object({
        cpu_manager_policy   = string
        cpu_cfs_quota        = optional(number)
        cpu_cfs_quota_period = optional(string)
        pod_pids_limit       = optional(number)
      })), [])
      linux_node_config = optional(list(object({
        sysctls     = optional(map(string))
        cgroup_mode = optional(string)
      })), [])
      sole_tenant_config = optional(list(object({
        key      = optional(string)
        operator = optional(string)
        values   = optional(list(string))
      })), [])
      advanced_machine_features = optional(list(object({
        threads_per_core            = number
        total_egress_bandwidth_tier = optional(number)
      })), [])
    })), [])
    node_pool_auto_config = optional(list(object({
      tags = optional(list(string))
    })), [])
    node_pool_defaults = optional(list(object({
      logging_variant = optional(string)
      gcfs_config     = optional(bool)
    })), [])
    notification_config = optional(list(object({
      enabled    = optional(bool)
      topic      = optional(string)
      event_type = optional(string)
    })), [])
    confidential_nodes = optional(list(object({
      enabled = bool
    })), [])
    pod_security_policy_config = optional(list(object({
      enabled = optional(bool)
    })), [])
    authenticator_groups_config = optional(list(object({
      security_group = optional(string)
    })), [])
    private_cluster_config = optional(list(object({
      enable_private_endpoint = optional(bool)
      enable_private_nodes    = optional(bool)
      master_ipv4_cidr_block  = optional(string)
      master_global_access    = optional(bool)
    })), [])
    cluster_telemetry = optional(list(object({
      type = string
    })), [])
    release_channel = optional(list(object({
      channel = string
    })), [])
    cost_management_config = optional(list(object({
      enabled = bool
    })), [])
    resource_usage_export_config = optional(list(object({
      enable_network_egress_metering       = optional(bool)
      enable_resource_consumption_metering = optional(bool)
      bigquery_dataset_id                  = optional(string)
    })), [])
    vertical_pod_autoscaling = optional(list(object({
      enabled = optional(bool)
    })), [])
    workload_identity_config = optional(list(object({
      workload_pool = optional(string)
    })), [])
    identity_service_config = optional(list(object({
      enabled = optional(bool)
    })), [])
    default_snat_status = optional(list(object({
      disabled = bool
    })), [])
    dns_config = optional(list(object({
      cluster_dns        = optional(string)
      cluster_dns_domain = optional(string)
      cluster_dns_scope  = optional(string)
    })), [])
    gateway_api_config      = optional(list(object({
      channel = string
    })), [])
    protect_config          = optional(list(object({
      workload_config_audit_mode = optional(string)
      workload_vulnerability_mode = optional(string)
    })), [])
    security_posture_config = optional(list(object({
      mode = optional(string)
      vulnerability_mode = optional(string)
    })), [])
    fleet                   = optional(list(object({
      project = optional(string)
    })), [])
    workload_alts_config    = optional(list(object({
      enable_alts = optional(bool)
    })), [])
    binary_authorization = optional(list(object({
      enabled         = optional(bool)
      evaluation_mode = optional(string)
    })), [])
  })), [])
  default = []
}