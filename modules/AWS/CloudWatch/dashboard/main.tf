resource "aws_cloudwatch_dashboard" "dashboard" {
  count          = length(var.dashboard)
  dashboard_body = var.dashboard_body
  dashboard_name = lookup(var.dashboard[count.index], "dashboard_name")
}