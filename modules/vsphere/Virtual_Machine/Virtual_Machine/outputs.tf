output "virtual_machine_id" {
  value = vsphere_virtual_machine.virtual_machine.*.id
}