run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "create_dms_certificate" {
  variables {
    certificate = [{
      id              = "0"
      certificate_id  = "test-dms-certificate-tf"
    }]
  }
}

run "create_endpoint" {
  variables {
    endpoint = [
      {
        id                          = 0
        database_name               = "test"
        endpoint_id                 = "test-dms-endpoint-tf-source"
        endpoint_type               = "source"
        engine_name                 = "aurora"
        extra_connection_attributes = ""
        password                    = "test"
        port                        = 3306
        server_name                 = "test"
        ssl_mode                    = "none"
      },
      {
        id                          = 1
        database_name               = "test1"
        endpoint_id                 = "test-dms-endpoint-tf-target"
        endpoint_type               = "target"
        engine_name                 = "aurora"
        extra_connection_attributes = ""
        password                    = "test"
        port                        = 3306
        server_name                 = "test"
        ssl_mode                    = "none"
      }
    ]
  }
}

run "create_event_subscription" {
  variables {
    event_subscription = [{
      id               = 0
      enabled          = true
      event_categories = ["creation", "failure"]
      name             = "my-favorite-event-subscription"
      sns_topic_arn    = aws_sns_topic.example.arn
      source_type      = "replication-task"
    }]
  }
}

run "create_replication_instance" {
  variables {
    replication_instance = [{
      id                           = 0
      allocated_storage            = 20
      apply_immediately            = true
      auto_minor_version_upgrade   = true
      availability_zone            = "us-west-2c"
      engine_version               = "3.1.4"
      multi_az                     = false
      preferred_maintenance_window = "sun:10:30-sun:14:30"
      publicly_accessible          = true
      replication_instance_class   = "dms.t2.micro"
      replication_instance_id      = "test-dms-replication-instance-tf"
    }]
  }
}

run "create_replication_task" {
  variables {
    replication_task = [{
      id                      = 0
      cdc_start_time          = "1993-05-21T05:50:00Z"
      migration_type          = "full-load"
      replication_instance_id = "test-dms-replication-task-tf"
      replication_task_id     = 0
      source_endpoint_id      = 0
      table_mappings          = "{\"rules\":[{\"rule-type\":\"selection\",\"rule-id\":\"1\",\"rule-name\":\"1\",\"object-locator\":{\"schema-name\":\"%\",\"table-name\":\"%\"},\"rule-action\":\"include\"}]}"
      target_endpoint_id      = 1
    }]
  }
}

run "create_s3_endpoint" {
  variables {
    s3_endpoint = [{
      id                      = 0
      endpoint_id             = "donnedtipi"
      endpoint_type           = "target"
      bucket_name             = "beckut_name"
      service_access_role_arn = aws_iam_role.example.arn
    }]
  }
}