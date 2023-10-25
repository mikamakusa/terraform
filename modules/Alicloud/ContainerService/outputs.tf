output "vpcs" {
  value = try(
    data.alicloud_vpcs.this,
    alicloud_vpc.this
  )
}

output "vswitches" {
  value = try(
    data.alicloud_vswitches.this,
    alicloud_vswitch.this
  )
}

output "security_groups" {
  value = try(
    data.alicloud_security_groups.this,
    alicloud_security_group.this
  )
}

output "scaling_groups" {
  value = try(
    data.alicloud_ess_scaling_groups.this,
    alicloud_ess_scaling_group.this
  )
}

output "scaling_configurations" {
  value = try(
    data.alicloud_ess_scaling_configurations.this,
    alicloud_ess_scaling_configuration.this
  )
}

output "kubernetes_clusters" {
  value = try(
    alicloud_cs_managed_kubernetes.this,
    alicloud_cs_edge_kubernetes.this,
    alicloud_cs_serverless_kubernetes.this
  )
}

output "kubernetes_node_pool" {
  value = try(
    alicloud_cs_kubernetes_node_pool.this
  )
}

output "policy" {
  value = try(
    alicloud_ram_user.this,
    alicloud_ram_policy.this,
    alicloud_ram_user_policy_attachment.this
  )
}

output "kms_keys" {
  value = try(
    data.alicloud_kms_keys.this,
    alicloud_kms_key.this
  )
}