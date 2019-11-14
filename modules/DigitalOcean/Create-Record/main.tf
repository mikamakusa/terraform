resource "digitalocean_record" "do_record" {
  count    = length(var.do_record)
  domain   = lookup(var.do_record[count.index], "domain")
  type     = lookup(var.do_record[count.index], "type")
  name     = lookup(var.do_record[count.index], "name")
  value    = lookup(var.do_record[count.index], "value")
  port     = lookup(var.do_record[count.index], "port", null)
  priority = lookup(var.do_record[count.index], "priority", null)
  weight   = lookup(var.do_record[count.index], "weight", null)
  ttl      = lookup(var.do_record[count.index], "ttl", null)
  flags    = lookup(var.do_record[count.index], "flags", null)
  tag      = lookup(var.do_record[count.index], "tag", null)
}
