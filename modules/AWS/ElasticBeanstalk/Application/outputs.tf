output "arn" {
  value = aws_elastic_beanstalk_application.application.*.arn
}

output "id" {
  value = aws_elastic_beanstalk_application.application.*.id
}

output "name" {
  value = aws_elastic_beanstalk_application.application.*.name
}
