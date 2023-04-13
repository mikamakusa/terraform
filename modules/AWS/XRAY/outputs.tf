output "xray" {
  value = try(
    aws_xray_sampling_rule.sampling_rule,
    aws_xray_group.xray_group,
    aws_xray_encryption_config.encryption_config
  )
}