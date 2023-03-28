variable "domain_relationship" {
  type = object({
    parent_dn = string
    aaa_domain_dn = string
  })
}