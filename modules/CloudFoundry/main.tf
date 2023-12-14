resource "cloudfoundry_app" "this" {
  count            = length(var.app)
  name             = lookup(var.app[count.index], "name")
  space            = lookup(var.app[count.index], "space")
  annotations      = lookup(var.app[count.index], "annotations")
  source_code_hash = lookup(var.app[count.index], "source_code_hash")
  stack            = lookup(var.app[count.index], "stack")
  stopped          = lookup(var.app[count.index], "stopped")
  strategy         = lookup(var.app[count.index], "strategy")
  buildpacks       = lookup(var.app[count.index], "buildpacks")
  buildpack = try(
    element(cloudfoundry_buildpack.this.*.id, lookup(var.app[count.index], "buildpack_id"))
  )
  disk_quota                      = lookup(var.app[count.index], "disk_quota")
  docker_credentials              = lookup(var.app[count.index], "docker_credentials")
  docker_image                    = lookup(var.app[count.index], "docker_image")
  instances                       = lookup(var.app[count.index], "instances")
  enable_ssh                      = lookup(var.app[count.index], "enable_ssh")
  health_check_http_endpoint      = lookup(var.app[count.index], "health_check_http_endpoint")
  health_check_invocation_timeout = lookup(var.app[count.index], "health_check_invocation_timeout")
  health_check_timeout            = lookup(var.app[count.index], "health_check_timeout")
  health_check_type               = lookup(var.app[count.index], "health_check_type")
  environment                     = lookup(var.app[count.index], "environment")
  labels                          = lookup(var.app[count.index], "labels")
  path                            = lookup(var.app[count.index], "path")
  ports                           = lookup(var.app[count.index], "ports")
  memory                          = lookup(var.app[count.index], "memory")
  timeout                         = lookup(var.app[count.index], "timeout")
  command                         = lookup(var.app[count.index], "command")

  dynamic "routes" {
    for_each = lookup(var.app[count.index], "routes") == null ? [] : ["routes"]
    content {
      route = lookup(routes.value, "route")
      port  = lookup(routes.value, "port")
    }
  }

  dynamic "service_binding" {
    for_each = lookup(var.app[count.index], "service_binding") == null ? [] : ["service_binding"]
    content {
      service_instance = lookup(service_binding.value, "service_instance")
      params           = lookup(service_binding.value, "params")
    }
  }
}

resource "cloudfoundry_asg" "this" {
  count = length(var.asg)
  name  = lookup(var.asg[count.index], "name")

  dynamic "rule" {
    for_each = lookup(var.asg[count.index], "rule") == null ? [] : ["rule"]
    content {
      destination = lookup(rule.value, "destination")
      protocol    = lookup(rule.value, "protocol")
      ports       = lookup(rule.value, "ports")
      type        = lookup(rule.value, "type")
      code        = lookup(rule.value, "code")
      log         = lookup(rule.value, "log")
      description = lookup(rule.value, "description")
    }
  }
}

resource "cloudfoundry_buildpack" "this" {
  count            = length(var.buildpack)
  name             = lookup(var.buildpack[count.index], "name")
  path             = lookup(var.buildpack[count.index], "path")
  position         = lookup(var.buildpack[count.index], "position")
  enabled          = lookup(var.buildpack[count.index], "enabled")
  locked           = lookup(var.buildpack[count.index], "locked")
  labels           = lookup(var.buildpack[count.index], "labels")
  annotations      = lookup(var.buildpack[count.index], "annotations")
  source_code_hash = lookup(var.buildpack[count.index], "source_code_hash")
}

resource "cloudfoundry_default_asg" "this" {
  count = length(var.default_asg) == "0" ? "0" : length(var.asg)
  asgs  = element(cloudfoundry_asg.this.*.id, lookup(var.default_asg[count.index], "asgs"))
  name  = lookup(var.default_asg[count.index], "name")
}

resource "cloudfoundry_domain" "this" {
  count = length(var.domain)
  name  = lookup(var.domain[count.index], "name")
  domain = try(
    data.cloudfoundry_domain.this.domain,
    element(cloudfoundry_domain.this.*.domain, lookup(var.domain[count.index], "domain_id"))
  )
  sub_domain   = lookup(var.domain[count.index], "sub_domain")
  router_group = lookup(var.domain[count.index], "router_group")
  org = try(
    element(cloudfoundry_org.this.*.id, lookup(var.domain[count.index], "org_id"))
  )
  internal = lookup(var.domain[count.index], "internal")
}

