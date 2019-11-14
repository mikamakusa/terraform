resource "digitalocean_certificate" "do_certificate" {
  count             = length(var.do_certs)
  name              = join("-", [join("/",[path.cwd,lookup(var.do_certs[count.index], "name")]), "cert"])
  leaf_certificate  = file(lookup(var.do_certs[count.index], "leaf_cert"))
  private_key       = file(lookup(var.do_certs[count.index], "private_key"))
  certificate_chain = file(lookup(var.do_certs[count.index], "certificate_chain"))
}
