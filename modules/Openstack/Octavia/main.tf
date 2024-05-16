resource "openstack_lb_l7policy_v2" "this" {
  count            = length(var.l7policy_v2) == "0" ? "0" : length(var.listener_v2)
  action           = lookup(var.l7policy_v2[count.index], "action")
  listener_id      = try(
    element(openstack_lb_listener_v2.this.*.id, lookup(var.l7policy_v2[count.index], "listener_id"))
  )
  region           = data.openstack_identity_project_v3.this.region
  tenant_id        = data.openstack_identity_project_v3.this.id
  name             = lookup(var.l7policy_v2[count.index], "name")
  description      = lookup(var.l7policy_v2[count.index], "description")
  position         = lookup(var.l7policy_v2[count.index], "position")
  redirect_pool_id = try(
    element(openstack_lb_pool_v2.this.*.id, lookup(var.l7policy_v2[count.index], "pool_id"))
  )
  redirect_url     = lookup(var.l7policy_v2[count.index], "redirect_url")
  admin_state_up   = lookup(var.l7policy_v2[count.index], "admin_state_up")
}

resource "openstack_lb_l7rule_v2" "this" {
  count          = length(var.l7rule_v2) == "0" ? "0" : length(var.l7policy_v2)
  compare_type   = lookup(var.l7rule_v2[count.index], "compare_type")
  l7policy_id    = try(
    element(openstack_lb_l7policy_v2.this.*.id, lookup(var.l7rule_v2[count.index], "l7policy_id"))
  )
  type           = lookup(var.l7rule_v2[count.index], "type")
  value          = lookup(var.l7rule_v2[count.index], "value")
  region         = data.openstack_identity_project_v3.this.region
  key            = lookup(var.l7rule_v2[count.index], "key")
  invert         = lookup(var.l7rule_v2[count.index], "invert")
  admin_state_up = lookup(var.l7rule_v2[count.index], "admin_state_up")
}

resource "openstack_lb_listener_v2" "this" {
  count                     = length(var.listener_v2) == "0" ? "0" : length(var.loadbalancer_v2)
  loadbalancer_id           = try(
    element(openstack_lb_loadbalancer_v2.this.*.id, lookup(var.listener_v2[count.index], "loadbalancer_id"))
  )
  protocol                  = lookup(var.listener_v2[count.index], "protocol")
  protocol_port             = lookup(var.listener_v2[count.index], "protocol_port")
  region                    = data.openstack_identity_project_v3.this.region
  tenant_id                 = data.openstack_identity_project_v3.this.id
  name                      = lookup(var.listener_v2[count.index], "name")
  default_pool_id           = try(
    element(openstack_lb_pool_v2.this.*.id, lookup(var.listener_v2[count.index], "pool_id"))
  )
  description               = lookup(var.listener_v2[count.index], "description")
  connection_limit          = lookup(var.listener_v2[count.index], "connection_limit")
  timeout_client_data       = lookup(var.listener_v2[count.index], "timeout_client_data")
  timeout_member_connect    = lookup(var.listener_v2[count.index], "timeout_member_connect")
  timeout_member_data       = lookup(var.listener_v2[count.index], "timeout_member_data")
  timeout_tcp_inspect       = lookup(var.listener_v2[count.index], "timeout_tcp_inspect")
  default_tls_container_ref = lookup(var.listener_v2[count.index], "default_tls_container_ref")
  sni_container_refs        = lookup(var.listener_v2[count.index], "sni_container_refs")
  admin_state_up            = lookup(var.listener_v2[count.index], "admin_state_up")
  insert_headers            = lookup(var.listener_v2[count.index], "insert_headers")
  allowed_cidrs             = lookup(var.listener_v2[count.index], "allowed_cidrs")
}

resource "openstack_lb_loadbalancer_v2" "this" {
  count                 = length(var.loadbalancer_v2)
  region                = data.openstack_identity_project_v3.this.region
  tenant_id             = data.openstack_identity_project_v3.this.id
  vip_address           = lookup(var.loadbalancer_v2[count.index], "vip_address")
  vip_network_id        = lookup(var.loadbalancer_v2[count.index], "vip_network_id")
  vip_port_id           = lookup(var.loadbalancer_v2[count.index], "vip_port_id")
  vip_subnet_id         = lookup(var.loadbalancer_v2[count.index], "vip_subnet_id")
  name                  = lookup(var.loadbalancer_v2[count.index], "name")
  description           = lookup(var.loadbalancer_v2[count.index], "description")
  admin_state_up        = lookup(var.loadbalancer_v2[count.index], "admin_state_up")
  flavor_id             = lookup(var.loadbalancer_v2[count.index], "flavor_id")
  loadbalancer_provider = lookup(var.loadbalancer_v2[count.index], "loadbalancer_provider")
  availability_zone     = lookup(var.loadbalancer_v2[count.index], "availability_zone")
  security_group_ids    = lookup(var.loadbalancer_v2[count.index], "security_group_ids")
  tags                  = lookup(var.loadbalancer_v2[count.index], "tags")
}