resource "cloudfoundry_evg" "this" {
  count     = length(var.evg)
  name      = lookup(var.evg[count.index], "name")
  variables = lookup(var.evg[count.index], "variables")
}

resource "cloudfoundry_feature_flags" "this" {
  count = length(var.feature_flags)

  dynamic "feature_flags" {
    for_each = lookup(var.feature_flags[count.index], "feature_flags") == null ? [] : ["feature_flags"]
    content {
      user_org_creation                    = lookup(feature_flags.value, "user_org_creation")
      private_domain_creation              = lookup(feature_flags.value, "private_domain_creation")
      app_bits_upload                      = lookup(feature_flags.value, "app_bits_upload")
      app_scaling                          = lookup(feature_flags.value, "app_scaling")
      route_creation                       = lookup(feature_flags.value, "route_creation")
      service_instance_creation            = lookup(feature_flags.value, "service_instance_creation")
      diego_docker                         = lookup(feature_flags.value, "diego_docker")
      set_roles_by_username                = lookup(feature_flags.value, "set_roles_by_username")
      unset_roles_by_username              = lookup(feature_flags.value, "unset_roles_by_username")
      task_creation                        = lookup(feature_flags.value, "task_creation")
      env_var_visibility                   = lookup(feature_flags.value, "env_var_visibility")
      space_scoped_private_broker_creation = lookup(feature_flags.value, "space_scoped_private_broker_creation")
      space_developer_env_var_visibility   = lookup(feature_flags.value, "space_developer_env_var_visibility")
    }
  }
}

resource "cloudfoundry_isolation_segment" "this" {
  count       = length(var.isolation_segment)
  name        = lookup(var.isolation_segment[count.index], "name")
  labels      = lookup(var.isolation_segment[count.index], "labels")
  annotations = lookup(var.isolation_segment[count.index], "annotations")
}

resource "cloudfoundry_isolation_segment_entitlement" "this" {
  count = length(var.isolation_segment_entitlement) == "0" ? "0" : (length(var.isolation_segment) && length(var.org))
  orgs = try(
    element(cloudfoundry_org.this.*.id, lookup(var.isolation_segment_entitlement[count.index], "orgs_id"))
  )
  segment = try(
    element(cloudfoundry_isolation_segment.this.*.id, lookup(var.isolation_segment_entitlement[count.index], "segment_id"))
  )
  default = lookup(var.isolation_segment_entitlement[count.index], "default")
}

resource "cloudfoundry_network_policy" "this" {
  count = length(var.network_policy)

  dynamic "policy" {
    for_each = lookup(var.network_policy[count.index], "policy") == null ? [] : ["policy"]
    content {
      destination_app = lookup(policy.value, "destination_app")
      port            = lookup(policy.value, "port")
      source_app      = lookup(policy.value, "source_app")
      protocol        = lookup(policy.value, "protocol")
    }
  }
}

resource "cloudfoundry_org" "this" {
  count       = length(var.org)
  name        = lookup(var.org[count.index], "name")
  quota       = lookup(var.org[count.index], "quota")
  labels      = lookup(var.org[count.index], "labels")
  annotations = lookup(var.org[count.index], "annotations")
}

resource "cloudfoundry_org_quota" "this" {
  count                    = length(var.org_quota)
  allow_paid_service_plans = lookup(var.org_quota[count.index], "allow_paid_service_plans")
  name                     = lookup(var.org_quota[count.index], "name")
  total_memory             = lookup(var.org_quota[count.index], "total_memory")
  total_routes             = lookup(var.org_quota[count.index], "total_routes")
  total_services           = lookup(var.org_quota[count.index], "total_services")
  instance_memory          = lookup(var.org_quota[count.index], "instance_memory")
  total_app_instances      = lookup(var.org_quota[count.index], "total_app_instances")
  total_route_ports        = lookup(var.org_quota[count.index], "total_route_ports")
  total_private_domains    = lookup(var.org_quota[count.index], "total_private_domains")
}

resource "cloudfoundry_org_users" "this" {
  count = length(var.org_users) == "0" ? "0" : length(var.org)
  org = try(
    element(cloudfoundry_org.this.*.id, lookup(var.org_users[count.index], "org"))
  )
  managers         = lookup(var.org_users[count.index], "managers")
  billing_managers = lookup(var.org_users[count.index], "billing_managers")
  auditors         = lookup(var.org_users[count.index], "auditors")
  force            = lookup(var.org_users[count.index], "force")
}

