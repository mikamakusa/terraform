resource "azurerm_mysql_server" "mysql_server" {
  count               = "${length(var.mysql_db)}"
  name                = "${var.mysql_prefix}${lookup(var.mysql_db[count.index], "suffix_name")}${var.mysql_suffix}"
  location            = "${var.mysql_rg_location}"
  resource_group_name = "${var.mysql_rg_name}"

  sku = ["${var.mysql_sku}"]

  ssl_enforcement = "${lookup(var.mysql_db[count.index], "ssl")}"

  storage_profile = ["${var.mysql_storage_profile}"]

  administrator_login          = "${lookup(var.mysql_db[count.index], "admin_login")}"
  administrator_login_password = "${lookup(var.mysql_db[count.index], "admin_pass")}"
  version                      = "${lookup(var.mysql_db[count.index], "version")}"
}

resource "azurerm_mysql_configuration" "mysql_config" {
  depends_on          = ["azurerm_mysql_server.mysql_server"]
  count               = "${length(var.mysql_db)}"
  name                = "${var.mysql_prefix}-config"
  resource_group_name = "${var.mysql_rg_name}"
  server_name         = "${element(azurerm_mysql_server.mysql_server.*.name, count.index)}"
  value               = "on"
}

resource "azurerm_mysql_database" "mysql_database" {
  depends_on          = ["azurerm_mysql_server.mysql_server"]
  count               = "${length(var.mysql_database)}"
  charset             = "${lookup(var.mysql_database[count.index],"charset")}"
  collation           = "${lookup(var.mysql_database[count.index],"collation")}"
  name                = "${lookup(var.mysql_database[count.index],"database_name")}"
  resource_group_name = "${var.mysql_rg_name}"
  server_name         = "${element(azurerm_mysql_server.mysql_server.*.name, count.index)}"
}

resource "azurerm_mysql_firewall_rule" "mysql_firewall_rule" {
  depends_on          = ["azurerm_mysql_server.mysql_server"]
  count               = "${length(var.mysql_firewall)}"
  name                = "${lookup(var.mysql_firewall[count.index],"name")}"
  resource_group_name = "${var.mysql_rg_name}"
  server_name         = "${element(azurerm_mysql_server.mysql_server.*.name, count.index)}"
  start_ip_address    = "${lookup(var.mysql_firewall[count.index],"start_ip")}"
  end_ip_address      = "${lookup(var.mysql_firewall[count.index],"end_ip")}"
}
