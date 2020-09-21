output "id" {
  value = aws_elastic_beanstalk_environment.environment.*.id
}

output "arn" {
  value = aws_elastic_beanstalk_environment.environment.*.arn
}

output "description" {
  value = aws_elastic_beanstalk_environment.environment.*.description
}

output "tier" {
  value = aws_elastic_beanstalk_environment.environment.*.tier
}

output "application" {
  value = aws_elastic_beanstalk_environment.environment.*.application
}

output "cname" {
  value = aws_elastic_beanstalk_environment.environment.*.cname
}

output "setting" {
  value = aws_elastic_beanstalk_environment.environment.*.setting
}