resource "cloudfoundry_private_domain_access" "this" {
  count = length(var.private_domain_access) == "0" ? "0" : (length(var.domain) && length(var.org))
  domain = try(
    element(cloudfoundry_domain.this.*.id, lookup(var.private_domain_access[count.index], "domain"))
  )
  org = try(
    element(cloudfoundry_org.this.*.id, lookup(var.private_domain_access[count.index], "org"))
  )
}

resource "cloudfoundry_route" "this" {
  count = length(var.route) == "0" ? "0" : length(var.domain)
  domain = try(
    element(cloudfoundry_domain.this.*.id, lookup(var.route[count.index], "domain"))
  )
  space    = lookup(var.route[count.index], "space")
  hostname = lookup(var.route[count.index], "hostname")
  port     = lookup(var.route[count.index], "port")
  path     = lookup(var.route[count.index], "path")

  dynamic "target" {
    for_each = lookup(var.route[count.index], "target") == null ? [] : ["target"]
    content {
      app  = lookup(target.value, "app")
      port = lookup(target.value, "port")
    }
  }
}

resource "cloudfoundry_route_destination" "this" {
  count = length(var.route_destination) == "0" ? "0" : (length(var.app) && length(var.route))
  app_id = try(
    element(cloudfoundry_app.this.*.id, lookup(var.route_destination[count.index], "app_id"))
  )
  route_id = try(
    element(cloudfoundry_route.this.*.id, lookup(var.route_destination[count.index], "route_id"))
  )
}

resource "cloudfoundry_route_service_binding" "this" {
  count = length(var.route_service_binding) == "0" ? "0" : (length(var.route) && length(var.service_instance))
  route = try(
    element(cloudfoundry_route.this.*.id, lookup(var.route_service_binding[count.index], "route"))
  )
  service_instance = try(
    element(cloudfoundry_service_instance.this.*.id, lookup(var.route_service_binding[count.index], "service_instance"))
  )
  json_params = lookup(var.route_service_binding[count.index], "json_params")
}

resource "cloudfoundry_service_binding" "this" {
  count = length(var.service_binding) == "0" ? "0" : (length(var.app) && length(var.service_instance))
  app_id = try(
    element(cloudfoundry_app.this.*.id, lookup(var.service_binding[count.index], "app_id"))
  )
  service_instance_id = try(
    element(cloudfoundry_service_instance.this.*.id, lookup(var.service_binding[count.index], "service_instance_id"))
  )
}

resource "cloudfoundry_service_broker" "this" {
  count    = length(var.service_broker)
  name     = lookup(var.service_broker[count.index], "name")
  password = lookup(var.service_broker[count.index], "password")
  url      = lookup(var.service_broker[count.index], "url")
  username = lookup(var.service_broker[count.index], "username")
  space = try(
    element(cloudfoundry_space.this.*.id, lookup(var.service_broker[count.index], "space"))
  )
  fail_when_catalog_not_accessible = lookup(var.service_broker[count.index], "fail_when_catalog_not_accessible")
  labels                           = lookup(var.service_broker[count.index], "labels")
  annotations                      = lookup(var.service_broker[count.index], "annotations")
}

resource "cloudfoundry_service_instance" "this" {
  count = length(var.service_instance) == "0" ? "0" : length(var.space)
  name  = lookup(var.service_instance[count.index], "name")
  service_plan = try(
    data.cloudfoundry_service.this.service_plans["shared_vm"]
  )
  space = try(
    element(cloudfoundry_space.this.*.id, lookup(var.service_instance[count.index], "space"))
  )
  json_params                    = lookup(var.service_instance[count.index], "json_params")
  tags                           = lookup(var.service_instance[count.index], "tags")
  recursive_delete               = lookup(var.service_instance[count.index], "recursive_delete")
  replace_on_params_change       = lookup(var.service_instance[count.index], "replace_on_params_change")
  replace_on_service_plan_change = lookup(var.service_instance[count.index], "replace_on_service_plan_change")
}

