resource "digitalocean_loadbalancer" "loadbalancer" {
  for_each                         = var.load_balancer
  name                             = each.key
  region                           = data.digitalocean_region.this.name
  droplet_ids                      = [data.digitalocean_droplet.this.id]
  algorithm                        = each.value.algorithm
  redirect_http_to_https           = each.value.redirect_http_to_https
  enable_proxy_protocol            = each.value.enable_proxy_protocol
  enable_backend_keepalive         = each.value.enable_backend_keepalive
  http_idle_timeout_seconds        = each.value.http_idle_timeout_seconds
  disable_lets_encrypt_dns_records = each.value.disable_lets_encrypt_dns_records
  project_id                       = data.digitalocean_project.this.id
  vpc_uuid                         = data.digitalocean_vpc.this.id
  size                             = each.value.size
  size_unit                        = 1


  dynamic "forwarding_rule" {
    for_each = var.forwarding_rule
    content {
      entry_port       = forwarding_rule.value.entry_port
      entry_protocol   = forwarding_rule.value.entry_protocol
      target_port      = forwarding_rule.value.target_port
      target_protocol  = forwarding_rule.value.target_protocol
      certificate_name = data.digitalocean_certificate.this.name
      tls_passthrough  = forwarding_rule.value.tls_passthrough
    }
  }

  dynamic "healthcheck" {
    for_each = var.healthcheck
    content {
      protocol                 = healthcheck.value.protocol
      port                     = healthcheck.value.port
      path                     = healthcheck.value.path
      check_interval_seconds   = healthcheck.value.check_interval_seconds
      response_timeout_seconds = healthcheck.value.response_timeout_seconds
      unhealthy_threshold      = healthcheck.value.unealthy_threshold
      healthy_threshold        = healthcheck.value.healthy_threshold
    }
  }

  dynamic "sticky_sessions" {
    for_each = var.sticky_sessions
    content {
      type               = sticky_sessions.value.type
      cookie_name        = sticky_sessions.value.cookie_name
      cookie_ttl_seconds = sticky_sessions.value.cookie_ttl_seconds
    }
  }
}
