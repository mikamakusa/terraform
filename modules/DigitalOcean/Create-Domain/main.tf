resource "digitalocean_domain" "do_domain" {
  count      = length(var.do_domain)
  ip_address = lookup(var.do_domain[count.index], "ip_address", null)
  name       = lookup(var.do_domain[count.index], "name")
}
