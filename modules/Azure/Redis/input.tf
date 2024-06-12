variable "redis" {
  type = list(object({
    id                            = number
    capacity                      = number
    family                        = string
    location                      = string
    name                          = string
    sku_name                      = string
    minimum_tls_version           = optional(string)
    private_static_ip_address     = optional(string)
    public_network_access_enabled = optional(bool)
    redis_version                 = optional(string)
    replicas_per_master           = optional(number)
    replicas_per_primary          = optional(number)
    shard_count                   = optional(number)
    subnet_id                     = optional(string)
    tags                          = optional(map(string))
    tenant_settings               = optional(map(string))
    zones                         = optional(list(string))
    enable_non_ssl_port           = optional(bool)
    identity = optional(list(object({
      type         = string
      identity_ids = optional(list(string))
    }), []))
    patch_schedule = optional(list(object({
      day_of_week        = string
      maintenance_window = optional(string)
      start_hour_utc     = optional(number)
    }), []))
    redis_configuration = optional(list(object({
      active_directory_authentication_enabled = optional(bool)
      aof_backup_enabled                      = optional(bool)
      aof_storage_connection_string_0         = optional(string)
      aof_storage_connection_string_1         = optional(string)
      data_persistence_authentication_method  = optional(string)
      enable_authentication                   = optional(bool)
      maxfragmentationmemory_reserved         = optional(number)
      maxmemory_delta                         = optional(number)
      maxmemory_policy                        = optional(string)
      maxmemory_reserved                      = optional(number)
      notify_keyspace_events                  = optional(string)
      rdb_backup_enabled                      = optional(bool)
      rdb_backup_frequency                    = optional(number)
      rdb_backup_max_snapshot_count           = optional(number)
      rdb_storage_connection_string           = optional(string)
      storage_account_subscription_id         = optional(string)
    }), []))
    timeouts = optional(list(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
      update = optional(string)
    }), []))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "redis_firewall" {
  type = list(object({
    id       = number
    name     = string
    redis_id = number
    start_ip = string
    end_ip   = string
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "enterprise_cluster" {
  type = list(object({
    id                  = number
    name                = string
    sku_name            = string
    minimum_tls_version = optional(string)
    tags                = optional(map(string))
    zones               = optional(list(string))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "enterprise_database" {
  type = list(object({
    id                             = number
    cluster_id                     = number
    client_protocol                = optional(string)
    clustering_policy              = optional(string)
    eviction_policy                = optional(string)
    linked_database_group_nickname = optional(string)
    linked_database_name           = optional(list(string))
    port                           = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "linked_server" {
  type = list(object({
    id             = number
    redis_cache_id = number
    server_role    = string
  }))
  default     = []
  description = <<EOF
EOF
}

variable "api_management_redis_cache" {
  type = object({
    api_management_id = string
    connection_string = string
    name              = string
    description       = optional(string)
    redis_cache_id    = optional(number)
    cache_location    = optional(string)
  })
  default     = []
  description = <<EOF
EOF
}

variable "cache_access_policy" {
  type = list(object({
    id             = number
    name           = string
    redis_cache_id = number
    permissions    = string
  }))
  default     = []
  description = <<EOF
EOF
}

variable "cache_access_policy_assignment" {
  type = list(object({
    id                 = number
    name               = string
    redis_cache_id     = number
    access_policy_name = string
    object_id          = string
    object_id_alias    = string
  }))
  default     = []
  description = <<EOF
EOF
}

variable "region" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "prefix" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "api_management_name" {
  type    = string
  default = null
}