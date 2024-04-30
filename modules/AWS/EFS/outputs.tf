output "file_system" {
  value = try(aws_efs_file_system.this)
}

output "access_point" {
  value = try(aws_efs_access_point.this)
}

output "backup_policy" {
  value = try(aws_efs_backup_policy.this)
}

output "file_system_policy" {
  value = try(aws_efs_file_system_policy.this)
}

output "mount_target" {
  value = try(aws_efs_mount_target.this)
}

output "replication_configuration" {
  value = try(aws_efs_replication_configuration.this)
}