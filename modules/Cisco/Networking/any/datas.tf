data "aci_tenant" "data_tenant" {
  name = var.tenant
}

data "aci_vrf" "data_vrf" {
  name      = var.vrf_name
  tenant_dn = data.aci_tenant.data_tenant.id
}