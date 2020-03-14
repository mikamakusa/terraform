resource "google_compute_address" "gcp_address" {
  count        = length(var.address)
  name         = "${var.prefix}-${lookup(var.address[count.index], "suffix_name")}-${lookup(var.address[count.index], "id")}-addr"
  region       = var.region
  project      = var.project
  subnetwork   = var.subnetwork
  address_type = lookup(var.address[count.index], "address_type")
  address      = lookup(var.address[count.index], "address")
}

resource "google_compute_disk" "gcp_disk" {
  count = length(var.disk)
  name  = lookup(var.disk[count.index], "name")
  type  = lookup(var.disk[count.index], "type")
  zone  = var.zone
  size  = lookup(var.disk[count.index], "size")
}

resource "google_compute_attached_disk" "gcp_attached_disk" {
  count       = length(var.disk)
  disk        = element(google_compute_disk.gcp_disk.*.self_link, count.index)
  instance    = element(google_compute_instance.google_Vms.*.id, lookup(var.disk[count.index], "instance_id"))
  device_name = lookup(var.disk[count.index], "device_name")
  project     = var.project
  zone        = var.zone
}

resource "google_compute_instance" "google_Vms" {
  count               = length(var.Linux_Vms)
  name                = "${var.prefix}-${lookup(var.Linux_Vms[count.index], "suffix_name")}-${lookup(var.Linux_Vms[count.index], "id")}"
  project             = var.project
  zone                = "projects/${var.app_project}/zones/${var.zone}"
  can_ip_forward      = lookup(var.Linux_Vms[count.index], "can_ip_forward", false)
  deletion_protection = lookup(var.Linux_Vms[count.index], "deletion_protection", false)
  machine_type        = lookup(var.Linux_Vms[count.index], "machine_type")
  allow_stopping_for_update = lookup(var.Linux_Vms[count.index], "allow_stopping_for_update", false)
  min_cpu_platform = lookup(var.Linux_Vms[count.index], "min_cpu_platform", null)

  dynamic "guest_accelerator" {
    for_each = lookup(var.Linux_Vms[count.index], "guest_accelerator")
    content {
      count = lookup(guest_accelerator.value, "count")
      type = lookup(guest_accelerator.value, "type")
    }
  }

  dynamic "boot_disk" {
    for_each = lookup(var.Linux_Vms[count.index], "boot_disk")
    content {
      auto_delete = lookup(boot_disk.value, "auto_delete")
      device_name = lookup(boot_disk.value, "device_name")
      initialize_params {
        size  = lookup(boot_disk.value, "size")
        type  = lookup(boot_disk.value, "type")
        image = lookup(boot_disk.value, "image")
      }
    }
  }

  dynamic "network_interface" {
    for_each = lookup(var.Linux_Vms[count.index], "network_interface")
    content {
      network    = lookup(network_interface.value, "network")
      subnetwork = lookup(network_interface.value, "subnetwork")
      address    = lookup(network_interface.value, "address")
    }
  }

  dynamic "attached_disk" {
    for_each = lookup(var.Linux_Vms[count.index], "attached_disk")
    content {
      source                  = lookup(attached_disk.value, "source")
      device_name             = lookup(attached_disk.value, "device_name", null)
      mode                    = lookup(attached_disk.value, "mode", null)
      disk_encryption_key_raw = lookup(attached_disk.value, "disk_encryption_key_raw", null)
      kms_key_self_link       = lookup(attached_disk.value, "kms_key_self_link", null)
    }
  }

  dynamic "service_account" {
    for_each = lookup(var.Linux_Vms[count.index], "service_account")
    content {
      email  = lookup(service_account.value, "email")
      scopes = [lookup(service_account.value, "scopes")]
    }
  }

  dynamic "scheduling" {
    for_each = lookup(var.Linux_Vms[count.index], "scheduling")
    content {
      preemptible         = lookup(scheduling.value,"preemptible")
      on_host_maintenance = lookup(scheduling.value,"on_host_maintenance")
      automatic_restart   = lookup(scheduling.value,"automatic_restart")
      node_affinities {
        key      = lookup(scheduling.value,"key")
        operator = lookup(scheduling.value,"operator", "NOT")
        values   = [lookup(scheduling.value,"values")]
      }
    }
  }

  dynamic "shielded_instance_config" {
    for_each = lookup(var.Linux_Vms[count.index], shielded_instance_config)
    content {
      enable_secure_boot = lookup(shielded_instance_config.value,"enable_secure_boot",false)
      enable_vtpm = lookup(shielded_instance_config.value,"enable_vtpm",true)
      enable_integrity_monitoring = lookup(shielded_instance_config.value,"enable_integrity_monitoring",true)
    }
  }
  metadata {
    ssh-keys = "${var.app_admin}:${var.ssh_keys}"
  }
}
