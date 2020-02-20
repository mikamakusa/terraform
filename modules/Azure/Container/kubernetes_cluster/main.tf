resource "azurerm_kubernetes_cluster" "kubnernetes_cluster" {
  count                           = length(var.kubernetes_cluster)
  dns_prefix                      = lookup(var.kubernetes_cluster[count.index], "dns_prefix")
  location                        = lookup(var.kubernetes_cluster[count.index], "resource_group_id") == null ? var.resource_group_location : element(var.resource_group_location, lookup(var.kubernetes_cluster[count.index], "resource_group_id"))
  name                            = lookup(var.kubernetes_cluster[count.index], "name")
  resource_group_name             = lookup(var.kubernetes_cluster[count.index], "resource_group_id") == null ? var.resource_group_name : element(var.resource_group_name, lookup(var.kubernetes_cluster[count.index], "resource_group_id"))
  api_server_authorized_ip_ranges = [lookup(var.kubernetes_cluster[count.index], "api_server_authorized_ip_ranges")]
  node_resource_group             = lookup(var.kubernetes_cluster[count.index], "node_resource_group_id") == null ? var.resource_group_name : element(var.resource_group_name, lookup(var.kubernetes_cluster[count.index], "node_resource_group_id"))
  kubernetes_version              = lookup(var.kubernetes_cluster[count.index], "kubernetes_version")

  dynamic "agent_pool_profile" {
    for_each = lookup(var.kubernetes_cluster[count.index], "agent_pool_profile")
    content {
      name                = lookup(agent_pool_profile.value, "name")
      vm_size             = lookup(agent_pool_profile.value, "vm_size")
      node_taints         = [lookup(agent_pool_profile.value, "node_taints")]
      availability_zones  = [lookup(agent_pool_profile.value, "availability_zones")]
      count               = lookup(agent_pool_profile.value, "count")
      enable_auto_scaling = lookup(agent_pool_profile.value, "enable_auto_scaling")
      os_disk_size_gb     = lookup(agent_pool_profile.value, "os_disk_size_gb")
      os_type             = lookup(agent_pool_profile.value, "os_type")
      max_count           = lookup(agent_pool_profile.value, "max_count")
      max_pods            = lookup(agent_pool_profile.value, "max_pods")
      min_count           = lookup(agent_pool_profile.value, "min_count")
      type                = lookup(agent_pool_profile.value, "type")
      vnet_subnet_id      = lookup(agent_pool_profile.value, "vnet_subnet_id")
    }
  }

  dynamic "addon_profile" {
    for_each = [for i in lookup(var.kubernetes_cluster[count.index], "addon_profile") : {
      aci       = lookup(i, "aci_connector_linux")
      http      = lookup(i, "http_application_routing")
      dashboard = lookup(i, "kube_dashboard")
      oms       = lookup(i, "oms_agent")
    }]
    content {
      dynamic "aci_connector_linux" {
        for_each = [for i in addon_profile.value.aci : {
          enabled     = i.enabled
          subnet_name = i.subnet_name
        }]
        content {
          enabled     = aci_connector_linux.value.enabled
          subnet_name = aci_connector_linux.value.subnet_name
        }
      }
      dynamic "http_application_routing" {
        for_each = [for i in addon_profile.value.http : {
          enabled = i.enabled
        }]
        content {
          enabled = http_application_routing.value.enabled
        }
      }
      dynamic "kube_dashboard" {
        for_each = [for i in addon_profile.value.dashboard : {
          enabled = i.enabled
        }]
        content {
          enabled = kube_dashboard.value.enabled
        }
      }
      dynamic "oms_agent" {
        for_each = [for i in addon_profile.value.oms : {
          enabled = i.enabled
          log     = i.log_analytics_workspace_id
        }]
        content {
          enabled                    = oms_agent.value.enabled
          log_analytics_workspace_id = oms_agent.value.log
        }
      }
    }
  }

  dynamic "service_principal" {
    for_each = lookup(var.kubernetes_cluster[count.index], "service_principal")
    content {
      client_id     = lookup(service_principal.value, "client_id")
      client_secret = lookup(service_principal.value, "client_secret")
    }
  }

  dynamic "role_based_access_control" {
    for_each = [for i in lookup(var.kubernetes_cluster[count.index], "role_based_access_control") : {
      azure_active_directory = lookup(i, "azure_active_directory")
    }]
    content {
      enabled = lookup(role_based_access_control.value, "enabled")
      dynamic "azure_active_directory" {
        for_each = role_based_access_control.value.azure_active_directory == null ? [] : [for i in role_based_access_control.value.azure_active_directory : {
          client_app_id     = i.client_app_id
          server_app_id     = i.server_app_id
          server_app_secret = i.server_app_secret
        }]
        content {
          client_app_id     = azure_active_directory.value.client_app_id
          server_app_id     = azure_active_directory.value.server_app_id
          server_app_secret = azure_active_directory.value.server_app_secret
        }
      }
    }
  }

  dynamic "linux_profile" {
    for_each = [ for i in lookup(var.kubernetes_cluster[count.index], "linux_profile") : {
      ssh_key = lookup(i, "ssh_key")
    }]
    content {
      admin_username = lookup(linux_profile.value, "admin_username")
      dynamic "ssh_key" {
        for_each = [for i in linux_profile.value.ssh_key : {
          key_data = i.key_data
        }]
        content {
          key_data = ssh_key.value.key_data
        }
      }
    }
  }

  dynamic "windows_profile" {
    for_each = lookup(var.kubernetes_cluster[count.index], "windows_profile")
    content {
      admin_username = lookup(windows_profile.value, "admin_username")
      admin_password = lookup(windows_profile.value, "admin_password")
    }
  }

  dynamic "network_profile" {
    for_each = lookup(var.kubernetes_cluster[count.index], "network_profile")
    content {
      network_plugin     = lookup(network_profile.value, "network_plugin")
      network_policy     = lookup(network_profile.value, "network_policy")
      dns_service_ip     = lookup(network_profile.value, "dns_service_ip")
      docker_bridge_cidr = lookup(network_profile.value, "docker_bridge_cidr")
      pod_cidr           = lookup(network_profile.value, "pod_cidr")
      service_cidr       = lookup(network_profile.value, "service_cidr")
      load_balancer_sku  = lookup(network_profile.value, "load_balancer_sku")
    }
  }

  dynamic "tags" {
    for_each = lookup(var.kubernetes_cluster[count.index], "tags")
    content {
      variables = tags.value
    }
  }
}
