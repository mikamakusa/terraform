resource "aws_detective_graph" "this" {
  count = length(var.graph)
  tags  = merge(var.tags, lookup(var.graph[count.index], "tags"))
}

resource "aws_detective_invitation_accepter" "this" {
  count     = length(var.invitation_accepter) == "0" ? "0" : length(var.graph)
  graph_arn = try(element(aws_detective_graph.this.*.graph_arn, lookup(var.invitation_accepter[count.index], "graph_id")))
}

resource "aws_detective_member" "this" {
  count                      = length(var.member) == "0" ? "0" : length(var.graph)
  account_id                 = lookup(var.member[count.index], "account_id")
  email_address              = lookup(var.member[count.index], "email_address")
  graph_arn                  = try(element(aws_detective_graph.this.*.id, lookup(var.member[count.index], "graph_id")))
  message                    = lookup(var.member[count.index], "message")
  disable_email_notification = lookup(var.member[count.index], "disable_email_notification")
}

resource "aws_detective_organization_admin_account" "this" {
  count      = length(var.organization_admin_account)
  account_id = lookup(var.organization_admin_account[count.index], "account_id")
}

resource "aws_detective_organization_configuration" "this" {
  count       = length(var.organization_configuration) == "0" ? "0" : length(var.graph)
  auto_enable = lookup(var.organization_configuration[count.index], "auto_enable")
  graph_arn   = try(element(aws_detective_graph.this.*.id, lookup(var.organization_configuration[count.index], "graph_id")))
}