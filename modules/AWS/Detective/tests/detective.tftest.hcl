run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "create_detective_graph" {
  variables {
    graph = [{
      id    = 0
      tags  = {
        graph = "ok"
      }
    }]
  }
}

run "create_invitation_accepter" {
  variables {
    invitation_accepter = [{
      id        = 0
      graph_id  = 0
    }]
  }
}

run "create_member" {
  variables {
    member = [{
      id = 0
      account_id                 = "AWS ACCOUNT ID"
      email_address              = "EMAIL"
      graph_id                   = 0
      message                    = "Message of the invitation"
      disable_email_notification = true
    }]
  }
}

run "create_organization_admin_account" {
  variables {
    organization_admin_account = [{
      id          = 0
      account_id  = "123456789012"
    }]
  }
}

run "create_organization_configuration" {
  variables {
    organization_configuration = [{
      id          = 0
      auto_enable = true
      graph_id    = 0
    }]
  }
}