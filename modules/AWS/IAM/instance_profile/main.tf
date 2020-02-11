resource "aws_iam_instance_profile" "instance_profile" {
  count = length(var.instance_profile)
  name  = lookup(var.instance_profile[count.index], "name")
  role  = element(var.role_name, lookup(var.instance_profile[count.index], "role_id"))
}