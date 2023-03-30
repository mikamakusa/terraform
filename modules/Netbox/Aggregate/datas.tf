data "netbox_tenant" "tenant" {
  name = var.tenant != null ? var.tenant : ""
}