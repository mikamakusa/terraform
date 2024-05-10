output "graph" {
  value = try(
    aws_detective_graph.this.*.id,
    aws_detective_graph.this.*.graph_arn,
    aws_detective_graph.this.*.tags
  )
}

output "member" {
  value = try(
    aws_detective_member.this.*.graph_arn,
    aws_detective_member.this.*.id,
    aws_detective_member.this.*.account_id,
    aws_detective_member.this.*.administrator_id,
    aws_detective_member.this.*.message
  )
}

output "invitation_accepter" {
  value = try(
    aws_detective_invitation_accepter.this.*.id,
    aws_detective_invitation_accepter.this.*.graph_arn
  )
}

output "organization_admin_account" {
  value = try(
    aws_detective_organization_admin_account.this.*.id
  )
}

output "organization_configuration" {
  value = try(
    aws_detective_organization_configuration.this.*.id
  )
}