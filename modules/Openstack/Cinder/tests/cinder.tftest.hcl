run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "qos_association_v3" {
  command = apply

  variables {
    project_name = "project_test_1"
    qos_v3 = [
      {
        id        = 0
        name      = "%s"
        consumer  = "front-end"
      }
    ]
    volume_type_v3 = [
      {
        id    = 0
        name  = "%s"
      }
    ]
    qos_association_v3 = [
      {
        id             = 0
        qos_id         = 0
        volume_type_id = 0
      }
    ]
  }
}
run "qos_v3" {
  command = apply

  variables {
    project_name = "project_test_1"
    qos_v3 = [
      {
        id        = 0
        name      = "%s"
        consumer  = "front-end"
      },
      {
        id        = 1
        name      = "%s"
        consumer  = "back-end"
      }
    ]
  }

  assert {
    condition     = contains(["front-end","back-end","both"], var.qos_v3[0].consumer)
    error_message = "Invalid input, Can be one of front-end, back-end or both."
  }
}
run "quotaset_v3" {
  command = apply

  variables {
    project_name = "project_test_1"
    quotaset_v3 = [
      {
        id                    = 0
        volumes               = 10
        snapshots             = 4
        gigabytes             = 100
        per_volume_gigabytes  = 10
        backups               = 4
        backup_gigabytes      = 10
        groups                = 100
      }
    ]
  }
}
run "volume_attach_v3" {
  command = apply

  variables {
    project_name = "project_test_1"
    volume_v3 = [
      {
        id                    = 0
        size                  = 100
        enable_online_resize  = true
        name                  = "volume_test"
        multiattach           = true
      }
    ]
    volume_attach_v3 = [
      {
        id         = 0
        volume_id  = 0
        device     = "auto"
        host_name  = "devstack"
        ip_address = "192.168.255.10"
        initiator  = "iqn.1993-08.org.debian:01:e9861fb1859"
        os_type    = "linux2"
        platform   = "x86_64"
      }
    ]
  }
}
run "volume_type_access_v3" {
  command = apply

  variables {
    project_name = "project_test_1"
    volume_type_v3 = [
      {
        id        = 0
        name      = "volume_type_1"
        is_public = false
      }
    ]
    volume_type_access_v3 = [
      {
        id             = 0
        volume_type_id = 0
      }
    ]
  }
}
run "volume_type_v3" {
  command = apply

  variables {
    project_name = "project_test_1"
    volume_type_v3 = [
      {
        id        = 0
        name      = "volume_type_1"
        is_public = false
      }
    ]
  }
}
run "volume_v3" {
  command = apply

  variables {
    project_name = "project_test_1"
    volume_v3 = [
      {
        id                    = 0
        size                  = 100
        enable_online_resize  = true
        name                  = "volume_test"
        multiattach           = true
      }
    ]
  }
}