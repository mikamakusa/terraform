resource "azurerm_postgresql_firewall_rule" "firewall_rule" {
  count               = length(var.firewall_rule)
  resource_group_name = lookup(var.firewall_rule[count.index], "server_id") == "" ? var.pgsql_resource_group_name : element(var.pgsql_resource_group_name, lookup(var.firewall_rule[count.index], "server_id"))
  server_name         = lookup(var.firewall_rule[count.index], "server_id") == "" ? var.pgsql_server_name : element(var.pgsql_server_name, lookup(var.firewall_rule[count.index], "server_id"))
  name                = "fwrule-${lookup(var.firewall_rule[count.index], "id")}"
  start_ip_address    = lookup(var.firewall_rule[count.index], "start_ip")
  end_ip_address      = lookup(var.firewall_rule[count.index], "end_ip")
}