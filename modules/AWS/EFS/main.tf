resource "aws_efs_access_point" "this" {
  count          = length(var.access_point) == "0" ? "0" : length(var.file_system)
  file_system_id = try(element(aws_efs_file_system.this.*.id, lookup(var.access_point[count.index], "file_system_id")))
  tags           = merge(var.tags, lookup(var.access_point[count.index], "tags"))

  dynamic "posix_user" {
    for_each = lookup(var.access_point[count.index], "posix_user") == null ? [] : ["posix_user"]
    content {
      gid            = lookup(posix_user.value, "gid")
      uid            = lookup(posix_user.value, "uid")
      secondary_gids = lookup(posix_user.value, "secondary_gids")
    }
  }

  dynamic "root_directory" {
    for_each = lookup(var.access_point[count.index], "root_directory") == null ? [] : ["root_directory"]
    content {
      dynamic "creation_info" {
        for_each = lookup(root_directory.value, "creation_info") == null ? [] : ["creation_info"]
        content {
          owner_gid   = lookup(creation_info.value, "owner_gid")
          owner_uid   = lookup(creation_info.value, "owner_uid")
          permissions = lookup(creation_info.value, "permissions")
        }
      }
      path = lookup(root_directory.value, "path")
    }
  }
}

resource "aws_efs_backup_policy" "this" {
  count          = length(var.backup_policy) == "0" ? "0" : length(var.file_system)
  file_system_id = try(element(aws_efs_file_system.this.*.id, lookup(var.backup_policy[count.index], "file_system_id")))

  dynamic "backup_policy" {
    for_each = lookup(var.backup_policy[count.index], "backup_policy")
    content {
      status = lookup(backup_policy.value, "status")
    }
  }
}

resource "aws_efs_file_system" "this" {
  count                           = lenght(var.file_system)
  availability_zone_name          = lookup(var.file_system[count.index], "availability_zone_name")
  creation_token                  = lookup(var.file_system[count.index], "creation_token")
  encrypted                       = lookup(var.file_system[count.index], "encrypted")
  kms_key_id                      = lookup(var.file_system[count.index], "kms_key_id")
  performance_mode                = lookup(var.file_system[count.index], "performance_mode")
  provisioned_throughput_in_mibps = lookup(var.file_system[count.index], "provisioned_throughput_in_mibps")
  tags                            = merge(var.tags, lookup(var.file_system[count.index], "tags"))
  throughput_mode                 = lookup(var.file_system[count.index], "throughput_mode")

  dynamic "lifecycle_policy" {
    for_each = lookup(var.file_system[count.index], "lifecycle_policy") == null ? [] : ["lifecycle_policy"]
    content {
      transition_to_archive               = lookup(lifecycle_policy.value, "transition_to_archive")
      transition_to_ia                    = lookup(lifecycle_policy.value, "transition_to_ia")
      transition_to_primary_storage_class = lookup(lifecycle_policy.value, "transition_to_primary_storage_class")
    }
  }

  dynamic "protection" {
    for_each = lookup(var.file_system[count.index], "protection") == null ? [] : ["protection"]
    content {
      replication_overwrite = lookup(prorection.value, "replication_overwrite")
    }
  }
}

resource "aws_efs_file_system_policy" "this" {
  count                              = length(var.file_system_policy) == "0" ? "0" : length(var.file_system)
  file_system_id                     = try(element(aws_efs_file_system.this.*.id, lookup(var.file_system_policy[count.index], "file_system_id")))
  policy                             = lookup(var.file_system_policy[count.index], "policy")
  bypass_policy_lockout_safety_check = lookup(var.file_system_policy[count.index], "bypass_policy_lockout_safety_check")
}

resource "aws_efs_mount_target" "this" {
  count           = length(var.mount_target) == "0" ? "0" : length(var.file_system)
  file_system_id  = try(element(aws_efs_file_system.this.*.id, lookup(var.mount_target[count.index], "file_system_id")))
  subnet_id       = lookup(var.mount_target[count.index], "subnet_id")
  ip_address      = lookup(var.mount_target[count.index], "ip_address")
  security_groups = lookup(var.mount_target[count.index], "security_groups")
}

resource "aws_efs_replication_configuration" "this" {
  count                 = length(var.replication_configuration)
  source_file_system_id = lookup(var.replication_configuration[count.index], "source_file_system_id")

  dynamic "destination" {
    for_each = lookup(var.replication_configuration[count.index], "destination")
    content {
      availability_zone_name = lookup(destination.value, "availability_zone_name")
      file_system_id         = lookup(destination.value, "file_system_id")
      kms_key_id             = lookup(destination.value, "kms_key_id")
      region                 = lookup(destination.value, "region")
    }
  }
}