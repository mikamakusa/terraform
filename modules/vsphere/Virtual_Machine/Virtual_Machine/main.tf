resource "vsphere_virtual_machine" "vm" {
  for_each               = var.vm
  name                   = each.key
  resource_pool_id       = data.vsphere_compute_cluster.cluster.id
  datastore_id           = data.vsphere_datastore.datastore.id
  num_cpus               = each.value.num_cpus
  cpu_hot_add_enabled    = true
  cpu_hot_remove_enabled = true
  memory                 = each.value.memory
  memory_hot_add_enabled = true
  guest_id               = each.value.guest_id

  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label            = each.value.disk_value
    size             = each.value.disk_size
    thin_provisioned = true
  }
}

resource "vsphere_virtual_machine" "clone_linux" {
  for_each         = var.clone_linux
  name             = each.key
  resource_pool_id = data.vsphere_compute_cluster.cluster.id
  datastore_id     = data.vsphere_datastore.datastore.id
  datacenter_id    = data.vsphere_datacenter.datacenter.id
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        domain    = each.value.domain
        host_name = each.key
      }
      network_interface {
        ipv4_address = each.value.ipv4_address
        ipv4_netmask = each.value.ipv4_netmask
      }
    }
  }
}

resource "vsphere_virtual_machine" "clone_windows" {
  for_each         = var.clone_windows
  name             = each.key
  resource_pool_id = data.vsphere_compute_cluster.cluster.id
  datastore_id     = data.vsphere_datastore.datastore.id
  datacenter_id    = data.vsphere_datacenter.datacenter.id
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      windows_options {
        computer_name = each.key
      }
      network_interface {
        ipv4_address = each.value.ipv4_address
        ipv4_netmask = each.value.ipv4_netmask
      }
    }
  }
}

resource "vsphere_virtual_machine" "from_ovf" {
  for_each             = var.from_ovf
  name                 = each.key
  datacenter_id        = data.vsphere_datacenter.datacenter.id
  datastore_id         = data.vsphere_datastore.datastore.id
  host_system_id       = data.vsphere_host.host.id
  resource_pool_id     = data.vsphere_compute_cluster.cluster.id
  num_cpus             = data.vsphere_ovf_vm_template.ovf_template.num_cpus
  num_cores_per_socket = data.vsphere_ovf_vm_template.ovf_template.num_cores_per_socket
  memory               = data.vsphere_ovf_vm_template.ovf_template.memory
  guest_id             = data.vsphere_ovf_vm_template.ovf_template.guest_id
  scsi_type            = data.vsphere_ovf_vm_template.ovf_template.scsi_type
  nested_hv_enabled    = data.vsphere_ovf_vm_template.ovf_template.nested_hv_enabled

  dynamic "network_interface" {
    for_each = data.vsphere_ovf_vm_template.ovf_template.ovf_network_map
    content {
      network_id = network_interface.value
    }
  }
  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  ovf_deploy {
    allow_unverified_ssl_cert = false
    remote_ovf_url            = data.vsphere_ovf_vm_template.ovf_template.remote_ovf_url
    disk_provisioning         = data.vsphere_ovf_vm_template.ovf_template.disk_provisioning
    ovf_network_map           = data.vsphere_ovf_vm_template.ovf_template.ovf_network_map
  }

  vapp {
    properties = each.value.vapp
  }
}