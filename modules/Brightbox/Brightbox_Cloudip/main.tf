resource "brightbox_cloudip" "bbx_cloudip" {
  count       = length(var.cloud_ip)
  name        = join("-",[lookup(var.cloud_ip[count.index],"name"),"cloudip"])
  target      = element(var.target,lookup(var.cloud_ip[count.index],"target"))
  reverse_dns = lookup(var.cloud_ip[count.index],"reverse_dns")

  dynamic "port_translator" {
    for_each = lookup(var.cloud_ip[count.index], "port_translator")
    content {
      incoming = lookup(port_translator.value, "incoming")
      outgoing = lookup(port_translator.value, "outgoing")
      protocol = lookup(port_translator.value, "protocol")
    }
  }

  dynamic "lifecycle" {
    for_each = lookup(var.cloud_ip, "lifecycle")
    content {
      create_before_destroy = lookup(lifecycle.value, "create_before_destroy", true)
      prevent_destroy = lookup(lifecycle.value, "prevent_destory", false)
      ignore_changes = [lookup(lifecycle.value, "ignore_changes", null)]
    }
  }
}
