output "users" {
  value = try(
    cloudfoundry_user.this,
    cloudfoundry_user_provided_service.this
  )
}

output "space" {
  value = try(
    cloudfoundry_space.this,
    cloudfoundry_space_quota.this,
    cloudfoundry_space_users.this
  )
}

output "org" {
  value = try(
    cloudfoundry_org.this,
    cloudfoundry_org_quota.this,
    cloudfoundry_org_users.this
  )
}

output "route" {
  value = try(
    cloudfoundry_route.this,
    cloudfoundry_route_service_binding.this,
    cloudfoundry_route_destination.this
  )
}

output "app" {
  value = try(
    cloudfoundry_buildpack.this,
    cloudfoundry_asg.this,
    cloudfoundry_default_asg.this,
    cloudfoundry_app.this,
    cloudfoundry_evg.this,
    cloudfoundry_feature_flags.this
  )
}

output "domain" {
  value = try(
    cloudfoundry_domain.this,
    cloudfoundry_private_domain_access.this
  )
}