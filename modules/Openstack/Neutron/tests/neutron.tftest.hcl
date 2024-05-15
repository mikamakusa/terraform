run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "group_v2" {
  command = apply
  variables {
    group_v2 = [
      {
        id        = 0
        name      = "firewall_group"
      }
    ]
  }
}

run "policy_v2" {
  command = apply
  variables {
    policy_v2 = [
      {
        id    = 0
        name  = "firewall_policy"
      }
    ]
  }
}

run "rule_v2" {
  command = apply
  variables {
    rule_v2 = [
      {
        id               = 0
        name             = "firewall_rule"
        description      = "drop TELNET traffic"
        action           = "deny"
        protocol         = "tcp"
        destination_port = "23"
        enabled          = "true"
      }
    ]
  }
}
