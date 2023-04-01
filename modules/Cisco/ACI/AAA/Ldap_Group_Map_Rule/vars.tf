variable "ldap_group_map_rule" {
  type        = any
  description = "Manages ACI LDAP Group Map Rule"

  validation {
    condition     = lookup(var.ldap_group_map_rule[count.index], "type") != null ? contains(["duo", "ldap"], var.ldap_group_map_rule["type"]) : "duo"
    error_message = "Type must contains 'duo' or 'ldap'."
  }
}