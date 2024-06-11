output "adb_account_id" {
  value = try(
    alicloud_adb_account.this.*.id
  )
}

output "adb_backup_policy_id" {
  value = try(
    alicloud_adb_backup_policy.this.*.id
  )
}

output "adb_cluster_id" {
  value = try(
    alicloud_adb_cluster.this.*.id
  )
}

output "adb_connection_id" {
  value = try(
    alicloud_adb_connection.this.*.id
  )
}

output "adb_lake_account_id" {
  value = try(
    alicloud_adb_lake_account.this.*.id
  )
}

output "adb_resource_group_id" {
  value = try(
    alicloud_adb_resource_group.this.*.id
  )
}

output "adb_db_cluster" {
  value = try(
    alicloud_adb_db_cluster.this.*.id,
    alicloud_adb_db_cluster_lake_version.this.*.id
  )
}

output "gpdb_instance_id" {
  value = try(
    alicloud_gpdb_instance.this.*.id
  )
}

output "gpdb_account_id" {
  value = try(
    alicloud_gpdb_account.this.*.id,
  )
}

output "gpdb_backup_policy_id" {
  value = try(
    alicloud_gpdb_backup_policy.this.*.id
  )
}

output "gpdb_connection_id" {
  value = try(
    alicloud_gpdb_connection.this.*.id
  )
}

output "gpdb_instance_plan_id" {
  value = try(
    alicloud_gpdb_db_instance_plan.this.*.id
  )
}

output "gpdb_elastic_instance_id" {
  value = try(
    alicloud_gpdb_elastic_instance.this.*.id
  )
}