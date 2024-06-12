resource "azurerm_redis_cache" "redis_service" {
  count                         = length(var.redis)
  capacity                      = lookup(var.redis[count.index], "capacity")
  family                        = lookup(var.redis[count.index], "family")
  location                      = data.azurerm_resource_group.this.location
  name                          = join("-", [var.prefix, lookup(var.redis[count.index], "name"), lookup(var.redis[count.index], "id")])
  resource_group_name           = data.azurerm_resource_group.this.name
  sku_name                      = lookup(var.redis[count.index], "sku_name")
  enable_non_ssl_port           = lookup(var.redis[count.index], "enable_non_ssl_port")
  minimum_tls_version           = lookup(var.redis[count.index], "minimum_tls_version")
  private_static_ip_address     = lookup(var.redis[count.index], "private_static_ip_address")
  public_network_access_enabled = lookup(var.redis[count.index], "public_network_access_enabled")
  redis_version                 = lookup(var.redis[count.index], "redis_version")
  replicas_per_master           = lookup(var.redis[count.index], "replicas_per_master")
  replicas_per_primary          = lookup(var.redis[count.index], "replicas_per_primary")
  shard_count                   = lookup(var.redis[count.index], "shard_count")
  subnet_id                     = lookup(var.redis[count.index], "subnet_id")
  tags                          = merge(var.tags, lookup(var.redis[count.index], "tags"))
  tenant_settings               = lookup(var.redis[count.index], "tenant_settings")
  zones                         = lookup(var.redis[count.index], "zones")

  dynamic "identity" {
    for_each = lookup(var.redis[count.index], "identity") == null ? [] : ["identity"]
    content {
      type         = lookup(identity.value, "type")
      identity_ids = lookup(identity.value, "identity_ids")
    }
  }

  dynamic "patch_schedule" {
    for_each = lookup(var.redis[count.index], "patch_schedule") == null ? [] : ["patch_schedule"]
    content {
      day_of_week        = lookup(patch_schedule.value, "day_of_week")
      maintenance_window = lookup(patch_schedule.value, "maintenance_window")
      start_hour_utc     = lookup(patch_schedule.value, "start_hour_utc")
    }
  }

  dynamic "redis_configuration" {
    for_each = lookup(var.redis[count.index], "redis_configuration") == null ? [] : ["redis_configuration"]
    content {
      active_directory_authentication_enabled = lookup(redis_configuration.value, "active_directory_authentication_enabled")
      aof_backup_enabled                      = lookup(redis_configuration.value, "aof_backup_enabled")
      aof_storage_connection_string_0         = sensitive(lookup(redis_configuration.value, "aof_storage_connection_string_0"))
      aof_storage_connection_string_1         = sensitive(lookup(redis_configuration.value, "aof_storage_connection_string_1"))
      data_persistence_authentication_method  = lookup(redis_configuration.value, "data_persistence_authentication_method")
      enable_authentication                   = lookup(redis_configuration.value, "enable_authentication")
      maxfragmentationmemory_reserved         = lookup(redis_configuration.value, "maxfragmentationmemory_reserved")
      maxmemory_delta                         = lookup(redis_configuration.value, "maxmemory_delta")
      maxmemory_policy                        = lookup(redis_configuration.value, "maxmemory_policy")
      maxmemory_reserved                      = lookup(redis_configuration.value, "maxmemory_reserved")
      notify_keyspace_events                  = lookup(redis_configuration.value, "notify_keyspace_events")
      rdb_backup_enabled                      = lookup(redis_configuration.value, "rdb_backup_enabled")
      rdb_backup_frequency                    = lookup(redis_configuration.value, "rdb_backup_frequency")
      rdb_backup_max_snapshot_count           = lookup(redis_configuration.value, "rdb_backup_max_snapshot_count")
      rdb_storage_connection_string           = sensitive(lookup(redis_configuration.value, "rdb_storage_connection_string"))
      storage_account_subscription_id         = lookup(redis_configuration.value, "storage_account_subscription_id")
    }
  }

  dynamic "timeouts" {
    for_each = lookup(var.redis[count.index], "timeouts") == null ? [] : ["timeouts"]
    content {
      create = lookup(timeouts.value, "create")
      delete = lookup(timeouts.value, "delete")
      read   = lookup(timeouts.value, "read")
      update = lookup(timeouts.value, "update")
    }
  }
}

