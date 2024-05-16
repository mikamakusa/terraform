output "listener" {
  value = try(
    openstack_lb_listener_v2.this.*.id,
    openstack_lb_listener_v2.this.*.name,
    openstack_lb_listener_v2.this.*.default_pool_id,
    openstack_lb_listener_v2.this.*.loadbalancer_id
  )
}

output "loadbalancer" {
  value = try(
    openstack_lb_loadbalancer_v2.this.*.id,
    openstack_lb_loadbalancer_v2.this.*.name,
    openstack_lb_loadbalancer_v2.this.*.availability_zone,
    openstack_lb_loadbalancer_v2.this.*.loadbalancer_provider
  )
}

output "pool" {
  value = try(
    openstack_lb_pool_v2.this.*.id,
    openstack_lb_pool_v2.this.*.name,
    openstack_lb_pool_v2.this.*.loadbalancer_id,
    openstack_lb_pool_v2.this.*.lb_method
  )
}

output "l7policy" {
  value = try(
    openstack_lb_l7policy_v2.this.*.id,
    openstack_lb_l7policy_v2.this.*.name
  )
}

output "quota" {
  value = try(
    openstack_lb_quota_v2.this.*.id,
    openstack_lb_quota_v2.this.*.loadbalancer,
    openstack_lb_quota_v2.this.*.pool,
    openstack_lb_quota_v2.this.*.listener,
    openstack_lb_quota_v2.this.*.health_monitor
  )
}

output "monitor" {
  value = try(
    openstack_lb_monitor_v2.this.*.id,
    openstack_lb_monitor_v2.this.*.name,
    openstack_lb_monitor_v2.this.*.expected_codes,
    openstack_lb_monitor_v2.this.*.http_method,
    openstack_lb_monitor_v2.this.*.pool_id
  )
}

output "member" {
  value = try(
    openstack_lb_member_v2.this.*.id,
    openstack_lb_member_v2.this.*.name,
    openstack_lb_member_v2.this.*.pool_id
  )
}