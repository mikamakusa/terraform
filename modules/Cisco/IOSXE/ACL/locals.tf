locals {
  acl = defaults(var.acl, {
    ace_rule_action = "permit"
    sequence        = 1
    standard        = true
  })
}