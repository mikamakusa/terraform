resource "azurerm_redis_cache" "redis_service" {
  count    = "${length(var.redis)}"
  capacity = "${lookup(var.redis[count.index],"capacity")}"
  family   = "${lookup(var.redis[count.index],"family")}"
  location = "${var.region}"
  name     = "${var.prefix}-${lookup(var.redis[count.index],"name")}-${lookup(var.redis[count.index],"id")}"

  "redis_configuration" {
    maxclients           = "${lookup(var.redis[count.index],"maxclients")}"
    maxmemory_delta      = "${lookup(var.redis[count.index],"maxmemory_delta")}"
    maxmemory_policy     = "${lookup(var.redis[count.index],"maxmemory_policy")}"
    maxmemory_reserved   = "${lookup(var.redis[count.index],"maxmemory_reserved")}"
    rdb_backup_enabled   = "${lookup(var.redis[count.index],"rdb_backup_enabled")}}"
    rdb_backup_frequency = "${lookup(var.redis[count.index],"rdb_backup_frequency")}"
  }

  resource_group_name = "${var.resource_group_name}"
  sku_name            = "${lookup(var.redis[count.index],"sku_name")}"
  enable_non_ssl_port = "${lookup(var.redis[count.index],"enable_non_ssl_port")}"
}

resource "azurerm_redis_firewall_rule" "redis_firewall" {
  count               = "${ "${length(var.redis_cache)}" == "0" ? "0" : "${length(var.redis_firewall)}" }"
  name                = "${var.prefix}-${lookup(var.redis_firewall[count.index],"name")}${lookup(var.redis_firewall[count.index],"id")}"
  redis_cache_name    = "${element(azurerm_redis_cache.redis_service.*.name,lookup(var.redis_firewall[count.index],"redis_id"))}"
  resource_group_name = "${var.resource_group_name}"
  start_ip            = "${lookup(var.redis_firewall[count.index],"start_ip")}"
  end_ip              = "${lookup(var.redis_firewall[count.index],"end_ip")}"
}
