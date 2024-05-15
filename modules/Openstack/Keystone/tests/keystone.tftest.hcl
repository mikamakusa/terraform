run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "project_v3" {
  command = apply

  variables {
    project_v3 = [
      {
        id          = 0
        name        = "project_1"
        description = "A project"
      }
    ]
  }
}

run "application_credential_v3" {
  command = apply

  variables {
    project_name = "project_1"
    application_credential_v3 = [
      {
        id          = 0
        name        = "swift"
        description = "Swift technical application credential"
        secret      = "supersecret"
        roles       = ["swiftoperator"]
        expires_at  = "2019-02-13T12:12:12Z"
      }
    ]
  }
}

run "ec2_credential_v3" {
  command = apply

  variables {
    project_v3 = [
      {
        id          = 0
        name        = "project_1"
        description = "A project"
      }
    ]
    user_v3 = [
      {
        id = 0
      }
    ]
    ec2_credential_v3 = [
      {
        id          = 0
        project_id  = 0
        user_id     = 0
      }
    ]
  }
}

run "endpoint_v3" {
  command = apply

  variables {
    project_v3 = [
      {
        id          = 0
        name        = "project_1"
        description = "A project"
      }
    ]
    endpoint_v3 = [
      {
        id              = 0
        name            = "my-endpoint"
        project_id      = 0
        url             = "http://my-endpoint"
      }
    ]
  }
}

run "group_v3" {
  command = apply

  variables {
    group_v3 = [
      {
        id          = 0
        name        = "group_1"
        description = "group 1"
      }
    ]
  }
}

run "inherit_role_assignment_v3" {
  command = apply

  variables {
    user_v3 = [
      {
        id                                    = 0
        name                                  = "user_1"
        description                           = "A user"
        password                              = "password123"
        ignore_change_password_upon_first_use = true
        multi_factor_auth_enabled             = true
      }
    ]
    role_v3 = [
      {
        id    = 0
        name  = "role_1"
      }
    ]
    inherit_role_assignment_v3 = [
      {
        id        = 0
        user_id   = 0
        domain_id = "default"
        role_id   = 0
      }
    ]
  }
}

run "role_assignment_v3" {
  command = apply

  variables {
    project_v3 = [
      {
        id          = 0
        name        = "project_1"
        description = "A project"
      }
    ]
    user_v3 = [
      {
        id                                    = 0
        name                                  = "user_1"
        description                           = "A user"
        password                              = "password123"
        ignore_change_password_upon_first_use = true
        multi_factor_auth_enabled             = true
      }
    ]
    role_v3 = [
      {
        id    = 0
        name  = "role_1"
      }
    ]
    role_assignment_v3 = [
      {
        id         = 0
        user_id    = 0
        project_id = 0
        role_id    = 0
      }
    ]
  }
}

run "role_v3" {
  command = apply

  variables {
    role_v3 = [
      {
        id    = 0
        name  = "role_1"
      }
    ]
  }
}

run "service_v3" {
  command = apply

  variables {
    service_v3 = [
      {
        id      = 0
        name    = "custom"
        type    = "custom"
        enabled = true
      }
    ]
  }
}

run "user_membership_v3" {
  command = apply

  variables {
    project_v3 = [
      {
        id          = 0
        name        = "project_1"
        description = "A project"
      }
    ]
    group_v3 = [
      {
        id          = 0
        name        = "group_1"
        description = "group 1"
      }
    ]
    role_v3 = [
      {
        id    = 0
        name  = "role_1"
      }
    ]
    role_assignment_v3 = [
      {
        id         = 0
        user_id    = 0
        project_id = 0
        role_id    = 0
      }
    ]
    user_membership_v3 = [
      {
        id        = 0
        user_id   = 0
        group_id  = 0
      }
    ]
  }
}

run "user_v3" {
  command = apply

  variables {
    user_v3 = [
      {
        id                                    = 0
        name                                  = "user_1"
        description                           = "A user"
        password                              = "password123"
        ignore_change_password_upon_first_use = true
        multi_factor_auth_enabled             = true
      }
    ]
  }
}
