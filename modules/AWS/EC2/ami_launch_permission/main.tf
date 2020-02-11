resource "aws_ami_launch_permission" "launch_permission" {
  count      = length(var.launch_permission)
  account_id = element(var.account_id, lookup(var.launch_permission[count.index], "account_id"))
  image_id   = element(var.image_id, lookup(var.launch_permission[count.index], "image_id"))
}