# How to use this module ?

### global_table resource
```yaml
global_table = [
  {
    name = "xxxxxxxx"
    replicas = [
      {
        region-name = "xxxxx"
      },
      {
        region_name = "yyyyy"
      }
    ]
  }
]
```

You can create more than one replica in a different region for a named `global_table` resource.

### table resource
```yaml
table = [
    {
        name           = "GameScores"
        billing_mode   = "PROVISIONED"
        read_capacity  = 20
        write_capacity = 20
        hash_key       = "UserId"
        range_key      = "GameTitle"
        attribute = [
            {
                name = ""
                type = ""
            }
        ]
        ttl = [
            {
                enabled = "true"
                attribute_name = ""
            }
        ]
        timeouts = [
            {
                create = ""
                update = ""
                delete = ""
            }
        ]
        local_secondary_index = [
            {
                name = ""
                range_key = ""
                projection_type = ""
                non_key_attributes = ""
            }
        ]
        global_secondary_index = [
            {
                name               = "GameTitleIndex"
                hash_key           = "GameTitle"
                range_key          = "TopScore"
                write_capacity     = 10
                read_capacity      = 10
                projection_type    = "INCLUDE"
                non_key_attributes = "UserId"
            }
        ]
        server_side_encryption = [
            {
                enabled = ""
            {
        ]
        point_in_time_recovery = [
            {
                enabled = ""
            }
        ]
    }
]
```

### aws_dynamodb_table_item resource
```yaml
item = [
    {
        hash_id = ""
        table_id = ""
        name = ""
    }
]
```

The `name` key in `item` list refers to the json file which is placed in the `dynamodb` folder in the folder from which you'll launch the `terraform apply` command.  
Please, don't add `json` at the end of the file name, it has been already added in the module.