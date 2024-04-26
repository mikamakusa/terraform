resource "oci_cloud_bridge_agent" "this" {
  count          = length(var.agent) == "0" ? "0" : lenght(var.environment)
  agent_type     = lookup(var.agent[count.index], "agent_type")
  agent_version  = lookup(var.agent[count.index], "agent_version")
  compartment_id = data.oci_identity_compartment.this.id
  display_name   = lookup(var.agent[count.index], "display_name")
  environment_id = try(element(oci_cloud_bridge_environment.this.*.id, lookup(var.agent[count.index], "environment_id")))
  os_version     = lookup(var.agent[count.index], "os_version")
  defined_tags   = merge(var.defined_tags, lookup(var.agent[count.index], "defined_tags"))
  freeform_tags  = merge(var.freeform_tags, lookup(var.agent[count.index], "freeform_tags"))
}

resource "oci_cloud_bridge_agent_dependency" "this" {
  count              = length(var.agent_dependency)
  bucket             = lookup(var.agent_dependency[count.index], "bucket")
  compartment_id     = data.oci_identity_compartment.this.id
  dependency_name    = lookup(var.agent_dependency[count.index], "dependency_name")
  display_name       = lookup(var.agent_dependency[count.index], "display_name")
  namespace          = lookup(var.agent_dependency[count.index], "namespace")
  object             = lookup(var.agent_dependency[count.index], "object")
  defined_tags       = merge(var.defined_tags, lookup(var.agent_dependency[count.index], "defined_tags"))
  freeform_tags      = merge(var.freeform_tags, lookup(var.agent_dependency[count.index], "freeform_tags"))
  dependency_version = lookup(var.agent_dependency[count.index], "dependency_version")
  description        = lookup(var.agent_dependency[count.index], "description")
  system_tags        = lookup(var.agent_dependency[count.index], "system_tags")
}

resource "oci_cloud_bridge_agent_plugin" "this" {
  count         = length(var.agent_plugin) == "0" ? "0" : length(var.agent)
  agent_id      = try(element(oci_cloud_bridge_agent.this.*.id, lookup(var.agent_plugin[count.index], "agent_id")))
  plugin_name   = lookup(var.agent_plugin[count.index], "plugin_name")
  desired_state = lookup(var.agent_plugin[count.index], "desired_state")
}

