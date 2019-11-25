resource "aws_storagegateway_gateway" "storage_gateway" {
  count               = length(var.StorGateway)
  gateway_name        = lookup(var.StorGateway[count.index], "gateway_name")
  gateway_timezone    = lookup(var.StorGateway[count.index], "gateway_timezone")
  gateway_type        = lookup(var.StorGateway[count.index], "gateway_type")
  medium_changer_type = lookup(var.StorGateway[count.index], "medium_changer_type", null) ? aws_storagegateway_gateway.storage_gateway.*.gateway_type : "VTL"
  tape_drive_type     = lookup(var.StorGateway[count.index], "tape_drive_type", null) ? aws_storagegateway_gateway.storage_gateway.*.gateway_type : "VTL"
  smb_guest_password  = lookup(var.StorGateway[count.index], "smb_guest_password", null) ? aws_storagegateway_gateway.storage_gateway.*.gateway_type : "FILE_S3"

  dynamic "smb_active_directory_settings" {
    for_each = lookup(var.StorGateway[count.index], "smb_active_directory_settings")
    content {
      domain_name = lookup(smb_active_directory_settings.value, "domain_name")
      password    = lookup(smb_active_directory_settings.value, "password")
      username    = lookup(smb_active_directory_settings.value, "username")
    }
  }
}

resource "aws_storagegateway_nfs_file_share" "storage_gateway_nfs" {
  count                   = length(var.StorGateway) == "0" ? "0" : length(var.StorGatewayNFS)
  client_list             = [lookup(var.StorGatewayNFS[count.index], "client_list")]
  gateway_arn             = element(aws_storagegateway_gateway.storage_gateway.*.arn, lookup(var.StorGatewayNFS[count.index], "storage_gateway_id"))
  location_arn            = element(var.s3_bucket, lookup(var.StorGatewayNFS[count.index], "location_id"))
  role_arn                = element(var.iam, lookup(var.StorGatewayNFS[count.index], "role_id"))
  default_storage_class   = lookup(var.StorGatewayNFS[count.index], "default_storage_class", null)
  guess_mime_type_enabled = lookup(var.StorGatewayNFS[count.index], "guess_mime_type_enabled", true)
  kms_encrypted           = lookup(var.StorGatewayNFS[count.index], "kms_encrypted", false)
  kms_key_arn             = lookup(var.StorGatewayNFS[count.index], "kms_key_arn", null) ? aws_storagegateway_nfs_file_share.storage_gateway_nfs.*.kms_encrypted : "true"
  object_acl              = lookup(var.StorGatewayNFS[count.index], "object_acl", null)
  read_only               = lookup(var.StorGatewayNFS[count.index], "read_only", false)
  requester_pays          = lookup(var.StorGatewayNFS[count.index], "requester_pays", false)
  squash                  = lookup(var.StorGatewayNFS[count.index], "squash", null)

  dynamic "nfs_file_share_defaults" {
    for_each = lookup(var.StorGatewayNFS[count.index], "nfs_file_share_defaults")
    content {
      directory_mode = lookup(nfs_file_share_defaults.value, "directory_mode", null)
      file_mode      = lookup(nfs_file_share_defaults.value, "file_mode", null)
      group_id       = lookup(nfs_file_share_defaults.value, "group_id", null)
      owner_id       = lookup(nfs_file_share_defaults.value, "owner_id", null)
    }
  }
}

resource "aws_storagegateway_smb_file_share" "storage_gateway_smb" {
  count                   = length(var.StorGateway) == "0" ? "0" : length(var.StorGatewaySMB)
  gateway_arn             = element(aws_storagegateway_gateway.storage_gateway.*.arn, lookup(var.StorGatewaySMB[count.index], "storage_gateway_id"))
  location_arn            = element(var.s3_bucket, lookup(var.StorGatewaySMB[count.index], "location_id"))
  role_arn                = element(var.iam, lookup(var.StorGatewaySMB[count.index], "role_id"))
  authentication          = lookup(var.StorGatewaySMB[count.index], "authentication")
  default_storage_class   = lookup(var.StorGatewaySMB[count.index], "default_storage_class", null)
  guess_mime_type_enabled = lookup(var.StorGatewaySMB[count.index], "guess_mime_type_enabled", true)
  invalid_user_list       = [lookup(var.StorGatewaySMB[count.index], "invalid_user_list") ? aws_storagegateway_smb_file_share.storage_gateway_smb.*.authentication : "ActiveDirectory"]
  kms_encrypted           = lookup(var.StorGatewaySMB[count.index], "kms_encrypted", false)
  kms_key_arn             = lookup(var.StorGatewaySMB[count.index], "kms_key_arn") ? aws_storagegateway_smb_file_share.storage_gateway_smb.*.kms_encrypted : "false"
  object_acl              = "private"
  read_only               = lookup(var.StorGatewaySMB[count.index], "read_only", false)
  requester_pays          = lookup(var.StorGatewaySMB[count.index], "requester_pays", false)
  valid_user_list         = [lookup(var.StorGatewaySMB[count.index], "valid_user_list") ? aws_storagegateway_smb_file_share.storage_gateway_smb.*.authentication : "ActiveDirectory"]

  dynamic "smb_file_share_defaults" {
    for_each = lookup(var.StorGatewaySMB[count.index], "smb_file_share_defaults")
    content {
      directory_mode = lookup(smb_file_share_defaults.value, "directory_mode")
      file_mode      = lookup(smb_file_share_defaults.value, "file_mode")
      group_id       = lookup(smb_file_share_defaults.value, "group_id")
      owner_id       = lookup(smb_file_share_defaults.value, "owner_id")
    }
  }
}

data "aws_storagegateway_local_disk" "data_storage_gateway_local_disk" {
  count       = length(var.StorGateway) == "0" ? "0" : length(var.local_disk)
  gateway_arn = element(aws_storagegateway_gateway.storage_gateway.*.arn, lookup(var.local_disk[count.index], "gateway_id"))
  disk_node   = lookup(var.local_disk[count.index], "disk_node", null)
  disk_path   = lookup(var.local_disk[count.index], "disk_path", null)
}

resource "aws_storagegateway_cache" "storage_gateway_cache" {
  count       = length(var.StorGateway) == "0" ? "0" : length(var.StorGatewayCache)
  disk_id     = element(data.aws_storagegateway_local_disk.data_storage_gateway_local_disk.*.id, lookup(var.StorGatewayCache[count.index], "disk_id"))
  gateway_arn = element(aws_storagegateway_gateway.storage_gateway.*.arn, lookup(var.StorGatewayCache[count.index], "gateway_id"))
}

resource "aws_storagegateway_upload_buffer" "storage_upload_buffer" {
  count       = length(var.StorGateway) == "0" ? "0" : length(var.upload_buffer)
  disk_id     = element(data.aws_storagegateway_local_disk.data_storage_gateway_local_disk.*.id, lookup(var.upload_buffer[count.index], "disk_id"))
  gateway_arn = element(aws_storagegateway_gateway.storage_gateway.*.arn, lookup(var.upload_buffer[count.index], "gateway_id"))
}

resource "aws_storagegateway_working_storage" "working_storage" {
  count       = length(var.StorGateway) == "0" ? "0" : length(var.working_storage)
  disk_id     = element(data.aws_storagegateway_local_disk.data_storage_gateway_local_disk.*.id, lookup(var.working_storage[count.index], "disk_id"))
  gateway_arn = element(aws_storagegateway_gateway.storage_gateway.*.arn, lookup(var.StorGateway[count.index], "gateway_id"))
}