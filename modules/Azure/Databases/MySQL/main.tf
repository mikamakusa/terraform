resource "azurerm_mysql_server" "mysql_server" {
  count               = "${length(var.mysql_server)}"
  name                = "${var.mysql_prefix}${lookup(var.mysql_server[count.index], "suffix_name")}${var.mysql_suffix}"
  location            = "${var.mysql_resource_group_name}"
  resource_group_name = "${var.mysql_location}"

  sku {
    capacity = "${lookup(var.mysql_server[count.index],"sku_capacity")}"
    family = "${lookup(var.mysql_server[count.index],"sku_family")}"
    name = "${lookup(var.mysql_server[count.index],"sku_name")}"
    tier = "${lookup(var.mysql_server[count.index],"sku_tier")}"
  }

  ssl_enforcement = "${lookup(var.mysql_server[count.index], "ssl_enforcement")}"

  storage_profile {
    storage_mb = "${lookup(var.mysql_server[count.index], "storage_mb")}"
    backup_retention_days = "${lookup(var.mysql_server[count.index], "backup_retention_days")}"
    geo_redundant_backup = "${lookup(var.mysql_server[count.index], "geo_redundant_backup")}"
  }

  administrator_login          = "${var.administrator_login}"
  administrator_login_password = "${var.administrator_login_password}"
  version                      = "${lookup(var.mysql_server[count.index], "version")}"
}

resource "azurerm_mysql_configuration" "mysql_config" {
  count               = "${ "${length(var.mysql_server)}" == "0" ? "0" : "${length(var.mysql_config)}" }"
  name                = "${var.mysql_config}-config"
  resource_group_name = "${element(azurerm_mysql_server.mysql_server.*.resource_group_name,lookup(var.mysql_config[count.index],"id_server"))}"
  server_name         = "${element(azurerm_mysql_server.mysql_server.*.name,lookup(var.mysql_config[count.index],"id_server"))}"
  value               = "${lookup(var.mysql_config[count.index],"value")}"
}

resource "azurerm_mysql_database" "mysql_database" {
  count               = "${ "${length(var.mysql_server)}" == "0" ? "0" : "${length(var.mysql_database)}" }"
  charset             = "${lookup(var.mysql_database[count.index],"charset")}"
  collation           = "${lookup(var.mysql_database[count.index],"collation")}"
  name                = "${lookup(var.mysql_database[count.index],"database_name")}"
  resource_group_name = "${element(azurerm_mysql_server.mysql_server.*.resource_group_name,lookup(var.mysql_database[count.index],"id_server"))}"
  server_name         = "${element(azurerm_mysql_server.mysql_server.*.name,lookup(var.mysql_database[count.index],"id_server"))}"
}

resource "azurerm_mysql_firewall_rule" "mysql_firewall_rule" {
  count               = "${ "${length(var.mysql_server)}" == "0" ? "0" : "${length(var.mysql_firewall)}" }"
  name                = "fwrule-${lookup(var.mysql_firewall[count.index],"id")}"
  resource_group_name = "${element(azurerm_mysql_server.mysql_server.*.resource_group_name,lookup(var.mysql_firewall[count.index],"id_server"))}"
  server_name         = "${element(azurerm_mysql_server.mysql_server.*.name,lookup(var.mysql_firewall[count.index],"id_server"))}"
  start_ip_address    = "${lookup(var.mysql_firewall[count.index],"start_ip")}"
  end_ip_address      = "${lookup(var.mysql_firewall[count.index],"end_ip")}"
}
