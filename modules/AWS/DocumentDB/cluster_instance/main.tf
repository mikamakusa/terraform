resource "aws_docdb_cluster_instance" "instance" {
  count                        = length(var.instance)
  cluster_identifier           = element(var.cluster_id, lookup(var.instance[count.index], "cluster_id"))
  instance_class               = lookup(var.instance[count.index], "instance_class")
  engine                       = lookup(var.instance[count.index], "engine", null)
  auto_minor_version_upgrade   = lookup(var.instance[count.index], "auto_minor_version_upgrade", null)
  apply_immediately            = lookup(var.instance[count.index], "apply_immediately", null)
  preferred_maintenance_window = lookup(var.instance[count.index], "preferred_maintenace_window", null)
  promotion_tier               = lookup(var.instance[count.index], "promotion_tier", null)
}