output "vmm_domain" {
  value = aci_vmm_domain.main
}

output "vmm_controller" {
  value = aci_vmm_controller.main
}

output "vmm_credential" {
  value = aci_vmm_credential.main
}

output "vswitch_policy" {
  value = aci_vswitch_policy.main
}

output "domain_uplinks" {
  value = aci_rest_managed.domain_uplinks
}

output "vmm_uplinks" {
  value = aci_rest_managed.vmm_uplinks
}