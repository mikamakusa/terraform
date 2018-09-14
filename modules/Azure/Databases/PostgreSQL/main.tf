resource "azurerm_postgresql_server" "postgresql_server" {
  count               = "${length(var.pgsql_db)}"
  name                = "${var.pgsql_prefix}${lookup(var.pgsql_db[count.index], "suffix_name")}${var.pgsql_suffix}"
  resource_group_name = "${var.pgsql_rg}"
  location            = "${var.pgsql_location}"

  sku = ["${var.pgsql_sku}"]

  ssl_enforcement = "${lookup(var.pgsql_db[count.index], "ssl")}"
  storage_profile = ["${var.pgsql_storage_profile}"]

  administrator_login          = "${lookup(var.pgsql_db[count.index], "administrator_login")}"
  administrator_login_password = "${lookup(var.pgsql_db[count.index], "administrator_password")}"
  version                      = "${lookup(var.pgsql_db[count.index], "db_version")}"
}

resource "azurerm_postgresql_database" "postgresql_database" {
  depends_on          = ["azurerm_postgresql_server.postgresql_server"]
  count               = "${length(var.pgsql_db)}"
  name                = "${var.pgsql_prefix}-${lookup(var.pgsql_db[count.index], "suffix_name")}-db1"
  resource_group_name = "${var.pgsql_rg}"
  server_name         = "${element(azurerm_postgresql_server.postgresql_server.*.name,count.index)}"
  charset             = "${lookup(var.pgsql_db[count.index], "charset")}"
  collation           = "${lookup(var.pgsql_db[count.index], "collation")}"
}

resource "azurerm_postgresql_firewall_rule" "postgresql_firewall_rule" {
  depends_on          = ["azurerm_postgresql_server.postgresql_server"]
  count               = "${length(var.pgsql_db_firewall)}"
  resource_group_name = "${var.pgsql_rg}"
  server_name         = "${element(azurerm_postgresql_server.postgresql_server.*.name,count.index)}"
  name                = "${var.pgsql_prefix}-${lookup(var.pgsql_db_firewall[count.index], "suffix_name")}-rule"
  start_ip_address    = "${lookup(var.pgsql_db_firewall[count.index], "start_ip")}"
  end_ip_address      = "${lookup(var.pgsql_db_firewall[count.index], "end_ip")}"
}

resource "azurerm_postgresql_configuration" "postgresql_config" {
  depends_on          = ["azurerm_postgresql_server.postgresql_server"]
  count               = "${length(var.pgsql_db)}"
  name                = "${var.pgsql_prefix}-config"
  resource_group_name = "${var.pgsql_rg}"
  server_name         = "${element(azurerm_postgresql_server.postgresql_server.*.name,count.index)}"
  value               = "on"
}

resource "azure_postgresql_virtual_network_rule" "vnet_rules" {
  depends_on          = ["azurerm_postgresql_server.postgresql_server"]
  count               = "${length(var.pgsql_vnet_rules)}"
  name                = "${var.pgsql_prefix}-${lookup(var.pgsql_vnet_rules[count.index], "name")}"
  resource_group_name = "${var.pgsql_rg}"
  server_name         = "${element(azurerm_postgresql_server.postgresql_server.*.name,count.index)}"
  subnet_id           = "${element(var.subnets_ids,lookup(var.pgsql_vnet_rules[count.index], "Id_Subnet"))}"
}
