run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "vault_ad_secret_backend" {
  command = apply

  variables {
    ad_secret_backend = [
      {
        id            = 0
        backend       = "ad"
        binddn        = "CN=Administrator,CN=Users,DC=corp,DC=example,DC=net"
        bindpass      = "SuperSecretPassw0rd"
        url           = "ldaps://ad"
        insecure_tls  = "true"
        userdn        = "CN=Users,DC=corp,DC=example,DC=net"
      }
    ]
  }
}

run "vault_ad_secret_library" {
  command = apply

  variables {
    ad_secret_backend = [
      {
        id            = 0
        backend       = "ad"
        binddn        = "CN=Administrator,CN=Users,DC=corp,DC=example,DC=net"
        bindpass      = "SuperSecretPassw0rd"
        url           = "ldaps://ad"
        insecure_tls  = "true"
        userdn        = "CN=Users,DC=corp,DC=example,DC=net"
      }
    ]
    ad_secret_library = [
      {
        id                            = 0
        backend_id                    = 0
        name                          = "qa"
        service_account_names         = ["Bob", "Mary"]
        ttl                           = 60
        disable_check_in_enforcement  = true
        max_ttl                       = 120
      }
    ]
  }
}

run "vault_ad_secret_role" {
  command = apply

  variables {
    ad_secret_backend = [
      {
        id            = 0
        backend       = "ad"
        binddn        = "CN=Administrator,CN=Users,DC=corp,DC=example,DC=net"
        bindpass      = "SuperSecretPassw0rd"
        url           = "ldaps://ad"
        insecure_tls  = "true"
        userdn        = "CN=Users,DC=corp,DC=example,DC=net"
      }
    ]
    ad_secret_role = [
      {
        id                    = 0
        backend_id            = 0
        role                  = "bob"
        service_account_name  = "Bob"
        ttl                   = 60
      }
    ]
  }
}

run "vault_alicloud_auth_backend_role" {
  command = apply

  variables {
    auth_backend = [
      {
        id    = 0
        type  = "alicloud"
        path  = "alicloud"
      }
    ]
    alicloud_auth_backend_role = [
      {
        id          = 0
        backend_id  = 0
        role        = "example"
        arn         = "acs:ram:123456:tf:role/foobar"
      }
    ]
  }
}