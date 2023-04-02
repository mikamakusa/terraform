output "login_domain_provider_id" {
  value = aci_login_domain_provider.login_domain_provider.*.id
}