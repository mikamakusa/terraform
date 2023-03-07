resource "vsphere_vapp_entity" "vapp_entity" {
  container_id = var.container_id
  target_id    = var.target_id
  start_order = var.start.order
  start_action = var.start.action
  start_delay = var.start.delay
  stop_action = var.stop.action
  stop_delay = var.stop.delay
  wait_for_guest = var.wait_for_guest
}