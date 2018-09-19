resource "brightbox_load_balancer" "bbx_loadbalancer" {
  count           = "${length(var.bbx_lb)}"
  name            = "${lookup(var.bbx_lb[count.index],"name")}"
  healthcheck     = ["${element(var.bbx_hc,lookup(var.bbx_lb[count.index],"hc_id"))}"]
  listener        = ["${element(var.listener,lookup(var.bbx_lb[count.index],"listener_id"))}"]
  nodes           = ["${element(var.nodes,lookup(var.bbx_lb[count.index],"node_id"))}"]
  certificate_pem = ["${element(var.certs,lookup(var.bbx_lb[count.index],"cert_id"))}"]
}
