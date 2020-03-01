output "id" {
  value = azurerm_analysis_services_server.analysis_services_server.*.id
}

output "server_full_name" {
  value = azurerm_analysis_services_server.analysis_services_server.*.server_full_name
}