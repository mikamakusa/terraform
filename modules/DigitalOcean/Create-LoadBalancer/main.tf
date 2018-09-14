resource "digitalocean_loadbalancer" "do_loadbalancer" {
  count                  = "${length(var.do_lb)}"
  name                   = "${lookup(var.do_lb[count.index], "name")}"
  region                 = "${lookup(var.do_lb[count.index], "region")}"
  droplet_ids            = ["${element(var.droplet_ids, count.index)}"]
  algorithm              = "${lookup(var.do_lb[count.index], "algorithm")}"
  redirect_http_to_https = "${lookup(var.do_lb[count.index], "redirect")}"

  "forwarding_rule" {
    entry_port      = "${lookup(var.do_lb, "rule_entry_port")}"
    entry_protocol  = "${lookup(var.do_lb, "rule_entry_proto")}"
    target_port     = "${lookup(var.do_lb, "rule_target_port")}"
    target_protocol = "${lookup(var.do_lb, "rule_target_proto")}"
    certificate_id  = "${lookup(var.do_lb, "rule_cert_id")}"
    tls_passthrough = "${lookup(var.do_lb, "rule_tls")}"
  }

  healthcheck {
    port                     = "${lookup(var.do_lb, "hc_port")}"
    protocol                 = "${lookup(var.do_lb, "hc_proto")}"
    path                     = "${lookup(var.do_lb, "hc_path")}"
    check_interval_seconds   = "${lookup(var.do_lb, "hc_interval")}"
    response_timeout_seconds = "${lookup(var.do_lb, "hc_timeout")}"
    unhealthy_threshold      = "${lookup(var.do_lb, "hc_unhealthy")}"
    healthy_threshold        = "${lookup(var.do_lb, "hc_healthy")}"
  }

  sticky_sessions {
    type               = "${lookup(var.do_lb, "sticky_type")}"
    cookie_name        = "${lookup(var.do_lb, "sticky_cookie")}"
    cookie_ttl_seconds = "${lookup(var.do_lb, "sticky_ttl")}"
  }
}
