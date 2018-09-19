resource "brightbox_server" "bbx_server" {
  depends_on    = ["brightbox_server_group.bbx_server_group"]
  count         = "${length(var.bbx_server)}"
  name          = "${lookup(var.bbx_server[count.index],"name")}"
  image         = "${lookup(var.bbx_server[count.index],"image")}"
  type          = "${lookup(var.bbx_server[count.index],"type")}"
  zone          = "${lookup(var.bbx_server[count.index],"zone")}"
  user_data     = "${element(var.user_data,lookup(var.bbx_server[count.index],"user_data_id"))}"
  server_groups = ["${element(brightbox_server_group.bbx_server_group.name,lookup(var.bbx_server[count.index],"server_group_name"))}"]
}

resource "brightbox_server_group" "bbx_server_group" {
  count       = "${length(var.bbx_server_group)}"
  name        = "${lookup(var.bbx_server_group[count.index],"name")}"
  description = "${lookup(var.bbx_server_group[count.index],"description")}"
}
