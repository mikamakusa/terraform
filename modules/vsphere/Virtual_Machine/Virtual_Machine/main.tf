resource "vsphere_virtual_machine" "virtual_machine" {
  count            = var.instances
  name             = join("-", [var.vmname, count.index + 1])
  resource_pool_id = data.vsphere_resource_pool.resource_pool.id

  ## Options to hardcode
  datastore_cluster_id    = var.datastore_cluster != "" ? data.vsphere_datastore_cluster.datastore_cluster.id : null
  datastore_id            = var.datastore != "" ? data.vsphere_datastore.datastore.id : null
  folder                  = var.folder != "" ? data.vsphere_folder.folder.path : null
  tags                    = var.tags_ids != null ? var.tags_ids : data.vsphere_tag.tag[*].id
  custom_attributes       = var.custom_attributes
  extra_config            = var.extra_config
  firmware                = var.general_options.firmware
  efi_secure_boot_enabled = var.general_options.firmware == "efi" ? true : false
  boot_retry_enabled      = true
  boot_retry_delay        = 10000
  enable_disk_uuid        = true
  storage_policy_id       = data.vsphere_storage_policy.storage_policy.id
  scsi_type               = var.general_options.scsi_type
  scsi_controller_count   = ""
  scsi_bus_sharing        = var.general_options.scsi_bus_sharing
  ### CPU
  num_cpus               = var.general_options.num_cpus == null ? 1 : var.general_options.num_cpus
  num_cores_per_socket   = var.general_options.num_cores_per_socket == null ? 1 : var.general_options.num_cores_per_socket
  cpu_hot_add_enabled    = true
  cpu_hot_remove_enabled = true
  cpu_reservation        = var.general_options.cpu_reservation != null ? var.general_options.cpu_reservation : null
  cpu_share_level        = var.general_options.cpu_share_level != "normal" ? var.general_options.cpu_share_level : "normal"
  cpu_share_count        = var.general_options.cpu_share_level == "custom" ? var.general_options.cpu_share_count : 4000
  cpu_limit              = var.general_options.cpu_limit
  ### MEMORY
  memory                 = var.general_options.memory == null ? 1024 : var.general_options.memory
  memory_hot_add_enabled = true
  memory_limit           = var.general_options.memory_limit
  memory_reservation     = var.general_options.memory_reservation
  memory_share_count     = var.general_options.memory_share_count
  memory_share_level     = var.general_options.memory_share_level
  ### NETWORK
  wait_for_guest_ip_timeout        = true
  wait_for_guest_net_routable      = true
  wait_for_guest_net_timeout       = true
  ignored_guest_ips                = var.general_options.ignored_guest_ips
  hv_mode                          = var.general_options.hv_mode == "" ? "hvAuto" : var.general_options.hv_mode
  ept_rvi_mode                     = var.general_options.ept_rvi_mode == "" ? "automatic" : var.general_options.ept_rvi_mode
  nested_hv_enabled                = true
  vbs_enabled                      = true
  vvtd_enabled                     = true
  enable_logging                   = true
  cpu_performance_counters_enabled = true
  swap_placement_policy            = var.general_options.swap_placement_policy
  latency_sensitivity              = var.general_options.latency_sensitivity
  force_power_off                  = true


  network_interface {
    network_id = data.vsphere_network.network.id
  }

  dynamic "disk" {
    for_each = var.disk
    content {
      label             = disk.key
      size              = disk.value.size
      unit_number       = disk.value.unit_number
      thin_provisioned  = disk.value.eagerly_scrub == true ? false : true
      eagerly_scrub     = disk.value.thin_provisioned == true ? false : true
      datastore_id      = data.vsphere_datastore.datastore.id
      storage_policy_id = data.vsphere_storage_policy.storage_policy.id
      io_share_level    = disk.value.io_share_level
      io_share_count    = disk.value.io_share_count
      disk_sharing      = disk.value.disk_sharing
      keep_on_remove    = false
      disk_mode         = disk.value.disk_mode
      controller_type   = disk.value.controller_type
    }
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      ipv4_gateway    = var.ipv4_gateway
      dns_server_list = var.dns_server_list
      dns_suffix_list = var.dns_suffix_list
      network_interface {
        ipv4_address = var.clone.network_address != "0.0.0.0" ? cidrhost(var.clone.network_address, var.clone.netmask) : ""
        ipv4_netmask = var.clone.network_address != "0.0.0.0" ? cidrnetmask(join("/", [var.clone.network_address, var.clone.netmask])) : ""
      }

      dynamic "linux_options" {
        for_each = var.linux ? 1 : 0
        content {
          domain       = var.domain
          host_name    = join("-", [var.vmname, count.index + 1])
          hw_clock_utc = true
          time_zone    = "Europe"
        }
      }
      dynamic "windows_options" {
        for_each = var.windows ? 1 : 0
        content {
          computer_name  = join("-", [var.vmname, count.index + 1])
          admin_password = var.admin_password
          workgroup      = var.workgroup
          time_zone      = "Europe"
        }
      }
    }
  }
}