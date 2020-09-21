resource "google_composer_environment" "environment" {
  provider = "google-beta"
  count    = length(var.environment)
  name     = lookup(var.environment[count.index], "name")
  labels   = lookup(var.environment[count.index], "labels")
  region   = lookup(var.environment[count.index], "region")
  project  = var.project

  dynamic "config" {
    for_each = [for i in lookup(var.environment[count.index], "config") : {
      node_count                        = i.node_count
      web_server_network_access_control = lookup(i, "web_server_network_access_control", null)
      node_config                       = lookup(i, "node_config", null)
      software_config                   = lookup(i, "software_config", null)
      private_environment_config        = lookup(i, "private_environment_config", null)
    }]
    content {
      node_count = config.value.node_count
      dynamic "web_server_network_access_control" {
        for_each = config.value.web_server_network_access_control == null ? [] : [for i in config.value.web_server_network_access_control : {
          allowed_ip_range = lookup(i, "allowed_ip_range")
        }]
        content {
          dynamic "allowed_ip_range" {
            for_each = web_server_network_access_control.value.allowed_ip_range == null ? [] : [for i in web_server_network_access_control.value.allowed_ip_range : {
              value       = i.value
              description = i.description
            }]
            content {
              value       = allowed_ip_range.value.value
              description = allowed_ip_range.value.description
            }
          }
        }
      }
      dynamic "node_config" {
        for_each = config.value.node_config == null ? [] : [for i in config.value.node_config : {
          zone                 = i.zone
          machine_type         = i.machine_type
          network              = i.network
          subnetwork           = i.subnetwork
          disk_size_gb         = i.disk_size_gb
          oauth_scopes         = i.oauth_scopes
          service_account      = i.service_account
          tags                 = i.tags
          ip_allocation_policy = lookup(i, "ip_allocation_policy", null)
        }]
        content {
          zone            = node_config.value.zone
          machine_type    = node_config.value.machine_type
          network         = node_config.value.network
          subnetwork      = node_config.value.subnetwork
          disk_size_gb    = node_config.value.disk_size_gb
          oauth_scopes    = node_config.value.oauth_scopes
          service_account = node_config.value.service_account
          tags            = node_config.value.tags
          dynamic "ip_allocation_policy" {
            for_each = node_config.value.ip_allocation_policy == null ? [] : [for i in node_config.value.ip_allocation_policy : {
              use_ip_aliases                = i.use_ip_aliases
              cluster_ipv4_cidr_block       = i.cluster_ipv4_cidr_block
              cluster_secondary_range_name  = i.cluster_secondary_range_name
              services_ipv4_cidr_block      = i.services_ipv4_cidr_block
              services_secondary_range_name = i.services_secondary_range_name
            }]
            content {
              use_ip_aliases                = ip_allocation_policy.value.use_ip_aliases
              cluster_ipv4_cidr_block       = ip_allocation_policy.value.cluster_ipv4_cidr_block
              cluster_secondary_range_name  = ip_allocation_policy.value.cluster_secondary_range_name
              services_ipv4_cidr_block      = ip_allocation_policy.value.services_ipv4_cidr_block
              services_secondary_range_name = ip_allocation_policy.value.services_secondary_range_name
            }
          }
        }
      }
      dynamic "software_config" {
        for_each = config.value.software_config == null ? [] : [for i in config.value.software_config : {
          airflow       = i.airflow_config_overrides
          env_variables = i.env_variables
          image_version = i.image_version
          pypi          = i.pypi_packages
          python        = i.python_version
        }]
        content {
          airflow_config_overrides = software_config.value.airflow
          env_variables            = software_config.value.env_variables
          image_version            = software_config.value.image_version
          pypi_packages            = software_config.value.pypi
          python_version           = software_config.value.python
        }
      }
      dynamic "private_environment_config" {
        for_each = config.value.private_environment_config == null ? [] : [for i in config.value.private_environment_config : {
          enable_private_endpoint    = i.enable_private_endpoint
          master_ipv4_cidr_block     = i.master_ipv4_cidr_block
          cloud_sql_ipv4_cidr_block  = i.cloud_sql_ipv4_cidr_block
          web_server_ipv4_cidr_block = i.web_server_ipv4_cidr_block
        }]
        content {
          enable_private_endpoint    = private_environment_config.value.enable_private_endpoint
          master_ipv4_cidr_block     = private_environment_config.value.master_ipv4_cidr_block
          cloud_sql_ipv4_cidr_block  = private_environment_config.value.cloud_sql_ipv4_cidr_block
          web_server_ipv4_cidr_block = private_environment_config.value.web_server_ipv4_cidr_block
        }
      }
    }
  }
}
