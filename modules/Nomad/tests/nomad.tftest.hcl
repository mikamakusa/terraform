run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "nomad_acl" {
  command = apply

  variables {
    job = [
      {
        id      = 0
        jobspec = "jobspec.hcl"
        hcl2 = [{
                  allow_fs = true
                }]
      }
    ]
    acl_auth_method = [
      {
        id                = 0
        name              = "my-nomad-acl-auth-method"
        type              = "OIDC"
        token_locality    = "global"
        max_token_ttl     = "10m0s"
        default           = true

        config = [
          {
            oidc_discovery_url    = "https://uk.auth0.com/"
            oidc_client_id        = "someclientid"
            oidc_client_secret    = "someclientsecret-t"
            bound_audiences       = ["someclientid"]
            allowed_redirect_uris = ["http://localhost:4649/oidc/callback","http://localhost:4646/ui/settings/tokens",]
            list_claim_mappings = {
              "http://nomad.internal/roles" : "roles"
            }
          }
        ]
      }
    ]
    acl_binding_rule = [
      {
        id          = 0
        description = "engineering rule"
        auth_method = 0
        selector    = "engineering in list.roles"
        bind_type   = "role"
        bind_name   = "engineering-read-only"
      }
    ]
    acl_policy = [
      {
        id          = 0
        name        = "dev"
        description = "Submit jobs to the dev environment."
        rules_hcl   = "dev.hcl"
        job_acl = [
          {
            job_id = 0
          }
        ]
      }
    ]
    acl_role = [
      {
        id          = 0
        name        = "my-nomad-acl-role"
        description = "An ACL Role for cluster developers"
        policy = [
          {
            policy_id = 0
          }
        ]
      }
    ]
    acl_token = [
      {
        id       = 0
        type     = "client"
        policies = ["dev"]
        global   = true
      },
      {
        id   = 1
        name = "Iman"
        type = "management"
      }
    ]
  }
}

run "csi_volumes" {
  command = apply

  variables {
    nomad_plugin = "aws-ebs0"
    namespace = [
      {
        id          = 0
        name        = "dev"
        description = "Shared development environment."
        quota       = "dev"
        meta        = {
          owner = "John Doe"
          foo   = "bar"
        }
      }
    ]
    csi_volume = [
      {
        id           = 0
        volume_id    = "mysql_volume"
        name         = "mysql_volume"
        capacity_min = "10GiB"
        capacity_max = "20GiB"
        capability = [
          {
            access_mode     = "single-node-writer"
            attachment_mode = "file-system"
          }
        ]
        mount_options = [
          {
            fs_type = "ext4"
          }
        ]
        topology_request = [
          {
            required = [
              {
                topology = [
                  {
                    segments = {
                      rack = "R1"
                      zone = "us-east-1a"
                    }
                  }
                ]
                topology = [
                  {
                    segments = {
                      rack = "R2"
                    }
                  }
                ]
              }
            ]
          }
        ]
      }
    ]
    csi_volume_registration = [
      {
        id           = 0
        volume_id    = "mysql_volume"
        external_id  = "..."
        name         = "mysql_volume"
        capacity_min = "10GiB"
        capacity_max = "20GiB"
        capability = [
          {
            access_mode     = "single-node-writer"
            attachment_mode = "file-system"
          }
        ]
        mount_options = [
          {
            fs_type = "ext4"
          }
        ]
        topology_request = [
          {
            required = [
              {
                topology = [
                  {
                    segments = {
                      rack = "R1"
                      zone = "us-east-1a"
                    }
                  }
                ]
                topology = [
                  {
                    segments = {
                      rack = "R2"
                    }
                  }
                ]
              }
            ]
          }
        ]
      }
    ]
  }
}

run "namespace" {
  command = apply

  variables {
    quota_specification = [
      {
        id          = 0
        name        = "web-team"
        description = "web team quota"
        limits = [
          {
            region = "global"
            region_limit = [
              {
                cpu       = 1000
                memory_mb = 256
              }
            ]
          }
        ]
      }
    ]
    namespace = [
      {
        id          = 0
        name        = "web"
        description = "Web team production environment."
        quota_id    = 0
      }
    ]
  }
}