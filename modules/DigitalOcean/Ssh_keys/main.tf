resource "digitalocean_ssh_key" "do_ssh_keys" {
  count      = "${length(var.ssh_key)}"
  name       = "${lookup(var.ssh_key[count.index], "name")}"
  public_key = "${lookup(var.ssh_key[count.index], "pub_key")}"
}
