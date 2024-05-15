output "user" {
  value = try(
    openstack_identity_user_v3.this.*.id,
    openstack_identity_user_v3.this.*.name,
    openstack_identity_user_v3.this.*.password,
    openstack_identity_user_v3.this.*.default_project_id
  )
}

output "group" {
  value = try(
    openstack_identity_group_v3.this.*.name,
    openstack_identity_group_v3.this.*.id,
    openstack_identity_group_v3.this.*.domain_id
  )
}

output "role" {
  value = try(
    openstack_identity_role_v3.this.*.id,
    openstack_identity_role_v3.this.*.name,
    openstack_identity_role_v3.this.*.domain_id
  )
}

output "project" {
  value = try(
    openstack_identity_project_v3.this.*.name,
    openstack_identity_project_v3.this.*.id,
    openstack_identity_project_v3.this.*.domain_id
  )
}

output "service" {
  value = try(
    openstack_identity_service_v3.this.*.id,
    openstack_identity_service_v3.this.*.name
  )
}

output "user_membership" {
  value = try(
    openstack_identity_user_membership_v3.this.*.id,
    openstack_identity_user_membership_v3.this.*.group_id,
    openstack_identity_user_membership_v3.this.*.user_id
  )
}

output "roe_assignment" {
  value = try(
    openstack_identity_role_assignment_v3.this.*.user_id,
    openstack_identity_role_assignment_v3.this.*.group_id,
    openstack_identity_role_assignment_v3.this.*.role_id
  )
}