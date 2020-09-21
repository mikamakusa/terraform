output "arn" {
  value = aws_elastic_beanstalk_application_version.application_version.*.arn
}
