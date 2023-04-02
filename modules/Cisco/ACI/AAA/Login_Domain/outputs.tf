output "login_domain_id" {
  value = aci_login_domain.login_domain.*.id
}