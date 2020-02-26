resource "aws_iam_service_linked_role" "service_linked_role" {
  count            = length(var.service_linked_role)
  aws_service_name = join(".", [lookup(var.service_linked_role[count.index], "aws_service_name"), "amazonaws", "com"])
}