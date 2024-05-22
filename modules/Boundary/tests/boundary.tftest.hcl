run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "account_ldap" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    auth_method_ldap = [
      {
        id            = 0
        name          = "forumsys public LDAP"
        scope_id      = "global"                               
        urls          = ["ldap://ldap.forumsys.com"]           
        user_dn       = "dc=example,dc=com"                    
        user_attr     = "uid"                                  
        group_dn      = "dc=example,dc=com"                    
        bind_dn       = "cn=read-only-admin,dc=example,dc=com" 
        bind_password = "password"                             
        state         = "active-public"                        
        enable_groups = true                                   
        discover_dn   = true                   
      }
    ]
    account_ldap = [
      {
        id             = 0
        auth_method_id = 0
        login_name     = "einstein"
        name           = "einstein"
      },
      {
        id             = 1
        auth_method_id = 0
        login_name     = "darwin"
        name           = "darwin"
      }
    ]
    user = [
      {
        id          = 0
        name        = "einstein"
        description = "User resource for einstein"
        scope_id    = "global"
        account_ids = [0]
      },
      {
        id          = 1
        name        = "darwin"
        description = "User resource for darwin"
        scope_id    = "global"
        account_ids = [1]
      }
    ]
  }
}

run "account_oid" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    auth_method_oidc = [
      {
        id                 = 0
        api_url_prefix     = "https://XO-XO-XO-XO-XOXOXO.boundary.hashicorp.cloud:9200"
        client_id          = "eieio"
        client_secret      = "hvo_secret_XO"
        description        = "My Boundary OIDC Auth Method for Vault"
        issuer             = "https://XO-XO-XO-XO-XOXOXO.vault.hashicorp.cloud:8200/v1/identity/oidc/provider/my-provider"
        scope_id           = 0
        signing_algorithms = ["RS256"]
        type               = "oidc"
      }
    ]
    account_oidc = [
      {
        id              = 0
        auth_method_id  = 0
        name            = "beethoven"
      }
    ]
    user = [
      {
        id          = 0
        name        = "beethoven"
        description = "User resource for einstein"
        scope_id    = "global"
        account_ids = [0]
      }
    ]
  }
}

run "account_password" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    auth_method = [
      {
        id        = 0
        scope_id  = 0
        type      = "password"
      }
    ]
    account_password = [
      {
        id             = 0
        auth_method_id = 0
        login_name     = "jeff"
        password       = "$uper$ecure"
      }
    ]
  }
}

run "auth_method" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    auth_method = [
      {
        id        = 0
        scope_id  = 0
        type      = "password"
      }
    ]
  }
}

run "auth_method_oidc" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    auth_method_oidc = [
      {
        id                 = 0
        api_url_prefix     = "https://XO-XO-XO-XO-XOXOXO.boundary.hashicorp.cloud:9200"
        client_id          = "eieio"
        client_secret      = "hvo_secret_XO"
        description        = "My Boundary OIDC Auth Method for Vault"
        issuer             = "https://XO-XO-XO-XO-XOXOXO.vault.hashicorp.cloud:8200/v1/identity/oidc/provider/my-provider"
        scope_id           = 0
        signing_algorithms = ["RS256"]
        type               = "oidc"
      }
    ]
  }
}

run "auth_method_ldap" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    auth_method_ldap = [
      {
        id            = 0
        name          = "forumsys public LDAP"
        scope_id      = "global"                               
        urls          = ["ldap://ldap.forumsys.com"]           
        user_dn       = "dc=example,dc=com"                    
        user_attr     = "uid"                                  
        group_dn      = "dc=example,dc=com"                    
        bind_dn       = "cn=read-only-admin,dc=example,dc=com" 
        bind_password = "password"                             
        state         = "active-public"                        
        enable_groups = true                                   
        discover_dn   = true                   
      }
    ]
  }
}

run "auth_method_password" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    auth_method_password = [
      {
        id        = 0
        scope_id  = 0
        type      = "password"
      }
    ]
  }
}

run "credential_json" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    credential_store_static = [
      {
        id          = 0
        name        = "example_static_credential_store"
        description = "My first static credential"
        scope_id    = 0
      }
    ]
    credential_json = [
      {
        id                  = 0
        name                = "example_json"
        description         = "My first json credential!"
        credential_store_id = 0
        object              = "~/object.json"
      }
    ]
  }
}

