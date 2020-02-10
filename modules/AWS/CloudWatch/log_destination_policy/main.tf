resource "aws_cloudwatch_log_destination_policy" "destination_policy" {
  count            = length(var.destination_policy)
  access_policy    = file(join(".", [join("/", [path.cwd, lookup(var.destination_policy[count.index], "access_policy")]), "json"]))
  destination_name = lookup(var.destination_policy[count.index], "destination_name")
}