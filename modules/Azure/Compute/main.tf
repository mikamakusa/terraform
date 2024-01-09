resource "azurerm_availability_set" "this" {
  for_each            = var.availability_set
  location            = data.azurerm_resource_group.this.location
  name                = each.key
  resource_group_name = data.azurerm_resource_group.this.name
  tags = merge(
    each.value.tags,
    var.tags,
    {
      terraform = "true"
    },
  )
  platform_fault_domain_count  = each.value.platform_fault_domain_count
  platform_update_domain_count = each.value.platform_update_domain_count
  proximity_placement_group_id = each.value.proximity_placement_group_id
  managed                      = each.value.managed
}

resource "azurerm_capacity_reservation" "this" {
  for_each                      = var.capacity_reservation
  capacity_reservation_group_id = azurerm_capacity_reservation_group.this[join("-", each.key, "group")].id
  name                          = each.key
  sku {
    capacity = each.value.sku.capacity
    name     = each.value.sku.name
  }
  tags = merge(
    each.value.tags,
    var.tags,
    {
      terraform = "true"
    },
  )
}

resource "azurerm_capacity_reservation_group" "this" {
  for_each            = var.capacity_reservation
  location            = data.azurerm_resource_group.this.location
  name                = join("-", each.key, "group")
  resource_group_name = data.azurerm_resource_group.this.name
  zones               = each.value.zone
  tags = merge(
    each.value.tags,
    var.tags,
    {
      terraform = "true"
    },
  )
}

resource "azurerm_dedicated_host" "this" {
  for_each                = var.dedicated_host
  dedicated_host_group_id = azurerm_dedicated_host_group.this[join("-", [each.key, "host-group"])].id
  location                = data.azurerm_resource_group.this.location
  name                    = each.key
  platform_fault_domain   = each.value.platform_fault_domain
  sku_name                = each.value.sku_name
  auto_replace_on_failure = each.value.auto_replace_on_failure
  license_type            = each.value.license_type
  tags = merge(
    each.value.tags,
    var.tags,
    {
      terraform = "true"
    },
  )
}

resource "azurerm_dedicated_host_group" "this" {
  for_each                    = var.dedicated_host
  location                    = data.azurerm_resource_group.this.location
  name                        = join("-", [each.key, "host-group"])
  platform_fault_domain_count = each.value.platform_fault_domain
  resource_group_name         = data.azurerm_resource_group.this.name
  automatic_placement_enabled = each.value.automatic_placement_enabled
  zone                        = each.value.zone
  tags = merge(
    each.value.tags,
    var.tags,
    {
      terraform = "true"
    },
  )
}

resource "azurerm_disk_access" "this" {
  for_each            = var.disk_access
  location            = data.azurerm_resource_group.this.location
  name                = each.key
  resource_group_name = data.azurerm_resource_group.this.name
  tags = merge(
    each.value.tags,
    var.tags,
    {
      terraform = "true"
    },
  )
}

resource "azurerm_disk_encryption_set" "this" {
  for_each                  = var.disk_encryption_set
  key_vault_key_id          = data.azurerm_key_vault_key.this.id
  location                  = data.azurerm_resource_group.this.location
  name                      = each.key
  resource_group_name       = data.azurerm_resource_group.this.name
  auto_key_rotation_enabled = each.value.auto_key_rotation_enabled
  encryption_type           = each.value.encryption_type
  federated_client_id       = each.value.federated_client_id

  dynamic "identity" {
    for_each = each.value.identity
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  tags = merge(
    each.value.tags,
    var.tags,
    {
      terraform = "true"
    },
  )
}

resource "azurerm_managed_disk" "this" {
  for_each                         = var.managed_disk
  create_option                    = each.value.create_option
  location                         = data.azurerm_resource_group.this.location
  name                             = each.key
  resource_group_name              = data.azurerm_resource_group.this.name
  storage_account_type             = each.value.storage_account_type
  disk_encryption_set_id           = each.value.disk_encryption_set_id
  disk_iops_read_only              = each.value.disk_iops_read_only
  disk_iops_read_write             = each.value.disk_iops_read_write
  disk_mbps_read_only              = each.value.disk_mbps_read_only
  disk_mbps_read_write             = each.value.disk_mbps_read_write
  disk_size_gb                     = each.value.create_option == "Copy" || "FromImage" ? each.value.disk_size_gb : ""
  upload_size_bytes                = each.value.create_option == "Upload" ? each.value.upload_size_bytes : ""
  secure_vm_disk_encryption_set_id = each.value.security_type == "ConfidentialVM_DiskEncryptedWithCustomerKey" ? each.value.secure_vm_disk_encryption_set_id : null
  edge_zone                        = ""
  hyper_v_generation               = ""
  image_reference_id               = each.value.create_option == "FromImage" ? each.value.image_reference_id : ""
  gallery_image_reference_id       = each.value.create_option == "FromImage" ? each.value.gallery_image_reference_id : ""
  logical_sector_size              = ""
  os_type                          = ""
  source_resource_id               = each.value.create_option == "Restore" ? each.value.source_resource_id : ""
  source_uri                       = each.value.create_option == "Import" ? join("/", [path.cwd, "source", file(each.value.source_uri)]) : ""
  storage_account_id               = ""
  tier                             = ""
  max_shares                       = ""
  trusted_launch_enabled           = ""
  security_type                    = ""
  on_demand_bursting_enabled       = ""
  zone                             = ""
  network_access_policy            = ""
  disk_access_id                   = ""
  public_network_access_enabled    = ""

  dynamic "encryption_settings" {
    for_each = ""
    content {
      dynamic "disk_encryption_key" {
        for_each = ""
        content {
          secret_url      = ""
          source_vault_id = ""
        }
      }

      dynamic "key_encryption_key" {
        for_each = ""
        content {
          key_url         = ""
          source_vault_id = ""
        }
      }
    }
  }

  dynamic "encryption_settings" {
    for_each = ""
    content {
      dynamic "disk_encryption_key" {
        for_each = ""
        content {
          secret_url      = ""
          source_vault_id = ""
        }
      }

      dynamic "key_encryption_key" {
        for_each = ""
        content {
          key_url         = ""
          source_vault_id = ""
        }
      }
    }
  }
  tags = merge(
    each.value.tags,
    var.tags,
    {
      terraform = "true"
    },
  )
}