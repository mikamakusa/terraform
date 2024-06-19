output "prometheus_workspace" {
  value = try(
    aws_prometheus_workspace.this.*.id,
    aws_prometheus_workspace.this.*.arn,
    aws_prometheus_workspace.this.*.alias
  )
}

output "prometheus_scraper" {
  value = try(
    aws_prometheus_scraper.this.*.id,
    aws_prometheus_scraper.this.*.alias,
  )
}

output "alert_manager_definition" {
  value = try(
    aws_prometheus_alert_manager_definition.this.*.id,
    aws_prometheus_alert_manager_definition.this.*.workspace_id
  )
}

output "rule_group_namespace" {
  value = try(
    aws_prometheus_rule_group_namespace.this.*.id,
    aws_prometheus_rule_group_namespace.this.*.workspace_id,
    aws_prometheus_rule_group_namespace.this.*.name,
    aws_prometheus_rule_group_namespace.this.*.data
  )
}