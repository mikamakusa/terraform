variable "general_options" {
  type = map(object({
    resource_pool_id  = string
    datastore_id      = optional(string)
    datacenter_id     = optional(string)
    storage_policy_id = optional(string)
    extra_config      = optional(map(string))
    custom_attributes = optional(map(string))
    firmware          = optional(string)
    folder            = optional(string)
    guest_id          = optional(string)
    hardware_version  = optional(number)
    host_system_id    = optional(string)
    pci_device_id     = optional(list(string))
    tags              = optional(map(any))
  }))
}

variable "cpu_memory_options" {
  type = object({
    num_cpus               = optional(number)
    num_cores_per_socket   = optional(number)
    cpu_hot_add_enabled    = optional(bool)
    cpu_hot_remove_enabled = optional(bool)
    memory                 = optional(number)
    memory_hot_add_enabled = optional(bool)
  })
  default = {}
}

variable "boot_options" {
  type = object({
    boot_delay              = optional(number)
    boot_retry_delay        = optional(number)
    boot_retry_enabled      = optional(bool)
    efi_secure_boot_enabled = optional(bool)
  })
  default = {}
}

variable "tools_options" {
  type = object({
    run_tools_scripts_after_power_on        = optional(bool)
    run_tools_scripts_after_resume          = optional(bool)
    run_tools_scripts_before_guest_reboot   = optional(bool)
    run_tools_scripts_before_guest_shutdown = optional(bool)
    run_tools_scripts_before_guest_standby  = optional(bool)
    sync_time_with_host                     = optional(bool)
    sync_time_with_host_periodically        = optional(bool)
    tools_upgrade_policy                    = optional(string)
  })
  default = {}
}

variable "resource_allocation_options" {
  type = object({
    cpu_limit          = optional(number)
    cpu_reservation    = optional(number)
    cpu_share_count    = optional(number)
    cpu_share_level    = optional(string)
    memory_limit       = optional(number)
    memory_reservation = optional(number)
    memory_share_count = optional(number)
    memory_share_level = optional(string)
  })
  default = {}
}

variable "advanced_options" {
  type = object({
    cpu_performance_counters_enabled = optional(bool)
    enable_disk_uuid                 = optional(bool)
    enable_logging                   = optional(bool)
    ept_rvi_mode                     = optional(string)
    latency_sensitivity              = optional(string)
    migrate_wait_timeout             = optional(number)
    nested_hv_enabled                = optional(bool)
    shutdown_wait_timeout            = optional(number)
    swap_placement_policy            = optional(string)
    vbs_enabled                      = optional(bool)
    vvtd_enabled                     = optional(bool)
    wait_for_guest_ip_timeout        = optional(number)
    wait_for_guest_net_timeout       = optional(number)
    wait_for_guest_net_routable      = optional(bool)
  })
  default = {}
}

variable "scsi" {
  type = object({
    scsi_type             = optional(string)
    scsi_bus_sharing      = optional(string)
    scsi_controller_count = optional(string)
  })
  default = {}
}

variable "network_interface" {
  type = object({
    network_id            = string
    adapter_type          = optional(string)
    use_static_mac        = optional(bool)
    mac_address           = optional(string)
    bandwidth_limit       = optional(number)
    bandwidth_reservation = optional(number)
    bandwidth_share_count = optional(number)
    bandwidth_share_level = optional(string)
    ovf_mapping           = optional(string)
    ipv4_address          = optional(string)
    ipv4_netmask          = optional(string)
    dns_domain            = optional(string)
    dns_server_list       = optional(list(string))
  })
  default = null
}

variable "disk" {
  type = map(object({
    size              = number
    unit_number       = optional(number)
    datastore_id      = optional(string)
    attach            = optional(string)
    path              = optional(string)
    keep_on_remove    = optional(bool)
    disk_mode         = optional(string)
    eagerly_scrub     = optional(bool)
    thin_provisioned  = optional(bool)
    disk_sharing      = optional(string)
    write_through     = optional(bool)
    io_limit          = optional(number)
    io_reservation    = optional(number)
    io_share_level    = optional(string)
    io_share_count    = optional(number)
    storage_policy_id = optional(string)
    controller_type   = optional(string)
  }))
}

variable "cdrom" {
  type = object({
    datastore_id = optional(string)
    path         = optional(string)
  })
  default = {}
}

variable "ovf_deploy" {
  type = object({
    allow_unverified_ssl_cert = optional(bool)
    enable_hidden_properties  = optional(bool)
    local_ovf_path            = optional(string)
    remote_ovf_url            = optional(string)
    ip_allocation_policy      = optional(string)
    ip_protocol               = optional(string)
    disk_provisioning         = optional(string)
    deployment_option         = optional(string)
    ovf_network_map           = optional(map(string))
  })
  default = {}
}

variable "clone" {
  type = object({
    template_uuid = optional(string)
    linked_clone  = optional(string)
    timeout       = optional(string)
  })
}

variable "customize" {
  type = object({
    timeout         = optional(number)
    dns_server_list = optional(list(string))
    dns_suffix_list = optional(list(string))
    ipv4_gateway    = optional(string)
    ipv6_gateway    = optional(string)
  })
  default = {}
}

variable "linux_options" {
  type = map(object({
    domain       = optional(string)
    hw_clock_utc = optional(bool)
    time_zone    = optional(string)
  }))
  default = {}
}

variable "windows_options" {
  type = map(object({
    admin_password        = optional(string)
    workgroup             = optional(string)
    join_domain           = optional(string)
    domain_admin_user     = optional(string)
    domain_admin_password = optional(string)
    organization_name     = optional(string)
    product_key           = optional(string)
    run_once_command_list = optional(list(string))
    auto_logon            = optional(bool)
    auto_logon_count      = optional(number)
    time_zone             = optional(string)
    windows_sysprep_text  = optional(string)
  }))
  default = {}
}