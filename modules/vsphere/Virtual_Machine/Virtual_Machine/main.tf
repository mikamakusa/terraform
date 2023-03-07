resource "vsphere_virtual_machine" "virtual_machine" {
  for_each         = var.general_options
  name             = each.key
  resource_pool_id = each.value.resource_pool_id

  datastore_id      = each.value.datastore_id
  datacenter_id     = each.value.datacenter_id
  storage_policy_id = each.value.storage_policy_id
  extra_config      = each.value.extra_config
  custom_attributes = each.value.custom_attributes
  firmware          = each.value.firmware
  folder            = each.value.folder
  guest_id          = each.value.guest_id
  hardware_version  = each.value.hardware_version
  host_system_id    = each.value.host_system_id
  pci_device_id     = each.value.pci_device_id
  tags              = each.value.tags

  scsi_type             = var.scsi.scsi_type
  scsi_bus_sharing      = var.scsi.scsi_bus_sharing
  scsi_controller_count = var.scsi.scsi_controller_count

  num_cpus               = var.cpu_memory_options.num_cpus
  num_cores_per_socket   = var.cpu_memory_options.num_cores_per_socket
  cpu_hot_add_enabled    = var.cpu_memory_options.cpu_hot_add_enabled
  cpu_hot_remove_enabled = var.cpu_memory_options.cpu_hot_remove_enabled
  memory                 = var.cpu_memory_options.memory
  memory_hot_add_enabled = var.cpu_memory_options.memory_hot_add_enabled

  cpu_limit          = var.resource_allocation_options.cpu_limit
  cpu_reservation    = var.resource_allocation_options.cpu_reservation
  cpu_share_count    = var.resource_allocation_options.cpu_share_count
  cpu_share_level    = var.resource_allocation_options.cpu_share_level
  memory_limit       = var.resource_allocation_options.memory_limit
  memory_reservation = var.resource_allocation_options.memory_reservation
  memory_share_count = var.resource_allocation_options.memory_share_count
  memory_share_level = var.resource_allocation_options.memory_share_level

  boot_delay              = var.boot_options.boot_delay
  boot_retry_delay        = var.boot_options.boot_retry_delay
  boot_retry_enabled      = var.boot_options.boot_retry_enabled
  efi_secure_boot_enabled = var.boot_options.efi_secure_boot_enabled

  run_tools_scripts_after_power_on        = var.tools_options.run_tools_scripts_after_power_on
  run_tools_scripts_after_resume          = var.tools_options.run_tools_scripts_after_resume
  run_tools_scripts_before_guest_reboot   = var.tools_options.run_tools_scripts_before_guest_reboot
  run_tools_scripts_before_guest_shutdown = var.tools_options.run_tools_scripts_before_guest_shutdown
  run_tools_scripts_before_guest_standby  = var.tools_options.run_tools_scripts_before_guest_standby
  sync_time_with_host                     = var.tools_options.sync_time_with_host
  sync_time_with_host_periodically        = var.tools_options.sync_time_with_host_periodically
  tools_upgrade_policy                    = var.tools_options.tools_upgrade_policy

  cpu_performance_counters_enabled = var.advanced_options.cpu_performance_counters_enabled
  enable_disk_uuid                 = var.advanced_options.enable_disk_uuid
  enable_logging                   = var.advanced_options.enable_logging
  ept_rvi_mode                     = var.advanced_options.ept_rvi_mode
  latency_sensitivity              = var.advanced_options.latency_sensitivity
  migrate_wait_timeout             = var.advanced_options.migrate_wait_timeout
  nested_hv_enabled                = var.advanced_options.nested_hv_enabled
  shutdown_wait_timeout            = var.advanced_options.shutdown_wait_timeout
  swap_placement_policy            = var.advanced_options.swap_placement_policy
  vbs_enabled                      = var.advanced_options.vbs_enabled
  vvtd_enabled                     = var.advanced_options.vvtd_enabled
  wait_for_guest_ip_timeout        = var.advanced_options.wait_for_guest_ip_timeout
  wait_for_guest_net_timeout       = var.advanced_options.wait_for_guest_net_timeout
  wait_for_guest_net_routable      = var.advanced_options.wait_for_guest_net_routable

  dynamic "network_interface" {
    for_each = var.network_interface
    content {
      network_id            = network_interface.value.network_id
      adapter_type          = network_interface.value.adapter_type
      use_static_mac        = network_interface.value.use_static_mac
      mac_address           = network_interface.value.mac_address
      bandwidth_limit       = network_interface.value.bandwidth_limit
      bandwidth_reservation = network_interface.value.bandwidth_reservation
      bandwidth_share_count = network_interface.value.bandwidth_share_count
      bandwidth_share_level = network_interface.value.bandwidth_share_level
      ovf_mapping           = network_interface.value.ovf_mapping
    }
  }

  dynamic "disk" {
    for_each = var.disk
    content {
      label             = disk.key
      size              = disk.value.size
      unit_number       = disk.value.unit_number
      datastore_id      = disk.value.datastore_id
      attach            = disk.value.attach
      path              = disk.value.path
      keep_on_remove    = disk.value.keep_on_remove
      disk_mode         = disk.value.disk_mode
      eagerly_scrub     = disk.value.eagerly_scrub
      thin_provisioned  = disk.value.thin_provisioned
      disk_sharing      = disk.value.disk_sharing
      write_through     = disk.value.write_through
      io_limit          = disk.value.io_limit
      io_reservation    = disk.value.io_reservation
      io_share_level    = disk.value.io_share_level
      io_share_count    = disk.value.io_share_count
      storage_policy_id = disk.value.storage_policy_id
      controller_type   = disk.value.controller_type
    }
  }

  dynamic "cdrom" {
    for_each = var.cdrom
    content {
      datastore_id  = cdrom.value.datastore_id
      path          = cdrom.value.path
    }
  }

  clone {
    template_uuid = var.clone.template_uuid
    linked_clone  = var.clone.linked_clone
    timeout       = var.clone.timeout
    customize {
      timeout         = var.customize.timeout
      dns_server_list = var.customize.dns_server_list
      dns_suffix_list = var.customize.dns_suffix_list
      ipv4_gateway    = var.customize.ipv4_gateway
      ipv6_gateway    = var.customize.ipv6_gateway
      network_interface {
        ipv4_address    = var.network_interface.ipv4_address
        ipv4_netmask    = var.network_interface.ipv4_netmask
        dns_domain      = var.network_interface.dns_domain
        dns_server_list = var.network_interface.dns_server_list
      }
      dynamic "linux_options" {
        for_each = var.linux_options
        content {
          domain       = linux_options.value.domain
          host_name    = linux_options.key
          hw_clock_utc = linux_options.value.hw_clock_utc
          time_zone    = linux_options.value.time_zone
        }
      }
      dynamic "windows_options" {
        for_each = var.windows_options
        content {
          computer_name         = windows_options.key
          admin_password        = windows_options.value.admin_password
          workgroup             = windows_options.value.workgroup
          join_domain           = windows_options.value.join_domain
          domain_admin_user     = windows_options.value.domain_admin_user
          domain_admin_password = windows_options.value.domain_admin_password
          organization_name     = windows_options.value.organization_name
          product_key           = windows_options.value.product_key
          run_once_command_list = windows_options.value.run_once_command_list
          auto_logon            = windows_options.value.auto_logon
          auto_logon_count      = windows_options.value.auto_logon_count
          time_zone             = windows_options.value.time_zone
        }
      }
      windows_sysprep_text = ""
    }
  }
  dynamic "ovf_deploy" {
    for_each = var.ovf_deploy
    content {
      allow_unverified_ssl_cert = ovf_deploy.value.allow_unverified_ssl_cert
      enable_hidden_properties  = ovf_deploy.value.enable_hidden_properties
      local_ovf_path            = ovf_deploy.value.local_ovf_path
      remote_ovf_url            = ovf_deploy.value.remote_ovf_url
      ip_allocation_policy      = ovf_deploy.value.ip_allocation_policy
      ip_protocol               = ovf_deploy.value.ip_protocol
      disk_provisioning         = ovf_deploy.value.disk_provisioning
      deployment_option         = ovf_deploy.value.deployment_option
      ovf_network_map           = ovf_deploy.value.ovf_network_map
    }
  }
}