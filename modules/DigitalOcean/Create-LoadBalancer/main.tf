resource "digitalocean_loadbalancer" "do_loadbalancer" {
  count                  = length(var.do_lb)
  name                   = lookup(var.do_lb[count.index], "name")
  region                 = lookup(var.do_lb[count.index], "region")
  droplet_ids            = [element(var.droplet_ids, lookup(var.do_lb[count.index], "droplet_ids"), null)]
  algorithm              = lookup(var.do_lb[count.index], "algorithm", null)
  redirect_http_to_https = lookup(var.do_lb[count.index], "redirect", null)
  enable_proxy_protocol  = lookup(var.do_lb[count.index], "enable_proxy_protocol", null)


  dynamic "forwarding_rule" {
    for_each = lookup(var.do_lb[count.index], "forwarding_rule")
    content {
      entry_port      = lookup(forwarding_rule.value, "entry_port")
      entry_protocol  = lookup(forwarding_rule.value, "entry_protocol")
      target_port     = lookup(forwarding_rule.value, "target_port")
      target_protocol = lookup(forwarding_rule.value, "target_protocol")
      certificate_id  = element(var.certificate_id, lookup(forwarding_rule.value, "certificate_id"), null)
      tls_passthrough = lookup(forwarding_rule.value, "tls_passthrough", null)
    }
  }

  dynamic "healthcheck" {
    for_each = lookup(var.do_lb[count.index], "healthcheck")
    content {
      protocol                 = lookup(healthcheck.value, "protocol")
      port                     = lookup(healthcheck.value, "port", null)
      path                     = lookup(healthcheck.value, "path", null)
      check_interval_seconds   = lookup(healthcheck.value, "check_interval_seconds", null)
      response_timeout_seconds = lookup(healthcheck.value, "response_timeout_seconds", null)
      unhealthy_threshold      = lookup(healthcheck.value, "unhealthy_threshold", null)
      healthy_threshold        = lookup(healthcheck.value, "healthy_threshold", null)
    }
  }

  dynamic "sticky_sessions" {
    for_each = lookup(var.do_lb[count.index], "sticky_sessions")
    content {
      type               = lookup(sticky_sessions.value, "type")
      cookie_name        = lookup(sticky_sessions.value, "cookie_name", null)
      cookie_ttl_seconds = lookup(sticky_sessions.value, "cookie_ttl_seconds", null)
    }
  }
}