run "credential_library_vault" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    credential_store_vault = [
      {
        id          = 0
        name        = "foo"
        description = "My first Vault credential store!"
        address     = "http://127.0.0.1:8200"      
        token       = "s.0ufRo6XEGU2jOqnIr7OlFYP5" 
        scope_id    = 0
      }
    ]
    credential_library_vault = [
      {
        id                  = 0
        name                = "foo"
        description         = "My first Vault credential library!"
        credential_store_id = 0
        path                = "my/secret/foo"
        http_method         = "GET"
      },
      {
        id                  = 1
        name                = "bar"
        description         = "My first Vault credential library!"
        credential_store_id = 0
        path                = "my/secret/bar"
        http_method         = "GET"
      }
    ]
  }
}

run "credential_library_vault_ssh_certificate" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    credential_store_vault = [
      {
        id          = 0
        name        = "foo"
        description = "My first Vault credential store!"
        address     = "http://127.0.0.1:8200"      
        token       = "s.0ufRo6XEGU2jOqnIr7OlFYP5" 
        scope_id    = 0
      }
    ]
    credential_library_vault_ssh_certificate = [
      {
        id                  = 0
        name                = "foo"
        description         = "My first Vault SSH certificate credential library!"
        credential_store_id = 0
        path                = "ssh/sign/foo"
        username            = "foo"
      },
      {
        id                  = 1
        name                = "bar"
        description         = "My second Vault SSH certificate credential library!"
        credential_store_id = 0
        path                = "ssh/sign/foo" 
        username            = "foo"
        key_type            = "ecdsa"
        key_bits            = 384
        extensions = {
          permit-pty = ""
        }
      }
    ]
  }
}

run "credential_ssh_private_key" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    credential_store_static = [
      {
        id          = 0
        name        = "example_static_credential_store"
        description = "My first static credential"
        scope_id    = 0
      }
    ]
    credential_ssh_private_key = [
      {
        id                     = 0
        name                   = "example_ssh_private_key"
        description            = "My first ssh private key credential!"
        credential_store_id    = 0
        username               = "my-username"
        private_key            = "~/.ssh/id_rsa"
        private_key_passphrase = "optional-passphrase"
      }
    ]
  }
}

run "credential_store_static" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    credential_store_static = [
      {
        id          = 0
        name        = "example_static_credential_store"
        description = "My first static credential"
        scope_id    = 0
      }
    ]
  }
}

run "credential_store_vault" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    credential_store_vault = [
      {
        id          = 0
        name        = "foo"
        description = "My first Vault credential store!"
        address     = "http://127.0.0.1:8200"     
        token       = "s.0ufRo6XEGU2jOqnIr7OlFYP5"
        scope_id    = 0
      }
    ]
  }
}

run "credential_username_password" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    credential_store_static = [
      {
        id          = 0
        name        = "example_static_credential_store"
        description = "My first static credential"
        scope_id    = 0
      }
    ]
    credential_username_password = [
      {
        id                  = 0
        name                = "example_username_password"
        description         = "My first username password credential!"
        credential_store_id = 0
        username            = "my-username"
        password            = "my-password"
      }
    ]
  }
}

run "group" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    user = [
      {
        id          = 0
        description = "foo user"
        scope_id    = 0
      },
      {
        id          = 1
        description = "bar user"
        scope_id    = 0
      },
      {
        id          = 2
        description = "test user"
        scope_id    = 0
      }
    ]
    group = [
      {
        id          = 0
        name        = "My group"
        description = "My first group!"
        member_ids  = [0, 1, 2]
        scope_id    = 0
      }
    ]
  }
}

run "host" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    host_catalog = [
      {
        id          = 0
        name        = "My catalog"
        description = "My first host catalog!"
        type        = "static"
        scope_id    = 0
      }
    ]
    host = [
      {
        id              = 0
        type            = "static"
        name            = "example_host"
        description     = "My first host!"
        address         = "10.0.0.1"
        host_catalog_id = 0
      }
    ]
  }
}

run "host_catalog" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    host_catalog = [
      {
        id          = 0
        name        = "My catalog"
        description = "My first host catalog!"
        type        = "static"
        scope_id    = 0
      }
    ]
  }
}

