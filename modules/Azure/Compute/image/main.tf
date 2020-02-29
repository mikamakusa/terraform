resource "azurerm_image" "image" {
  count               = length(var.image)
  location            = element(var.location, lookup(var.image[count.index], "location_id"))
  name                = lookup(var.image[count.index], "name")
  resource_group_name = element(var.resource_group_name, lookup(var.image[count.index], "resource_group_id"))
  zone_resilient      = lookup(var.image[count.index], "zone_resilient")
  hyper_v_generation  = lookup(var.image[count.index], "hyper_v_generation")

  dynamic "os_disk" {
    for_each = lookup(var.image[count.index], "os_disk")
    content {
      os_state        = lookup(os_disk.value, "os_state")
      os_type         = lookup(os_disk.value, "os_type")
      managed_disk_id = element(var.managed_disk_id, lookup(os_disk.value, "managed_disk_id"))
      blob_uri        = element(var.blob_uri, lookup(os_disk.value, "blob_uri"))
      caching         = lookup(os_disk.value, "caching")
      size_gb         = lookup(os_disk.value, "size_gb")
    }
  }

  dynamic "data_disk" {
    for_each = lookup(var.image[count.index], "data_disk")
    content {
      lun             = lookup(data_disk.value, "lun")
      managed_disk_id = element(var.managed_disk_id, lookup(data_disk.value, "managed_disk_id"))
      blob_uri        = element(var.blob_uri, lookup(data_disk.value, "blob_uri"))
      caching         = lookup(data_disk.value, "caching")
      size_gb         = lookup(data_disk.value, "size_gb")
    }
  }
}