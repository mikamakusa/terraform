resource "aws_elasticsearch_domain_policy" "domain_policy" {
  count           = length(var.domain_policy)
  access_policies = element(var.policy, lookup(var.domain_policy[count.index], "policy_id"))
  domain_name     = element(var.elastic_domain_id, lookup(var.domain_policy[count.index], "domain_id"))
}