run "host_catalog_plugin" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    host_catalog = [
      {
        id          = 0
        name        = "My catalog"
        description = "My first host catalog!"
        type        = "static"
        scope_id    = 0
      }
    ]
    host_catalog_plugin = [
      {
        id              = 0
        name            = "My aws catalog"
        description     = "My first host catalog!"
        scope_id        = 0
        plugin_name     = "aws"
        attributes_json = { "region" = "us-east-1" }
        secrets_json = {
                          "access_key_id"     = "aws_access_key_id_value",
                          "secret_access_key" = "aws_secret_access_key_value"
                        }
      }
    ]
  }
}

run "host_catalog_static" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    host_catalog_static = [
      {
        id          = 0
        name        = "My catalog"
        description = "My first host catalog!"
        scope_id    = 0
      }
    ]
  }
}

run "host_set" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    host_catalog_static = [
      {
        id          = 0
        name        = "My catalog"
        description = "My first host catalog!"
        scope_id    = 0
      }
    ]
    host = [
      {
        id              = 0
        type            = "static"
        name            = "example_host"
        description     = "My first host!"
        address         = "10.0.0.1"
        host_catalog_id = 0
      },
      {
        id              = 1
        type            = "static"
        name            = "example_host"
        description     = "My second host!"
        address         = "10.0.0.2"
        host_catalog_id = 0
      }
    ]
    host_set = [
      {
        id = 0
        host_catalog_id = 0
        type            = "static"
        host_ids = [
          1,
          2
        ]
      }
    ]
  }
}

run "host_set_plugin" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    host_catalog = [
      {
        id          = 0
        name        = "My catalog"
        description = "My first host catalog!"
        type        = "static"
        scope_id    = 0
      }
    ]
    host_catalog_plugin = [
      {
        id              = 0
        name            = "My aws catalog"
        description     = "My first host catalog!"
        scope_id        = 0
        plugin_name     = "aws"
        attributes_json = { "region" = "us-east-1" }
        secrets_json = {
                          "access_key_id"     = "aws_access_key_id_value",
                          "secret_access_key" = "aws_secret_access_key_value"
                        }
      },
      {
        id              = 1
        name            = "My azure catalog"
        description     = "My second host catalog!"
        scope_id        = 0
        plugin_name     = "azure"
        attributes_json = {
                            "disable_credential_rotation" = "true",
                            "tenant_id"                   = "ARM_TENANT_ID",
                            "subscription_id"             = "ARM_SUBSCRIPTION_ID",
                            "client_id"                   = "ARM_CLIENT_ID"
                          }
        secrets_json = {
                          "secret_value" = "ARM_CLIENT_SECRET"
                        }
      }
    ]
    host_set_plugin = [
      {
        id              = 0
        name            = "My web host set plugin"
        host_catalog_id = 0
        attributes_json = { "filters" = ["tag:service-type=web"] }
      },
      {
        id                  = 1
        name                = "My foobar host set plugin"
        host_catalog_id     = 0
        preferred_endpoints = ["cidr:54.0.0.0/8"]
        attributes_json = {
          "filters" = ["tag-key=foo", "tag-key=bar"]
        }
      },
      {
        id                    = 2
        name                  = "My foodev host set plugin"
        host_catalog_id       = 0
        preferred_endpoints   = ["cidr:54.0.0.0/8"]
        sync_interval_seconds = 60
        attributes_json = {
          "filter" = "tagName eq 'tag-key' and tagValue eq 'foo'",
          "filter" = "tagName eq 'application' and tagValue eq 'dev'",
        }
      }
    ]
  }
}

run "host_set_static" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    host_catalog_static = [
      {
        id          = 0
        name        = "My catalog"
        description = "My first host catalog!"
        scope_id    = 0
      }
    ]
    host_static = [
      {
        id              = 0
        name            = "host_1"
        description     = "My first host!"
        address         = "10.0.0.1"
        host_catalog_id = 1
      },
      {
        id              = 1
        name            = "host_2"
        description     = "My first host!"
        address         = "10.0.0.2"
        host_catalog_id = 1
      }
    ]
    host_set_static = [
      {
        id = 0
        host_catalog_id = 0
        host_ids = [
          0,
          1
        ]
      }
    ]
  }
}

