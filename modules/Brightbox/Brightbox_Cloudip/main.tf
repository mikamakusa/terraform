resource "brightbox_cloudip" "bbx_cloudip" {
  count       = "${length(var.cloud_ip)}"
  name        = "${lookup(var.cloud_ip[count.index],"name")}-cloudip"
  target      = "${element(var.target,lookup(var.cloud_ip[count.index],"target"))}"
  reverse_dns = "${lookup(var.cloud_ip[count.index],"reverse_dns")}"
}
