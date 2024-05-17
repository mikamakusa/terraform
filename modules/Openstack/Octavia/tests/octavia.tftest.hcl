run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "l7policy_v2" {
  command = apply

  variables {
    loadbalancer_v2 = [
      {
        id            = 0
        name          = "loadbalancer_1"
      }
    ]
    pool_v2 = [
      {
        id              = 0
        name            = "pool_1"
        protocol        = "HTTP"
        lb_method       = "ROUND_ROBIN"
        loadbalancer_id = 0
      }
    ]
    listener_v2 = [
      {
        id              = 0
        name            = "listener_1"
        protocol        = "HTTP"
        protocol_port   = 8080
        loadbalancer_id = 0
      }
    ]
    l7policy_v2 = [
      {
        id               = 0
        name             = "test"
        action           = "REDIRECT_TO_POOL"
        description      = "test l7 policy"
        position         = 1
        listener_id      = 0
        redirect_pool_id = 0
      }
    ]
  }

  assert {
    condition     = contains(["REDIRECT_TO_POOL", "REDIRECT_TO_URL or REJECT"], var.l7policy_v2[0].action)
    error_message = "Valid values are REDIRECT_TO_POOL or REDIRECT_TO_URL or REJECT."
  }

  assert {
    condition     = contains(["TCP", "HTTP", "HTTPS", "TERMINATED_HTTPS", "UDP", "SCTP", "PROMETHEUS"], var.listener_v2[0].protocol)
    error_message = "Valid values are : TCP, HTTP, HTTPS, TERMINATED_HTTPS, UDP (supported only in Octavia), SCTP (supported only in Octavia minor version >= 2.23) or PROMETHEUS."
  }
}

run "l7rule_v2" {
  command = apply

  variables {
    loadbalancer_v2 = [
      {
        id            = 0
        name          = "loadbalancer_1"
      }
    ]
    pool_v2 = [
      {
        id              = 0
        name            = "pool_1"
        protocol        = "HTTP"
        lb_method       = "ROUND_ROBIN"
        loadbalancer_id = 0
      }
    ]
    listener_v2 = [
      {
        id              = 0
        name            = "listener_1"
        protocol        = "HTTP"
        protocol_port   = 8080
        loadbalancer_id = 0
      }
    ]
    l7policy_v2 = [
      {
        id               = 0
        name             = "test"
        action           = "REDIRECT_TO_POOL"
        description      = "test l7 policy"
        position         = 1
        listener_id      = 0
        redirect_pool_id = 0
      }
    ]
    l7rule_v2 = [
      {
        id           = 0
        l7policy_id  = 0
        type         = "PATH"
        compare_type = "EQUAL_TO"
        value        = "/api"
      }
    ]
  }

  assert {
    condition     = contains(["REDIRECT_TO_POOL", "REDIRECT_TO_URL or REJECT"], var.l7policy_v2[0].action)
    error_message = "Valid values are REDIRECT_TO_POOL or REDIRECT_TO_URL or REJECT."
  }

  assert {
    condition     = contains(["COOKIE", "FILE_TYPE", "HEADER", "HOST_NAME", "PATH"], var.l7rule_v2[0].type)
    error_message = "Valid values are : COOKIE, FILE_TYPE, HEADER, HOST_NAME or PATH."
  }

  assert {
    condition     = contains(["CONTAINS", "STARTS_WITH", "ENDS_WITH", "EQUAL_TO", "REGEX"], var.l7rule_v2[0].compare_type)
    error_message = "Valid values are : CONTAINS, STARTS_WITH, ENDS_WITH, EQUAL_TO or REGEX."
  }

  assert {
    condition     = contains(["TCP", "HTTP", "HTTPS", "TERMINATED_HTTPS", "UDP", "SCTP", "PROMETHEUS"], var.listener_v2[0].protocol)
    error_message = "Valid values are : TCP, HTTP, HTTPS, TERMINATED_HTTPS, UDP (supported only in Octavia), SCTP (supported only in Octavia minor version >= 2.23) or PROMETHEUS."
  }
}

run "listener_v2" {
  command = apply

  variables {
    listener_v2 = [
      {
        id              = 0
        protocol        = "HTTP"
        protocol_port   = 8080
        loadbalancer_id = "d9415786-5f1a-428b-b35f-2f1523e146d2"
      }
    ]
  }

  assert {
    condition     = contains(["TCP", "HTTP", "HTTPS", "TERMINATED_HTTPS", "UDP", "SCTP", "PROMETHEUS"], var.listener_v2[0].protocol)
    error_message = "Valid values are : TCP, HTTP, HTTPS, TERMINATED_HTTPS, UDP (supported only in Octavia), SCTP (supported only in Octavia minor version >= 2.23) or PROMETHEUS."
  }
}

run "loadbalancer_v2" {
  command = apply

  variables {
    loadbalancer_v2 = [
      {
        id            = 0
        name          = "loadbalancer_1"
      }
    ]
  }
}

run "member_v2" {
  command = apply

  variables {
    pool_v2 = [
      {
        id              = 0
        name            = "pool_1"
        protocol        = "HTTP"
        lb_method       = "ROUND_ROBIN"
        loadbalancer_id = 0
      }
    ]
    member_v2 = [
      {
        id            = 0
        pool_id       = 0
        address       = "192.168.199.23"
        protocol_port = 8080
      }
    ]
  }
}

run "members_v2" {
  command = apply

  variables {
    pool_v2 = [
      {
        id              = 0
        name            = "pool_1"
        protocol        = "HTTP"
        lb_method       = "ROUND_ROBIN"
        loadbalancer_id = 0
      }
    ]
    members_v2 = [
      {
        id      = 0
        pool_id = 0
        member = [
                  {
                    address       = "192.168.199.23"
                    protocol_port = 8080
                  },
                  {
                    address       = "192.168.199.24"
                    protocol_port = 8080
                  }
                ]
      }
    ]
  }
}

run "monitor_v2" {
  command = apply

  variables {
    pool_v2 = [
      {
        id              = 0
        name            = "pool_1"
        protocol        = "HTTP"
        lb_method       = "ROUND_ROBIN"
        loadbalancer_id = 0
      }
    ]
    monitor_v2 = [
      {
        id          = 0
        pool_id     = 0
        type        = "PING"
        delay       = 20
        timeout     = 10
        max_retries = 5
      }
    ]
  }
}

run "pool_v2" {
  command = apply

  variables {
    pool_v2 = [
      {
        id              = 0
        name            = "pool_1"
        protocol        = "HTTP"
        lb_method       = "ROUND_ROBIN"
        loadbalancer_id = 0
      }
    ]
  }
}

run "quota_v2" {
  command = apply

  variables {
    project_name = "project_test_1"
    quota_v2 = [
      {
        id             = 0
        loadbalancer   = 6
        listener       = 7
        member         = 8
        pool           = 9
        health_monitor = 10
        l7_policy      = 11
        l7_rule        = 12
      }
    ]
  }
}