run "host_static" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    host_catalog_static = [
      {
        id          = 0
        name        = "My catalog"
        description = "My first host catalog!"
        scope_id    = 0
      }
    ]
    host_static = [
      {
        id              = 0
        name            = "host_1"
        description     = "My first host!"
        address         = "10.0.0.1"
        host_catalog_id = 1
      },
      {
        id              = 1
        name            = "host_2"
        description     = "My first host!"
        address         = "10.0.0.2"
        host_catalog_id = 1
      }
    ]
  }
}

run "managed_group_ldap" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    auth_method_ldap = [
      {
        id            = 0
        name          = "forumsys public LDAP"
        scope_id      = "global"                               
        urls          = ["ldap://ldap.forumsys.com"]           
        user_dn       = "dc=example,dc=com"                    
        user_attr     = "uid"                                  
        group_dn      = "dc=example,dc=com"                    
        bind_dn       = "cn=read-only-admin,dc=example,dc=com" 
        bind_password = "password"                             
        state         = "active-public"                        
        enable_groups = true                                   
        discover_dn   = true                   
      }
    ]
    managed_group_ldap = [
      {
        id             = 0
        name           = "scientists"
        description    = "forumsys scientists managed group"
        auth_method_id = 0
        group_names    = ["Scientists"]
      }
    ]
  }
}

run "role" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    user = [
      {
        id          = 0
        description = "foo user"
        scope_id    = 0
      },
      {
        id          = 1
        description = "bar user"
        scope_id    = 0
      },
      {
        id          = 2
        description = "test user"
        scope_id    = 0
      }
    ]
    group = [
      {
        id          = 0
        name        = "My group"
        description = "My first group!"
        member_ids  = [0, 1, 2]
        scope_id    = 0
      }
    ]
    role = [
      {
        id            = 0
        name          = "My role"
        description   = "My first role!"
        scope_id      = 0
        principal_ids = [1, 2]
      }
    ]
  }
}

run "scope" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
  }
}

run "storage_bucket" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    storage_bucket = [
      {
        id              = 0
        name            = "My aws storage bucket with static credentials"
        description     = "My first storage bucket!"
        scope_id        = 0
        plugin_name     = "aws"
        bucket_name     = "mybucket"
        attributes_json = { "region" = "us-east-1" }
        secrets_json = {
          "access_key_id"     = "aws_access_key_id_value",
          "secret_access_key" = "aws_secret_access_key_value"
        }
      }
    ]
  }
}

run "target" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    credential_store_vault = [
      {
        id          = 0
        name        = "foo"
        description = "My first Vault credential store!"
        address     = "http://127.0.0.1:8200"     
        token       = "s.0ufRo6XEGU2jOqnIr7OlFYP5"
        scope_id    = 0
      }
    ]
    host_catalog_static = [
      {
        id          = 0
        name        = "My catalog"
        description = "My first host catalog!"
        scope_id    = 0
      }
    ]
    host = [
      {
        id              = 0
        type            = "static"
        name            = "example_host"
        description     = "My first host!"
        address         = "10.0.0.1"
        host_catalog_id = 0
      },
      {
        id              = 1
        type            = "static"
        name            = "example_host"
        description     = "My second host!"
        address         = "10.0.0.2"
        host_catalog_id = 0
      }
    ]
    host_set = [
      {
        id = 0
        host_catalog_id = 0
        type            = "static"
        host_ids = [
          1,
          2
        ]
      }
    ]
    target = [
      {
        id           = 0
        name         = "foo"
        description  = "Foo target"
        type         = "tcp"
        default_port = "22"
        scope_id     = 0
        host_source_ids = [
          0
        ]
        brokered_credential_source_ids = [
          0
        ]
      }
    ]
  }
}

run "user" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    user = [
      {
        id          = 0
        description = "foo user"
        scope_id    = 0
      },
      {
        id          = 1
        description = "bar user"
        scope_id    = 0
      },
      {
        id          = 2
        description = "test user"
        scope_id    = 0
      }
    ]
  }
}

run "worker" {
  command = apply

  variables {
    scope = [
      {
        id                       = 0
        name                     = "organization_one"
        description              = "My first scope!"
        scope_id                 = "global"
        auto_create_admin_role   = true
        auto_create_default_role = true
      }
    ]
    worker = [
      {
        id          = 0
        scope_id    = 0
        name        = "worker 1"
        description = "self managed worker with controller led auth"
      }
    ]
  }
}
