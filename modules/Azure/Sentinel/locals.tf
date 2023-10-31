locals {
  content_id = try(
    azurerm_sentinel_alert_rule_scheduled.this.*.name,
    azurerm_sentinel_alert_rule_threat_intelligence.this.*.name,
    azurerm_sentinel_alert_rule_anomaly_built_in.this.*.name,
    azurerm_sentinel_alert_rule_nrt.this.*.name,
    azurerm_sentinel_alert_rule_ms_security_incident.this.*.name,
    azurerm_sentinel_alert_rule_fusion.this.*.name,
    azurerm_sentinel_alert_rule_anomaly_duplicate.this.*.name,
    azurerm_sentinel_alert_rule_machine_learning_behavior_analytics.this.*.name
  )
  parent_id = try(
    azurerm_sentinel_alert_rule_scheduled.this.*.id,
    azurerm_sentinel_alert_rule_threat_intelligence.this.*.id,
    azurerm_sentinel_alert_rule_anomaly_built_in.this.*.id,
    azurerm_sentinel_alert_rule_nrt.this.*.id,
    azurerm_sentinel_alert_rule_ms_security_incident.this.*.id,
    azurerm_sentinel_alert_rule_fusion.this.*.id,
    azurerm_sentinel_alert_rule_anomaly_duplicate.this.*.id,
    azurerm_sentinel_alert_rule_machine_learning_behavior_analytics.this.*.id
  )
}