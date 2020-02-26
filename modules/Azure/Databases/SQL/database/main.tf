resource "azurerm_sql_database" "database" {
  count                            = length(var.database)
  location                         = lookup(var.database[count.index], "location_id") == [] ? var.location : element(var.location, lookup(var.database[count.index], "location_id"))
  name                             = lookup(var.database[count.index], "name")
  resource_group_name              = lookup(var.database[count.index], "resource_group_id") == [] ? var.resource_group_name : element(var.resource_group_name, lookup(var.database[count.index], "resource_group_id"))
  server_name                      = lookup(var.database[count.index], "server_id") == [] ? var.server_name : element(var.server_name, lookup(var.database[count.index], "server_id"))
  create_mode                      = lookup(var.database[count.index], "create_mode", null)
  source_database_id               = lookup(var.database[count.index], "source_database_id", null)
  restore_point_in_time            = lookup(var.database[count.index], "restore_point_in_time", null)
  edition                          = lookup(var.database[count.index], "edition", null)
  collation                        = lookup(var.database[count.index], "collation", null)
  max_size_bytes                   = lookup(var.database[count.index], "max_size_bytes", null)
  requested_service_objective_id   = lookup(var.database[count.index], "requested_service_objective_id", null)
  requested_service_objective_name = lookup(var.database[count.index], "requested_service_objective_name", null)
  source_database_deletion_date    = lookup(var.database[count.index], "source_database_deletion_date", null)
  elastic_pool_name                = lookup(var.database[count.index], "elastic_pool_name", null)
  read_scale                       = lookup(var.database[count.index], "read_scale", null)
  zone_redundant                   = lookup(var.database[count.index], "zone_redundant", null)

  dynamic "threat_detection_policy" {
    for_each = lookup(var.database[count.index], "threat_detection_policy")
    content {
      state                      = lookup(threat_detection_policy.value, "state")
      storage_account_access_key = lookup(threat_detection_policy.value, "storage_account_access_key")
      storage_endpoint           = lookup(threat_detection_policy.value, "storage_endpoint")
      disabled_alerts            = [lookup(threat_detection_policy.value, "disabled_alerts")]
      email_account_admins       = lookup(threat_detection_policy.value, "email_account_admins")
      email_addresses            = [lookup(threat_detection_policy.value, "email_addresses")]
      retention_days             = lookup(threat_detection_policy.value, "retention_days")
      use_server_default         = lookup(threat_detection_policy.value, "use_server_default")
    }
  }

  dynamic "import" {
    for_each = lookup(var.database[count.index], "import")
    content {
      administrator_login          = lookup(import.value, "administrator_login")
      administrator_login_password = lookup(import.value, "administrator_login_password")
      authentication_type          = lookup(import.value, "authentication_type")
      storage_key                  = lookup(import.value, "storage_key")
      storage_key_type             = lookup(import.value, "storage_key_type")
      storage_uri                  = lookup(import.value, "storage_uri")
      operation_mode               = lookup(import.value, "operation_mode")
    }
  }

  tags = var.tags
}
