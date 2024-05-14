run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "create_aggregate_v2" {
  variables {
    aggregate_v2 = [
      {
        id    = 0
        name  = "aggregate_test"
      }
    ]
  }
}

run "create_flavor_access_v2" {
  variables {
    flavor_v2 = [
      {
        id    = 0
        name  = "my-flavor"
        ram   = "8096"
        vcpus = "2"
        disk  = "20"
      }
    ]
    flavor_access_v2 = [
      {
        id        = 0
        flavor_id = 0
      }
    ]
    project_name = "tenant_test"
  }
}

run "create_flavor_v2" {
  variables {
    flavor_v2 = [
      {
        id    = 0
        name  = "my-flavor"
        ram   = "8096"
        vcpus = "2"
        disk  = "20"
      }
    ]
  }
}

run "create_instance_v2" {
  variables {
    flavor_v2 = [
      {
        id    = 0
        name  = "my-flavor"
        ram   = "8096"
        vcpus = "2"
        disk  = "20"
      }
    ]
    instance_v2 = [
      {
        id        = 0
        name      = "instance_test"
        flavor_id = 0
      }
    ]
  }
}

run "create_interface_attach_v2" {
  variables {
    flavor_v2 = [
      {
        id    = 0
        name  = "my-flavor"
        ram   = "8096"
        vcpus = "2"
        disk  = "20"
      }
    ]
    instance_v2 = [
      {
        id        = 0
        name      = "instance_test"
        flavor_id = 0
      }
    ]
    interface_attach_v2 = [
      {
        id          = 0
        instance_id = 0
      }
    ]
  }
}

run "create_keypair_v2" {
  variables {
    keypair_v2 = [
      {
        id          = 0
        name        = "test_key"
        public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAjpC1hwiOCCmKEWxJ4qzTTsJbKzndLotBCz5PcwtUnflmU+gHJtWMZKpuEGVi29h0A/+ydKek1O18k10Ff+4tyFjiHDQAnOfgWf7+b1yK+qDip3X1C0UPMbwHlTfSGWLGZqd9LvEFx9k3h/M+VtMvwR1lJ9LUyTAImnNjWG7TaIPmui30HvM2UiFEmqkr4ijq45MyX2+fLIePLRIF61p4whjHAQYufqyno3BS48icQb4p6iVEZPo4AE2o9oIyQvj2mx4dk5Y8CgSETOZTYDOR3rU2fZTRDRgPJDH9FWvQjF5tA0p3d9CoWWd2s6GKKbfoUIi8R/Db1BSPJwkqB"
      }
    ]
  }
}

run "create_quotaset_v2" {
  variables {
    quotaset_v2 = [
      {
        id                   = 0
        key_pairs            = 10
        ram                  = 40960
        cores                = 32
        instances            = 20
        server_groups        = 4
        server_group_members = 8
      }
    ]
  }
}

run "create_servergroup_v2" {
  variables {
    servergroup_v2 = [
      {
        id       = 0
        name     = "my-sg"
        policies = ["anti-affinity"]
      }
    ]
  }
}

run "create_volume_attach_v2" {
  variables {
    volume_name = "volume_test_1"
    instance_v2 = [
      {
        id        = 0
        name      = "instance_test"
        flavor_id = 0
      }
    ]
    volume_attach_v2 = [
      {
        id          = 0
        instance_id = 0
      }
    ]
  }
}