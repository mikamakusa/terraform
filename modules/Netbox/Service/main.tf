resource "netbox_service" "service" {
  count              = length(var.service)
  name               = lookup(var.service[count.index], "name")
  protocol           = lookup(var.service[count.index], "protocol")
  virtual_machine_id = element(var.virtual_machine_id, lookup(var.service[count.index], "virtual_machine_id"))
  ports              = lookup(var.service[count.index], "ports", [])
}