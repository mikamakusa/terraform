run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "container_v1" {
  command = apply

  variables {
    project_name = "project_test_1"
    metadata = {
      apply     = "terraform"
      provider  = "openstack"
    }
    container_v1 = [
      {
        id        = 0
        name      = "tf-test-container-1"
        metadata  = {
          test = "true"
        }
        content_type = "application/json"
        versioning   = true
      }
    ]
  }
}

run "object_v1" {
  command = apply

  variables {
    project_name = "project_test_1"
    metadata = {
      apply     = "terraform"
      provider  = "openstack"
    }
    container_v1 = [
      {
        id        = 0
        name      = "tf-test-container-1"
        metadata  = {
          test = "true"
        }
        content_type = "application/json"
        versioning   = true
      }
    ]
    object_v1 = [
      {
        id             = 0
        container_name = 0
        name           = "test/default.json"
        metadata = {
          test = "true"
        }
        content_type = "application/json"
        content      = <<JSON
                     {
                       "foo" : "bar"
                     }
      JSON
      }
    ]
  }
}

run "tempurl_v1" {
  command = apply

  variables {
    project_name = "project_test_1"
    metadata = {
      apply     = "terraform"
      provider  = "openstack"
    }
    container_v1 = [
      {
        id        = 0
        name      = "tf-test-container-1"
        metadata  = {
          test = "true"
        }
        content_type = "application/json"
        versioning   = true
      }
    ]
    object_v1 = [
      {
        id             = 0
        container_name = 0
        name           = "test/default.json"
        metadata = {
          test = "true"
        }
        content_type = "application/json"
        content      = <<JSON
                     {
                       "foo" : "bar"
                     }
      JSON
      }
    ]
    tempurl_v1 = [
      {
        id        = 0
        container = 0
        object    = 0
        method    = "post"
        ttl       = 20
      }
    ]
  }
}
