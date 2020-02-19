resource "aws_athena_named_query" "athena_query" {
  count     = length(var.athena_query)
  database  = lookup(var.athena_query[count.index], "database")
  name      = lookup(var.athena_query[count.index], "name")
  query     = join(" ", ["SELECT", "*", "FROM", element(var.athena_database_name, lookup(var.athena_query[count.index], "database_id", lookup(var.athena_query[count.index], "query")))])
  workgroup = element(var.athena_workgroup_id, lookup(var.athena_query[count.index], "workspace_id"))
}