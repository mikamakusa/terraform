run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "actiontrail" {
    command = apply

    variables {
        roles   = "test1"
        buckets = "bucket_test1"
        ram_roles = [
            {
                id = 0
                name = "role-test"
            }
        ]
        oss_bucket = [
            {
                id = 0
                bucket = "test-bucket"
            },
            {
                id = 1
                bucket = "test-bucket-logging"
            }
        ]
        actiontrail = [
            {
                id              = 0
                name            = "action-trail"
                event_rw        = "Write-test"
                oss_key_prefix  = "at-product-account-audit-B"
            },
            {
                id = 1
                name            = "action-trail"
                event_rw        = "Write-test-1"
                oss_bucket_id   = 0
                role_id         = 0
                oss_key_prefix  = "at-product-account-audit-C"
            }
        ]
    }
}