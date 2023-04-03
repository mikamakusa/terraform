output "saml_provider_id" {
  value = aci_saml_provider.saml_provider.*.id
}