resource "openstack_lb_member_v2" "this" {
  count           = length(var.member_v2) == "0" ? "0" : length(var.pool_v2)
  address         = lookup(var.member_v2[count.index], "address")
  pool_id         = try(
    element(openstack_lb_pool_v2.this.*.id, lookup(var.member_v2[count.index], "pool_id"))
  )
  protocol_port   = lookup(var.member_v2[count.index], "protocol_port")
  region          = data.openstack_identity_project_v3.this.region
  tenant_id       = data.openstack_identity_project_v3.this.id
  subnet_id       = lookup(var.member_v2[count.index], "subnet_id")
  name            = lookup(var.member_v2[count.index], "name")
  weight          = lookup(var.member_v2[count.index], "weight")
  admin_state_up  = lookup(var.member_v2[count.index], "admin_state_up")
  monitor_address = lookup(var.member_v2[count.index], "monitor_address")
  monitor_port    = lookup(var.member_v2[count.index], "monitor_port")
  backup          = lookup(var.member_v2[count.index], "backup")
}

resource "openstack_lb_members_v2" "this" {
  count   = length(var.members_v2) == "0" ? "0" : length(var.pool_v2)
  pool_id = try(
    element(openstack_lb_pool_v2.this.*.id, lookup(var.members_v2[count.index], "pool_id"))
  )
  region  = data.openstack_identity_project_v3.this.region

  dynamic "member" {
    for_each = lookup(var.member_v2[count.index], "member") == null ? [] : ["member"]
    content {
      address         = lookup(member.value, "address")
      protocol_port   = lookup(member.value, "protocol_port")
      subnet_id       = lookup(member.value, "subnet_id")
      name            = lookup(member.value, "name")
      weight          = lookup(member.value, "weight")
      monitor_port    = lookup(member.value, "monitor_port")
      monitor_address = lookup(member.value, "monitor_address")
      admin_state_up  = lookup(member.value, "admin_state_up")
      backup          = lookup(member.value, "backup")
    }
  }
}

resource "openstack_lb_monitor_v2" "this" {
  count            = length(var.monitor_v2) == "0" ? "0" : length(var.pool_v2)
  delay            = lookup(var.monitor_v2[count.index], "delay")
  max_retries      = lookup(var.monitor_v2[count.index], "max_retries")
  pool_id          = try(
    element(openstack_lb_pool_v2.this.*.id, lookup(var.monitor_v2[count.index], "pool_id"))
  )
  timeout          = lookup(var.monitor_v2[count.index], "timeout")
  type             = lookup(var.monitor_v2[count.index], "type")
  name             = lookup(var.monitor_v2[count.index], "name")
  region           = data.openstack_identity_project_v3.this.region
  tenant_id        = data.openstack_identity_project_v3.this.id
  max_retries_down = lookup(var.monitor_v2[count.index], "max_retries_down")
  url_path         = lookup(var.monitor_v2[count.index], "url_path")
  http_method      = lookup(var.monitor_v2[count.index], "http_method")
  expected_codes   = lookup(var.monitor_v2[count.index], "expected_codes")
  admin_state_up   = lookup(var.monitor_v2[count.index], "admin_state_up")
}

resource "openstack_lb_pool_v2" "this" {
  count           = length(var.pool_v2)
  lb_method       = lookup(var.pool_v2[count.index], "lb_method")
  protocol        = lookup(var.pool_v2[count.index], "protocol")
  region           = data.openstack_identity_project_v3.this.region
  tenant_id        = data.openstack_identity_project_v3.this.id
  name            = lookup(var.pool_v2[count.index], "name")
  description     = lookup(var.pool_v2[count.index], "description")
  loadbalancer_id = try(
    element(openstack_lb_loadbalancer_v2.this.*.id, lookup(var.pool_v2[count.index], "loadbalancer_id"))
  )
  listener_id     = try(
    element(openstack_lb_listener_v2.this.*.id, lookup(var.pool_v2[count.index], "listener_id"))
  )
  admin_state_up  = lookup(var.pool_v2[count.index], "admin_state_up")

  dynamic "persistence" {
    for_each = lookup(var.pool_v2[count.index], "persistence") == null ? [] : ["persistence"]
    content {
      type        = lookup(persistence.value, "type")
      cookie_name = lookup(persistence.value, "cookie_name")
    }
  }
}

resource "openstack_lb_quota_v2" "this" {
  count          = length(var.quota_v2)
  project_id     = data.openstack_identity_project_v3.this.project_id
  region         = data.openstack_identity_project_v3.this.region
  loadbalancer   = lookup(var.quota_v2[count.index], "loadbalancer")
  listener       = lookup(var.quota_v2[count.index], "listener")
  member         = lookup(var.quota_v2[count.index], "member")
  pool           = lookup(var.quota_v2[count.index], "pool")
  health_monitor = lookup(var.quota_v2[count.index], "health_monitor")
  l7_policy      = lookup(var.quota_v2[count.index], "l7_policy")
  l7_rule        = lookup(var.quota_v2[count.index], "l7_rule")
}