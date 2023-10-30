output "resource_group" {
  value = try(
    data.azurerm_resource_group.this,
    azurerm_resource_group.this
  )
}

output "application_group" {
  value = try(
    azurerm_virtual_desktop_application_group.this
  )
}

output "application" {
  value = try(
    azurerm_virtual_desktop_application.this
  )
}

output "host_pool" {
  value = try(
    azurerm_virtual_desktop_host_pool.this
  )
}

output "scaling_plan" {
  value = try(
    azurerm_virtual_desktop_scaling_plan.this
  )
}

output "desktop_workspace" {
  value = try(
    azurerm_virtual_desktop_workspace.this
  )
}