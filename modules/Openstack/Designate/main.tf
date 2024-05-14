resource "openstack_dns_recordset_v2" "this" {
  count                = length(var.recordset_v2) == "0" ? "0" : length(var.zone_v2)
  name                 = lookup(var.recordset_v2[count.index], "name")
  records              = lookup(var.recordset_v2[count.index], "records")
  zone_id              = try(element(openstack_dns_zone_v2.this.*.id, lookup(var.recordset_v2[count.index], "zone_id")))
  region               = data.openstack_identity_project_v3.this.region
  project_id           = data.openstack_identity_project_v3.this.id
  type                 = lookup(var.recordset_v2[count.index], "type")
  ttl                  = lookup(var.recordset_v2[count.index], "ttl")
  description          = lookup(var.recordset_v2[count.index], "description")
  value_specs          = lookup(var.recordset_v2[count.index], "value_specs")
  disable_status_check = lookup(var.recordset_v2[count.index], "disable_status_check")
}

resource "openstack_dns_transfer_accept_v2" "this" {
  count                    = length(var.transfer_accept_v2) == "0" ? "0" : length(var.transfer_request_v2)
  key                      = try(element(openstack_dns_transfer_request_v2.this.*.key, lookup(var.transfer_accept_v2[count.index], "zone_id")))
  zone_transfer_request_id = try(element(openstack_dns_transfer_request_v2.this.*.id, lookup(var.transfer_accept_v2[count.index], "zone_transfer_request_id")))
  region                   = data.openstack_identity_project_v3.this.region
  value_specs              = lookup(var.transfer_accept_v2[count.index], "value_specs")
  disable_status_check     = lookup(var.transfer_accept_v2[count.index], "disable_status_check")
}

resource "openstack_dns_transfer_request_v2" "this" {
  count                = length(var.transfer_request_v2) == "0" ? "0" : length(var.zone_v2)
  zone_id              = try(element(openstack_dns_zone_v2.this.*.id, lookup(var.transfer_request_v2[count.index], "zone_id")))
  region               = data.openstack_identity_project_v3.this.region
  target_project_id    = lookup(var.transfer_request_v2[count.index], "target_project_id")
  description          = lookup(var.transfer_request_v2[count.index], "description")
  value_specs          = lookup(var.transfer_request_v2[count.index], "value_specs")
  disable_status_check = lookup(var.transfer_request_v2[count.index], "disable_status_check")
}

resource "openstack_dns_zone_v2" "this" {
  count                = length(var.zone_v2)
  name                 = lookup(var.zone_v2[count.index], "name")
  region               = data.openstack_identity_project_v3.this.region
  project_id           = data.openstack_identity_project_v3.this.id
  email                = lookup(var.zone_v2[count.index], "email")
  type                 = lookup(var.zone_v2[count.index], "type")
  attributes           = lookup(var.zone_v2[count.index], "attributes")
  ttl                  = lookup(var.zone_v2[count.index], "ttl")
  description          = lookup(var.zone_v2[count.index], "description")
  masters              = lookup(var.zone_v2[count.index], "masters")
  value_specs          = lookup(var.zone_v2[count.index], "value_specs")
  disable_status_check = lookup(var.zone_v2[count.index], "disable_status_check")
}