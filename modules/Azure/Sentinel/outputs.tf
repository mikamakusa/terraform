output "data_connector" {
  value = try(
    azurerm_sentinel_data_connector_threat_intelligence_taxii.this,
    azurerm_sentinel_data_connector_microsoft_defender_advanced_threat_protection.this,
    azurerm_sentinel_data_connector_azure_security_center.this,
    azurerm_sentinel_data_connector_office_power_bi.this,
    azurerm_sentinel_data_connector_office_irm.this,
    azurerm_sentinel_data_connector_office_atp.this,
    azurerm_sentinel_data_connector_office_365_project.this,
    azurerm_sentinel_data_connector_office_365.this,
    azurerm_sentinel_data_connector_microsoft_threat_protection.this,
    azurerm_sentinel_data_connector_microsoft_threat_intelligence.this,
    azurerm_sentinel_data_connector_microsoft_cloud_app_security.this,
    azurerm_sentinel_data_connector_iot.this,
    azurerm_sentinel_data_connector_dynamics_365.this,
    azurerm_sentinel_data_connector_azure_active_directory.this,
    azurerm_sentinel_data_connector_aws_s3.this,
    azurerm_sentinel_data_connector_aws_cloud_trail
  )
}

output "alert_rule" {
  value = try(
    azurerm_sentinel_alert_rule_machine_learning_behavior_analytics.this,
    azurerm_sentinel_alert_rule_anomaly_duplicate.this,
    azurerm_sentinel_alert_rule_fusion.this,
    azurerm_sentinel_alert_rule_ms_security_incident.this,
    azurerm_sentinel_alert_rule_nrt.this,
    azurerm_sentinel_alert_rule_anomaly_built_in.this,
    azurerm_sentinel_alert_rule_threat_intelligence.this,
    azurerm_sentinel_alert_rule_scheduled.this
  )
}

output "watchlist" {
  value = try(
    azurerm_sentinel_watchlist.this,
    azurerm_sentinel_watchlist_item.this
  )
}

output "threat_intelligence_indicator" {
  value = try(
    azurerm_sentinel_threat_intelligence_indicator.this
  )
}

output "log_analytics" {
  value = try(
    azurerm_log_analytics_workspace.this,
    azurerm_log_analytics_solution.this,
    azurerm_sentinel_log_analytics_workspace_onboarding.this
  )
}