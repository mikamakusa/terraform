resource "aws_efs_file_system" "efs_fs" {
  count                           = length(var.efs_fs)
  creation_token                  = lookup(var.efs_fs[count.index], "creation_token", null)
  encrypted                       = lookup(var.efs_fs[count.index], "encrypted", null)
  kms_key_id                      = element(var.kms_key_id, lookup(var.efs_fs[count.index], "kms_key_id"), null)
  performance_mode                = lookup(var.efs_fs[count.index], "performance_mode", null)
  provisioned_throughput_in_mibps = lookup(var.efs_fs[count.index], "provisioned_throughput_in_mibps", null)
  throughput_mode                 = lookup(var.efs_fs[count.index], "throughput_mode", null)

  dynamic "lifecycle_policy" {
    for_each = lookup(var.efs_fs[count.index], "lifecycle_policy")
    content {
      transition_to_ia = lookup(lifecycle_policy.value, "transition_to_ia")
    }
  }

  tags = lookup(var.efs_fs[count.index], "tags", null)
}

resource "aws_efs_mount_target" "efs_mount_target" {
  count           = length(var.efs_fs) == "0" ? "0" : length(var.efs_mount)
  file_system_id  = element(aws_efs_file_system.efs_fs.*.id, lookup(var.efs_mount[count.index], "file_system_id"))
  subnet_id       = element(var.subnet_id, lookup(var.efs_mount[count.index], "subnet_id"))
  ip_address      = lookup(var.efs_mount[count.index], "ip_address", null)
  security_groups = [element(var.security_groups, lookup(var.efs_mount[count.index], "security_groups_id"), null)]
}