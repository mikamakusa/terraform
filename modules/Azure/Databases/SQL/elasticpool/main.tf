resource "azurerm_sql_elasticpool" "elasticpool" {
  count               = length(var.elasticpool)
  dtu                 = lookup(var.elasticpool[count.index], "dtu")
  db_dtu_max          = lookup(var.elasticpool[count.index], "db_dtu_max")
  db_dtu_min          = lookup(var.elasticpool[count.index], "db_dtu_min")
  pool_size           = lookup(var.elasticpool[count.index], "pool_size")
  edition             = lookup(var.elasticpool[count.index], "edition")
  location            = lookup(var.elasticpool[count.index], "location_id") == [] ? var.location : element(var.location, lookup(var.elasticpool[count.index], "location_id"))
  name                = lookup(var.elasticpool[count.index], "name")
  resource_group_name = lookup(var.elasticpool[count.index], "resource_group_id") == [] ? var.resource_group_name : element(var.resource_group_name, lookup(var.elasticpool[count.index], "resource_group_id"))
  server_name         = lookup(var.elasticpool[count.index], "server_id") == [] ? var.server_name : element(var.server_name, lookup(var.elasticpool[count.index], "server_id"))
  tags                = var.tags
}