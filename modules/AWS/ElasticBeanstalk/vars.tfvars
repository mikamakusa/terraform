application = [
  {
    id = ""
    name = ""
    description = "" # Optional
    tags = [ # Optional
      {
        ####
      }
    ]
    appversion_lifecycle = [
      {
        service_role_id = "" # Optional
        max_count = "" # Optional
        max_age_in_days = "" # Optional
        delete_source_from_s3 = "" # Optional
      }
    ]
  }
]

application_version = [
  {
    id = ""
    application_id = ""
    bucket_id = ""
    object_id = ""
    name = ""
    description = "" # Optional
    force_delete = "" # Optional
    tags = [
      {
        ####
      }
    ]
  }
]

configuration_template = [
  {
    id = ""
    application_id = ""
    name = ""
    description = "" # Optional
    environment_id = "" # Optional
    solution_stack_name = "" # Optional

    setting = [ # Optional
      {
        namespace = ""
        name = ""
        value = ""
        resource = "" # Optional
      }
    ]
  }
]

environment = [
  {
    id = ""
    application_id = ""
    name = ""
    cname_prefix = "" # Optional
    description = "" # Optional
    tier = "" # Optional, default value : WebServer / other value : Worker
    solution_stack_name = "" # Optional, in conflict with template_name and platform_arn
    template_name = "" # Optional, in conflict with solution_stack_name and platform_arn
    platform_arn = "" # Optional, in conflict with template_name and solution_stack_name
    wait_for_ready_timeout = "" # Optional
    poll_interval = "" # Optional
    version_label = "" # Optional
    tags = [ # Optional
      {
        ###
      }
    ]

    setting = [ # Optional
      {
        namespace = ""
        name = ""
        value = ""
        resource = "" # Optional
      }
    ]
  }
]
