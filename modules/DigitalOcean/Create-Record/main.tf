resource "digitalocean_record" "do_record" {
  count  = "${length(var.do_record)}"
  domain = "${lookup(var.do_record[count.index], "domain")}"
  type   = "${lookup(var.do_record[count.index], "type")}"
  name   = "${lookup(var.do_record[count.index], "name")}"
  value  = "${lookup(var.do_record[count.index], "value")}"
}
