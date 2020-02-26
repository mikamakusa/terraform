output "id" {
  value = azurerm_sql_database.database.*.id
}

output "creation_date" {
  value = azurerm_sql_database.database.*.creation_date
}

output "default_secondary_location" {
  value = azurerm_sql_database.database.*.default_secondary_location
}