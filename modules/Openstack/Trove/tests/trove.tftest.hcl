run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "configuration_v1" {
  variables {
    configuration_v1 = [
      {
        id          = 0
        name        = "test"
        description = "description"
        datastore = [{
                  version = "mysql-5.7"
                  type    = "mysql"
                }]
        configuration = [{
                  name  = "max_connections"
                  value = 200
                }]
      }
    ]
  }
}
run "database_v1" {
  variables {
    instance_v1 = [
      {
        id        = 0
        region    = "region-test"
        name      = "test"
        flavor_id = "31792d21-c355-4587-9290-56c1ed0ca376"
        size      = 8
      }
    ]
    database_v1 = [
      {
        id          = 0
        name        = "mydb"
        instance_id = 0
      }
    ]
  }
}
run "instance_v1" {
  variables {
    instance_v1 = [
      {
        id = 0
        region    = "region-test"
        name      = "test"
        flavor_id = "31792d21-c355-4587-9290-56c1ed0ca376"
        size      = 8
      }
    ]
  }
}
run "user_v1" {
  variables {
    instance_v1 = [
      {
        id = 0
        region    = "region-test"
        name      = "test"
        flavor_id = "31792d21-c355-4587-9290-56c1ed0ca376"
        size      = 8
      }
    ]
    user_v1 = [
      {
        id           = 0
        name         = "user1"
        password     = "password"
        databases    = ["testdb"]
      }
    ]
  }
}