resource "cloudfoundry_service_key" "this" {
  count = length(var.service_key) == "0" ? "0" : length(var.service_instance)
  name  = lookup(var.service_key[count.index], "name")
  service_instance = try(
    element(cloudfoundry_service_instance.this.*.name, lookup(var.service_key[count.index], "service_instance"))
  )
  params      = lookup(var.service_key[count.index], "params")
  params_json = lookup(var.service_key[count.index], "params_json")
}

resource "cloudfoundry_service_plan_access" "this" {
  count = length(var.service_plan_access) == "0" ? "0" : length(var.service_broker)
  plan = try(
    element(cloudfoundry_service_broker.this.*.service_plans[""], lookup(var.service_plan_access[count.index], "plan"))
  )
  org = try(
    element(cloudfoundry_org.this.*.id, lookup(var.service_plan_access[count.index], "org"))
  )
  public = lookup(var.service_plan_access[count.index], "public")
}

resource "cloudfoundry_space" "this" {
  count = length(var.space) == "0" ? "0" : length(var.org)
  name  = lookup(var.space[count.index], "name")
  org = try(
    element(cloudfoundry_org.this.*.id, lookup(var.space[count.index], "org"))
  )
  quota = try(
    element(cloudfoundry_space_quota.this.*.id, lookup(var.space[count.index], "quota"),
    element(cloudfoundry_org_quota.this.*.id, lookup(var.space[count.index], "quota")))
  )
  allow_ssh = lookup(var.space[count.index], "allow_ssh")
  isolation_segment = try(
    element(cloudfoundry_isolation_segment.this.*.id, lookup(var.space[count.index], "isolation_segment"))
  )
  asgs = try(
    element(cloudfoundry_asg.this.*.id, lookup(var.space[count.index], "asgs"))
  )
  staging_asgs = try(
    element(cloudfoundry_asg.this.*.id, lookup(var.space[count.index], "staging_asgs"))
  )
  labels      = lookup(var.space[count.index], "labels")
  annotations = lookup(var.space[count.index], "annotations")
}

resource "cloudfoundry_space_quota" "this" {
  count                    = length(var.space_quota) == "0" ? "0" : length(var.org)
  allow_paid_service_plans = lookup(var.space_quota[count.index], "allow_paid_service_plans")
  name                     = lookup(var.space_quota[count.index], "name")
  org = try(
    element(cloudfoundry_org.this.*.id, lookup(var.space_quota[count.index], "org"))
  )
  total_memory        = lookup(var.space_quota[count.index], "total_memory")
  total_routes        = lookup(var.space_quota[count.index], "total_routes")
  total_services      = lookup(var.space_quota[count.index], "total_services")
  instance_memory     = lookup(var.space_quota[count.index], "instance_memory")
  total_app_instances = lookup(var.space_quota[count.index], "total_app_instances")
  total_route_ports   = lookup(var.space_quota[count.index], "total_route_ports")
}

resource "cloudfoundry_space_users" "this" {
  count = length(var.space_users) == "0" ? "0" : length(var.space)
  space = try(
    element(cloudfoundry_space.this.*.id, lookup(var.space_users[count.index], "space"))
  )
  managers   = lookup(var.space_users[count.index], "managers")
  auditors   = lookup(var.space_users[count.index], "auditors")
  developers = lookup(var.space_users[count.index], "developers")
  force      = lookup(var.space_users[count.index], "force")
}

resource "cloudfoundry_user" "this" {
  count       = length(var.user)
  name        = lookup(var.user[count.index], "name")
  password    = lookup(var.user[count.index], "password")
  origin      = lookup(var.user[count.index], "origin")
  given_name  = lookup(var.user[count.index], "given_name")
  family_name = lookup(var.user[count.index], "family_name")
  email       = lookup(var.user[count.index], "email")
  groups      = lookup(var.user[count.index], "groups")
}

resource "cloudfoundry_user_provided_service" "this" {
  count = length(var.user_provided_service) == "0" ? "0" : length(var.space)
  name  = lookup(var.user_provided_service[count.index], "name")
  space = try(
    element(cloudfoundry_space.this.*.id, lookup(var.user_provided_service[count.index], "space"))
  )
  credentials       = lookup(var.user_provided_service[count.index], "credentials")
  credentials_json  = lookup(var.user_provided_service[count.index], "credentials_json")
  syslog_drain_url  = lookup(var.user_provided_service[count.index], "syslog_drain_url")
  route_service_url = lookup(var.user_provided_service[count.index], "route_service_url")
  tags              = lookup(var.user_provided_service[count.index], "tags")
}