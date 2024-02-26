# GKE - Kubernetes X Google Cloud Platform - Terraform module documentation

## How to use it
```hcl
module "GKE" {
  source = "../../modules/Google/Kubernetes/cluster"
  cluster = [
    {
      id                          = 0
      name                        = "cluster1"
      deletion_protection         = true
      enable_kubernetes_alpha     = false
      enable_shielded_nodes       = true
      enable_copilot              = true
      enable_intranode_visibility = true
      binary_authorization = [
        {
          evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
        }
      ]
      addons_config = [
        {
          http_load_balancing     = true
          network_policy_config   = true
          gke_backup_agent_config = true
        }
      ]
      cluster_autoscaling = [
        {
          enabled = true
          resource_limits = [
            {
              resource_type = "cpu"
              minimum       = 2
              maximum       = 5
            }
          ]
          auto_provisioning_defaults = [
            {
              disk_size  = 50
              image_type = "UBUNTU_CONTAINERD"
            }
          ]
        }
      ]
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.17.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.17.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_container_cluster.this](https://registry.terraform.io/providers/hashicorp/google/5.17.0/docs/resources/container_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster"></a> [cluster](#input\_cluster) | n/a | <pre>list(map(object({<br>    id                          = number<br>    name                        = string<br>    location                    = optional(string)<br>    node_locations              = optional(list(string))<br>    deletion_protection         = optional(bool)<br>    allow_net_admin             = optional(bool)<br>    cluster_ipv4_cidr           = optional(string)<br>    description                 = optional(string)<br>    default_max_pods_per_node   = optional(number)<br>    enable_kubernetes_alpha     = optional(bool)<br>    enable_tpu                  = optional(bool)<br>    enable_legacy_abac          = optional(bool)<br>    enable_shielded_nodes       = optional(bool)<br>    enable_autopilot            = optional(bool)<br>    initial_node_count          = optional(number)<br>    networking_mode             = optional(string)<br>    min_master_version          = optional(string)<br>    monitoring_service          = optional(string)<br>    network                     = optional(string)<br>    node_version                = optional(string)<br>    project                     = optional(string)<br>    remove_default_node_pool    = optional(bool)<br>    resource_labels             = optional(map(string))<br>    subnetwork                  = optional(string)<br>    enable_intranode_visibility = optional(bool)<br>    enable_l4_ilb_subsetting    = optional(bool)<br>    enable_multi_networking     = optional(bool)<br>    enable_fqdn_network_policy  = optional(bool)<br>    private_ipv6_google_access  = optional(string)<br>    datapath_provider           = optional(string)<br>    addons_config = optional(list(object({<br>      horizontal_pod_autoscaling            = optional(bool)<br>      http_load_balancing                   = optional(bool)<br>      network_policy_config                 = optional(bool)<br>      gcp_filestore_csi_driver_config       = optional(bool)<br>      cloudrun_config                       = optional(bool)<br>      load_balancer_type                    = optional(string)<br>      istio_config                          = optional(bool)<br>      auth                                  = optional(bool)<br>      dns_cache_config                      = optional(bool)<br>      gce_persistent_disk_csi_driver_config = optional(bool)<br>      gke_backup_agent_config               = optional(bool)<br>      kalm_config                           = optional(bool)<br>      config_connector_config               = optional(bool)<br>    })), [])<br>    cluster_autoscaling = optional(list(object({<br>      enabled             = bool<br>      autoscaling_profile = optional(string)<br>      resource_limits = optional(list(object({<br>        resource_type = optional(string)<br>        minimum       = optional(number)<br>        maximum       = optional(number)<br>      })), [])<br>      auto_provisioning_defaults = optional(list(object({<br>        min_cpu_platform  = ""<br>        oauth_scopes      = []<br>        service_account   = ""<br>        boot_disk_kms_key = ""<br>        disk_size         = 0<br>        disk_type         = ""<br>        image_type        = ""<br>        shielded_instance_config = optional(list(object({<br>          enable_secure_boot          = true<br>          enable_integrity_monitoring = true<br>        })))<br>        management = optional(list(object({<br>          auto_repair  = true<br>          auto_upgrade = true<br>        })), [])<br>        upgrade_settings = optional(list(object({<br>          strategy        = ""<br>          max_surge       = 0<br>          max_unavailable = 0<br>          blue_green_settings = optional(list(object({<br>            node_pool_soak_duration = optional(string)<br>            standard_rollout_policy = optional(list(object({<br>              batch_percentage    = 0<br>              batch_node_count    = 0<br>              batch_soak_duration = ""<br>            })), [])<br>          })), [])<br>        })), [])<br>      })), [])<br>    })), [])<br>    service_external_ips_config = optional(list(object({<br>      enabled = bool<br>    })))<br>    mesh_certificates = optional(list(object({<br>      enable_certificates = optional(bool)<br>    })), [])<br>    database_encryption = optional(list(object({<br>      state    = string<br>      key_name = optional(string)<br>    })), [])<br>    enable_k8s_beta_apis = optional(list(object({<br>      enabled_apis = list(string)<br>    })), [])<br>    ip_allocation_policy = optional(list(object({<br>      cluster_secondary_range_name  = string<br>      services_secondary_range_name = optional(string)<br>      cluster_ipv4_cidr_block       = optional(string)<br>      services_ipv4_cidr_block      = optional(string)<br>      stack_type                    = optional(string)<br>      additional_pod_ranges_config = optional(list(object({<br>        pod_range_names = optional(list(string))<br>      })), [])<br>    })), [])<br>    logging_config = optional(list(object({<br>      enable_components = list(string)<br>    })), [])<br>    maintenance_policy = optional(list(object({<br>      daily_maintenance_window = optional(list(object({<br>        start_time = string<br>      })), [])<br>      recurring_window = optional(list(object({<br>        end_time   = string<br>        recurrence = string<br>        start_time = string<br>      })), [])<br>      maintenance_exclusion = optional(list(object({<br>        end_time       = string<br>        exclusion_name = string<br>        start_time     = string<br>        exclusion_options = optional(list(object({<br>          scope = optional(string)<br>        })), [])<br>      })), [])<br>    })), [])<br>    master_auth = optional(list(object({<br>      issue_client_certificate = bool<br>    })), [])<br>    master_authorized_networks_config = optional(list(object({<br>      cidr_block                      = string<br>      display_name                    = optional(string)<br>      gcp_public_cidrs_access_enabled = bool<br>    })), [])<br>    monitoring_config = optional(list(object({<br>      enable_components = list(string)<br>      managed_prometheus = optional(list(object({<br>        enabled = bool<br>      })), [])<br>      advanced_datapath_observability_config = optional(list(object({<br>        enable_metrics = optional(bool)<br>        relay_mode     = optional(string)<br>        enable_relay   = optional(bool)<br>      })), [])<br>    })), [])<br>    network_policy = optional(list(object({<br>      enabled  = bool<br>      provider = optional(string)<br>    })), [])<br>    node_config = optional(list(object({<br>      disk_size_gb                = optional(number)<br>      disk_type                   = optional(string)<br>      enable_confidential_storage = optional(bool)<br>      logging_variant             = optional(string)<br>      image_type                  = optional(string)<br>      labels                      = optional(map(string))<br>      resource_labels             = optional(map(string))<br>      local_ssd_count             = optional(number)<br>      machine_type                = optional(string)<br>      metadata                    = optional(map(string))<br>      min_cpu_platform            = optional(string)<br>      oauth_scopes                = optional(list(string))<br>      preemptible                 = optional(bool)<br>      spot                        = optional(bool)<br>      boot_disk_kms_key           = optional(string)<br>      service_account             = optional(string)<br>      tags                        = optional(list(string))<br>      node_group                  = optional(string)<br>      ephemeral_storage_config = optional(list(object({<br>        local_ssd_count = number<br>      })), [])<br>      ephemeral_storage_local_ssd_config = optional(list(object({<br>        local_ssd_count = number<br>      })), [])<br>      fast_socket = optional(list(object({<br>        enabled = bool<br>      })), [])<br>      local_nvme_ssd_block_config = optional(list(object({<br>        local_ssd_count = number<br>      })), [])<br>      gcfs_config = optional(list(object({<br>        enabled = bool<br>      })), [])<br>      gvnic = optional(list(object({<br>        enabled = bool<br>      })), [])<br>      guest_accelerator = optional(list(object({<br>        type  = optional(string)<br>        count = optional(number)<br>      })), [])<br>      reservation_affinity = optional(list(object({<br>        consume_reservation_type = string<br>        key                      = optional(string)<br>        values                   = optional(list(string))<br>      })), [])<br>      sandbox_config = optional(list(object({<br>        sandbox_type = string<br>      })), [])<br>      shielded_instance_config = optional(list(object({<br>        enable_secure_boot          = optional(bool)<br>        enable_integrity_monitoring = optional(bool)<br>      })), [])<br>      taint = optional(list(object({<br>        effect = string<br>        key    = string<br>        value  = string<br>      })), [])<br>      workload_metadata_config = optional(list(object({<br>        mode = string<br>      })), [])<br>      kubelet_config = optional(list(object({<br>        cpu_manager_policy   = string<br>        cpu_cfs_quota        = optional(number)<br>        cpu_cfs_quota_period = optional(string)<br>        pod_pids_limit       = optional(number)<br>      })), [])<br>      linux_node_config = optional(list(object({<br>        sysctls     = optional(map(string))<br>        cgroup_mode = optional(string)<br>      })), [])<br>      sole_tenant_config = optional(list(object({<br>        key      = optional(string)<br>        operator = optional(string)<br>        values   = optional(list(string))<br>      })), [])<br>      advanced_machine_features = optional(list(object({<br>        threads_per_core            = number<br>        total_egress_bandwidth_tier = optional(number)<br>      })), [])<br>    })), [])<br>    node_pool_auto_config = optional(list(object({<br>      tags = optional(list(string))<br>    })), [])<br>    node_pool_defaults = optional(list(object({<br>      logging_variant = optional(string)<br>      gcfs_config     = optional(bool)<br>    })), [])<br>    notification_config = optional(list(object({<br>      enabled    = optional(bool)<br>      topic      = optional(string)<br>      event_type = optional(string)<br>    })), [])<br>    confidential_nodes = optional(list(object({<br>      enabled = bool<br>    })), [])<br>    pod_security_policy_config = optional(list(object({<br>      enabled = optional(bool)<br>    })), [])<br>    authenticator_groups_config = optional(list(object({<br>      security_group = optional(string)<br>    })), [])<br>    private_cluster_config = optional(list(object({<br>      enable_private_endpoint = optional(bool)<br>      enable_private_nodes    = optional(bool)<br>      master_ipv4_cidr_block  = optional(string)<br>      master_global_access    = optional(bool)<br>    })), [])<br>    cluster_telemetry = optional(list(object({<br>      type = string<br>    })), [])<br>    release_channel = optional(list(object({<br>      channel = string<br>    })), [])<br>    cost_management_config = optional(list(object({<br>      enabled = bool<br>    })), [])<br>    resource_usage_export_config = optional(list(object({<br>      enable_network_egress_metering       = optional(bool)<br>      enable_resource_consumption_metering = optional(bool)<br>      bigquery_dataset_id                  = optional(string)<br>    })), [])<br>    vertical_pod_autoscaling = optional(list(object({<br>      enabled = optional(bool)<br>    })), [])<br>    workload_identity_config = optional(list(object({<br>      workload_pool = optional(string)<br>    })), [])<br>    identity_service_config = optional(list(object({<br>      enabled = optional(bool)<br>    })), [])<br>    default_snat_status = optional(list(object({<br>      disabled = bool<br>    })), [])<br>    dns_config = optional(list(object({<br>      cluster_dns        = optional(string)<br>      cluster_dns_domain = optional(string)<br>      cluster_dns_scope  = optional(string)<br>    })), [])<br>    gateway_api_config      = optional(list(object({<br>      channel = string<br>    })), [])<br>    protect_config          = optional(list(object({<br>      workload_config_audit_mode = optional(string)<br>      workload_vulnerability_mode = optional(string)<br>    })), [])<br>    security_posture_config = optional(list(object({<br>      mode = optional(string)<br>      vulnerability_mode = optional(string)<br>    })), [])<br>    fleet                   = optional(list(object({<br>      project = optional(string)<br>    })), [])<br>    workload_alts_config    = optional(list(object({<br>      enable_alts = optional(bool)<br>    })), [])<br>    binary_authorization = optional(list(object({<br>      enabled         = optional(bool)<br>      evaluation_mode = optional(string)<br>    })), [])<br>  })), [])</pre> | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | `{}` | no |
| <a name="input_node_labels"></a> [node\_labels](#input\_node\_labels) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_k8s_cluster_id"></a> [k8s\_cluster\_id](#output\_k8s\_cluster\_id) | n/a |
| <a name="output_k8s_cluster_name"></a> [k8s\_cluster\_name](#output\_k8s\_cluster\_name) | n/a |
