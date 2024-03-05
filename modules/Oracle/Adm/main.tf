resource "oci_adm_knowledge_base" "this" {
  count          = length(var.knowledge_base)
  compartment_id = data.oci_identity_compartment.this.compartment_id
  defined_tags = merge(
    var.defined_tags,
    lookup(var.knowledge_base[count.index], "defined_tags")
  )
  display_name = lookup(var.knowledge_base[count.index], "display_name")
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.knowledge_base[count.index], "freeform_tags")
  )
}

resource "oci_adm_remediation_recipe" "this" {
  count                         = length(var.remediation_recipe) == "0" ? "0" : length(var.knowledge_base)
  compartment_id                = data.oci_identity_compartment.this.compartment_id
  is_run_triggered_on_kb_change = lookup(var.remediation_recipe[count.index], "is_run_triggered_on_kb_change")
  knowledge_base_id             = try(element(oci_adm_knowledge_base.this.*.id, lookup(var.remediation_recipe[count.index], "knowledge_base_id")))
  display_name                  = lookup(var.remediation_recipe[count.index], "display_name")
  defined_tags = merge(
    var.defined_tags,
    lookup(var.remediation_recipe[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.remediation_recipe[count.index], "freeform_tags")
  )


  dynamic "detect_configuration" {
    for_each = lookup(var.remediation_recipe[count.index], "detect_configuration")
    content {
      exclusions                   = lookup(detect_configuration.value, "exclusions")
      max_permissible_cvss_v2score = lookup(detect_configuration.value, "max_permissible_cvss_v2score")
      max_permissible_cvss_v3score = lookup(detect_configuration.value, "max_permissible_cvss_v3score")
      upgrade_policy               = lookup(detect_configuration.value, "upgrade_policy")
      max_permissible_severity     = lookup(detect_configuration.value, "max_permissible_severity")
    }
  }

  dynamic "network_configuration" {
    for_each = lookup(var.remediation_recipe[count.index], "network_configuration")
    content {
      subnet_id = data.oci_core_subnet.this.id
      nsg_ids   = lookup(network_configuration.value, "nsg_ids")
    }
  }

  dynamic "scm_configuration" {
    for_each = lookup(var.remediation_recipe[count.index], "scm_configuration")
    content {
      branch                 = lookup(scm_configuration.value, "branch")
      is_automerge_enabled   = lookup(scm_configuration.value, "is_automerge_enabled")
      scm_type               = lookup(scm_configuration.value, "scm_type")
      build_file_location    = lookup(scm_configuration.value, "build_file_location")
      oci_code_repository_id = lookup(scm_configuration.value, "oci_code_repository_id")
      pat_secret_id          = lookup(scm_configuration.value, "pat_secret_id")
      repository_url         = lookup(scm_configuration.value, "repository_url")
      username               = lookup(scm_configuration.value, "username")
    }
  }

  dynamic "verify_configuration" {
    for_each = lookup(var.remediation_recipe[count.index], "verify_configuration")
    content {
      build_service_type    = lookup(verify_configuration.value, "build_service_type")
      additional_parameters = lookup(verify_configuration.value, "additional_parameters")
      jenkins_url           = lookup(verify_configuration.value, "jenkins_url")
      job_name              = lookup(verify_configuration.value, "job_name")
      pat_secret_id         = lookup(verify_configuration.value, "pat_secret_id")
      pipeline_id           = lookup(verify_configuration.value, "pipeline_id")
      repository_url        = lookup(verify_configuration.value, "repository_url")
      trigger_secret_id     = lookup(verify_configuration.value, "trigger_secret_id")
      username              = lookup(verify_configuration.value, "username")
      workflow_name         = lookup(verify_configuration.value, "workflow_name")
    }
  }
}

resource "oci_adm_remediation_run" "this" {
  count                 = length(var.remediation_run) == "0" ? "0" : length(var.remediation_recipe)
  remediation_recipe_id = try(element(oci_adm_remediation_recipe.this.*.id, lookup(var.remediation_run[count.index], "remediation_recipe_id")))
  compartment_id        = data.oci_identity_compartment.this.compartment_id
  defined_tags = merge(
    var.defined_tags,
    lookup(var.remediation_run[count.index], "defined_tags")
  )
  freeform_tags = merge(
    var.freeform_tags,
    lookup(var.remediation_run[count.index], "freeform_tags")
  )
  display_name = lookup(var.remediation_run[count.index], "display_name")
}

resource "oci_adm_vulnerability_audit" "this" {
  count             = length(var.vulnerability_audit) == "0" ? "0" : length(var.knowledge_base)
  build_type        = lookup(var.vulnerability_audit[count.index], "build_type")
  knowledge_base_id = try(
    element(oci_adm_knowledge_base.this.*.id, lookup(var.vulnerability_audit[count.index], "knowledge_base_id"))
  )
  compartment_id    = data.oci_identity_compartment.this.compartment_id
  display_name      = lookup(var.vulnerability_audit[count.index], "display_name")
  defined_tags      = merge(
    var.defined_tags,
    lookup(var.vulnerability_audit[count.index], "defined_tags")
  )
  freeform_tags     = merge(
    var.freeform_tags,
    lookup(var.vulnerability_audit[count.index], "freeform_tags")
  )

  dynamic "application_dependencies" {
    for_each = lookup(var.vulnerability_audit[count.index], "application_dependencies") == null ? [] : ["application_dependencies"]
    content {
      gav                             = lookup(application_dependencies.value, "gav")
      node_id                         = lookup(application_dependencies.value, "node_id")
      application_dependency_node_ids = lookup(application_dependencies.value, "application_dependency_node_ids")
      purl                            = lookup(application_dependencies.value, "purl")
    }
  }

  dynamic "configuration" {
    for_each = lookup(var.vulnerability_audit[count.index], "configuration") == null ? [] : ["configuration"]
    content {
      exclusions                   = lookup(configuration.value, "exclusions")
      max_permissible_cvss_v2score = lookup(configuration.value, "max_permissible_cvss_v2score")
      max_permissible_cvss_v3score = lookup(configuration.value, "max_permissible_cvss_v3score")
      max_permissible_severity     = lookup(configuration.value, "max_permissible_severity")
    }
  }

  dynamic "source" {
    for_each = lookup(var.vulnerability_audit[count.index], "source") == null ? [] : ["source"]
    content {
      type            = lookup(source.value, "type")
      description     = lookup(source.value, "description")
      oci_resource_id = lookup(source.value, "oci_resource_id")
    }
  }

  dynamic "usage_data" {
    for_each = lookup(var.vulnerability_audit[count.index], "usage_data") == null ? [] : ["usage_data"]
    content {
      bucket      = lookup(usage_data.value, "bucket")
      namespace   = lookup(usage_data.value, "namespace")
      object      = lookup(usage_data.value, "object")
      source_type = lookup(usage_data.value, "source_type")
    }
  }
}