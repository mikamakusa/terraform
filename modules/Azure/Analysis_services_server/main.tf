resource "azurerm_analysis_services_server" "analysis_services_server" {
  count                     = length(var.analysis_services_server)
  location                  = element(var.location, lookup(var.analysis_services_server[count.index], "location_id"))
  name                      = lookup(var.analysis_services_server[count.index], "name")
  resource_group_name       = element(var.resource_group_name, lookup(var.analysis_services_server[count.index], "resource_group_id"))
  sku                       = lookup(var.analysis_services_server[count.index], "sku")
  admin_users               = [ookup(var.analysis_services_server[count.index], "admin_users")]
  querypool_connection_mode = lookup(var.analysis_services_server[count.index], "querypool_connection_mode")
  backup_blob_container_uri = lookup(var.analysis_services_server[count.index], "backup_blob_container_uri")
  enable_power_bi_service   = lookup(var.analysis_services_server[count.index], "enable_power_bi_service")

  dynamic "ipv4_firewall_rule" {
    for_each = lookup(var.analysis_services_server[count.index], "")
    content {
      name        = lookup(ipv4_firewall_rule.value, "name")
      range_start = lookup(ipv4_firewall_rule.value, "range_start")
      range_end   = lookup(ipv4_firewall_rule.value, "range_end")
    }
  }
}