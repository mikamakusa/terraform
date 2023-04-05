output "tenant" {
  value = aci_tenant.tenant
}

output "vrf" {
  value = aci_vrf.vrf
}

output "subnet" {
  value = aci_subnet.subnet
}

output "contract" {
  value = aci_contract.contract
}

output "bridge_domain" {
  value = aci_bridge_domain.bridge_domain
}

output "filter" {
  value = aci_filter.filter
}

output "filter_entry" {
  value = aci_filter_entry.filter_entry
}

output "application_profile" {
  value = aci_application_profile.application_profile
}

output "epg_to_domain" {
  value = aci_epg_to_domain.epg_to_domain
}

output "epg_to_contract" {
  value = aci_epg_to_contract.epg_to_contract
}