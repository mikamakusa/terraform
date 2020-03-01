resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  count               = length(var.linux_virtual_machine)
  name                = lookup(var.linux_virtual_machine[count.index], "name")
  resource_group_name = element(var.resource_group_name, lookup(var.linux_virtual_machine[count.index], "resource_group_id"))
  location            = element(var.location, lookup(var.linux_virtual_machine[count.index], "location_id"))
  size                = lookup(var.linux_virtual_machine[count.index], "size")
  admin_username      = lookup(var.linux_virtual_machine[count.index], "admin_username")
  network_interface_ids = [
    var.network_interface_ids,
  ]

  dynamic "admin_ssh_key" {
    for_each = lookup(var.linux_virtual_machine[count.index], "admin_ssh_key")
    content {
      username   = lookup(admin_ssh_key.value, "username")
      public_key = file(join(".", [join("/", [path.cwd, "keys", lookup(admin_ssh_key.value, "public_key")]), "pub"]))
    }
  }

  dynamic "os_disk" {
    for_each = [for i in lookup(var.linux_virtual_machine[count.index], "os_disk") : {
      diff = lookup(i, "diff_disk_settings", null)
    }]
    content {
      caching                   = lookup(os_disk.value, "caching")
      storage_account_type      = lookup(os_disk.value, "storage_account_type")
      disk_encryption_set_id    = element(var.disk_encryption_set_id, lookup(os_disk.value, "disk_encryption_set_id"))
      disk_size_gb              = lookup(os_disk.value, "disk_size_gb")
      name                      = lookup(os_disk.value, "name")
      write_accelerator_enabled = lookup(os_disk.value, "write_accelerator_enabled")

      dynamic "diff_disk_settings" {
        for_each = [for i in os_disk.value.diff : {
          option = i.option
        }]
        content {
          option = diff_disk_settings.value.option
        }
      }
    }
  }

  dynamic "source_image_reference" {
    for_each = lookup(var.linux_virtual_machine[count.index], "source_image_reference")
    content {
      publisher = lookup(source_image_reference.value, "publisher")
      offer     = lookup(source_image_reference.value, "offer")
      sku       = lookup(source_image_reference.value, "sku")
      version   = lookup(source_image_reference.value, "version")
    }
  }

  dynamic "additional_capabilities" {
    for_each = lookup(var.linux_virtual_machine[count.index], "additional_capabilities")
    content {
      ultra_ssd_enabled = lookup(additional_capabilities.value, "ultra_ssd_enabled")
    }
  }

  dynamic "boot_diagnostics" {
    for_each = lookup(var.linux_virtual_machine[count.index], "boot_diagnostics")
    content {
      storage_account_uri = lookup(boot_diagnostics.value, "storage_account_uri")
    }
  }

  dynamic "identity" {
    for_each = lookup(var.linux_virtual_machine[count.index], "identity")
    content {
      type         = lookup(identity.value, "type")
      identity_ids = element(var.identity_ids, lookup(identity.value, "identity_id"))
    }
  }

  dynamic "certificate" {
    for_each = lookup(var.linux_virtual_machine[count.index], "certificate")
    content {
      url = lookup(certificate.value, "url")
    }
  }

  dynamic "plan" {
    for_each = lookup(var.linux_virtual_machine[count.index], "plan")
    content {
      name      = lookup(plan.value, "name")
      product   = lookup(plan.value, "product")
      publisher = lookup(plan.value, "publisher")
    }
  }

  dynamic "secret" {
    for_each = lookup(var.linux_virtual_machine[count.index], "secret")
    content {
      certificate  = lookup(secret.value, "certificate")
      key_vault_id = element(var.key_vault_id, lookup(secret.value, "key_vault_id"))
    }
  }
}