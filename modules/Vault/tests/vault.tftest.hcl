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

run "vault_approle_auth_backend_login" {
  command = apply

  variables {
    auth_backend = [
      {
        id    = 0
        type  = "approle"
        path  = "approle"
      }
    ]
    approle_auth_backend_role = [
      {
        id              = 0
        backend_id      = 0
        role_name       = "test-role"
        token_policies  = ["default", "dev", "prod"]
      }
    ]
    approle_auth_backend_role_secret_id = [
      {
        id          = 0
        backend_id  = 0
        role_name   = 0
      }
    ]
    approle_auth_backend_login = [
      {
        id          = 0
        backend_id  = 0
        role_id     = 0
        secret_id   = 0
      }
    ]
  }
}

run "audit" {
  command = apply

  variables {
    audit = [
      {
        id    = 0
        type  = "socket"
        path  = "app_socket"
        local = false
        options = {
          address     = "127.0.0.1:8000"
          socket_type = "tcp"
          description = "application x socket"
        }
      }
    ]
  }
}

run "auth_backend" {
  command = apply

  variables {
    auth_backend = [
      {
        id    = 0
        type  = "aws"
      },
      {
        id    = 1
        type  = "azure"
      },
      {
        id    = 2
        type  = "gcp"
      }
    ]
    aws_auth_backend_cert = [
      {
        id              = 0
        backend_id      = 0
        cert_name       = "my-cert"
        aws_public_cert = "aws_public_key.crt"
        type            = "pkcs7"
      }
    ]
    aws_auth_backend_client = [
      {
        id         = 0
        backend_id = 0
        access_key = "INSERT_AWS_ACCESS_KEY"
        secret_key = "INSERT_AWS_SECRET_KEY"
      }
    ]
    azure_auth_backend_config = [
      {
        id            = 0
        backend_id    = 1
        tenant_id     = "11111111-2222-3333-4444-555555555555"
        client_id     = "11111111-2222-3333-4444-555555555555"
        client_secret = "01234567890123456789"
        resource      = "https://vault.hashicorp.com"
      }
    ]
    gcp_auth_backend_role = [
      {
        id                     = 0
        backend_id             = 2
        role                   = "test"
        type                   = "iam"
        bound_service_accounts = ["test"]
        bound_projects         = ["test"]
        token_ttl              = 300
        token_max_ttl          = 600
        token_policies         = ["policy_a", "policy_b"]
        add_group_aliases      = true
      }
    ]
  }
}

run "vault_pki_secret_backend_intermediate_set_signed" {
  command = apply

  variables {
    mount = [
      {
        id                        = 0
        path                      = "pki-root"
        type                      = "pki"
        description               = "root"
        default_lease_ttl_seconds = 8640000
        max_lease_ttl_seconds     = 8640000
      },
      {
        id                        = 1
        path                      = "pki-int"
        type_id                   = 0
        description               = "intermediate"
        default_lease_ttl_seconds = 86400
        max_lease_ttl_seconds     = 86400
      }
    ]
    pki_secret_backend_root_cert = [
      {
        id                   = 0
        backend              = 0
        type                 = "internal"
        common_name          = "RootOrg Root CA"
        ttl                  = 86400
        format               = "pem"
        private_key_format   = "der"
        key_type             = "rsa"
        key_bits             = 4096
        exclude_cn_from_sans = true
        ou                   = "Organizational Unit"
        organization         = "RootOrg"
        country              = "US"
        locality             = "San Francisco"
        province             = "CA"
      }
    ]
    pki_secret_backend_intermediate_cert_request = [
      {
        id          = 0
        backend     = 1
        type        = 0
        common_name = "SubOrg Intermediate CA"
      }
    ]
    pki_secret_backend_root_sign_intermediate = [
      {
        id                   = 0
        backend              = 0
        csr_id               = 0
        common_name          = "SubOrg Intermediate CA"
        exclude_cn_from_sans = true
        ou                   = "SubUnit"
        organization         = "SubOrg"
        country              = "US"
        locality             = "San Francisco"
        province             = "CA"
        revoke               = true
      }
    ]
    pki_secret_backend_intermediate_set_signed = [
      {
        id             = 0
        backend_id     = 1
        certificate_id = 0
      }
    ]
  }
}

run "vault_transit_secret" {
  command = apply

  variables {
    namespace = [
      {
        id    = 0
        path  = "ns1"
      }
    ]
    mount = [
      {
        id                        = 0
        path                      = "transit"
        type                      = "transit"
        description               = "Example description"
        default_lease_ttl_seconds = 3600
        max_lease_ttl_seconds     = 86400
        namespace_id              = 0
      }
    ]
    transit_secret_backend_key = [
      {
        id            = 0
        backend_id    = 0
        namespace_id  = 0
        name          = "my_key"
      }
    ]
    transit_secret_cache_config = [
      {
        id            = 0
        backend_id    = 0
        namespace_id  = 0
        size          = 500
      }
    ]
  }
}