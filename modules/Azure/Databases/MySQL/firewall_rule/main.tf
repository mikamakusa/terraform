resource "azurerm_mysql_firewall_rule" "firewall_rule" {
  count               = length(var.firewall_rule)
  name                = "fwrule-${lookup(var.firewall_rule[count.index], "id")}"
  resource_group_name = lookup(var.firewall_rule[count.index], "server_id") == "" ? var.mysql_resource_group_name : element(var.mysql_resource_group_name, lookup(var.firewall_rule[count.index], "server_id"))
  server_name         = lookup(var.firewall_rule[count.index], "server_id") == "" ? var.mysql_server_name : element(var.mysql_server_name, lookup(var.firewall_rule[count.index], "id_server"))
  start_ip_address    = lookup(var.firewall_rule[count.index], "start_ip")
  end_ip_address      = lookup(var.firewall_rule[count.index], "end_ip")
}