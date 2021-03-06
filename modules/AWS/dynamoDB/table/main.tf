resource "aws_dynamodb_table" "aws_dynamodb_table" {
  count          = length(var.table)
  hash_key       = lookup(var.table[count.index], "hash_key")
  name           = lookup(var.table[count.index], "name")
  billing_mode   = lookup(var.table[count.index], "billing_mode")
  read_capacity  = lookup(var.table[count.index], "read_capacity")
  write_capacity = lookup(var.table[count.index], "write_capacity")
  range_key      = lookup(var.table[count.index], "range_key", null)

  dynamic "attribute" {
    for_each = lookup(var.table[count.index], "attribute")
    content {
      name = lookup(attribute.value, "name")
      type = lookup(attribute.value, "type")
    }
  }

  dynamic "ttl" {
    for_each = lookup(var.table[count.index], "ttl")
    content {
      enabled        = lookup(ttl.value, "enabled", false)
      attribute_name = lookup(ttl.value, "attribute_name")
    }
  }

  dynamic "timeouts" {
    for_each = lookup(var.table[count.index], "timeouts")
    content {
      create = lookup(timeouts.value, "create", 10)
      update = lookup(timeouts.value, "update", 60)
      delete = lookup(timeouts.value, "delete", 10)
    }
  }

  dynamic "local_secondary_index" {
    for_each = lookup(var.table[count.index], "local_secondary_index")
    content {
      name               = lookup(local_secondary_index.value, "name")
      range_key          = lookup(local_secondary_index.value, "range_key")
      projection_type    = lookup(local_secondary_index.value, "projection_type")
      non_key_attributes = [lookup(local_secondary_index.value, "non_key_attributes", null)]
    }
  }

  dynamic "global_secondary_index" {
    for_each = lookup(var.table[count.index], "global_secondary_index")
    content {
      name               = lookup(global_secondary_index.value, "name")
      write_capacity     = lookup(global_secondary_index.value, "write_capacity", null)
      read_capacity      = lookup(global_secondary_index.value, "read_capacity", null)
      hash_key           = lookup(global_secondary_index.value, "hash_key")
      range_key          = lookup(global_secondary_index.value, "range_key", null)
      projection_type    = lookup(global_secondary_index.value, "projection_type")
      non_key_attributes = [lookup(global_secondary_index.value, "non_key_attributes", null)]
    }
  }
  dynamic "server_side_encryption" {
    for_each = lookup(var.table[count.index], "server_side_encryption")
    content {
      enabled = lookup(server_side_encryption.value, "enabled", false)
    }
  }

  dynamic "point_in_time_recovery" {
    for_each = lookup(var.table[count.index], "point_in_time_recovery")
    content {
      enabled = lookup(point_in_time_recovery.value, "enabled", false)
    }
  }
}