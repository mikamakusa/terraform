resource "aws_db_instance_role_association" "instance_role_association" {
  count                  = length(var.instance_role_association)
  db_instance_identifier = element(var.db_instance_identifier, lookup(var.instance_role_association[count.index], "instance_id"))
  feature_name           = lookup(var.instance_role_association[count.index], "feature_name")
  role_arn               = element(var.role_arn, lookup(var.instance_role_association[count.index], "role_id"))
}