output "name" {
  value = aws_elastic_beanstalk_configuration_template.configuration_template.*.name
}

output "application" {
  value = aws_elastic_beanstalk_configuration_template.configuration_template.*.application
}

output "description" {
  value = aws_elastic_beanstalk_configuration_template.configuration_template.*.description
}

output "environment_id" {
  value = aws_elastic_beanstalk_configuration_template.configuration_template.*.environment_id
}