resource "oci_cloud_bridge_asset" "this" {
  count              = length(var.asset)
  asset_type         = lookup(var.asset[count.index], "asset_type")
  compartment_id     = data.oci_identity_compartment.this.id
  external_asset_key = lookup(var.asset[count.index], "external_asset_key")
  inventory_id       = lookup(var.asset[count.index], "inventory_id")
  source_key         = lookup(var.asset[count.index], "source_key")
  asset_source_ids   = lookup(var.asset[count.index], "asset_source_ids")
  defined_tags       = merge(var.defined_tags, lookup(var.asset[count.index], "defined_tags"))
  freeform_tags      = merge(var.freeform_tags, lookup(var.asset[count.index], "freeform_tags"))
  display_name       = lookup(var.asset[count.index], "display_name")

  dynamic "compute" {
    for_each = lookup(var.asset[count.index], "asset_type") == "VM" || "VMWARE_VM" ? (lookup(var.asset[count.index], "compute") == null ? [] : ["compute"]) : []
    content {
      connected_networks         = lookup(compute.value, "connected_networks")
      cores_count                = lookup(compute.value, "cores_count")
      cpu_model                  = lookup(compute.value, "cpu_model")
      description                = lookup(compute.value, "description")
      disks_count                = lookup(compute.value, "disks_count")
      dns_name                   = lookup(compute.value, "dns_name")
      firmware                   = lookup(compute.value, "firmware")
      gpu_devices_count          = lookup(compute.value, "gpu_devices_count")
      guest_state                = lookup(compute.value, "guest_state")
      hardware_version           = lookup(compute.value, "hardware_version")
      host_name                  = lookup(compute.value, "host_name")
      is_pmem_enabled            = lookup(compute.value, "is_pmem_enabled")
      is_tpm_enabled             = lookup(compute.value, "is_tpm_enabled")
      latency_sensitivity        = lookup(compute.value, "latency_sensitivity")
      memory_in_mbs              = lookup(compute.value, "memory_in_mbs")
      nics_count                 = lookup(compute.value, "nics_count")
      operating_system           = lookup(compute.value, "operating_system")
      operating_system_version   = lookup(compute.value, "operating_system_version")
      pmem_in_mbs                = lookup(compute.value, "pmem_in_mbs")
      power_state                = lookup(compute.value, "power_state")
      primary_ip                 = lookup(compute.value, "primary_ip")
      storage_provisioned_in_mbs = lookup(compute.value, "storage_provisioned_in_mbs")
      threads_per_core_count     = lookup(compute.value, "threads_per_core_count")

      dynamic "disks" {
        for_each = lookup(compute.value, "disks") == null ? [] : ["disks"]
        content {
          boot_order      = lookup(disks.value, "boot_order")
          location        = lookup(disks.value, "location")
          name            = lookup(disks.value, "name")
          persistent_mode = lookup(disks.value, "persistent_mode")
          size_in_mbs     = lookup(disks.value, "size_in_mbs")
          uuid            = lookup(disks.value, "uuid")
          uuid_lun        = lookup(disks.value, "uuid_lun")
        }
      }

      dynamic "nvdimm_controller" {
        for_each = lookup(compute.value, "nvdimm_controller") == null ? [] : ["nvdimm_controller"]
        content {
          bus_number = lookup(nvdimm_controller.value, "bus_number")
          label      = lookup(nvdimm_controller.value, "label")
        }
      }

      dynamic "nvdimms" {
        for_each = lookup(compute.value, "nvdimms") == null ? [] : ["nvdimms"]
        content {
          controller_key = lookup(nvdimms.value, "controller_key")
          label          = lookup(nvdimms.value, "label")
          unit_number    = lookup(nvdimms.value, "unit_number")
        }
      }

      dynamic "gpu_devices" {
        for_each = lookup(compute.value, "gpu_devices") == null ? [] : ["gpu_devices"]
        content {
          cores_count   = lookup(gpu_devices.value, "cores_count")
          description   = lookup(gpu_devices.value, "description")
          manufacturer  = lookup(gpu_devices.value, "manufacturer")
          memory_in_mbs = lookup(gpu_devices.value, "memory_in_mbs")
          name          = lookup(gpu_devices.value, "name")
        }
      }

      dynamic "nics" {
        for_each = lookup(compute.value, "nics") == null ? [] : ["nics"]
        content {
          ip_addresses     = lookup(nics.value, "ip_addresses")
          label            = lookup(nics.value, "label")
          mac_address      = lookup(nics.value, "mac_address")
          mac_address_type = lookup(nics.value, "mac_address_type")
          network_name     = lookup(nics.value, "network_name")
          switch_name      = lookup(nics.value, "switch_name")
        }
      }

      dynamic "scsi_controller" {
        for_each = lookup(compute.value, "scsi_controller") == null ? [] : ["scsi_controller"]
        content {
          label       = lookup(scsi_controller.value, "label")
          shared_bus  = lookup(scsi_controller.value, "shared_bus")
          unit_number = lookup(scsi_controller.value, "unit_number")
        }
      }
    }
  }

  dynamic "vm" {
    for_each = lookup(var.asset[count.index], "asset_type") == "VM" || "VMWARE_VM" ? (lookup(var.asset[count.index], "vm") == null ? [] : ["vm"]) : []
    content {
      hypervisor_host    = lookup(vm.value, "hypervisor_host")
      hypervisor_vendor  = lookup(vm.value, "hypervisor_vendor")
      hypervisor_version = lookup(vm.value, "hypervisor_version")
    }
  }

  dynamic "vmware_vcenter" {
    for_each = lookup(var.asset[count.index], "vmware_vcenter") == null ? [] : ["vmware_vcenter"]
    content {
      data_center     = lookup(vmware_vcenter.value, "data_center")
      vcenter_key     = lookup(vmware_vcenter.value, "vcenter_key")
      vcenter_version = lookup(vmware_vcenter.value, "vcenter_version")
    }
  }

  dynamic "vmware_vm" {
    for_each = lookup(var.asset[count.index], "vmware_vm") == null ? [] : ["vmware_vm"]
    content {
      cluster                           = lookup(vmware_vm.value, "cluster")
      customer_fields                   = lookup(vmware_vm.value, "customer_fields")
      fault_tolerance_bandwidth         = lookup(vmware_vm.value, "fault_tolerance_bandwidth")
      fault_tolerance_secondary_latency = lookup(vmware_vm.value, "fault_tolerance_secondary_latency")
      fault_tolerance_state             = lookup(vmware_vm.value, "fault_tolerance_state")
      instance_uuid                     = lookup(vmware_vm.value, "instance_uuid")
      is_disks_cbt_enabled              = lookup(vmware_vm.value, "is_disks_cbt_enabled")
      is_disks_uuid_enabled             = lookup(vmware_vm.value, "is_disks_uuid_enabled")
      path                              = lookup(vmware_vm.value, "path")
      vmware_tools_status               = lookup(vmware_vm.value, "vmware_tools_status")

      dynamic "customer_tags" {
        for_each = lookup(vmware_vm.value, "customer_tags") == null ? [] : ["customer_tags"]
        content {
          description = lookup(customer_tags.value, "description")
          name        = lookup(customer_tags.value, "name")
        }
      }
    }
  }
}

