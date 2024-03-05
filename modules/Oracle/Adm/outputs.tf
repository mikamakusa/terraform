output "knowledge_base" {
  value = try(
    oci_adm_knowledge_base.this
  )
}

output "remediation_recipe" {
  value = try(
    oci_adm_remediation_recipe.this
  )
}

output "remediation_run" {
  value = try(
    oci_adm_remediation_run.this
  )
}

output "vulnerability_audit" {
  value = try(
    oci_adm_vulnerability_audit.this
  )
}