output "rule" {
  value = try(
    openstack_fw_rule_v2.this.*.id,
    openstack_fw_rule_v2.this.*.name,
    openstack_fw_rule_v2.this.*.destination_ip_address,
    openstack_fw_rule_v2.this.*.source_ip_address,
    openstack_fw_rule_v2.this.*.source_port,
    openstack_fw_rule_v2.this.*.destination_port
  )
}

output "policy" {
  value = try(
    openstack_fw_policy_v2.this.*.id,
    openstack_fw_policy_v2.this.*.name,
    openstack_fw_policy_v2.this.*.rules,
    openstack_fw_policy_v2.this.*.audited,
    openstack_fw_policy_v2.this.*.shared
  )
}

output "group" {
  value = try(
    openstack_fw_group_v2.this.*.id,
    openstack_fw_group_v2.this.*.name,
    openstack_fw_group_v2.this.*.egress_firewall_policy_id,
    openstack_fw_group_v2.this.*.ingress_firewall_policy_id
  )
}