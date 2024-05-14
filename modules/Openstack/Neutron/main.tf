resource "openstack_fw_group_v2" "this" {
  count                      = length(var.group_v2)
  region                     = data.openstack_identity_project_v3.this.region
  name                       = lookup(var.group_v2[count.index], "name")
  description                = lookup(var.group_v2[count.index], "description")
  tenant_id                  = data.openstack_identity_project_v3.this.id
  project_id                 = data.openstack_identity_project_v3.this.project_id
  ingress_firewall_policy_id = lookup(var.group_v2[count.index], "ingress_firewall_policy_id")
  egress_firewall_policy_id  = lookup(var.group_v2[count.index], "egress_firewall_policy_id")
  admin_state_up             = lookup(var.group_v2[count.index], "admin_state_up")
  ports                      = lookup(var.group_v2[count.index], "ports")
  shared                     = lookup(var.group_v2[count.index], "shared")
}

resource "openstack_fw_policy_v2" "this" {
  count       = length(var.policy_v2)
  region      = data.openstack_identity_project_v3.this.region
  tenant_id   = data.openstack_identity_project_v3.this.id
  project_id  = data.openstack_identity_project_v3.this.project_id
  name        = lookup(var.policy_v2[count.index], "name")
  description = lookup(var.policy_v2[count.index], "description")
  rules       = lookup(var.policy_v2[count.index], "rules")
  audited     = lookup(var.policy_v2[count.index], "audited")
  shared      = lookup(var.policy_v2[count.index], "shared")
}

resource "openstack_fw_rule_v2" "this" {
  count                  = length(var.rule_v2)
  region                 = data.openstack_identity_project_v3.this.region
  tenant_id              = data.openstack_identity_project_v3.this.id
  project_id             = data.openstack_identity_project_v3.this.project_id
  name                   = lookup(var.rule_v2[count.index], "name")
  description            = lookup(var.rule_v2[count.index], "description")
  protocol               = lookup(var.rule_v2[count.index], "protocol")
  action                 = lookup(var.rule_v2[count.index], "action")
  ip_version             = lookup(var.rule_v2[count.index], "ip_version")
  source_ip_address      = lookup(var.rule_v2[count.index], "source_ip_address")
  destination_ip_address = lookup(var.rule_v2[count.index], "destination_ip_address")
  source_port            = lookup(var.rule_v2[count.index], "source_port")
  destination_port       = lookup(var.rule_v2[count.index], "destination_port")
  shared                 = lookup(var.rule_v2[count.index], "shared")
  enabled                = lookup(var.rule_v2[count.index], "enabled")
}