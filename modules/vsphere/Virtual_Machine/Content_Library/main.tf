resource "vsphere_content_library" "publication" {
  for_each        = var.publication ? 1 : 0
  name            = each.key
  description     = each.value.description
  storage_backing = each.value.storage_backing
  publication {
    authentication_method = each.value.authentication_method
    username              = var.username
    password              = var.password
    published             = each.value.published
  }
}

resource "vsphere_content_library" "subscription" {
  for_each        = var.subscription ? 1 : 0
  name            = each.key
  description     = each.value.description
  storage_backing = each.value.storage_backing
  subscription {
    subscription_url      = each.value.subscription_url
    authentication_method = each.value.authentication_method
    username              = var.username
    password              = var.password
    automatic_sync        = each.value.automatic_sync
    on_demand             = each.value.on_demand
  }
}