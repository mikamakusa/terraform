resource "aws_db_snapshot" "snapshot" {
  count                  = length(var.snapshot)
  db_instance_identifier = element(var.db_instance_identifier, lookup(var.snapshot[count.index], "instance_id"))
  db_snapshot_identifier = lookup(var.snapshot[count.index], "snapshot_identifier")
  tags                   = var.tags
}