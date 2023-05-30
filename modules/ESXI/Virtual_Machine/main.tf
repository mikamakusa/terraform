resource "esxi_resource_pool" "resource_pool" {
  for_each = var.resource_pool
  resource_pool_name = each.key
  cpu_min = each.value.cpu_min
  cpu_max = each.value.cpu_max
  cpu_max_shares = each.value.cpu_max_shares
  mem_min = each.value.mem_min
  mem_max = each.value.mem_max
  mem_shares = each.value.mem_shares
}

resource "esxi_virtual_disk" "virtual_disk" {
  for_each = var.virtual_disk
  virtual_disk_name = each.key
  virtual_disk_disk_store = each.value.virtual_disk_disk_store
  virtual_disk_dir = each.value.virtual_disk_dir
  virtual_disk_size = each.value.virtual_disk_size
  virtual_disk_type = each.value.virtual_disk_type
}

resource "esxi_guest" "guest" {
  for_each = var.guest
  guest_name = each.key
  boot_disk_type = each.value.boot_disk_type
  boot_disk_size = each.value.boot_disk_size
  guestos = each.value.guestos
  boot_firmware = each.value.boot_firmware
  clone_from_vm = each.value.clone_from_vm
  ovf_source = join("/", [each.value.datastore, join(".", [each.value.clone_from_vm, "vmx"])])
  disk_store = each.value.disk_store
  resource_pool_name = esxi_resource_pool.resource_pool[each.value.resource_pool_name].id
  memsize = each.value.memsize
  numvcpus = each.value.numvcpus
  power = "on"
  guest_startup_timeout = "30"
  guest_shutdown_timeout = "30"

  dynamic "network_interfaces" {
    for_each = each.value.network_interfaces
    content {
      virtual_network = network_interfaces.value.virtual_network
      mac_address = network_interfaces.value.mac_address
      nic_type = network_interfaces.value.nic_type 
    }
  }

  dynamic "virtual_disks" {
    for_each = each.value.virtual_disks
    content {
      virtual_disk_id = virtual_disks.value.virtual_disk_id  
      slot = virtual_disks.value.slot
    }
  }
}