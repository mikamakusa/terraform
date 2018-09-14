resource "azurerm_sql_server" "azure_sqlserver" {
  count                        = "${length(var.sqlserver)}"
  administrator_login          = "${lookup(var.sqlserver[count.index],"admin_login")}"
  administrator_login_password = "${lookup(var.sqlserver[count.index],"admin_pass")}"
  location                     = "${var.sql_location}"
  name                         = "${lookup(var.sqlserver[count.index],"name")}"
  resource_group_name          = "${var.sql_rg_name}"
  version                      = "${lookup(var.sqlserver[count.index],"version")}"
  tags                         = ["${element(var.sql_tags,count.index)}"]
}

resource "azurerm_sql_database" "azure_sqlserver_database" {
  depends_on = ["azurerm_sql_server.azure_sqlserver"]
  count               = "${length(var.sql_database)}"
  location            = "${var.sql_location}"
  name                = "${lookup(var.sql_database[count.index],"name")}"
  resource_group_name = "${var.sql_rg_name}"
  server_name         = "${element(var.sql_database,lookup(var.sqlserver[count.index],"name"))}"
  tags                = ["${element(var.sql_tags, count.index)}"]
}

resource "azurerm_sql_firewall_rule" "azure_sqlserver_firewall_rule" {
  depends_on = ["azurerm_sql_server.azure_sqlserver"]
  count               = "${length(var.sql_firewall)}"
  end_ip_address      = "${lookup(var.sql_firewall[count.index],"end_ip")}"
  name                = "${lookup(var.sql_firewall[count.index],"name")}"
  resource_group_name = "${var.sql_rg_name}"
  server_name         = "${element(var.sql_firewall,lookup(var.sqlserver[count.index],"name"))}"
  start_ip_address    = "${lookup(var.sql_firewall[count.index],"start_ip")}"
}

resource "azurerm_sql_virtual_network_rule" "azure_sql_vnet_rule" {
  depends_on = ["azurerm_sql_server.azure_sqlserver"]
  count               = "${length(var.sql_vnet_rule)}"
  name                = "${lookup(var.sql_vnet_rule[count.index],"name")}"
  resource_group_name = "${var.sql_rg_name}"
  server_name         = "${element(var.sql_vnet_rule,lookup(var.sqlserver[count.index],"name"))}"
  subnet_id           = "${element(var.subnets_ids,lookup(var.sql_vnet_rule[count.index], "Id_Subnet"))}"
}
