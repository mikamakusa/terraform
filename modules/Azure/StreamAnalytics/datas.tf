data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_storage_account" "this" {
  count               = var.storage_account_name ? 1 : 0
  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_storage_container" "this" {
  count                = var.storage_container_name ? 1 : 0
  name                 = var.storage_container_name
  storage_account_name = data.azurerm_storage_account.this.name
}

data "azurerm_cosmosdb_account" "this" {
  count               = var.cosmosdb_account_name ? 1 : 0
  name                = var.cosmosdb_account_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_cosmosdb_sql_database" "this" {
  count               = var.cosmosdb_sql_database_name ? 1 : 0
  account_name        = data.azurerm_cosmosdb_account.this.name
  name                = var.cosmosdb_sql_database_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_eventhub_namespace" "this" {
  count               = var.eventhub_namespace_name ? 1 : 0
  name                = var.eventhub_namespace_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_eventhub" "this" {
  count               = var.eventhub_name ? 1 : 0
  name                = var.eventhub_name
  namespace_name      = data.azurerm_eventhub_namespace.this.name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_function_app" "this" {
  count               = var.function_app_name ? 1 : 0
  name                = var.function_app_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_sql_server" "this" {
  count               = var.sql_server_name ? 1 : 0
  name                = var.sql_server_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_sql_database" "this" {
  count               = var.sql_database_name ? 1 : 0
  name                = var.sql_database_name
  resource_group_name = data.azurerm_resource_group.this.name
  server_name         = data.azurerm_sql_server.this.name
}

data "azurerm_servicebus_namespace" "this" {
  count               = var.servicebus_namespace_name ? 1 : 0
  name                = var.servicebus_namespace_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_servicebus_queue" "this" {
  count        = var.servicebus_queue_name ? 1 : 0
  name         = var.servicebus_queue_name
  namespace_id = data.azurerm_servicebus_namespace.this.id
}

data "azurerm_servicebus_topic" "this" {
  count        = var.servicebus_topic_name ? 1 : 0
  name         = var.servicebus_topic_name
  namespace_id = data.azurerm_servicebus_namespace.this.id
}

data "azurerm_storage_table" "this" {
  count                = var.storage_table_name ? 1 : 0
  name                 = var.storage_table_name
  storage_account_name = data.azurerm_storage_account.this.name
}

data "azurerm_eventhub_consumer_group" "this" {
  count               = var.eventhub_consumer_group_name ? 1 : 0
  eventhub_name       = data.azurerm_eventhub.this.name
  name                = var.eventhub_consumer_group_name
  namespace_name      = data.azurerm_eventhub_namespace.this.name
  resource_group_name = data.azurerm_resource_group.this.name
}