resource "oci_cloud_bridge_asset_source" "this" {
  count                            = length(var.asset_source) == "0" ? "0" : (length(var.environment) && lenght(var.inventory))
  assets_compartment_id            = lookup(var.asset_source[count.index], "assets_compartment_id")
  compartment_id                   = data.oci_identity_compartment.this.id
  environment_id                   = lookup(var.asset_source[count.index], "environment_id")
  inventory_id                     = lookup(var.asset_source[count.index], "inventory_id")
  type                             = lookup(var.asset_source[count.index], "type")
  vcenter_endpoint                 = lookup(var.asset_source[count.index], "vcenter_endpoint")
  are_historical_metrics_collected = lookup(var.asset_source[count.index], "are_historical_metrics_collected")
  are_realtime_metrics_collected   = lookup(var.asset_source[count.index], "are_realtime_metrics_collected")
  defined_tags                     = merge(var.defined_tags, lookup(var.asset_source[count.index], "defined_tags"))
  freeform_tags                    = merge(var.freeform_tags, lookup(var.asset_source[count.index], "freeform_tags"))
  discovery_schedule_id            = lookup(var.asset_source[count.index], "discovery_schedule_id")
  display_name                     = lookup(var.asset_source[count.index], "display_name")
  system_tags                      = lookup(var.asset_source[count.index], "system_tags")

  dynamic "discovery_credentials" {
    for_each = lookup(var.asset_source[count.index], "discovery_credentials")
    content {
      secret_id = lookup(discovery_credentials.value, "secret_id")
      type      = lookup(discovery_credentials.value, "type")
    }
  }

  dynamic "replication_credentials" {
    for_each = lookup(var.asset_source[count.index], "replication_credentials") == null ? [] : ["replication_credentials"]
    content {
      secret_id = lookup(replication_credentials.value, "secret_id")
      type      = lookup(replication_credentials.value, "type")
    }
  }
}

resource "oci_cloud_bridge_discovery_schedule" "this" {
  count                 = length(var.discovery_schedule)
  compartment_id        = data.oci_identity_compartment.this.id
  execution_recurrences = lookup(var.discovery_schedule[count.index], "execution_recurrences")
  defined_tags          = merge(var.defined_tags, lookup(var.discovery_schedule[count.index], "defined_tags"))
  freeform_tags         = merge(var.freeform_tags, lookup(var.discovery_schedule[count.index], "freeform_tags"))
  display_name          = lookup(var.discovery_schedule[count.index], "display_name")
}

resource "oci_cloud_bridge_environment" "this" {
  count          = length(var.environment)
  compartment_id = data.oci_identity_compartment.this.id
  defined_tags   = merge(var.defined_tags, lookup(var.environment[count.index], "defined_tags"))
  freeform_tags  = merge(var.freeform_tags, lookup(var.environment[count.index], "freeform_tags"))
  display_name   = lookup(var.environment[count.index], "display_name")
}

resource "oci_cloud_bridge_inventory" "this" {
  count          = length(var.inventory)
  compartment_id = data.oci_identity_compartment.this.id
  display_name   = lookup(var.inventory[count.index], "display_name")
  defined_tags   = merge(var.defined_tags, lookup(var.inventory[count.index], "defined_tags"))
  freeform_tags  = merge(var.freeform_tags, lookup(var.inventory[count.index], "freeform_tags"))
}