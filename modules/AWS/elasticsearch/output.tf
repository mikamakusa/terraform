output "elastic_domain_arn" {
  value = aws_elasticsearch_domain.elastic.*.arn
}