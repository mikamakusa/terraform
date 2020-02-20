resource "aws_dynamodb_global_table" "aws_global_table" {
  count = length(var.global_table)
  name  = element(var.dynamodb_table_name, lookup(var.global_table[count.index], "table_id"))

  dynamic "replica" {
    for_each = lookup(var.global_table[count.index], "replica")
    content {
      region_name = lookup(replica.value, "region_name")
    }
  }
}