output "workspace_directory" {
  value = try(aws_workspaces_directory.this)
}

output "workspace_ip_group" {
  value = try(aws_workspaces_ip_group.this)
}

output "workspace" {
  value = try(aws_workspaces_workspace.this)
}