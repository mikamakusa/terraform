resource "aws_dynamodb_table_item" "aws_table_item" {
  count      = length(var.item)
  hash_key   = element(var.dynamodb_table_hash_key,lookup(var.item[count.index],"table_id"))
  item       = file("${path.cwd}/dynamodb/${lookup(var.item[count.index],"name")}.json")
  table_name = element(var.dynamodb_table_name,lookup(var.item[count.index],"table_id"))
}