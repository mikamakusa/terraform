output "elasticsearch_domain_id" {
  value = aws_elasticsearch_domain.elasticsearch.*.id
}