output "vpcs" {
  value = try(
    data.alicloud_vpcs.this,
    alicloud_vpc.this
  )
}

output "zones" {
  value = try(
    data.alicloud_zones.this
  )
}

output "vswitches" {
  value = try(
    data.alicloud_vswitches.this,
    alicloud_vswitch.this
  )
}

output "kms_keys" {
  value = try(
    data.alicloud_kms_keys.this,
    alicloud_kms_key.this
  )
}

output "security_groups" {
  value = try(
    data.alicloud_security_groups.this,
    alicloud_security_group.this
  )
}

output "resource_groups" {
  value = try(
    data.alicloud_resource_manager_resource_groups.this,
    alicloud_resource_manager_resource_group.this
  )
}

output "alikafka_instances" {
  value = try(
    alicloud_alikafka_instance.this,
    data.alicloud_alikafka_instances.this
  )
}

output "topic" {
  value = try(
    alicloud_alikafka_topic.this
  )
}

output "sasl" {
  value = try(
    alicloud_alikafka_sasl_acl.this,
    alicloud_alikafka_sasl_user.this
  )
}

output "allowed_ip_attachment" {
  value = try(
    alicloud_alikafka_instance_allowed_ip_attachment.this
  )
}