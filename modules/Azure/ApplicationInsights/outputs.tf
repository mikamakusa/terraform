output "application_insights" {
  value = try(azurerm_application_insights.this)
}

output "workbook" {
  value = try(
    azurerm_application_insights_workbook_template.this,
    azurerm_application_insights_workbook.this
  )
}

output "web_test" {
  value = try(
    azurerm_application_insights_standard_web_test.this,
    azurerm_application_insights_web_test.this
  )
}

output "application_insights_configuration" {
  value = try(
    azurerm_application_insights_analytics_item.this,
    azurerm_application_insights_api_key.this,
    azurerm_application_insights_smart_detection_rule.this
  )
}