resource "azurerm_redis_firewall_rule" "redis_firewall" {
  count               = length(var.redis) == 0 ? 0 : length(var.redis_firewall)
  name                = join("-", [var.prefix, lookup(var.redis_firewall[count.index], "name"), lookup(var.redis_firewall[count.index], "id")])
  redis_cache_name    = try(element(azurerm_redis_cache.redis_service.*.name, lookup(var.redis_firewall[count.index], "redis_id")))
  resource_group_name = data.azurerm_resource_group.this.name
  start_ip            = lookup(var.redis_firewall[count.index], "start_ip")
  end_ip              = lookup(var.redis_firewall[count.index], "end_ip")
}

resource "azurerm_redis_enterprise_cluster" "this" {
  count               = length(var.enterprise_cluster)
  location            = data.azurerm_resource_group.this.location
  name                = lookup(var.enterprise_cluster[count.index], "name")
  resource_group_name = data.azurerm_resource_group.this.name
  sku_name            = lookup(var.enterprise_cluster[count.index], "sku_name")
  minimum_tls_version = lookup(var.enterprise_cluster[count.index], "minimum_tls_version")
  tags                = merge(var.tags, lookup(var.enterprise_cluster[count.index], "tags"))
  zones               = lookup(var.enterprise_cluster[count.index], "zones")
}

resource "azurerm_redis_enterprise_database" "this" {
  count                          = length(var.enterprise_cluster) == 0 ? 0 : length(var.enterprise_database)
  cluster_id                     = try(element(azurerm_redis_enterprise_cluster.this.*.id, lookup(var.enterprise_database[count.index], "cluster_id")))
  client_protocol                = lookup(var.enterprise_database[count.index], "client_protocol")
  clustering_policy              = lookup(var.enterprise_database[count.index], "clustering_policy")
  eviction_policy                = lookup(var.enterprise_database[count.index], "eviction_policy")
  linked_database_group_nickname = lookup(var.enterprise_database[count.index], "linked_database_group_nickname")
  linked_database_id = join("/", [
    try(element(azurerm_redis_enterprise_cluster.this.*.id, lookup(var.enterprise_database[count.index], "cluster_id"))),
    "databases",
    lookup(var.enterprise_database[count.index], "linked_database_name")
  ])
  port = lookup(var.enterprise_database[count.index], "port")
}

resource "azurerm_redis_linked_server" "this" {
  count                       = length(var.redis) == 0 ? 0 : length(var.linked_server)
  linked_redis_cache_id       = try(element(azurerm_redis_cache.redis_service.*.id, lookup(var.linked_server[count.index], "redis_cache_id")))
  linked_redis_cache_location = try(element(azurerm_redis_cache.redis_service.*.location, lookup(var.linked_server[count.index], "redis_cache_id")))
  resource_group_name         = try(element(azurerm_redis_cache.redis_service.*.resource_group_name, lookup(var.linked_server[count.index], "redis_cache_id")))
  server_role                 = lookup(var.linked_server[count.index], "server_role")
  target_redis_cache_name     = try(element(azurerm_redis_cache.redis_service.*.name, lookup(var.linked_server[count.index], "redis_cache_id")))
}

resource "azurerm_api_management_redis_cache" "this" {
  count             = length(var.api_management_redis_cache)
  api_management_id = data.azurerm_api_management.this.id
  connection_string = lookup(var.api_management_redis_cache[count.index], "connection_string")
  name              = lookup(var.api_management_redis_cache[count.index], "name")
  description       = lookup(var.api_management_redis_cache[count.index], "description")
  redis_cache_id    = try(element(azurerm_redis_cache.redis_service.*.id, lookup(var.api_management_redis_cache[count.index], "redis_cache_id")))
  cache_location    = lookup(var.api_management_redis_cache[count.index], "cache_location")
}

resource "azurerm_redis_cache_access_policy" "this" {
  count          = length(var.redis) == 0 ? 0 : length(var.cache_access_policy)
  name           = lookup(var.cache_access_policy[count.index], "name")
  redis_cache_id = try(element(azurerm_redis_cache.redis_service.*.id, lookup(var.cache_access_policy[count.index], "redis_cache_id")))
  permissions    = lookup(var.cache_access_policy[count.index], "permissions")
}

resource "azurerm_redis_cache_access_policy_assignment" "this" {
  count              = length(var.redis) == 0 ? 0 : length(var.cache_access_policy_assignment)
  name               = lookup(var.cache_access_policy_assignment[count.index], "name")
  redis_cache_id     = try(element(azurerm_redis_cache.redis_service.*.id, lookup(var.cache_access_policy_assignment[count.index], "redis_cache_id")))
  access_policy_name = lookup(var.cache_access_policy_assignment[count.index], "access_policy_name")
  object_id          = data.azurerm_client_config.test.object_id
  object_id_alias    = lookup(var.cache_access_policy_assignment[count.index], "object_id_alias")
}