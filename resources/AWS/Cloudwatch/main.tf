module "log_group" {
  source     = "../../../modules/AWS/CloudWatch/log_group"
  kms_key_id = ""
  log_group  = var.log_group
  tags       = local.log_group_tags
}

module "log_stream" {
  source         = "../../../modules/AWS/CloudWatch/log_stream"
  log_group_name = module.log_group.clog_group_name
  log_stream     = var.log_stream
}