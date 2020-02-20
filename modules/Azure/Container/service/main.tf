resource "azurerm_container_service" "service" {
  count                  = length(var.service)
  resource_group_name    = lookup(var.service[count.index], "resource_group_id") == null ? var.resource_group_name : element(var.resource_group_name, lookup(var.service[count.index], "resource_group_id"))
  location               = lookup(var.service[count.index], "resource_group_id") == null ? var.resource_group_location : element(var.resource_group_location, lookup(var.service[count.index], "resource_group_id"))
  name                   = lookup(var.service[count.index], "name")
  orchestration_platform = lookup(var.service[count.index], "orchestration_platform")

  dynamic "master_profile" {
    for_each = lookup(var.service[count.index], "master_profile")
    content {
      dns_prefix = lookup(master_profile.value, "dns_prefix")
    }
  }

  dynamic "linux_profile" {
    for_each = [for i in lookup(var.service[count.index], "linux_profile") : {
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

  dynamic "diagnostics_profile" {
    for_each = lookup(var.service[count.index], "diagnostics_profile")
    content {
      enabled = lookup(diagnostics_profile.value, "diagnostics_profile", true)
    }
  }

  dynamic "agent_pool_profile" {
    for_each = lookup(var.service[count.index], "agent_pool_profile")
    content {
      dns_prefix = lookup(agent_pool_profile.value, "dns_prefix")
      name       = lookup(agent_pool_profile.value, "name")
      vm_size    = lookup(agent_pool_profile.value, "vm_size")
      count      = lookup(agent_pool_profile.value, "count")
    }
  }

  dynamic "service_principal" {
    for_each = lookup(var.service[count.index], "service_principal")
    content {
      client_id     = lookup(service_principal.value, "client_id")
      client_secret = lookup(service_principal.value, "client_secret")
    }
  }

}