run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "image_v2" {
  command = apply

  variables {
    image_v2 = [
      {
        id               = 0
        name             = "RancherOS"
        image_source_url = "https://releases.rancher.com/os/latest/rancheros-openstack.img"
        container_format = "bare"
        disk_format      = "qcow2"
      }
    ]
  }
}

run "image_access_accept_v2" {
  command = apply

  variables {
    image_v2 = [
      {
        id               = 0
        name             = "RancherOS"
        image_source_url = "https://releases.rancher.com/os/latest/rancheros-openstack.img"
        container_format = "bare"
        disk_format      = "qcow2"
      }
    ]
    image_access_accept_v2 = [
      {
        id       = 0
        image_id = 0
        status   = "accepted"
      }
    ]
  }
}

run "image_access_v2" {
  command = apply

  variables {
    image_v2 = [
      {
        id               = 0
        name             = "RancherOS"
        image_source_url = "https://releases.rancher.com/os/latest/rancheros-openstack.img"
        container_format = "bare"
        disk_format      = "qcow2"
      }
    ]
    image_access_v2 = [
      {
        id        = 0
        image_id  = 0
        member_id = "bed6b6cbb86a4e2d8dc2735c2f1000e4"
        status    = "accepted"
      }
    ]
  }
}
