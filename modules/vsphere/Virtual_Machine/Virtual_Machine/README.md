## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_vsphere"></a> [vsphere](#requirement\_vsphere) | 2.3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vsphere"></a> [vsphere](#provider\_vsphere) | 2.3.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vsphere_virtual_machine.virtual_machine](https://registry.terraform.io/providers/hashicorp/vsphere/2.3.1/docs/resources/virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_advanced_options"></a> [advanced\_options](#input\_advanced\_options) | n/a | <pre>object({<br>    cpu_performance_counters_enabled = optional(bool)<br>    enable_disk_uuid                 = optional(bool)<br>    enable_logging                   = optional(bool)<br>    ept_rvi_mode                     = optional(string)<br>    latency_sensitivity              = optional(string)<br>    migrate_wait_timeout             = optional(number)<br>    nested_hv_enabled                = optional(bool)<br>    shutdown_wait_timeout            = optional(number)<br>    swap_placement_policy            = optional(string)<br>    vbs_enabled                      = optional(bool)<br>    vvtd_enabled                     = optional(bool)<br>    wait_for_guest_ip_timeout        = optional(number)<br>    wait_for_guest_net_timeout       = optional(number)<br>    wait_for_guest_net_routable      = optional(bool)<br>  })</pre> | `{}` | no |
| <a name="input_boot_options"></a> [boot\_options](#input\_boot\_options) | n/a | <pre>object({<br>    boot_delay              = optional(number)<br>    boot_retry_delay        = optional(number)<br>    boot_retry_enabled      = optional(bool)<br>    efi_secure_boot_enabled = optional(bool)<br>  })</pre> | `{}` | no |
| <a name="input_cdrom"></a> [cdrom](#input\_cdrom) | n/a | <pre>object({<br>    datastore_id = optional(string)<br>    path         = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_clone"></a> [clone](#input\_clone) | n/a | <pre>object({<br>    template_uuid = optional(string)<br>    linked_clone  = optional(string)<br>    timeout       = optional(string)<br>  })</pre> | n/a | yes |
| <a name="input_cpu_memory_options"></a> [cpu\_memory\_options](#input\_cpu\_memory\_options) | n/a | <pre>object({<br>    num_cpus               = optional(number)<br>    num_cores_per_socket   = optional(number)<br>    cpu_hot_add_enabled    = optional(bool)<br>    cpu_hot_remove_enabled = optional(bool)<br>    memory                 = optional(number)<br>    memory_hot_add_enabled = optional(bool)<br>  })</pre> | `{}` | no |
| <a name="input_customize"></a> [customize](#input\_customize) | n/a | <pre>object({<br>    timeout         = optional(number)<br>    dns_server_list = optional(list(string))<br>    dns_suffix_list = optional(list(string))<br>    ipv4_gateway    = optional(string)<br>    ipv6_gateway    = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_disk"></a> [disk](#input\_disk) | n/a | <pre>map(object({<br>    size              = number<br>    unit_number       = optional(number)<br>    datastore_id      = optional(string)<br>    attach            = optional(string)<br>    path              = optional(string)<br>    keep_on_remove    = optional(bool)<br>    disk_mode         = optional(string)<br>    eagerly_scrub     = optional(bool)<br>    thin_provisioned  = optional(bool)<br>    disk_sharing      = optional(string)<br>    write_through     = optional(bool)<br>    io_limit          = optional(number)<br>    io_reservation    = optional(number)<br>    io_share_level    = optional(string)<br>    io_share_count    = optional(number)<br>    storage_policy_id = optional(string)<br>    controller_type   = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_general_options"></a> [general\_options](#input\_general\_options) | n/a | <pre>map(object({<br>    resource_pool_id  = string<br>    datastore_id      = optional(string)<br>    datacenter_id     = optional(string)<br>    storage_policy_id = optional(string)<br>    extra_config      = optional(map(string))<br>    custom_attributes = optional(map(string))<br>    firmware          = optional(string)<br>    folder            = optional(string)<br>    guest_id          = optional(string)<br>    hardware_version  = optional(number)<br>    host_system_id    = optional(string)<br>    pci_device_id     = optional(list(string))<br>    tags              = optional(map(any))<br>  }))</pre> | n/a | yes |
| <a name="input_linux_options"></a> [linux\_options](#input\_linux\_options) | n/a | <pre>map(object({<br>    domain       = optional(string)<br>    hw_clock_utc = optional(bool)<br>    time_zone    = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_network_interface"></a> [network\_interface](#input\_network\_interface) | n/a | <pre>object({<br>    network_id            = string<br>    adapter_type          = optional(string)<br>    use_static_mac        = optional(bool)<br>    mac_address           = optional(string)<br>    bandwidth_limit       = optional(number)<br>    bandwidth_reservation = optional(number)<br>    bandwidth_share_count = optional(number)<br>    bandwidth_share_level = optional(string)<br>    ovf_mapping           = optional(string)<br>    ipv4_address          = optional(string)<br>    ipv4_netmask          = optional(string)<br>    dns_domain            = optional(string)<br>    dns_server_list       = optional(list(string))<br>  })</pre> | `null` | no |
| <a name="input_ovf_deploy"></a> [ovf\_deploy](#input\_ovf\_deploy) | n/a | <pre>object({<br>    allow_unverified_ssl_cert = optional(bool)<br>    enable_hidden_properties  = optional(bool)<br>    local_ovf_path            = optional(string)<br>    remote_ovf_url            = optional(string)<br>    ip_allocation_policy      = optional(string)<br>    ip_protocol               = optional(string)<br>    disk_provisioning         = optional(string)<br>    deployment_option         = optional(string)<br>    ovf_network_map           = optional(map(string))<br>  })</pre> | `{}` | no |
| <a name="input_resource_allocation_options"></a> [resource\_allocation\_options](#input\_resource\_allocation\_options) | n/a | <pre>object({<br>    cpu_limit          = optional(number)<br>    cpu_reservation    = optional(number)<br>    cpu_share_count    = optional(number)<br>    cpu_share_level    = optional(string)<br>    memory_limit       = optional(number)<br>    memory_reservation = optional(number)<br>    memory_share_count = optional(number)<br>    memory_share_level = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_scsi"></a> [scsi](#input\_scsi) | n/a | <pre>object({<br>    scsi_type             = optional(string)<br>    scsi_bus_sharing      = optional(string)<br>    scsi_controller_count = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_tools_options"></a> [tools\_options](#input\_tools\_options) | n/a | <pre>object({<br>    run_tools_scripts_after_power_on        = optional(bool)<br>    run_tools_scripts_after_resume          = optional(bool)<br>    run_tools_scripts_before_guest_reboot   = optional(bool)<br>    run_tools_scripts_before_guest_shutdown = optional(bool)<br>    run_tools_scripts_before_guest_standby  = optional(bool)<br>    sync_time_with_host                     = optional(bool)<br>    sync_time_with_host_periodically        = optional(bool)<br>    tools_upgrade_policy                    = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_windows_options"></a> [windows\_options](#input\_windows\_options) | n/a | <pre>map(object({<br>    admin_password        = optional(string)<br>    workgroup             = optional(string)<br>    join_domain           = optional(string)<br>    domain_admin_user     = optional(string)<br>    domain_admin_password = optional(string)<br>    organization_name     = optional(string)<br>    product_key           = optional(string)<br>    run_once_command_list = optional(list(string))<br>    auto_logon            = optional(bool)<br>    auto_logon_count      = optional(number)<br>    time_zone             = optional(string)<br>    windows_sysprep_text  = optional(string)<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_virtual_machine"></a> [virtual\_machine](#output\_virtual\_machine) | n/a |
