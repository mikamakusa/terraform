output "windows" {
  value = try(
    azurerm_windows_web_app_slot.this,
    azurerm_windows_web_app.this,
    azurerm_windows_function_app_slot.this,
    azurerm_windows_web_app_slot.this
  )
}

output "linux" {
  value = try(
    azurerm_linux_web_app_slot.this,
    azurerm_linux_web_app.this,
    azurerm_linux_function_app_slot.this,
    azurerm_linux_function_app.this
  )
}

output "static_site" {
  value = try(
    azurerm_static_site.this,
    azurerm_static_site_custom_domain.this
  )
}

output "function_app" {
  value = try(
    azurerm_function_app.this,
    azurerm_function_app_slot.this,
    azurerm_function_app_active_slot.this,
    azurerm_function_app_function.this,
    azurerm_function_app_hybrid_connection.this,
    azurerm_function_app_connection.this
  )
}

output "app_service" {
  value = try(
    azurerm_app_service.this,
    azurerm_app_service_plan.this,
    azurerm_app_service_slot.this,
    azurerm_app_service_custom_hostname_binding.this,
    azurerm_app_service_managed_certificate.this,
    azurerm_app_service_virtual_network_swift_connection.this,
    azurerm_app_service_source_control_token.this,
    azurerm_app_service_source_control_slot.this,
    azurerm_app_service_slot_virtual_network_swift_connection.this,
    azurerm_app_service_slot_custom_hostname_binding.this,
    azurerm_app_service_public_certificate.this,
    azurerm_app_service_active_slot.this,
    azurerm_app_service_slot_custom_hostname_binding.this,
    azurerm_app_service_slot_virtual_network_swift_connection.this,
    azurerm_app_service_source_control.this,
    azurerm_app_service_source_control_slot.this,
    azurerm_app_service_source_control_token.this,
    azurerm_app_service_virtual_network_swift_connection.this
  )
}