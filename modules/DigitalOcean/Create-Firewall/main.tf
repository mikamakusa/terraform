resource "digitalocean_firewall" "do_firewall" {
  count       = "${length(var.do_firewall)}"
  name        = "${lookup(var.do_firewall[count.index], "name")}"
  droplet_ids = ["${element(var.droplet_ids, count.index)}"]

  inbound_rule = ["${element(var.inbound_rules, count.index)}"]

  outbound_rule = ["${element(var.outbound_rules, count.index)}"]
}
