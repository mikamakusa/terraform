run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "recordset_v2" {
  command = apply
  
  variables {
    project_name = "project_test_1"
    zone_v2 = {
      [
        id          = 0
        name        = "example.com."
        email       = "jdoe@example.com"
        description = "An example zone"
        ttl         = 3000
        type        = "PRIMARY"
      ]
    }
    recordset_v2 = {
      [
        id          = 0
        zone_id     = 0
        name        = "rs.example.com."
        description = "An example record set"
        ttl         = 3000
        type        = "A"
        records     = ["10.0.0.1"]
      ]
    }
  }
}

run "transfer_accept_v2" {
  command = apply
  
  variables {
    project_name = "project_test_1"
    zone_v2 = {
      [
        id          = 0
        name        = "example.com."
        email       = "jdoe@example.com"
        description = "An example zone"
        ttl         = 3000
        type        = "PRIMARY"
      ]
    }
    transfer_request_v2 = {
      [
        id                = 0
        zone_id           = 0
        description       = "a transfer accept"
      ]
    }
  }
}

run "transfer_request_v2" {
  command = apply
  
  variables {
    project_name = "project_test_1"
    zone_v2 = {
      [
        id = 0
        name        = "example.com."
        email       = "jdoe@example.com"
        description = "An example zone"
        ttl         = 3000
        type        = "PRIMARY"
      ]
    }
    transfer_request_v2 = {
      [
        id                = 0
        zone_id           = 0
        description       = "a transfer accept"
      ]
    }
    transfer_accept_v2 = {
      [
        id      = 0
        zone_id = 0
      ]
    }
  }
}

run "zone_v2" {
  command = apply
  
  variables {
    project_name = "project_test_1"
    zone_v2 = {
      [
        id = 0
        name        = "example.com."
        email       = "jdoe@example.com"
        description = "An example zone"
        ttl         = 3000
        type        = "PRIMARY"
      ]
    }
  }
}
