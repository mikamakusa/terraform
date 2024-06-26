resource "vault_ad_secret_backend" "this" {
  count                        = length(var.ad_secret_backend)
  binddn                       = lookup(var.ad_secret_backend[count.index], "binddn")
  bindpass                     = lookup(var.ad_secret_backend[count.index], "bindpass")
  namespace                    = try(element(vault_namespace.this.*.id, lookup(var.ad_secret_backend[count.index], "namespace_id")))
  backend                      = lookup(var.ad_secret_backend[count.index], "backend")
  disable_remount              = lookup(var.ad_secret_backend[count.index], "disable_remount")
  anonymous_group_search       = lookup(var.ad_secret_backend[count.index], "anonymous_group_search")
  case_sensitive_names         = lookup(var.ad_secret_backend[count.index], "case_sensitive_names")
  certificate                  = lookup(var.ad_secret_backend[count.index], "certificate")
  client_tls_cert              = lookup(var.ad_secret_backend[count.index], "client_tls_cert")
  client_tls_key               = lookup(var.ad_secret_backend[count.index], "client_tls_key")
  default_lease_ttl_seconds    = lookup(var.ad_secret_backend[count.index], "default_lease_ttl_seconds")
  deny_null_bind               = lookup(var.ad_secret_backend[count.index], "deny_null_bind")
  description                  = lookup(var.ad_secret_backend[count.index], "description")
  discoverdn                   = lookup(var.ad_secret_backend[count.index], "discoverdn")
  groupattr                    = lookup(var.ad_secret_backend[count.index], "groupattr")
  groupdn                      = lookup(var.ad_secret_backend[count.index], "groupdn")
  groupfilter                  = lookup(var.ad_secret_backend[count.index], "groupfilter")
  insecure_tls                 = lookup(var.ad_secret_backend[count.index], "insecure_tls")
  last_rotation_tolerance      = lookup(var.ad_secret_backend[count.index], "last_rotation_tolerance")
  local                        = lookup(var.ad_secret_backend[count.index], "local")
  max_lease_ttl_seconds        = lookup(var.ad_secret_backend[count.index], "max_lease_ttl_seconds")
  max_ttl                      = lookup(var.ad_secret_backend[count.index], "max_ttl")
  password_policy              = lookup(var.ad_secret_backend[count.index], "password_policy")
  request_timeout              = lookup(var.ad_secret_backend[count.index], "request_timeout")
  starttls                     = lookup(var.ad_secret_backend[count.index], "starttls")
  tls_max_version              = lookup(var.ad_secret_backend[count.index], "tls_max_version")
  tls_min_version              = lookup(var.ad_secret_backend[count.index], "tls_min_version")
  ttl                          = lookup(var.ad_secret_backend[count.index], "ttl")
  use_pre111_group_cn_behavior = lookup(var.ad_secret_backend[count.index], "use_pre111_group_cn_behavior")
  use_token_groups             = lookup(var.ad_secret_backend[count.index], "use_token_groups")
  userattr                     = lookup(var.ad_secret_backend[count.index], "userattr")
  userdn                       = lookup(var.ad_secret_backend[count.index], "userdn")
}

resource "vault_ad_secret_library" "this" {
  count = length(var.ad_secret_library) == "0" ? "0" : length(var.ad_secret_backend)
  backend = try(
    element(vault_ad_secret_backend.this.*.backend, lookup(var.ad_secret_library[count.index], "backend_id"))
  )
  name                  = lookup(var.ad_secret_library[count.index], "name")
  service_account_names = lookup(var.ad_secret_library[count.index], "service_account_names")
  namespace             = try(element(vault_namespace.this.*.id, lookup(var.ad_secret_library[count.index], "namespace_id")))
  ttl                   = lookup(var.ad_secret_library[count.index], "ttl")
  max_ttl               = lookup(var.ad_secret_library[count.index], "max_ttl")
}

resource "vault_ad_secret_role" "this" {
  count = length(var.ad_secret_role) == "0" ? "0" : length(var.ad_secret_backend)
  backend = try(
    element(vault_ad_secret_backend.this.*.backend, lookup(var.ad_secret_role[count.index], "backend_id"))
  )
  role                 = lookup(var.ad_secret_role[count.index], "role")
  service_account_name = lookup(var.ad_secret_role[count.index], "service_account_name")
  namespace            = try(element(vault_namespace.this.*.id, lookup(var.ad_secret_role[count.index], "namespace_id")))
  ttl                  = lookup(var.ad_secret_role[count.index], "ttl")
}

resource "vault_alicloud_auth_backend_role" "this" {
  count     = length(var.alicloud_auth_backend_role) == "0" ? "0" : length(var.auth_backend)
  arn       = lookup(var.alicloud_auth_backend_role[count.index], "arn")
  role      = lookup(var.alicloud_auth_backend_role[count.index], "role")
  namespace = try(element(vault_namespace.this.*.id, lookup(var.alicloud_auth_backend_role[count.index], "namespace_id")))
  backend = try(
    element(vault_auth_backend.this.*.path, lookup(var.alicloud_auth_backend_role[count.index], "backend_id"))
  )
}

resource "vault_approle_auth_backend_login" "this" {
  count     = length(var.approle_auth_backend_login) == "0" ? "0" : length(var.approle_auth_backend_role)
  role_id   = try(element(vault_approle_auth_backend_role.this.*.role_id, lookup(var.approle_auth_backend_login[count.index], "role_id")))
  namespace = try(element(vault_namespace.this.*.id, lookup(var.approle_auth_backend_login[count.index], "namespace_id")))
  secret_id = try(element(vault_approle_auth_backend_role_secret_id.this.*.secret_id, lookup(var.approle_auth_backend_login[count.index], "secret_id")))
  backend   = try(element(vault_auth_backend.this.*.path, lookup(var.approle_auth_backend_login[count.index], "backend_id")))
}

resource "vault_approle_auth_backend_role" "this" {
  count                 = length(var.approle_auth_backend_role)
  role_name             = lookup(var.approle_auth_backend_role[count.index], "role_name")
  namespace             = try(element(vault_namespace.this.*.id, lookup(var.approle_auth_backend_role[count.index], "namespace_id")))
  role_id               = lookup(var.approle_auth_backend_role[count.index], "role_id")
  bind_secret_id        = lookup(var.approle_auth_backend_role[count.index], "bind_secret_id")
  secret_id_bound_cidrs = lookup(var.approle_auth_backend_role[count.index], "secret_id_bound_cidrs")
  secret_id_num_uses    = lookup(var.approle_auth_backend_role[count.index], "secret_id_num_uses")
  secret_id_ttl         = lookup(var.approle_auth_backend_role[count.index], "secret_id_ttl")
  backend               = try(element(vault_auth_backend.this.*.path, lookup(var.approle_auth_backend_role[count.index], "backend_id")))
}

resource "vault_approle_auth_backend_role_secret_id" "this" {
  count                 = length(var.approle_auth_backend_role_secret_id) == "0" ? "0" : length(var.approle_auth_backend_role)
  role_name             = try(element(vault_approle_auth_backend_role.*.role_name, lookup(var.approle_auth_backend_role_secret_id[count.index], "role_id")))
  backend               = try(element(vault_auth_backend.*.path, lookup(var.approle_auth_backend_role_secret_id[count.index], "backend_id")))
  namespace             = try(element(vault_namespace.this.*.id, lookup(var.approle_auth_backend_role_secret_id[count.index], "namespace_id")))
  metadata              = lookup(var.approle_auth_backend_role_secret_id[count.index], "metadata")
  cidr_list             = lookup(var.approle_auth_backend_role_secret_id[count.index], "cidr_list")
  secret_id             = lookup(var.approle_auth_backend_role_secret_id[count.index], "secret_id")
  wrapping_ttl          = lookup(var.approle_auth_backend_role_secret_id[count.index], "wrapping_ttl")
  with_wrapped_accessor = lookup(var.approle_auth_backend_role_secret_id[count.index], "with_wrapped_accessor")
}

resource "vault_audit" "this" {
  count       = length(var.audit)
  options     = lookup(var.audit[count.index], "options")
  type        = lookup(var.audit[count.index], "type")
  namespace   = try(element(vault_namespace.this.*.id, lookup(var.audit[count.index], "namespace_id")))
  path        = lookup(var.audit[count.index], "path")
  description = lookup(var.audit[count.index], "description")
  local       = lookup(var.audit[count.index], "local")
}

resource "vault_audit_request_header" "this" {
  count = length(var.audit_request_header)
  name  = lookup(var.audit_request_header[count.index], "name")
  hmac  = lookup(var.audit_request_header[count.index], "hmac")
}

resource "vault_auth_backend" "this" {
  count           = length(var.auth_backend)
  type            = lookup(var.auth_backend[count.index], "type")
  namespace       = try(element(vault_namespace.this.*.id, lookup(var.auth_backend[count.index], "namespace_id")))
  path            = lookup(var.auth_backend[count.index], "path")
  disable_remount = lookup(var.auth_backend[count.index], "disable_remount")
  description     = lookup(var.auth_backend[count.index], "description")
  local           = lookup(var.auth_backend[count.index], "local")

  dynamic "tune" {
    for_each = lookup(var.auth_backend[count.index], "tune") == null ? [] : ["tune"]
    content {
      default_lease_ttl            = lookup(tune.value, "default_lease_ttl")
      max_lease_ttl                = lookup(tune.value, "max_lease_ttl")
      audit_non_hmac_request_keys  = lookup(tune.value, "audit_non_hmac_request_keys")
      audit_non_hmac_response_keys = lookup(tune.value, "audit_non_hmac_response_keys")
      listing_visibility           = lookup(tune.value, "listing_visibility")
      passthrough_request_headers  = lookup(tune.value, "passthrough_request_headers")
      allowed_response_headers     = lookup(tune.value, "allowed_response_headers")
      token_type                   = lookup(tune.value, "token_type")
    }
  }
}

resource "vault_aws_auth_backend_cert" "this" {
  count           = length(var.aws_auth_backend_cert)
  aws_public_cert = file(join("/", [path.cwd, "certificate", lookup(var.aws_auth_backend_cert[count.index], "aws_public_cert")]))
  cert_name       = lookup(var.aws_auth_backend_cert[count.index], "cert_name")
  namespace       = try(element(vault_namespace.this.*.id, lookup(var.aws_auth_backend_cert[count.index], "namespace_id")))
  type            = lookup(var.aws_auth_backend_cert[count.index], "type")
  backend         = try(element(vault_auth_backend.this.*.path, lookup(var.aws_auth_backend_cert[count.index], "backend_id")))
}

resource "vault_aws_auth_backend_client" "this" {
  count                      = length(var.aws_auth_backend_client)
  namespace                  = try(element(vault_namespace.this.*.id, lookup(var.aws_auth_backend_client[count.index], "namespace_id")))
  backend                    = try(element(vault_auth_backend.this.*.path, lookup(var.aws_auth_backend_client[count.index], "backend_id")))
  access_key                 = sensitive(lookup(var.aws_auth_backend_client[count.index], "access_key"))
  secret_key                 = sensitive(lookup(var.aws_auth_backend_client[count.index], "secret_key"))
  ec2_endpoint               = lookup(var.aws_auth_backend_client[count.index], "ec2_endpoint")
  iam_endpoint               = lookup(var.aws_auth_backend_client[count.index], "iam_endpoint")
  iam_server_id_header_value = lookup(var.aws_auth_backend_client[count.index], "iam_server_id_header_value")
  sts_endpoint               = lookup(var.aws_auth_backend_client[count.index], "sts_endpoint")
  sts_region                 = lookup(var.aws_auth_backend_client[count.index], "sts_region")
  use_sts_region_from_client = lookup(var.aws_auth_backend_client[count.index], "use_sts_region_from_client")
}

resource "vault_aws_auth_backend_config_identity" "this" {
  count        = length(var.aws_auth_backend_config_identity)
  namespace    = try(element(vault_namespace.this.*.id, lookup(var.aws_auth_backend_config_identity[count.index], "namespace_id")))
  iam_alias    = lookup(var.aws_auth_backend_config_identity[count.index], "iam_alias")
  iam_metadata = lookup(var.aws_auth_backend_config_identity[count.index], "iam_metadata")
  ec2_alias    = lookup(var.aws_auth_backend_config_identity[count.index], "ec2_alias")
  ec2_metadata = lookup(var.aws_auth_backend_config_identity[count.index], "ec2_metadata")
  backend      = try(element(vault_auth_backend.this.*.path, lookup(var.aws_auth_backend_config_identity[count.index], "backend_id")))
}

resource "vault_aws_auth_backend_identity_whitelist" "this" {
  count                 = length(var.aws_auth_backend_identity_whitelist)
  namespace             = try(element(vault_namespace.this.*.id, lookup(var.aws_auth_backend_identity_whitelist[count.index], "namespace_id")))
  backend               = try(element(vault_auth_backend.this.*.path, lookup(var.aws_auth_backend_identity_whitelist[count.index], "backend")))
  safety_buffer         = lookup(var.aws_auth_backend_identity_whitelist[count.index], "safety_buffer")
  disable_periodic_tidy = lookup(var.aws_auth_backend_identity_whitelist[count.index], "disable_periodic_tidy")
}

resource "vault_aws_auth_backend_login" "this" {
  count                   = length(var.aws_auth_backend_login)
  namespace               = lookup(var.aws_auth_backend_login[count.index], "namespace")
  backend                 = try(element(vault_auth_backend.this.*.path, lookup(var.aws_auth_backend_login[count.index], "backend_id")))
  role                    = lookup(var.aws_auth_backend_login[count.index], "role")
  identity                = lookup(var.aws_auth_backend_login[count.index], "identity")
  signature               = lookup(var.aws_auth_backend_login[count.index], "signature")
  pkcs7                   = lookup(var.aws_auth_backend_login[count.index], "pkcs7")
  nonce                   = lookup(var.aws_auth_backend_login[count.index], "nonce")
  iam_http_request_method = lookup(var.aws_auth_backend_login[count.index], "iam_http_request_method")
  iam_request_url         = lookup(var.aws_auth_backend_login[count.index], "iam_request_url")
  iam_request_body        = lookup(var.aws_auth_backend_login[count.index], "iam_request_body")
  iam_request_headers     = lookup(var.aws_auth_backend_login[count.index], "iam_request_headers")
}

resource "vault_aws_auth_backend_role" "this" {
  count                           = length(var.aws_auth_backend_role)
  role                            = lookup(var.aws_auth_backend_role[count.index], "role")
  backend                         = try(element(vault_auth_backend.this.*.path, lookup(var.aws_auth_backend_role[count.index], "backend_id")))
  namespace                       = try(element(vault_namespace.this.*.id, lookup(var.aws_auth_backend_role[count.index], "namespace_id")))
  auth_type                       = lookup(var.aws_auth_backend_role[count.index], "auth_type")
  allow_instance_migration        = lookup(var.aws_auth_backend_role[count.index], "allow_instance_migration")
  bound_account_ids               = lookup(var.aws_auth_backend_role[count.index], "bound_account_ids")
  bound_ami_ids                   = lookup(var.aws_auth_backend_role[count.index], "bound_ami_ids")
  bound_ec2_instance_ids          = lookup(var.aws_auth_backend_role[count.index], "bound_ec2_instance_ids")
  bound_iam_instance_profile_arns = lookup(var.aws_auth_backend_role[count.index], "bound_iam_instance_profile_arns")
  bound_iam_principal_arns        = lookup(var.aws_auth_backend_role[count.index], "bound_iam_principal_arns")
  bound_iam_role_arns             = lookup(var.aws_auth_backend_role[count.index], "bound_iam_role_arns")
  bound_regions                   = lookup(var.aws_auth_backend_role[count.index], "bound_regions")
  bound_subnet_ids                = lookup(var.aws_auth_backend_role[count.index], "bound_subnet_ids")
  bound_vpc_ids                   = lookup(var.aws_auth_backend_role[count.index], "bound_vpc_ids")
  inferred_aws_region             = lookup(var.aws_auth_backend_role[count.index], "inferred_aws_region")
  inferred_entity_type            = lookup(var.aws_auth_backend_role[count.index], "inferred_entity_type")
  role_tag                        = lookup(var.aws_auth_backend_role[count.index], "role_tag")
  resolve_aws_unique_ids          = lookup(var.aws_auth_backend_role[count.index], "resolve_aws_unique_ids")
  disallow_reauthentication       = lookup(var.aws_auth_backend_role[count.index], "disallow_reauthentication")
  token_bound_cidrs               = lookup(var.aws_auth_backend_role[count.index], "token_bound_cidrs")
  token_explicit_max_ttl          = lookup(var.aws_auth_backend_role[count.index], "token_explicit_max_ttl")
  token_max_ttl                   = lookup(var.aws_auth_backend_role[count.index], "token_max_ttl")
  token_no_default_policy         = lookup(var.aws_auth_backend_role[count.index], "token_no_default_policy")
  token_num_uses                  = lookup(var.aws_auth_backend_role[count.index], "token_num_uses")
  token_period                    = lookup(var.aws_auth_backend_role[count.index], "token_period")
  token_policies                  = lookup(var.aws_auth_backend_role[count.index], "token_policies")
  token_ttl                       = lookup(var.aws_auth_backend_role[count.index], "token_ttl")
  token_type                      = lookup(var.aws_auth_backend_role[count.index], "token_type")
}

resource "vault_aws_auth_backend_role_tag" "this" {
  count                     = length(var.aws_auth_backend_role_tag)
  role                      = lookup(var.aws_auth_backend_role_tag[count.index], "role")
  namespace                 = try(element(vault_namespace.this.*.id, lookup(var.aws_auth_backend_role_tag[count.index], "namespace_id")))
  backend                   = try(element(vault_auth_backend.this.*.path, lookup(var.aws_auth_backend_role_tag[count.index], "backend_id")))
  policies                  = lookup(var.aws_auth_backend_role_tag[count.index], "policies")
  max_ttl                   = lookup(var.aws_auth_backend_role_tag[count.index], "max_ttl")
  instance_id               = lookup(var.aws_auth_backend_role_tag[count.index], "instance_id")
  allow_instance_migration  = lookup(var.aws_auth_backend_role_tag[count.index], "allow_instance_migration")
  disallow_reauthentication = lookup(var.aws_auth_backend_role_tag[count.index], "disallow_reauthentication")
}

resource "vault_aws_auth_backend_roletag_blacklist" "this" {
  count                 = length(var.aws_auth_backend_roletag_blacklist)
  backend               = try(element(vault_auth_backend.this.*.path, lookup(var.aws_auth_backend_roletag_blacklist[count.index], "backend_id")))
  namespace             = try(element(vault_namespace.this.*.id, lookup(var.aws_auth_backend_roletag_blacklist[count.index], "namespace_id")))
  safety_buffer         = lookup(var.aws_auth_backend_roletag_blacklist[count.index], "safety_buffer")
  disable_periodic_tidy = lookup(var.aws_auth_backend_roletag_blacklist[count.index], "disable_periodic_tidy")
}

resource "vault_aws_auth_backend_sts_role" "this" {
  count      = length(var.aws_auth_backend_sts_role)
  account_id = lookup(var.aws_auth_backend_sts_role[count.index], "account_id")
  sts_role   = lookup(var.aws_auth_backend_sts_role[count.index], "sts_role")
  namespace  = try(element(vault_namespace.this.*.id, lookup(var.aws_auth_backend_sts_role[count.index], "namespace_id")))
  backend    = try(element(vault_auth_backend.this.*.path, lookup(var.aws_auth_backend_sts_role[count.index], "backend_id")))
}

resource "vault_aws_secret_backend" "this" {
  count                     = length(var.aws_secret_backend)
  access_key                = lookup(var.aws_secret_backend[count.index], "access_key")
  secret_key                = lookup(var.aws_secret_backend[count.index], "secret_key")
  namespace                 = try(element(vault_namespace.this.*.id, lookup(var.aws_secret_backend[count.index], "namespace_id")))
  region                    = lookup(var.aws_secret_backend[count.index], "region")
  path                      = try(element(vault_auth_backend.this.*.path, lookup(var.aws_secret_backend[count.index], "backend_id")))
  disable_remount           = lookup(var.aws_secret_backend[count.index], "disable_remount")
  description               = lookup(var.aws_secret_backend[count.index], "description")
  default_lease_ttl_seconds = lookup(var.aws_secret_backend[count.index], "default_lease_ttl_seconds")
  max_lease_ttl_seconds     = lookup(var.aws_secret_backend[count.index], "max_lease_ttl_seconds")
  iam_endpoint              = lookup(var.aws_secret_backend[count.index], "iam_endpoint")
  sts_endpoint              = lookup(var.aws_secret_backend[count.index], "sts_endpoint")
  username_template         = lookup(var.aws_secret_backend[count.index], "username_template")
  local                     = lookup(var.aws_secret_backend[count.index], "local")
}

resource "vault_aws_secret_backend_role" "this" {
  count                    = length(var.aws_secret_backend_role)
  backend                  = try(element(vault_auth_backend.this.*.path, lookup(var.aws_secret_backend_role[count.index], "backend_id")))
  credential_type          = lookup(var.aws_secret_backend_role[count.index], "credential_type")
  name                     = lookup(var.aws_secret_backend_role[count.index], "name")
  namespace                = try(element(vault_namespace.this.*.id, lookup(var.aws_secret_backend_role[count.index], "namespace_id")))
  role_arns                = lookup(var.aws_secret_backend_role[count.index], "role_arns")
  policy_arns              = lookup(var.aws_secret_backend_role[count.index], "policy_arns")
  policy_document          = lookup(var.aws_secret_backend_role[count.index], "policy_document")
  iam_groups               = lookup(var.aws_secret_backend_role[count.index], "iam_groups")
  max_sts_ttl              = lookup(var.aws_secret_backend_role[count.index], "max_sts_ttl")
  user_path                = lookup(var.aws_secret_backend_role[count.index], "user_path")
  permissions_boundary_arn = lookup(var.aws_secret_backend_role[count.index], "permissions_boundary_arn")
}

resource "vault_aws_secret_backend_static_role" "this" {
  count           = length(var.aws_secret_backend_static_role)
  name            = lookup(var.aws_secret_backend_static_role[count.index], "name")
  rotation_period = lookup(var.aws_secret_backend_static_role[count.index], "rotation_period")
  username        = lookup(var.aws_secret_backend_static_role[count.index], "username")
  namespace       = try(element(vault_namespace.this.*.id, lookup(var.aws_secret_backend_static_role[count.index], "namespace_id")))
  backend         = try(element(vault_auth_backend.this.*.path, lookup(var.aws_secret_backend_static_role[count.index], "backend_id")))
}

resource "vault_azure_auth_backend_config" "this" {
  resource      = lookup(var.azure_auth_backend_config[count.index], "resource")
  tenant_id     = lookup(var.azure_auth_backend_config[count.index], "tenant_id")
  namespace     = try(element(vault_namespace.this.*.id, lookup(var.azure_auth_backend_config[count.index], "namespace_id")))
  backend       = try(element(vault_auth_backend.this.*.path, lookup(var.azure_auth_backend_config[count.index], "backend_id")))
  client_id     = sensitive(lookup(var.azure_auth_backend_config[count.index], "client_id"))
  client_secret = sensitive(lookup(var.azure_auth_backend_config[count.index], "client_secret"))
  environment   = lookup(var.azure_auth_backend_config[count.index], "environment")
}

resource "vault_azure_auth_backend_role" "this" {
  count                       = length(var.azure_auth_backend_role)
  role                        = lookup(var.azure_auth_backend_role[count.index], "role")
  backend                     = try(element(vault_auth_backend.this.*.path, lookup(var.azure_auth_backend_role[count.index], "backend_id")))
  namespace                   = try(element(vault_namespace.this.*.id, lookup(var.azure_auth_backend_role[count.index], "namespace_id")))
  bound_service_principal_ids = sensitive(lookup(var.azure_auth_backend_role[count.index], "bound_service_principal_ids"))
  bound_group_ids             = lookup(var.azure_auth_backend_role[count.index], "bound_group_ids")
  bound_locations             = lookup(var.azure_auth_backend_role[count.index], "bound_locations")
  bound_resource_groups       = lookup(var.azure_auth_backend_role[count.index], "bound_resource_groups")
  bound_subscription_ids      = lookup(var.azure_auth_backend_role[count.index], "bound_subscription_ids")
  bound_scale_sets            = lookup(var.azure_auth_backend_role[count.index], "bound_scale_sets")
  token_bound_cidrs           = lookup(var.azure_auth_backend_role[count.index], "token_bound_cidrs")
  token_explicit_max_ttl      = lookup(var.azure_auth_backend_role[count.index], "token_explicit_max_ttl")
  token_max_ttl               = lookup(var.azure_auth_backend_role[count.index], "token_max_ttl")
  token_no_default_policy     = lookup(var.azure_auth_backend_role[count.index], "token_no_default_policy")
  token_num_uses              = lookup(var.azure_auth_backend_role[count.index], "token_num_uses")
  token_period                = lookup(var.azure_auth_backend_role[count.index], "token_period")
  token_policies              = lookup(var.azure_auth_backend_role[count.index], "token_policies")
  token_ttl                   = lookup(var.azure_auth_backend_role[count.index], "token_ttl")
  token_type                  = lookup(var.azure_auth_backend_role[count.index], "token_type")
}

resource "vault_azure_secret_backend" "this" {
  count                   = length(var.azure_secret_backend)
  subscription_id         = sensitive(lookup(var.azure_secret_backend[count.index], "subscription_id"))
  tenant_id               = sensitive(lookup(var.azure_secret_backend[count.index], "tenant_id"))
  namespace               = try(element(vault_namespace.this.*.id, lookup(var.azure_secret_backend[count.index], "namespace_id")))
  use_microsoft_graph_api = lookup(var.azure_secret_backend[count.index], "use_microsoft_graph_api")
  client_id               = sensitive(lookup(var.azure_secret_backend[count.index], "client_id"))
  client_secret           = sensitive(lookup(var.azure_secret_backend[count.index], "client_secret"))
  environment             = lookup(var.azure_secret_backend[count.index], "environment")
  path                    = lookup(var.azure_secret_backend[count.index][count.index], "path")
  disable_remount         = lookup(var.azure_secret_backend[count.index], "disable_remount")
}

resource "vault_azure_secret_backend_role" "this" {
  count                 = length(var.azure_secret_backend_role)
  role                  = lookup(var.azure_secret_backend_role[count.index], "role")
  namespace             = try(element(vault_namespace.this.*.id, lookup(var.azure_secret_backend_role[count.index], "namespace_id")))
  backend               = try(element(vault_auth_backend.this.*.path, lookup(var.azure_secret_backend_role[count.index], "backend_id")))
  application_object_id = sensitive(lookup(var.azure_secret_backend_role[count.index], "application_object_id"))
  ttl                   = lookup(var.azure_secret_backend_role[count.index], "ttl")
  max_ttl               = lookup(var.azure_secret_backend_role[count.index], "max_ttl")

  dynamic "azure_groups" {
    for_each = try(lookup(var.azure_secret_backend_role[count.index], "azure_groups")) == null ? [] : ["azure_groups"]
    content {
      group_name = lookup(azure_groups.value, "group_name")
    }
  }

  dynamic "azure_roles" {
    for_each = try(lookup(var.azure_secret_backend_role[count.index], "azure_roles")) == null ? [] : ["azure_roles"]
    content {
      scope     = lookup(azure_roles.value, "scope")
      role_id   = lookup(azure_roles.value, "role_id")
      role_name = lookup(azure_roles.value, "role_name")
    }
  }
}

resource "vault_cert_auth_backend_role" "this" {
  count                        = length(var.cert_auth_backend_role)
  certificate                  = file(join("/", [path.cwd, "certificates", lookup(var.cert_auth_backend_role[count.index], "certificate")]))
  name                         = lookup(var.cert_auth_backend_role[count.index], "name")
  backend                      = try(element(vault_auth_backend.this.*.path, lookup(var.cert_auth_backend_role[count.index], "backend_id")))
  namespace                    = try(element(vault_namespace.this.*.id, lookup(var.cert_auth_backend_role[count.index], "namespace_id")))
  allowed_names                = lookup(var.cert_auth_backend_role[count.index], "allowed_names")
  allowed_common_names         = lookup(var.cert_auth_backend_role[count.index], "allowed_common_names")
  allowed_dns_sans             = lookup(var.cert_auth_backend_role[count.index], "allowed_dns_sans")
  allowed_email_sans           = lookup(var.cert_auth_backend_role[count.index], "allowed_email_sans")
  allowed_organizational_units = lookup(var.cert_auth_backend_role[count.index], "allowed_organizational_units")
  allowed_uri_sans             = lookup(var.cert_auth_backend_role[count.index], "allowed_uri_sans")
  required_extensions          = lookup(var.cert_auth_backend_role[count.index], "required_extensions")
  display_name                 = lookup(var.cert_auth_backend_role[count.index], "display_name")
  ocsp_enabled                 = lookup(var.cert_auth_backend_role[count.index], "ocsp_enabled")
  ocsp_ca_certificates         = lookup(var.cert_auth_backend_role[count.index], "ocsp_ca_certificates")
  ocsp_fail_open               = lookup(var.cert_auth_backend_role[count.index], "ocsp_fail_open")
  ocsp_query_all_servers       = lookup(var.cert_auth_backend_role[count.index], "ocsp_query_all_servers")
  ocsp_servers_override        = lookup(var.cert_auth_backend_role[count.index], "ocsp_servers_override")
  token_bound_cidrs            = lookup(var.cert_auth_backend_role[count.index], "token_bound_cidrs")
  token_explicit_max_ttl       = lookup(var.cert_auth_backend_role[count.index], "token_explicit_max_ttl")
  token_max_ttl                = lookup(var.cert_auth_backend_role[count.index], "token_max_ttl")
  token_no_default_policy      = lookup(var.cert_auth_backend_role[count.index], "token_no_default_policy")
  token_num_uses               = lookup(var.cert_auth_backend_role[count.index], "token_num_uses")
  token_period                 = lookup(var.cert_auth_backend_role[count.index], "token_period")
  token_policies               = lookup(var.cert_auth_backend_role[count.index], "token_policies")
  token_ttl                    = lookup(var.cert_auth_backend_role[count.index], "token_ttl")
  token_type                   = lookup(var.cert_auth_backend_role[count.index], "token_type")
}

resource "vault_consul_secret_backend" "this" {
  count                     = length(var.consul_secret_backend)
  address                   = lookup(var.consul_secret_backend[count.index], "address")
  namespace                 = try(element(vault_namespace.this.*.id, lookup(var.consul_secret_backend[count.index], "namespace_id")))
  token                     = lookup(var.consul_secret_backend[count.index], "token")
  bootstrap                 = lookup(var.consul_secret_backend[count.index], "bootstrap")
  path                      = lookup(var.consul_secret_backend[count.index], "path")
  disable_remount           = lookup(var.consul_secret_backend[count.index], "disable_remount")
  description               = lookup(var.consul_secret_backend[count.index], "description")
  scheme                    = lookup(var.consul_secret_backend[count.index], "scheme")
  ca_cert                   = lookup(var.consul_secret_backend[count.index], "ca_cert")
  client_cert               = lookup(var.consul_secret_backend[count.index], "client_cert")
  client_key                = lookup(var.consul_secret_backend[count.index], "client_key")
  default_lease_ttl_seconds = lookup(var.consul_secret_backend[count.index], "default_lease_ttl_seconds")
  max_lease_ttl_seconds     = lookup(var.consul_secret_backend[count.index], "max_lease_ttl_seconds")
  local                     = lookup(var.consul_secret_backend[count.index], "local")
}

resource "vault_consul_secret_backend_role" "this" {
  count              = length(var.consul_secret_backend_role)
  name               = lookup(var.consul_secret_backend_role[count.index], "name")
  namespace          = try(element(vault_namespace.this.*.id, lookup(var.consul_secret_backend_role[count.index], "namespace_id")))
  backend            = try(element(vault_auth_backend.this.*.path, lookup(var.consul_secret_backend_role[count.index], "backend_id")))
  policies           = lookup(var.consul_secret_backend_role[count.index], "policies")
  consul_policies    = lookup(var.consul_secret_backend_role[count.index], "consul_policies")
  consul_namespace   = lookup(var.consul_secret_backend_role[count.index], "consul_namespace")
  consul_roles       = lookup(var.consul_secret_backend_role[count.index], "consul_roles")
  service_identities = lookup(var.consul_secret_backend_role[count.index], "service_identities")
  node_identities    = lookup(var.consul_secret_backend_role[count.index], "node_identities")
  partition          = lookup(var.consul_secret_backend_role[count.index], "partition")
  max_ttl            = lookup(var.consul_secret_backend_role[count.index], "max_ttl")
  ttl                = lookup(var.consul_secret_backend_role[count.index], "ttl")
  local              = lookup(var.consul_secret_backend_role[count.index], "local")
}

resource "vault_database_secret_backend_connection" "this" {
  count                    = length(var.database_secret_backend_connection)
  backend                  = try(element(vault_mount.this.*.path, lookup(var.database_secret_backend_connection[count.index], "backend_id")))
  name                     = lookup(var.database_secret_backend_connection[count.index], "name")
  namespace                = try(element(vault_namespace.this.*.id, lookup(var.database_secret_backend_connection[count.index], "namespace_id")))
  plugin_name              = lookup(var.database_secret_backend_connection[count.index], "plugin_name")
  verify_connection        = lookup(var.database_secret_backend_connection[count.index], "verify_connection")
  allowed_roles            = lookup(var.database_secret_backend_connection[count.index], "allowed_roles")
  root_rotation_statements = lookup(var.database_secret_backend_connection[count.index], "root_rotation_statements")
  data                     = lookup(var.database_secret_backend_connection[count.index], "data")

  dynamic "cassandra" {
    for_each = try(lookup(var.database_secret_backend_connection[count.index], "cassandra")) == null ? [] : ["cassandra"]
    content {
      hosts            = lookup(cassandra.value, "hosts")
      username         = sensitive(lookup(cassandra.value, "username"))
      password         = sensitive(lookup(cassandra.value, "password"))
      port             = lookup(cassandra.value, "port")
      tls              = lookup(cassandra.value, "tls")
      insecure_tls     = lookup(cassandra.value, "insecure_tls")
      pem_bundle       = lookup(cassandra.value, "pem_bundle")
      pem_json         = jsonencode(lookup(cassandra.value, "pem_json"))
      protocol_version = lookup(cassandra.value, "protocol_version")
      connect_timeout  = lookup(cassandra.value, "connect_timeout")
    }
  }

  dynamic "couchbase" {
    for_each = try(lookup(var.database_secret_backend_connection[count.index], "couchbase")) == null ? [] : ["couchbase"]
    content {
      hosts             = lookup(couchbase.value, "hosts")
      password          = sensitive(lookup(couchbase.value, "password"))
      username          = sensitive(lookup(couchbase.value, "username"))
      tls               = lookup(couchbase.value, "tls")
      insecure_tls      = lookup(couchbase.value, "insecure_tls")
      base64_pem        = base64encode(lookup(couchbase.value, "base64_pem"))
      bucket_name       = lookup(couchbase.value, "bucket_name")
      username_template = lookup(couchbase.value, "username_template")
    }
  }

  dynamic "elasticsearch" {
    for_each = try(lookup(var.database_secret_backend_connection[count.index], "elasticsearch")) == null ? [] : ["elasticsearch"]
    content {
      password          = sensitive(lookup(elasticsearch.value, "password"))
      url               = lookup(elasticsearch.value, "url")
      username          = sensitive(lookup(elasticsearch.value, "username"))
      tls_server_name   = lookup(elasticsearch.value, "tls_server_name")
      ca_cert           = file(join("/", [path.cwd, "certificate"], lookup(elasticsearch.value, "ca_cert")))
      ca_path           = file(join("/", [path.cwd, "certificate"], lookup(elasticsearch.value, "ca_path")))
      client_cert       = file(join("/", [path.cwd, "certificate"], lookup(elasticsearch.value, "client_cert")))
      client_key        = file(join("/", [path.cwd, "certificate"], lookup(elasticsearch.value, "client_key")))
      insecure          = lookup(elasticsearch.value, "insecure")
      username_template = lookup(elasticsearch.value, "username_template")
    }
  }

  dynamic "hana" {
    for_each = try(lookup(var.database_secret_backend_connection[count.index], "hana")) == null ? [] : ["hana"]
    content {
      connection_url          = lookup(hana.value, "connection_url")
      max_connection_lifetime = lookup(hana.value, "max_connection_lifetime")
      max_idle_connections    = lookup(hana.value, "max_idle_connections")
      max_open_connections    = lookup(hana.value, "max_open_connections")
      username                = sensitive(lookup(hana.value, "username"))
      password                = sensitive(lookup(hana.value, "password"))
      disable_escaping        = lookup(hana.value, "disable_escaping")
    }
  }

  dynamic "influxdb" {
    for_each = try(lookup(var.database_secret_backend_connection[count.index], "influxdb")) == null ? [] : ["influxdb"]
    content {
      host              = lookup(influxdb.value, "host")
      password          = sensitive(lookup(influxdb.value, "password"))
      username          = sensitive(lookup(influxdb.value, "username"))
      tls               = lookup(influxdb.value, "tls")
      insecure_tls      = lookup(influxdb.value, "insecure_tls")
      pem_bundle        = lookup(influxdb.value, "pem_bundle")
      pem_json          = jsonencode(lookup(influxdb.value, "pem_json"))
      username_template = lookup(influxdb.value, "username_template")
      connect_timeout   = lookup(influxdb.value, "connect_timeout")
    }
  }

  dynamic "mongodb" {
    for_each = try(lookup(var.database_secret_backend_connection[count.index], "mongodb")) == null ? [] : ["mongodb"]
    content {
      connection_url    = lookup(mongodb.value, "connection_url")
      username          = sensitive(lookup(mongodb.value, "username"))
      username_template = lookup(mongodb.value, "username_template")
      password          = sensitive(lookup(mongodb.value, "password"))
    }
  }

  dynamic "mongodbatlas" {
    for_each = try(lookup(var.database_secret_backend_connection[count.index], "mongodbatlas")) == null ? [] : ["mongodbatlas"]
    content {
      private_key = sensitive(lookup(mongodbatlas.value, "private_key"))
      project_id  = sensitive(lookup(mongodbatlas.value, "project_id"))
      public_key  = sensitive(lookup(mongodbatlas.value, "public_key"))
    }
  }

  dynamic "mssql" {
    for_each = try(lookup(var.database_secret_backend_connection[count.index], "mssql")) == null ? [] : ["mssql"]
    content {
      connection_url          = lookup(mssql.value, "connection_url")
      max_connection_lifetime = lookup(mssql.value, "max_connection_lifetime")
      max_idle_connections    = lookup(mssql.value, "max_idle_connections")
      max_open_connections    = lookup(mssql.value, "max_open_connections")
      username_template       = lookup(mssql.value, "username_template")
      username                = sensitive(lookup(mssql.value, "username"))
      password                = sensitive(lookup(mssql.value, "password"))
      disable_escaping        = lookup(mssql.value, "disable_escaping")
      contained_db            = lookup(mssql.value, "contained_db")
    }
  }

  dynamic "mysql" {
    for_each = try(lookup(var.database_secret_backend_connection[count.index], "mysql")) == null ? [] : ["mysql"]
    content {
      connection_url          = lookup(mysql.value, "connection_url")
      max_connection_lifetime = lookup(mysql.value, "max_connection_lifetime")
      max_idle_connections    = lookup(mysql.value, "max_idle_connections")
      max_open_connections    = lookup(mysql.value, "max_open_connections")
      username                = sensitive(lookup(mysql.value, "username"))
      password                = sensitive(lookup(mysql.value, "password"))
      auth_type               = lookup(mysql.value, "auth_type")
      service_account_json    = lookup(mysql.value, "service_account_json")
      tls_certificate_key     = file(join("/", [path.cwd, "certificate"], lookup(mysql.value, "tls_certificate_key")))
      tls_ca                  = file(join("/", [path.cwd, "certificate"], lookup(mysql.value, "tls_ca")))
      username_template       = lookup(mysql.value, "username_template")
    }
  }

  dynamic "oracle" {
    for_each = try(lookup(var.database_secret_backend_connection[count.index], "oracle")) == null ? [] : ["oracle"]
    content {
      connection_url          = lookup(oracle.value, "connection_url")
      max_connection_lifetime = lookup(oracle.value, "max_connection_lifetime")
      max_idle_connections    = lookup(oracle.value, "max_idle_connections")
      max_open_connections    = lookup(oracle.value, "max_open_connections")
      username                = sensitive(lookup(oracle.value, "username"))
      password                = sensitive(lookup(oracle.value, "password"))
      username_template       = lookup(oracle.value, "username_template")
    }
  }

  dynamic "postgresql" {
    for_each = try(lookup(var.database_secret_backend_connection[count.index], "postgresql")) == null ? [] : ["postgresql"]
    content {
      connection_url          = lookup(postgresql.value, "connection_url")
      max_connection_lifetime = lookup(postgresql.value, "max_connection_lifetime")
      max_idle_connections    = lookup(postgresql.value, "max_idle_connections")
      max_open_connections    = lookup(postgresql.value, "max_open_connections")
      username                = sensitive(lookup(postgresql.value, "username"))
      password                = sensitive(lookup(postgresql.value, "password"))
      auth_type               = lookup(postgresql.value, "auth_type")
      service_account_json    = lookup(postgresql.value, "service_account_json")
      username_template       = lookup(postgresql.value, "username_template")
    }
  }

  dynamic "redis" {
    for_each = try(lookup(var.database_secret_backend_connection[count.index], "redis")) == null ? [] : ["redis"]
    content {
      host         = lookup(redis.value, "host")
      password     = sensitive(lookup(redis.value, "password"))
      username     = sensitive(lookup(redis.value, "username"))
      tls          = lookup(redis.value, "tls")
      insecure_tls = lookup(redis.value, "insecure_tls")
      ca_cert      = file(join("/", [path.cwd, "certificate"], lookup(redis.value, "ca_cert")))
    }
  }

  dynamic "redis_elasticache" {
    for_each = try(lookup(var.database_secret_backend_connection[count.index], "redis_elasticache")) == null ? [] : ["redis_elasticache"]
    content {
      url      = lookup(redis_elasticache.value, "url")
      username = sensitive(lookup(redis_elasticache.value, "username"))
      password = sensitive(lookup(redis_elasticache.value, "password"))
      region   = lookup(redis_elasticache.value, "region")
    }
  }

  dynamic "redshift" {
    for_each = try(lookup(var.database_secret_backend_connection[count.index], "redshift")) == null ? [] : ["redshift"]
    content {
      connection_url          = lookup(redshift.value, "connection_url")
      max_connection_lifetime = lookup(redshift.value, "max_connection_lifetime")
      max_idle_connections    = lookup(redshift.value, "max_idle_connections")
      max_open_connections    = lookup(redshift.value, "max_open_connections")
      username                = sensitive(lookup(redshift.value, "username"))
      password                = sensitive(lookup(redshift.value, "password"))
      username_template       = lookup(redshift.value, "username_template")
      disable_escaping        = lookup(redshift.value, "disable_escaping")
    }
  }

  dynamic "snowflake" {
    for_each = try(lookup(var.database_secret_backend_connection[count.index], "snowflake")) == null ? [] : ["snowflake"]
    content {
      connection_url          = lookup(snowflake.value, "connection_url")
      max_connection_lifetime = lookup(snowflake.value, "max_connection_lifetime")
      max_idle_connections    = lookup(snowflake.value, "max_idle_connections")
      max_open_connections    = lookup(snowflake.value, "max_open_connections")
      username                = sensitive(lookup(snowflake.value, "username"))
      password                = sensitive(lookup(snowflake.value, "password"))
      username_template       = lookup(snowflake.value, "username_template")
    }
  }
}

resource "vault_database_secret_backend_role" "this" {
  count                 = length(var.database_secret_backend_role)
  backend               = try(element(vault_mount.this.*.path, lookup(var.database_secret_backend_role[count.index], "backend_id")))
  creation_statements   = lookup(var.database_secret_backend_role[count.index], "creation_statements")
  db_name               = lookup(var.database_secret_backend_role[count.index], "db_name")
  name                  = lookup(var.database_secret_backend_role[count.index], "name")
  namespace             = try(element(vault_namespace.this.*.id, lookup(var.database_secret_backend_role[count.index], "namespace_id")))
  credential_config     = lookup(var.database_secret_backend_role[count.index], "credential_config")
  credential_type       = lookup(var.database_secret_backend_role[count.index], "credential_type")
  revocation_statements = lookup(var.database_secret_backend_role[count.index], "revocation_statements")
  renew_statements      = lookup(var.database_secret_backend_role[count.index], "renew_statements")
  rollback_statements   = lookup(var.database_secret_backend_role[count.index], "rollback_statements")
  default_ttl           = lookup(var.database_secret_backend_role[count.index], "default_ttl")
  max_ttl               = lookup(var.database_secret_backend_role[count.index], "max_ttl")
}

resource "vault_database_secret_backend_static_role" "this" {
  count               = length(var.database_secret_backend_static_role)
  backend             = try(element(vault_mount.this.*.path, lookup(var.database_secret_backend_static_role[count.index], "backend_id")))
  db_name             = lookup(var.database_secret_backend_static_role[count.index], "db_name")
  name                = lookup(var.database_secret_backend_static_role[count.index], "name")
  username            = sensitive(lookup(var.database_secret_backend_static_role[count.index], "username"))
  namespace           = try(element(vault_namespace.this.*.id, lookup(var.database_secret_backend_static_role[count.index], "namespace_id")))
  rotation_period     = lookup(var.database_secret_backend_static_role[count.index], "rotation_period")
  rotation_schedule   = lookup(var.database_secret_backend_static_role[count.index], "rotation_schedule")
  rotation_statements = lookup(var.database_secret_backend_static_role[count.index], "rotation_statements")
  rotation_window     = lookup(var.database_secret_backend_static_role[count.index], "rotation_window")
}

resource "vault_database_secrets_mount" "this" {
  count                        = length(var.database_secrets_mount)
  path                         = lookup(var.database_secrets_mount[count.index], "path")
  description                  = lookup(var.database_secrets_mount[count.index], "description")
  default_lease_ttl_seconds    = lookup(var.database_secrets_mount[count.index], "default_lease_ttl_seconds")
  max_lease_ttl_seconds        = lookup(var.database_secrets_mount[count.index], "max_lease_ttl_seconds")
  audit_non_hmac_request_keys  = lookup(var.database_secrets_mount[count.index], "audit_non_hmac_request_keys")
  audit_non_hmac_response_keys = lookup(var.database_secrets_mount[count.index], "audit_non_hmac_response_keys")
  local                        = lookup(var.database_secrets_mount[count.index], "local")
  options                      = lookup(var.database_secrets_mount[count.index], "options")
  seal_wrap                    = lookup(var.database_secrets_mount[count.index], "seal_wrap")
  external_entropy_access      = lookup(var.database_secrets_mount[count.index], "external_entropy_access")
  allowed_managed_keys         = lookup(var.database_secrets_mount[count.index], "allowed_managed_keys")
  namespace                    = try(element(vault_namespace.this.*.id, lookup(var.database_secrets_mount[count.index], "namespace_id")))

  dynamic "cassandra" {
    for_each = try(lookup(var.database_secrets_mount[count.index], "cassandra")) == null ? [] : ["cassandra"]
    content {
      name             = lookup(cassandra.value, "name")
      username         = sensitive(lookup(cassandra.value, "username"))
      password         = sensitive(lookup(cassandra.value, "password"))
      port             = lookup(cassandra.value, "port")
      tls              = lookup(cassandra.value, "tls")
      insecure_tls     = lookup(cassandra.value, "insecure_tls")
      pem_bundle       = lookup(cassandra.value, "pem_bundle")
      pem_json         = jsonencode(lookup(cassandra.value, "pem_json"))
      protocol_version = lookup(cassandra.value, "protocol_version")
      connect_timeout  = lookup(cassandra.value, "connect_timeout")
    }
  }

  dynamic "couchbase" {
    for_each = try(lookup(var.database_secrets_mount[count.index], "couchbase")) == null ? [] : ["couchbase"]
    content {
      hosts             = lookup(couchbase.value, "hosts")
      name              = lookup(couchbase.value, "name")
      password          = sensitive(lookup(couchbase.value, "password"))
      username          = sensitive(lookup(couchbase.value, "username"))
      tls               = lookup(couchbase.value, "tls")
      insecure_tls      = lookup(couchbase.value, "insecure_tls")
      base64_pem        = base64encode(lookup(couchbase.value, "base64_pem"))
      bucket_name       = lookup(couchbase.value, "bucket_name")
      username_template = lookup(couchbase.value, "username_template")
    }
  }

  dynamic "elasticsearch" {
    for_each = try(lookup(var.database_secrets_mount[count.index], "elasticsearch")) == null ? [] : ["elasticsearch"]
    content {
      name              = lookup(elasticsearch.value, "name")
      password          = sensitive(lookup(elasticsearch.value, "password"))
      url               = lookup(elasticsearch.value, "url")
      username          = sensitive(lookup(elasticsearch.value, "username"))
      ca_cert           = lookup(elasticsearch.value, "ca_cert")
      ca_path           = file(join("/", [path.cwd, "certificate", lookup(elasticsearch.value, "ca_path")]))
      client_cert       = lookup(elasticsearch.value, "client_cert")
      client_key        = lookup(elasticsearch.value, "client_key")
      tls_server_name   = lookup(elasticsearch.value, "tls_server_name")
      insecure          = lookup(elasticsearch.value, "insecure")
      username_template = lookup(elasticsearch.value, "username_template")
    }
  }

  dynamic "hana" {
    for_each = try(lookup(var.database_secrets_mount[count.index], "hana")) == null ? [] : ["hana"]
    content {
      name                    = lookup(hana.value, "name")
      connection_url          = lookup(hana.value, "connection_url")
      max_open_connections    = lookup(hana.value, "max_open_connections")
      max_idle_connections    = lookup(hana.value, "max_idle_connections")
      max_connection_lifetime = lookup(hana.value, "max_connection_lifetime")
      username                = sensitive(lookup(hana.value, "username"))
      password                = sensitive(lookup(hana.value, "password"))
      disable_escaping        = lookup(hana.value, "disable_escaping")
    }
  }

  dynamic "influxdb" {
    for_each = try(lookup(var.database_secrets_mount[count.index], "influxdb")) == null ? [] : ["influxdb"]
    content {
      host              = lookup(influxdb.value, "host")
      name              = lookup(influxdb.value, "name")
      password          = sensitive(lookup(influxdb.value, "password"))
      username          = sensitive(lookup(influxdb.value, "username"))
      port              = lookup(influxdb.value, "port")
      tls               = lookup(influxdb.value, "tls")
      insecure_tls      = lookup(influxdb.value, "insecure_tls")
      pem_bundle        = lookup(influxdb.value, "pem_bundle")
      pem_json          = jsonencode(lookup(influxdb.value, "pem_json"))
      username_template = lookup(influxdb.value, "username_template")
      connect_timeout   = lookup(influxdb.value, "connect_timeout")
    }
  }

  dynamic "mongodb" {
    for_each = try(lookup(var.database_secrets_mount[count.index], "mongodb")) == null ? [] : ["mongodb"]
    content {
      name              = lookup(mongodb.value, "name")
      connection_url    = lookup(mongodb.value, "connection_url")
      username          = sensitive(lookup(mongodb.value, "username"))
      password          = sensitive(lookup(mongodb.value, "password"))
      username_template = lookup(mongodb.value, "username_template")
    }
  }

  dynamic "mongodbatlas" {
    for_each = try(lookup(var.database_secrets_mount[count.index], "mongodbatlas")) == null ? [] : ["mongodbatlas"]
    content {
      name        = lookup(mongodbatlas.value, "name")
      private_key = sensitive(lookup(mongodbatlas.value, "private_key"))
      project_id  = sensitive(lookup(mongodbatlas.value, "project_id"))
      public_key  = sensitive(lookup(mongodbatlas.value, "public_key"))
    }
  }

  dynamic "mssql" {
    for_each = try(lookup(var.database_secrets_mount[count.index], "mssql")) == null ? [] : ["mssql"]
    content {
      name                    = lookup(mssql.value, "name")
      connection_url          = lookup(mssql.value, "connection_url")
      contained_db            = lookup(mssql.value, "contained_db")
      max_open_connections    = lookup(mssql.value, "max_open_connections")
      max_idle_connections    = lookup(mssql.value, "max_idle_connections")
      max_connection_lifetime = lookup(mssql.value, "max_connection_lifetime")
      username_template       = lookup(mssql.value, "username_template")
      username                = sensitive(lookup(mssql.value, "username"))
      password                = sensitive(lookup(mssql.value, "password"))
      disable_escaping        = lookup(mssql.value, "disable_escaping")
    }
  }

  dynamic "mysql" {
    for_each = try(lookup(var.database_secrets_mount[count.index], "mysql")) == null ? [] : ["mysql"]
    content {
      name                    = lookup(mysql.value, "name")
      connection_url          = lookup(mysql.value, "connection_url")
      max_open_connections    = lookup(mysql.value, "max_open_connections")
      max_idle_connections    = lookup(mysql.value, "max_idle_connections")
      max_connection_lifetime = lookup(mysql.value, "max_connection_lifetime")
      username                = sensitive(lookup(mysql.value, "username"))
      password                = sensitive(lookup(mysql.value, "password"))
      tls_certificate_key     = lookup(mysql.value, "tls_certificate_key")
      tls_ca                  = lookup(mysql.value, "tls_ca")
      username_template       = lookup(mysql.value, "username_template")
    }
  }

  dynamic "oracle" {
    for_each = try(lookup(var.database_secrets_mount[count.index], "oracle")) == null ? [] : ["oracle"]
    content {
      name                    = lookup(oracle.value, "name")
      connection_url          = lookup(oracle.value, "connection_url")
      max_open_connections    = lookup(oracle.value, "max_open_connections")
      max_idle_connections    = lookup(oracle.value, "max_idle_connections")
      max_connection_lifetime = lookup(oracle.value, "max_connection_lifetime")
      username_template       = lookup(oracle.value, "username_template")
      username                = sensitive(lookup(oracle.value, "username"))
      password                = sensitive(lookup(oracle.value, "password"))
    }
  }

  dynamic "postgresql" {
    for_each = try(lookup(var.database_secrets_mount[count.index], "postgresql")) == null ? [] : ["postgresql"]
    content {
      name                    = lookup(postgresql.value, "name")
      connection_url          = lookup(postgresql.value, "connection_url")
      max_open_connections    = lookup(postgresql.value, "max_open_connections")
      max_idle_connections    = lookup(postgresql.value, "max_idle_connections")
      max_connection_lifetime = lookup(postgresql.value, "max_connection_lifetime")
      username_template       = lookup(postgresql.value, "username_template")
      username                = sensitive(lookup(postgresql.value, "username"))
      password                = sensitive(lookup(postgresql.value, "password"))
      disable_escaping        = lookup(postgresql.value, "disable_escaping")
    }
  }

  dynamic "redis" {
    for_each = try(lookup(var.database_secrets_mount[count.index], "redis")) == null ? [] : ["redis"]
    content {
      host         = lookup(redis.value, "host")
      name         = lookup(redis.value, "name")
      password     = sensitive(lookup(redis.value, "password"))
      username     = sensitive(lookup(redis.value, "username"))
      port         = lookup(redis.value, "port")
      tls          = lookup(redis.value, "tls")
      insecure_tls = lookup(redis.value, "insecure_tls")
      ca_cert      = lookup(redis.value, "ca_cert")
    }
  }

  dynamic "redis_elasticache" {
    for_each = try(lookup(var.database_secrets_mount[count.index], "redis_elasticache")) == null ? [] : ["redis_elasticache"]
    content {
      name     = lookup(redis_elasticache.value, "name")
      url      = lookup(redis_elasticache.value, "url")
      username = sensitive(lookup(redis_elasticache.value, "username"))
      password = sensitive(lookup(redis_elasticache.value, "password"))
      region   = lookup(redis_elasticache.value, "region")
    }
  }

  dynamic "redshift" {
    for_each = try(lookup(var.database_secrets_mount[count.index], "redshift")) == null ? [] : ["redshift"]
    content {
      name                    = lookup(redshift.value, "name")
      connection_url          = lookup(redshift.value, "connection_url")
      max_open_connections    = lookup(redshift.value, "max_open_connections")
      max_idle_connections    = lookup(redshift.value, "max_idle_connections")
      max_connection_lifetime = lookup(redshift.value, "max_connection_lifetime")
      username                = sensitive(lookup(redshift.value, "username"))
      password                = sensitive(lookup(redshift.value, "password"))
      disable_escaping        = lookup(redshift.value, "disable_escaping")
      username_template       = lookup(redshift.value, "username_template")
    }
  }

  dynamic "snowflake" {
    for_each = try(lookup(var.database_secrets_mount[count.index], "snowflake")) == null ? [] : ["snowflake"]
    content {
      name                    = lookup(snowflake.value, "name")
      connection_url          = lookup(snowflake.value, "connection_url")
      max_open_connections    = lookup(snowflake.value, "max_open_connections")
      max_idle_connections    = lookup(snowflake.value, "max_idle_connections")
      max_connection_lifetime = lookup(snowflake.value, "max_connection_lifetime")
      username                = sensitive(lookup(snowflake.value, "username"))
      password                = sensitive(lookup(snowflake.value, "password"))
      disable_escaping        = lookup(snowflake.value, "disable_escaping")
      username_template       = lookup(snowflake.value, "username_template")
    }
  }
}

resource "vault_egp_policy" "this" {
  count             = length(var.egp_policy)
  enforcement_level = lookup(var.egp_policy[count.index], "enforcement_level")
  name              = lookup(var.egp_policy[count.index], "name")
  paths             = lookup(var.egp_policy[count.index], "paths")
  policy            = lookup(var.egp_policy[count.index], "policy")
  namespace         = try(element(vault_namespace.this.*.id, lookup(var.egp_policy[count.index], "namespace_id")))
}

resource "vault_gcp_auth_backend" "this" {
  count           = length(var.gcp_auth_backend)
  namespace       = try(element(vault_namespace.this.*.id, lookup(var.gcp_auth_backend[count.index], "namespace_id")))
  credentials     = file(join("/", [path.cwd, "credentials", lookup(var.gcp_auth_backend[count.index], "credentials")]))
  path            = lookup(var.gcp_auth_backend[count.index], "path")
  disable_remount = lookup(var.gcp_auth_backend[count.index], "disable_remount")
  description     = lookup(var.gcp_auth_backend[count.index], "description")
  local           = lookup(var.gcp_auth_backend[count.index], "local")
}

resource "vault_gcp_auth_backend_role" "this" {
  count                   = length(var.gcp_auth_backend_role)
  role                    = lookup(var.gcp_auth_backend_role[count.index], "role")
  type                    = lookup(var.gcp_auth_backend_role[count.index], "type")
  backend                 = try(element(vault_auth_backend.this.*.path, lookup(var.gcp_auth_backend_role[count.index], "backend_id")))
  namespace               = try(element(vault_namespace.this.*.id, lookup(var.gcp_auth_backend_role[count.index], "namespace_id")))
  bound_instance_groups   = lookup(var.gcp_auth_backend_role[count.index], "bound_instance_groups")
  bound_labels            = lookup(var.gcp_auth_backend_role[count.index], "bound_labels")
  bound_projects          = lookup(var.gcp_auth_backend_role[count.index], "bound_projects")
  bound_regions           = lookup(var.gcp_auth_backend_role[count.index], "bound_regions")
  bound_service_accounts  = lookup(var.gcp_auth_backend_role[count.index], "bound_service_accounts")
  bound_zones             = lookup(var.gcp_auth_backend_role[count.index], "bound_zones")
  token_bound_cidrs       = lookup(var.gcp_auth_backend_role[count.index], "token_bound_cidrs")
  token_explicit_max_ttl  = lookup(var.gcp_auth_backend_role[count.index], "token_explicit_max_ttl")
  token_max_ttl           = lookup(var.gcp_auth_backend_role[count.index], "token_max_ttl")
  token_no_default_policy = lookup(var.gcp_auth_backend_role[count.index], "token_no_default_policy")
  token_num_uses          = lookup(var.gcp_auth_backend_role[count.index], "token_num_uses")
  token_period            = lookup(var.gcp_auth_backend_role[count.index], "token_period")
  token_policies          = lookup(var.gcp_auth_backend_role[count.index], "token_policies")
  token_ttl               = lookup(var.gcp_auth_backend_role[count.index], "token_ttl")
  token_type              = lookup(var.gcp_auth_backend_role[count.index], "token_type")
}

resource "vault_gcp_secret_backend" "this" {
  count                     = length(var.gcp_secret_backend)
  credentials               = file(join("/", [path.cwd, "credentials", lookup(var.gcp_secret_backend[count.index], "credentials")]))
  namespace                 = try(element(vault_namespace.this.*.id, lookup(var.gcp_secret_backend[count.index], "namespace_id")))
  path                      = lookup(var.gcp_secret_backend[count.index], "path")
  disable_remount           = lookup(var.gcp_secret_backend[count.index], "disable_remount")
  description               = lookup(var.gcp_secret_backend[count.index], "description")
  default_lease_ttl_seconds = lookup(var.gcp_secret_backend[count.index], "default_lease_ttl_seconds")
  max_lease_ttl_seconds     = lookup(var.gcp_secret_backend[count.index], "max_lease_ttl_seconds")
  local                     = lookup(var.gcp_secret_backend[count.index], "local")
}

resource "vault_gcp_secret_impersonated_account" "this" {
  count                 = length(var.gcp_secret_impersonated_account)
  backend               = try(element(vault_gcp_secret_backend.this.*.path, lookup(var.gcp_secret_impersonated_account[count.index], "backend_id")))
  impersonated_account  = lookup(var.gcp_secret_impersonated_account[count.index], "impersonated_account")
  service_account_email = lookup(var.gcp_secret_impersonated_account[count.index], "service_account_email")
  token_scopes          = lookup(var.gcp_secret_impersonated_account[count.index], "token_scopes")
  namespace             = try(element(vault_namespace.this.*.id, lookup(var.gcp_secret_impersonated_account[count.index], "namespace_id")))
}

resource "vault_gcp_secret_roleset" "this" {
  count        = length(var.gcp_secret_roleset)
  backend      = try(element(vault_gcp_secret_backend.this.*.path, lookup(var.gcp_secret_roleset[count.index], "backend_id")))
  project      = lookup(var.gcp_secret_roleset[count.index], "project")
  roleset      = lookup(var.gcp_secret_roleset[count.index], "roleset")
  namespace    = lookup(var.gcp_secret_roleset[count.index], "namespace")
  secret_type  = lookup(var.gcp_secret_roleset[count.index], "secret_type")
  token_scopes = lookup(var.gcp_secret_roleset[count.index], "token_scopes")

  dynamic "binding" {
    for_each = lookup(var.gcp_secret_roleset[count.index], "binding") == null ? [] : ["binding"]
    content {
      resource = lookup(binding.value, "resource")
      roles    = lookup(binding.value, "roles")
    }
  }
}

resource "vault_gcp_secret_static_account" "this" {
  count                 = length(var.gcp_secret_static_account)
  backend               = try(element(vault_gcp_secret_backend.this.*.path, lookup(var.gcp_secret_static_account[count.index], "backend_id")))
  service_account_email = lookup(var.gcp_secret_static_account[count.index], "service_account_email")
  static_account        = lookup(var.gcp_secret_static_account[count.index], "static_account")
  namespace             = try(element(vault_namespace.this.*.id, lookup(var.gcp_secret_static_account[count.index], "namespace_id")))
  secret_type           = lookup(var.gcp_secret_static_account[count.index], "secret_type")
  token_scopes          = lookup(var.gcp_secret_static_account[count.index], "token_scopes")

  dynamic "binding" {
    for_each = lookup(var.gcp_secret_static_account[count.index], "binding") == null ? [] : ["binding"]
    content {
      resource = lookup(binding.value, "resource")
      roles    = lookup(binding.value, "roles")
    }
  }
}

resource "vault_generic_endpoint" "this" {
  count                = length(var.generic_endpoint)
  data_json            = jsonencode(lookup(var.generic_endpoint[count.index], "data_json"))
  path                 = lookup(var.generic_endpoint[count.index], "path")
  namespace            = try(element(vault_namespace.this.*.id, lookup(var.generic_endpoint[count.index], "namespace_id")))
  disable_read         = lookup(var.generic_endpoint[count.index], "disable_read")
  disable_delete       = lookup(var.generic_endpoint[count.index], "disable_delete")
  ignore_absent_fields = lookup(var.generic_endpoint[count.index], "ignore_absent_fields")
  write_fields         = lookup(var.generic_endpoint[count.index], "write_fields")
}

resource "vault_generic_secret" "this" {
  count               = length(var.generic_secret)
  data_json           = jsonencode(lookup(var.generic_secret[count.index], "data_json"))
  path                = lookup(var.generic_secret[count.index], "path")
  namespace           = try(element(vault_namespace.this.*.id, lookup(var.generic_secret[count.index], "namespace_id")))
  disable_read        = lookup(var.generic_secret[count.index], "disable_read")
  delete_all_versions = lookup(var.generic_secret[count.index], "delete_all_versions")
}

resource "vault_github_auth_backend" "this" {
  count           = length(var.github_auth_backend)
  organization    = lookup(var.github_auth_backend[count.index], "organization")
  namespace       = try(element(vault_namespace.this.*.id, lookup(var.github_auth_backend[count.index], "namespace_id")))
  path            = lookup(var.github_auth_backend[count.index], "path")
  disable_remount = lookup(var.github_auth_backend[count.index], "disable_remount")
  organization_id = lookup(var.github_auth_backend[count.index], "organization_id")
  base_url        = lookup(var.github_auth_backend[count.index], "base_url")
  description     = lookup(var.github_auth_backend[count.index], "description")
}

resource "vault_github_team" "this" {
  count     = length(var.github_team)
  team      = lookup(var.github_team[count.index], "team")
  backend   = try(element(vault_github_auth_backend.this.*.id, lookup(var.github_team[count.index], "backend_id")))
  namespace = try(element(vault_namespace.this.*.id, lookup(var.github_team[count.index], "namespace_id")))
  policies  = lookup(var.github_team[count.index], "policies")
}

resource "vault_github_user" "this" {
  count     = length(var.github_user)
  user      = lookup(var.github_user[count.index], "user")
  backend   = try(element(vault_github_auth_backend.this.*.id, lookup(var.github_user[count.index], "backend_id")))
  namespace = try(element(vault_namespace.this.*.id, lookup(var.github_user[count.index], "namespace_id")))
  policies  = lookup(var.github_user[count.index], "policies")
}

resource "vault_identity_entity" "this" {
  count             = length(var.identity_entity)
  namespace         = try(element(vault_namespace.this.*.id, lookup(var.identity_entity[count.index], "namespace_id")))
  name              = lookup(var.identity_entity[count.index], "name")
  policies          = lookup(var.identity_entity[count.index], "policies")
  external_policies = lookup(var.identity_entity[count.index], "external_policies")
  metadata          = lookup(var.identity_entity[count.index], "metadata")
  disabled          = lookup(var.identity_entity[count.index], "disabled")
}

resource "vault_identity_entity_alias" "this" {
  count          = length(var.identity_entity_alias)
  canonical_id   = lookup(var.identity_entity_alias[count.index], "canonical_id")
  mount_accessor = lookup(var.identity_entity_alias[count.index], "mount_accessor")
  name           = lookup(var.identity_entity_alias[count.index], "name")
  namespace      = try(element(vault_namespace.this.*.id, lookup(var.identity_entity_alias[count.index], "namespace_id")))
}

resource "vault_identity_entity_policies" "this" {
  count     = length(var.identity_entity_policies)
  entity_id = try(element(vault_identity_entity.this.*.id, lookup(var.identity_entity_policies[count.index], "entity_id")))
  policies  = lookup(var.identity_entity_policies[count.index], "policies")
  namespace = lookup(var.identity_entity_policies[count.index], "namespace")
  exclusive = lookup(var.identity_entity_policies[count.index], "exclusive")
}

resource "vault_identity_group" "this" {
  count                      = length(var.identity_group)
  namespace                  = try(element(vault_namespace.this.*.id, lookup(var.identity_group[count.index], "namespace_id")))
  name                       = lookup(var.identity_group[count.index], "name")
  type                       = lookup(var.identity_group[count.index], "type")
  policies                   = lookup(var.identity_group[count.index], "policies")
  external_policies          = lookup(var.identity_group[count.index], "external_policies")
  external_member_group_ids  = lookup(var.identity_group[count.index], "external_member_group_ids")
  external_member_entity_ids = lookup(var.identity_group[count.index], "external_member_entity_ids")
  metadata                   = lookup(var.identity_group[count.index], "metadata")
  member_entity_ids          = lookup(var.identity_group[count.index], "type") == "external" ? null : lookup(var.identity_group[count.index], "member_entity_ids")
  member_group_ids           = lookup(var.identity_group[count.index], "type") == "external" ? null : lookup(var.identity_group[count.index], "member_group_ids")
}

resource "vault_identity_group_alias" "this" {
  count          = length(var.identity_group_alias)
  canonical_id   = try(element(vault_identity_group.this.*.id, lookup(var.identity_group_alias[count.index], "canonical_id")))
  mount_accessor = try(element(vault_github_auth_backend.this.*.accessor, lookup(var.identity_group_alias[count.index], "mount_accessor_id")))
  name           = lookup(var.identity_group_alias[count.index], "name")
  namespace      = try(element(vault_namespace.this.*.id, lookup(var.identity_group_alias[count.index], "namespace_id")))
}

resource "vault_identity_group_member_entity_ids" "this" {
  count             = length(var.identity_group_member_entity_ids)
  group_id          = try(element(vault_identity_group.this.*.id, lookup(var.identity_group_member_entity_ids[count.index], "group_id")))
  namespace         = try(element(vault_namespace.this.*.id, lookup(var.identity_group_member_entity_ids[count.index], "namespace_id")))
  member_entity_ids = try(element(vault_identity_entity.this.*.id, lookup(var.identity_group_member_entity_ids[count.index], "member_entity_ids")))
  exclusive         = lookup(var.identity_group_member_entity_ids[count.index], "exclusive")
}

resource "vault_identity_group_member_group_ids" "this" {
  count             = length(var.identity_group_member_group_ids)
  group_id          = try(element(vault_identity_group.this.*.id, lookup(var.identity_group_member_group_ids[count.index], "group_id")))
  namespace         = try(element(vault_namespace.this.*.id, lookup(var.identity_group_member_group_ids[count.index], "namespace_id")))
  member_entity_ids = try(element(vault_identity_entity.this.*.id, lookup(var.identity_group_member_group_ids[count.index], "member_entity_ids")))
  exclusive         = lookup(var.identity_group_member_group_ids[count.index], "exclusive")
}

resource "vault_identity_group_policies" "this" {
  count     = length(var.identity_group_policies)
  group_id  = try(element(vault_identity_group.this.*.id, lookup(var.identity_group_policies[count.index], "group_id")))
  policies  = lookup(var.identity_group_policies[count.index], "policies")
  namespace = try(element(vault_namespace.this.*.id, lookup(var.identity_group_policies[count.index], "namespace_id")))
  exclusive = lookup(var.identity_group_policies[count.index], "exclusive")
}

resource "vault_identity_mfa_duo" "this" {
  count           = length(var.identity_mfa_duo)
  api_hostname    = lookup(var.identity_mfa_duo[count.index], "api_hostname")
  integration_key = lookup(var.identity_mfa_duo[count.index], "integration_key")
  secret_key      = lookup(var.identity_mfa_duo[count.index], "secret_key")
  namespace       = try(element(vault_namespace.this.*.id, lookup(var.identity_mfa_duo[count.index], "namespace_id")))
  push_info       = lookup(var.identity_mfa_duo[count.index], "push_info")
  use_passcode    = lookup(var.identity_mfa_duo[count.index], "use_passcode")
  username_format = lookup(var.identity_mfa_duo[count.index], "username_format")
}

resource "vault_identity_mfa_login_enforcement" "this" {
  count = length(var.identity_mfa_login_enforcement)
  mfa_method_ids = try(
    element(vault_identity_mfa_duo.this.*.id, lookup(var.identity_mfa_login_enforcement[count.index], "mfa_method_ids")),
    element(vault_identity_mfa_totp.this.*.id, lookup(var.identity_mfa_login_enforcement[count.index], "mfa_method_ids")),
    element(vault_identity_mfa_okta.this.*.id, lookup(var.identity_mfa_login_enforcement[count.index], "mfa_method_ids")),
    element(vault_identity_mfa_pingid.this.*.id, lookup(var.identity_mfa_login_enforcement[count.index], "mfa_method_ids"))
  )
  name                  = lookup(var.identity_mfa_login_enforcement[count.index], "name")
  auth_method_accessors = lookup(var.identity_mfa_login_enforcement[count.index], "auth_method_accessors")
  auth_method_types     = lookup(var.identity_mfa_login_enforcement[count.index], "auth_method_types")
  identity_entity_ids = try(
    element(vault_identity_entity.this.*.id, lookup(var.identity_mfa_login_enforcement[count.index], "identity_entity_ids"))
  )
  identity_group_ids = try(
    element(vault_identity_group.this.*.id, lookup(var.identity_mfa_login_enforcement[count.index], "identity_group_ids"))
  )
  namespace = try(element(vault_namespace.this.*.id, lookup(var.identity_mfa_login_enforcement[count.index], "namespace_id")))
}

resource "vault_identity_mfa_okta" "this" {
  count           = length(var.identity_mfa_okta)
  api_token       = lookup(var.identity_mfa_okta[count.index], "api_token")
  org_name        = lookup(var.identity_mfa_okta[count.index], "org_name")
  base_url        = lookup(var.identity_mfa_okta[count.index], "base_url")
  namespace       = try(element(vault_namespace.this.*.id, lookup(var.identity_mfa_okta[count.index], "namespace_id")))
  primary_email   = lookup(var.identity_mfa_okta[count.index], "primary_email")
  username_format = lookup(var.identity_mfa_okta[count.index], "username_format")
}

resource "vault_identity_mfa_pingid" "this" {
  count                = length(var.identity_mfa_pingid)
  settings_file_base64 = lookup(var.identity_mfa_pingid[count.index], "settings_file_base64")
  namespace            = try(element(vault_namespace.this.*.id, lookup(var.identity_mfa_pingid[count.index], "namespace_id")))
  username_format      = lookup(var.identity_mfa_pingid[count.index], "username_format")
}

resource "vault_identity_mfa_totp" "this" {
  count                   = length(var.identity_mfa_totp)
  issuer                  = lookup(var.identity_mfa_totp[count.index], "issuer")
  algorithm               = lookup(var.identity_mfa_totp[count.index], "algorithm")
  digits                  = lookup(var.identity_mfa_totp[count.index], "digits")
  key_size                = lookup(var.identity_mfa_totp[count.index], "key_size")
  max_validation_attempts = lookup(var.identity_mfa_totp[count.index], "max_validation_attempts")
  namespace               = try(element(vault_namespace.this.*.id, lookup(var.identity_mfa_totp[count.index], "namespace_id")))
  period                  = lookup(var.identity_mfa_totp[count.index], "period")
  qr_size                 = lookup(var.identity_mfa_totp[count.index], "qr_size")
  skew                    = lookup(var.identity_mfa_totp[count.index], "skew")
}

resource "vault_identity_oidc" "this" {
  count     = length(var.identity_oidc)
  namespace = try(element(vault_namespace.this.*.id, lookup(var.identity_oidc[count.index], "namespace_id")))
  issuer    = lookup(var.identity_oidc[count.index], "issuer")
}

resource "vault_identity_oidc_assignment" "this" {
  count = length(var.identity_oidc_assignment)
  name  = lookup(var.identity_oidc_assignment[count.index], "name")
  entity_ids = try(
    element(vault_identity_entity.this.*.id, lookup(var.identity_oidc_assignment[count.index], "entity_ids"))
  )
  group_ids = try(
    element(vault_identity_group.this.*.id, lookup(var.identity_oidc_assignment[count.index], "group_ids"))
  )
  namespace = try(element(vault_namespace.this.*.id, lookup(var.identity_oidc_assignment[count.index], "namespace_id")))
}

resource "vault_identity_oidc_client" "this" {
  count            = length(var.identity_oidc_client)
  name             = lookup(var.identity_oidc_client[count.index], "name")
  key              = lookup(var.identity_oidc_client[count.index], "key")
  redirect_uris    = lookup(var.identity_oidc_client[count.index], "redirect_uris")
  assignments      = lookup(var.identity_oidc_client[count.index], "assignments")
  id_token_ttl     = lookup(var.identity_oidc_client[count.index], "id_token_ttl")
  access_token_ttl = lookup(var.identity_oidc_client[count.index], "access_token_ttl")
  client_type      = lookup(var.identity_oidc_client[count.index], "client_type")
  namespace        = try(element(vault_namespace.this.*.id, lookup(var.identity_oidc_client[count.index], "namespace_id")))
}

resource "vault_identity_oidc_key" "this" {
  count            = length(var.identity_oidc_key)
  name             = lookup(var.identity_oidc_key[count.index], "name")
  namespace        = try(element(vault_namespace.this.*.id, lookup(var.identity_oidc_key[count.index], "namespace_id")))
  rotation_period  = lookup(var.identity_oidc_key[count.index], "rotation_period")
  verification_ttl = lookup(var.identity_oidc_key[count.index], "verification_ttl")
  algorithm        = lookup(var.identity_oidc_key[count.index], "algorithm")
  allowed_client_ids = try(
    element(vault_identity_oidc_role.this.*.id, lookup(var.identity_oidc_key[count.index], "allowed_client_ids"))
  )
}

resource "vault_identity_oidc_key_allowed_client_id" "this" {
  count             = length(var.identity_oidc_key_allowed_client_id)
  allowed_client_id = try(element(vault_identity_oidc_role.this.*.client_id, lookup(var.identity_oidc_key_allowed_client_id[count.index], "allowed_client_id")))
  key_name          = try(element(vault_identity_oidc_key.this.*.name, lookup(var.identity_oidc_key_allowed_client_id[count.index], "key_id")))
  namespace         = try(element(vault_namespace.this.*.id, lookup(var.identity_oidc_key_allowed_client_id[count.index], "namespace_id")))
}

resource "vault_identity_oidc_provider" "this" {
  count = length(var.identity_oidc_provider)
  name  = lookup(var.identity_oidc_provider[count.index], "name")
  allowed_client_ids = try(
    element(vault_identity_oidc_client.this.*.client_id, lookup(var.identity_oidc_provider[count.index], "allowed_client_ids"))
  )
  issuer_host   = lookup(var.identity_oidc_provider[count.index], "issuer_host")
  https_enabled = lookup(var.identity_oidc_provider[count.index], "https_enabled")
  namespace     = try(element(vault_namespace.this.*.id, lookup(var.identity_oidc_provider[count.index], "namespace_id")))
  scopes_supported = try(
    element(vault_identity_oidc_scope.this.*.name, lookup(var.identity_oidc_provider[count.index], "scopes_ids"))
  )
}

resource "vault_identity_oidc_role" "this" {
  count     = length(var.identity_oidc_role)
  key       = try(element(vault_identity_oidc_key.this.*.name, lookup(var.identity_oidc_role[count.index], "key_id")))
  name      = lookup(var.identity_oidc_role[count.index], "name")
  template  = lookup(var.identity_oidc_role[count.index], "template")
  ttl       = lookup(var.identity_oidc_role[count.index], "ttl")
  client_id = try(element(vault_identity_oidc_client.this.*.client_id, lookup(var.identity_oidc_role[count.index], "client_id")))
  namespace = try(element(vault_namespace.this.*.id, lookup(var.identity_oidc_role[count.index], "namespace_id")))
}

resource "vault_identity_oidc_scope" "this" {
  count       = length(var.identity_oidc_scope)
  name        = lookup(var.identity_oidc_scope[count.index], "name")
  template    = lookup(var.identity_oidc_scope[count.index], "template")
  description = lookup(var.identity_oidc_scope[count.index], "description")
  namespace   = try(element(vault_namespace.this.*.id, lookup(var.identity_oidc_scope[count.index], "namespace_id")))
}

resource "vault_jwt_auth_backend" "this" {
  count                  = length(var.jwt_auth_backend)
  namespace              = try(element(vault_namespace.this.*.id, lookup(var.jwt_auth_backend[count.index], "namespace_id")))
  namespace_in_state     = lookup(var.jwt_auth_backend[count.index], "namespace_in_state")
  path                   = lookup(var.jwt_auth_backend[count.index], "path")
  disable_remount        = lookup(var.jwt_auth_backend[count.index], "disable_remount")
  type                   = lookup(var.jwt_auth_backend[count.index], "type")
  description            = lookup(var.jwt_auth_backend[count.index], "description")
  oidc_client_id         = lookup(var.jwt_auth_backend[count.index], "oidc_client_id")
  oidc_client_secret     = lookup(var.jwt_auth_backend[count.index], "oidc_client_secret")
  oidc_discovery_ca_pem  = lookup(var.jwt_auth_backend[count.index], "oidc_discovery_ca_pem")
  oidc_discovery_url     = lookup(var.jwt_auth_backend[count.index], "oidc_discovery_url")
  oidc_response_mode     = lookup(var.jwt_auth_backend[count.index], "oidc_response_mode")
  oidc_response_types    = lookup(var.jwt_auth_backend[count.index], "oidc_response_types")
  jwks_ca_pem            = lookup(var.jwt_auth_backend[count.index], "jwks_ca_pem")
  jwks_url               = lookup(var.jwt_auth_backend[count.index], "jwks_url")
  jwt_supported_algs     = lookup(var.jwt_auth_backend[count.index], "jwt_supported_algs")
  jwt_validation_pubkeys = lookup(var.jwt_auth_backend[count.index], "jwt_validation_pubkeys")
  default_role           = lookup(var.jwt_auth_backend[count.index], "default_role")
  provider_config        = lookup(var.jwt_auth_backend[count.index], "provider_config")
  local                  = lookup(var.jwt_auth_backend[count.index], "local")
}

resource "vault_jwt_auth_backend_role" "this" {
  count                        = length(var.jwt_auth_backend_role)
  backend                      = try(element(vault_jwt_auth_backend.this.*.path, lookup(var.jwt_auth_backend_role[count.index], "backend_id")))
  role_name                    = lookup(var.jwt_auth_backend_role[count.index], "role_name")
  user_claim                   = lookup(var.jwt_auth_backend_role[count.index], "user_claim")
  role_type                    = lookup(var.jwt_auth_backend_role[count.index], "role_type")
  bound_audiences              = lookup(var.jwt_auth_backend_role[count.index], "bound_audiences")
  bound_claims                 = lookup(var.jwt_auth_backend_role[count.index], "bound_claims")
  bound_claims_type            = lookup(var.jwt_auth_backend_role[count.index], "bound_claims_type")
  bound_subject                = lookup(var.jwt_auth_backend_role[count.index], "bound_subject")
  disable_bound_claims_parsing = lookup(var.jwt_auth_backend_role[count.index], "disable_bound_claims_parsing")
  user_claim_json_pointer      = lookup(var.jwt_auth_backend_role[count.index], "user_claim_json_pointer")
  claim_mappings               = lookup(var.jwt_auth_backend_role[count.index], "claim_mappings")
  clock_skew_leeway            = lookup(var.jwt_auth_backend_role[count.index], "clock_skew_leeway")
  oidc_scopes                  = lookup(var.jwt_auth_backend_role[count.index], "oidc_scopes")
  groups_claim                 = lookup(var.jwt_auth_backend_role[count.index], "groups_claim")
  allowed_redirect_uris        = lookup(var.jwt_auth_backend_role[count.index], "allowed_redirect_uris")
  expiration_leeway            = lookup(var.jwt_auth_backend_role[count.index], "expiration_leeway")
  not_before_leeway            = lookup(var.jwt_auth_backend_role[count.index], "not_before_leeway")
  verbose_oidc_logging         = lookup(var.jwt_auth_backend_role[count.index], "verbose_oidc_logging")
  max_age                      = lookup(var.jwt_auth_backend_role[count.index], "max_age")
  namespace                    = try(element(vault_namespace.this.*.id, lookup(var.jwt_auth_backend_role[count.index], "namespace_id")))
  token_bound_cidrs            = lookup(var.jwt_auth_backend_role[count.index], "token_bound_cidrs")
  token_explicit_max_ttl       = lookup(var.jwt_auth_backend_role[count.index], "token_explicit_max_ttl")
  token_max_ttl                = lookup(var.jwt_auth_backend_role[count.index], "token_max_ttl")
  token_num_uses               = lookup(var.jwt_auth_backend_role[count.index], "token_num_uses")
  token_no_default_policy      = lookup(var.jwt_auth_backend_role[count.index], "token_no_default_policy")
  token_policies               = lookup(var.jwt_auth_backend_role[count.index], "token_policies")
  token_period                 = lookup(var.jwt_auth_backend_role[count.index], "token_period")
  token_ttl                    = lookup(var.jwt_auth_backend_role[count.index], "token_ttl")
  token_type                   = lookup(var.jwt_auth_backend_role[count.index], "token_type")
}

resource "vault_kmip_secret_backend" "this" {
  count                       = length(var.kmip_secret_backend)
  path                        = lookup(var.kmip_secret_backend[count.index], "path")
  namespace                   = try(element(vault_namespace.this.*.id, lookup(var.kmip_secret_backend[count.index], "namespace_id")))
  disable_remount             = lookup(var.kmip_secret_backend[count.index], "disable_remount")
  description                 = lookup(var.kmip_secret_backend[count.index], "description")
  listen_addrs                = lookup(var.kmip_secret_backend[count.index], "listen_addrs")
  server_hostnames            = lookup(var.kmip_secret_backend[count.index], "server_hostnames")
  server_ips                  = lookup(var.kmip_secret_backend[count.index], "server_ips")
  tls_ca_key_bits             = lookup(var.kmip_secret_backend[count.index], "tls_ca_key_bits")
  tls_ca_key_type             = lookup(var.kmip_secret_backend[count.index], "tls_ca_key_type")
  tls_min_version             = lookup(var.kmip_secret_backend[count.index], "tls_min_version")
  default_tls_client_key_bits = lookup(var.kmip_secret_backend[count.index], "default_tls_client_key_bits")
  default_tls_client_key_type = lookup(var.kmip_secret_backend[count.index], "default_tls_client_key_type")
  default_tls_client_ttl      = lookup(var.kmip_secret_backend[count.index], "default_tls_client_ttl")
}

resource "vault_kmip_secret_role" "this" {
  count                        = length(var.kmip_secret_role)
  path                         = try(element(vault_kmip_secret_scope.this.*.path, lookup(var.kmip_secret_role[count.index], "scope_id")))
  role                         = try(element(vault_kmip_secret_scope.this.*.scope, lookup(var.kmip_secret_role[count.index], "scope_id")))
  scope                        = lookup(var.kmip_secret_role[count.index], "scope")
  namespace                    = try(element(vault_namespace.this.*.id, lookup(var.kmip_secret_role[count.index], "namespace_id")))
  tls_client_key_bits          = lookup(var.kmip_secret_role[count.index], "tls_client_key_bits")
  tls_client_key_type          = lookup(var.kmip_secret_role[count.index], "tls_client_key_type")
  tls_client_ttl               = lookup(var.kmip_secret_role[count.index], "tls_client_ttl")
  operation_activate           = lookup(var.kmip_secret_role[count.index], "operation_activate")
  operation_add_attribute      = lookup(var.kmip_secret_role[count.index], "operation_add_attribute")
  operation_all                = lookup(var.kmip_secret_role[count.index], "operation_all")
  operation_create             = lookup(var.kmip_secret_role[count.index], "operation_create")
  operation_destroy            = lookup(var.kmip_secret_role[count.index], "operation_destroy")
  operation_discover_versions  = lookup(var.kmip_secret_role[count.index], "operation_discover_versions")
  operation_get                = lookup(var.kmip_secret_role[count.index], "operation_get")
  operation_get_attribute_list = lookup(var.kmip_secret_role[count.index], "operation_get_attribute_list")
  operation_get_attributes     = lookup(var.kmip_secret_role[count.index], "operation_get_attributes")
  operation_locate             = lookup(var.kmip_secret_role[count.index], "operation_locate")
  operation_none               = lookup(var.kmip_secret_role[count.index], "operation_none")
  operation_register           = lookup(var.kmip_secret_role[count.index], "operation_register")
  operation_rekey              = lookup(var.kmip_secret_role[count.index], "operation_rekey")
  operation_revoke             = lookup(var.kmip_secret_role[count.index], "operation_revoke")
}

resource "vault_kmip_secret_scope" "this" {
  count     = length(var.kmip_secret_scope)
  path      = try(element(vault_kmip_secret_backend.this.*.path, lookup(var.kmip_secret_scope[count.index], "path_id")))
  scope     = lookup(var.kmip_secret_scope[count.index], "scope")
  force     = lookup(var.kmip_secret_scope[count.index], "force")
  namespace = try(element(vault_namespace.this.*.id, lookup(var.kmip_secret_scope[count.index], "namespace_id")))
}

resource "vault_kubernetes_auth_backend_config" "this" {
  count                  = length(var.kubernetes_auth_backend_config)
  backend                = try(element(vault_kubernetes_secret_backend.this.*.path, lookup(var.kubernetes_auth_backend_config[count.index], "backend_id")))
  kubernetes_host        = lookup(var.kubernetes_auth_backend_config[count.index], "kubernetes_host")
  kubernetes_ca_cert     = sensitive(lookup(var.kubernetes_auth_backend_config[count.index], "kubernetes_ca_cert"))
  token_reviewer_jwt     = sensitive(lookup(var.kubernetes_auth_backend_config[count.index], "token_reviewer_jwt"))
  issuer                 = lookup(var.kubernetes_auth_backend_config[count.index], "issuer")
  namespace              = try(element(vault_namespace.this.*.id, lookup(var.kubernetes_auth_backend_config[count.index], "namespace_id")))
  disable_iss_validation = lookup(var.kubernetes_auth_backend_config[count.index], "disable_iss_validation")
  disable_local_ca_jwt   = lookup(var.kubernetes_auth_backend_config[count.index], "disable_local_ca_jwt")
  pem_keys               = lookup(var.kubernetes_auth_backend_config[count.index], "pem_keys")
}

resource "vault_kubernetes_auth_backend_role" "this" {
  count                            = length(var.kubernetes_auth_backend_role)
  bound_service_account_names      = lookup(var.kubernetes_auth_backend_role[count.index], "bound_service_account_names")
  bound_service_account_namespaces = lookup(var.kubernetes_auth_backend_role[count.index], "bound_service_account_namespaces")
  role_name                        = lookup(var.kubernetes_auth_backend_role[count.index], "role_name")
  backend                          = try(element(vault_kubernetes_secret_backend.this.*.path, lookup(var.kubernetes_auth_backend_role[count.index], "backend_id")))
  audience                         = lookup(var.kubernetes_auth_backend_role[count.index], "audience")
  alias_name_source                = lookup(var.kubernetes_auth_backend_role[count.index], "alias_name_source")
  token_type                       = lookup(var.kubernetes_auth_backend_role[count.index], "token_type")
  token_bound_cidrs                = lookup(var.kubernetes_auth_backend_role[count.index], "token_bound_cidrs")
  token_policies                   = lookup(var.kubernetes_auth_backend_role[count.index], "token_policies")
  token_explicit_max_ttl           = lookup(var.kubernetes_auth_backend_role[count.index], "token_explicit_max_ttl")
  token_max_ttl                    = lookup(var.kubernetes_auth_backend_role[count.index], "token_max_ttl")
  token_num_uses                   = lookup(var.kubernetes_auth_backend_role[count.index], "token_num_uses")
  token_period                     = lookup(var.kubernetes_auth_backend_role[count.index], "token_period")
  token_ttl                        = lookup(var.kubernetes_auth_backend_role[count.index], "token_ttl")
  token_no_default_policy          = lookup(var.kubernetes_auth_backend_role[count.index], "token_no_default_policy")
  namespace                        = try(element(vault_namespace.this.*.id, lookup(var.kubernetes_auth_backend_role[count.index], "namespace_id")))
}

resource "vault_kubernetes_secret_backend" "this" {
  count                = length(var.kubernetes_secret_backend)
  path                 = lookup(var.kubernetes_secret_backend[count.index], "path")
  namespace            = try(element(vault_namespace.this.*.id, lookup(var.kubernetes_secret_backend[count.index], "namespace_id")))
  kubernetes_ca_cert   = file(join("/", [path.cwd, "certificate", lookup(var.kubernetes_secret_backend[count.index], "kubernetes_ca_cert")]))
  kubernetes_host      = lookup(var.kubernetes_secret_backend[count.index], "kubernetes_host")
  service_account_jwt  = file(join("/", [path.cwd, "service_account", lookup(var.kubernetes_secret_backend[count.index], "service_account_jwt")]))
  disable_local_ca_jwt = lookup(var.kubernetes_secret_backend[count.index], "disable_local_ca_jwt")
}

resource "vault_kubernetes_secret_backend_role" "this" {
  count                         = length(var.kubernetes_secret_backend_role)
  allowed_kubernetes_namespaces = lookup(var.kubernetes_auth_backend_role[count.index], "allowed_kubernetes_namespaces")
  backend                       = try(element(vault_kubernetes_secret_backend.this.*.path, lookup(var.kubernetes_auth_backend_role[count.index], "backend_id")))
  name                          = lookup(var.kubernetes_auth_backend_role[count.index], "name")
  namespace                     = try(element(vault_namespace.this.*.id, lookup(var.kubernetes_auth_backend_role[count.index], "namespace_id")))
  name_template                 = lookup(var.kubernetes_auth_backend_role[count.index], "name_template")
  token_max_ttl                 = lookup(var.kubernetes_auth_backend_role[count.index], "token_max_ttl")
  token_default_ttl             = lookup(var.kubernetes_auth_backend_role[count.index], "token_default_ttl")
  kubernetes_role_name          = lookup(var.kubernetes_auth_backend_role[count.index], "kubernetes_role_name")
  kubernetes_role_type          = lookup(var.kubernetes_auth_backend_role[count.index], "kubernetes_role_type")
  generated_role_rules          = lookup(var.kubernetes_auth_backend_role[count.index], "generated_role_rules")
  extra_annotations             = lookup(var.kubernetes_auth_backend_role[count.index], "extra_annotations")
  extra_labels                  = lookup(var.kubernetes_auth_backend_role[count.index], "extra_labels")
}

resource "vault_kv_secret" "this" {
  count     = length(var.kv_secret)
  data_json = jsonencode(lookup(var.kv_secret[count.index], "data_json"))
  path      = try(element(vault_mount.this.*.path, lookup(var.kv_secret[count.index], "path_id")))
  namespace = try(element(vault_namespace.this.*.id, lookup(var.kv_secret[count.index], "namespace_id")))
}

resource "vault_kv_secret_backend_v2" "this" {
  count                = length(var.kv_secret_backend_v2)
  mount                = try(element(vault_mount.this.*.path, lookup(var.kv_secret_backend_v2[count.index], "mount_id")))
  namespace            = try(element(vault_namespace.this.*.id, lookup(var.kv_secret_backend_v2[count.index], "namespace_id")))
  max_versions         = lookup(var.kv_secret_backend_v2[count.index], "max_versions")
  cas_required         = lookup(var.kv_secret_backend_v2[count.index], "cas_required")
  delete_version_after = lookup(var.kv_secret_backend_v2[count.index], "delete_version_after")
}

resource "vault_kv_secret_v2" "this" {
  count               = length(var.kv_secret_v2)
  data_json           = jsonencode(lookup(var.kv_secret_v2[count.index], "data_json"))
  mount               = try(element(vault_mount.this.*.path, lookup(var.kv_secret_v2[count.index], "mount")))
  name                = lookup(var.kv_secret_v2[count.index], "name")
  namespace           = try(element(vault_namespace.this.*.id, lookup(var.kv_secret_v2[count.index], "namespace_id")))
  cas                 = lookup(var.kv_secret_v2[count.index], "cas")
  disable_read        = lookup(var.kv_secret_v2[count.index], "disable_read")
  delete_all_versions = lookup(var.kv_secret_v2[count.index], "delete_all_versions")
}

resource "vault_ldap_auth_backend" "this" {
  count                = length(var.ldap_auth_backend)
  url                  = lookup(var.ldap_auth_backend[count.index], "url")
  starttls             = lookup(var.ldap_auth_backend[count.index], "starttls")
  case_sensitive_names = lookup(var.ldap_auth_backend[count.index], "case_sensitive_names")
  insecure_tls         = lookup(var.ldap_auth_backend[count.index], "insecure_tls")
  deny_null_bind       = lookup(var.ldap_auth_backend[count.index], "deny_null_bind")
  discoverdn           = lookup(var.ldap_auth_backend[count.index], "discoverdn")
  disable_remount      = lookup(var.ldap_auth_backend[count.index], "disable_remount")
  use_token_groups     = lookup(var.ldap_auth_backend[count.index], "use_token_groups")
  username_as_alias    = lookup(var.ldap_auth_backend[count.index], "username_as_alias")
  local                = lookup(var.ldap_auth_backend[count.index], "local")
  token_num_uses       = lookup(var.ldap_auth_backend[count.index], "token_num_uses")
  max_page_size        = lookup(var.ldap_auth_backend[count.index], "max_page_size")
  tls_min_version      = lookup(var.ldap_auth_backend[count.index], "tls_min_version")
  tls_max_version      = lookup(var.ldap_auth_backend[count.index], "tls_max_version")
  certificate          = lookup(var.ldap_auth_backend[count.index], "certificate")
  client_tls_cert      = lookup(var.ldap_auth_backend[count.index], "client_tls_cert")
  client_tls_key       = lookup(var.ldap_auth_backend[count.index], "client_tls_key")
  binddn               = lookup(var.ldap_auth_backend[count.index], "binddn")
  bindpass             = lookup(var.ldap_auth_backend[count.index], "bindpass")
  upndomain            = lookup(var.ldap_auth_backend[count.index], "upndomain")
  groupattr            = lookup(var.ldap_auth_backend[count.index], "groupattr")
  groupdn              = lookup(var.ldap_auth_backend[count.index], "groupdn")
  groupfilter          = lookup(var.ldap_auth_backend[count.index], "groupfilter")
  path                 = lookup(var.ldap_auth_backend[count.index], "path")
  description          = lookup(var.ldap_auth_backend[count.index], "description")
  namespace            = try(element(vault_namespace.this.*.id, lookup(var.ldap_auth_backend[count.index], "namespace_id")))
}

resource "vault_ldap_auth_backend_group" "this" {
  count     = length(var.ldap_auth_backend_group)
  groupname = lookup(var.ldap_auth_backend_group[count.index], "groupname")
  namespace = try(element(vault_namespace.this.*.id, lookup(var.ldap_auth_backend_group[count.index], "namespace_id")))
  policies  = lookup(var.ldap_auth_backend_group[count.index], "policies")
  backend   = try(element(vault_ldap_auth_backend.this.*.path, lookup(var.ldap_auth_backend_group[count.index], "backend_id")))
}

resource "vault_ldap_auth_backend_user" "this" {
  count     = length(var.ldap_auth_backend_user)
  username  = lookup(var.ldap_auth_backend_user[count.index], "username")
  backend   = try(element(vault_ldap_auth_backend.this.*.path, lookup(var.ldap_auth_backend_user[count.index], "backend_id")))
  groups    = try(element(vault_ldap_auth_backend_group.this.*.id, lookup(var.ldap_auth_backend_user[count.index], "groups_id")))
  policies  = lookup(var.ldap_auth_backend_user[count.index], "policies")
  namespace = try(element(vault_namespace.this.*.id, lookup(var.ldap_auth_backend_user[count.index], "namespace_id")))
}

resource "vault_ldap_secret_backend" "this" {
  count                        = length(var.ldap_secret_backend)
  binddn                       = lookup(var.ldap_secret_backend[count.index], "binddn")
  bindpass                     = lookup(var.ldap_secret_backend[count.index], "bindpass")
  path                         = lookup(var.ldap_secret_backend[count.index], "path")
  url                          = lookup(var.ldap_secret_backend[count.index], "url")
  certificate                  = file(join("/", [path.cwd, "certificate", lookup(var.ldap_secret_backend[count.index], "certificate")]))
  client_tls_cert              = file(join("/", [path.cwd, "certificate", lookup(var.ldap_secret_backend[count.index], "client_tls_cert")]))
  client_tls_key               = file(join("/", [path.cwd, "certificate", lookup(var.ldap_secret_backend[count.index], "client_tls_key")]))
  description                  = lookup(var.ldap_secret_backend[count.index], "description")
  upndomain                    = lookup(var.ldap_secret_backend[count.index], "upndomain")
  password_policy              = lookup(var.ldap_secret_backend[count.index], "password_policy")
  schema                       = lookup(var.ldap_secret_backend[count.index], "schema")
  userattr                     = lookup(var.ldap_secret_backend[count.index], "userattr")
  userdn                       = lookup(var.ldap_secret_backend[count.index], "userdn")
  audit_non_hmac_request_keys  = lookup(var.ldap_secret_backend[count.index], "audit_non_hmac_request_keys")
  audit_non_hmac_response_keys = lookup(var.ldap_secret_backend[count.index], "audit_non_hmac_response_keys")
  connection_timeout           = lookup(var.ldap_secret_backend[count.index], "connection_timeout")
  default_lease_ttl_seconds    = lookup(var.ldap_secret_backend[count.index], "default_lease_ttl_seconds")
  max_lease_ttl_seconds        = lookup(var.ldap_secret_backend[count.index], "max_lease_ttl_seconds")
  request_timeout              = lookup(var.ldap_secret_backend[count.index], "request_timeout")
  starttls                     = lookup(var.ldap_secret_backend[count.index], "starttls")
  insecure_tls                 = lookup(var.ldap_secret_backend[count.index], "insecure_tls")
  local                        = lookup(var.ldap_secret_backend[count.index], "local")
  disable_remount              = lookup(var.ldap_secret_backend[count.index], "disable_remount")
  namespace                    = try(element(vault_namespace.this.*.id, lookup(var.ldap_secret_backend[count.index], "namespace_id")))
}

resource "vault_ldap_secret_backend_dynamic_role" "this" {
  count             = length(var.ldap_secret_backend_dynamic_role)
  creation_ldif     = lookup(var.ldap_secret_backend_dynamic_role[count.index], "creation_ldif")
  deletion_ldif     = lookup(var.ldap_secret_backend_dynamic_role[count.index], "deletion_ldif")
  role_name         = lookup(var.ldap_secret_backend_dynamic_role[count.index], "role_name")
  namespace         = try(element(vault_namespace.this.*.id, lookup(var.ldap_secret_backend_dynamic_role[count.index], "namespace_id")))
  mount             = try(element(vault_ldap_secret_backend.this.*.path, lookup(var.ldap_secret_backend_dynamic_role[count.index], "mount")))
  rollback_ldif     = lookup(var.ldap_secret_backend_dynamic_role[count.index], "rollback_ldif")
  username_template = lookup(var.ldap_secret_backend_dynamic_role[count.index], "username_template")
  default_ttl       = lookup(var.ldap_secret_backend_dynamic_role[count.index], "default_ttl")
  max_ttl           = lookup(var.ldap_secret_backend_dynamic_role[count.index], "max_ttl")
}

resource "vault_ldap_secret_backend_library_set" "this" {
  count                        = length(var.ldap_secret_backend_library_set)
  name                         = lookup(var.ldap_secret_backend_library_set[count.index], "name")
  service_account_names        = lookup(var.ldap_secret_backend_library_set[count.index], "service_account_names")
  mount                        = try(element(vault_ldap_secret_backend.this.*.path, lookup(var.ldap_secret_backend_library_set[count.index], "mount")))
  namespace                    = try(element(vault_namespace.this.*.id, lookup(var.ldap_secret_backend_library_set[count.index], "namespace_id")))
  ttl                          = lookup(var.ldap_secret_backend_library_set[count.index], "ttl")
  max_ttl                      = lookup(var.ldap_secret_backend_library_set[count.index], "max_ttl")
  disable_check_in_enforcement = lookup(var.ldap_secret_backend_library_set[count.index], "disable_check_in_enforcement")
}

resource "vault_ldap_secret_backend_static_role" "this" {
  count           = length(var.ldap_secret_backend_static_role)
  role_name       = lookup(var.ldap_secret_backend_static_role[count.index], "role_name")
  rotation_period = lookup(var.ldap_secret_backend_static_role[count.index], "rotation_period")
  username        = lookup(var.ldap_secret_backend_static_role[count.index], "username")
  mount           = try(element(vault_ldap_secret_backend.this.*.path, lookup(var.ldap_secret_backend_static_role[count.index], "mount")))
  namespace       = try(element(vault_namespace.this.*.id, lookup(var.ldap_secret_backend_static_role[count.index], "namespace_id")))
  dn              = lookup(var.ldap_secret_backend_static_role[count.index], "dn")
}

resource "vault_managed_keys" "this" {
  count     = length(var.managed_keys)
  namespace = try(element(vault_namespace.this.*.id, lookup(var.managed_keys[count.index], "namespace_id")))

  dynamic "aws" {
    for_each = try(lookup(var.managed_keys[count.index], "aws")) == null ? [] : ["aws"]
    content {
      access_key         = sensitive(lookup(aws.value, "access_key"))
      key_bits           = lookup(aws.value, "key_bits")
      key_type           = lookup(aws.value, "key_type")
      kms_key            = lookup(aws.value, "kms_key")
      name               = lookup(aws.value, "name")
      secret_key         = sensitive(lookup(aws.value, "secret_key"))
      curve              = lookup(aws.value, "curve")
      endpoint           = lookup(aws.value, "endpoint")
      region             = lookup(aws.value, "region")
      allow_generate_key = lookup(aws.value, "allow_generate_key")
      allow_replace_key  = lookup(aws.value, "allow_replace_key")
      allow_store_key    = lookup(aws.value, "allow_store_key")
    }
  }

  dynamic "azure" {
    for_each = try(lookup(var.managed_keys[count.index], "azure")) == null ? [] : ["azure"]
    content {
      client_id          = sensitive(lookup(azure.value, "client_id"))
      client_secret      = sensitive(lookup(azure.value, "client_secret"))
      key_name           = lookup(azure.value, "key_name")
      key_type           = lookup(azure.value, "key_type")
      name               = lookup(azure.value, "name")
      tenant_id          = lookup(azure.value, "tenant_id")
      vault_name         = lookup(azure.value, "vault_name")
      environment        = lookup(azure.value, "environment")
      resource           = lookup(azure.value, "resource")
      key_bits           = lookup(azure.value, "key_bits")
      allow_generate_key = lookup(azure.value, "allow_generate_key")
      allow_replace_key  = lookup(azure.value, "allow_replace_key")
      allow_store_key    = lookup(azure.value, "allow_store_key")
    }
  }

  dynamic "pkcs" {
    for_each = try(lookup(var.managed_keys[count.index], "pkcs")) == null ? [] : ["pkcs"]
    content {
      key_id             = sensitive(lookup(pkcs.value, "key_id"))
      key_label          = sensitive(lookup(pkcs.value, "key_label"))
      library            = lookup(pkcs.value, "library")
      mechanism          = lookup(pkcs.value, "mechanism")
      name               = lookup(pkcs.value, "name")
      pin                = lookup(pkcs.value, "pin")
      token_label        = lookup(pkcs.value, "token_label")
      curve              = lookup(pkcs.value, "curve")
      key_bits           = lookup(pkcs.value, "key_bits")
      force_rw_session   = lookup(pkcs.value, "force_rw_session")
      allow_generate_key = lookup(pkcs.value, "allow_generate_key")
      allow_replace_key  = lookup(pkcs.value, "allow_replace_key")
      allow_store_key    = lookup(pkcs.value, "allow_store_key")
    }
  }
}

resource "vault_mfa_duo" "this" {
  count           = length(var.mfa_duo)
  api_hostname    = lookup(var.mfa_duo[count.index], "api_hostname")
  integration_key = lookup(var.mfa_duo[count.index], "integration_key")
  mount_accessor  = try(element(vault_auth_backend.this.*.accessor, lookup(var.mfa_duo[count.index], "mount_accessor")))
  name            = lookup(var.mfa_duo[count.index], "name")
  secret_key      = lookup(var.mfa_duo[count.index], "secret_key")
  username_format = lookup(var.mfa_duo[count.index], "username_format")
  namespace       = try(element(vault_namespace.this.*.id, lookup(var.mfa_duo[count.index], "namespace_id")))
  push_info       = lookup(var.mfa_duo[count.index], "push_info")
}

resource "vault_mfa_okta" "this" {
  count           = length(var.mfa_okta)
  api_token       = lookup(var.mfa_okta[count.index], "api_token")
  mount_accessor  = try(element(vault_auth_backend.this.*.accessor, lookup(var.mfa_okta[count.index], "mount_accessor")))
  name            = lookup(var.mfa_okta[count.index], "name")
  org_name        = lookup(var.mfa_okta[count.index], "org_name")
  namespace       = try(element(vault_namespace.this.*.id, lookup(var.mfa_okta[count.index], "namespace_id")))
  username_format = lookup(var.mfa_okta[count.index], "username_format")
  base_url        = lookup(var.mfa_okta[count.index], "base_url")
  primary_email   = lookup(var.mfa_okta[count.index], "primary_email")
}

resource "vault_mfa_pingid" "this" {
  count                = length(var.mfa_pingid)
  mount_accessor       = try(element(vault_auth_backend.this.*.accessor, lookup(var.mfa_pingid[count.index], "mount_accessor")))
  name                 = lookup(var.mfa_pingid[count.index], "name")
  settings_file_base64 = file(join("/", [path.cwd, "settings", lookup(var.mfa_pingid[count.index], "settings_file_base64")]))
  namespace            = try(element(vault_namespace.this.*.id, lookup(var.mfa_pingid[count.index], "namespace_id")))
}

resource "vault_mfa_totp" "this" {
  count     = length(var.mfa_totp)
  issuer    = lookup(var.mfa_totp[count.index], "issuer")
  name      = lookup(var.mfa_totp[count.index], "name")
  namespace = try(element(vault_namespace.this.*.id, lookup(var.mfa_totp[count.index], "namespace_id")))
  period    = lookup(var.mfa_totp[count.index], "period")
  key_size  = lookup(var.mfa_totp[count.index], "key_size")
  qr_size   = lookup(var.mfa_totp[count.index], "qr_size")
  algorithm = lookup(var.mfa_totp[count.index], "algorithm")
  digits    = lookup(var.mfa_totp[count.index], "digits")
  skew      = lookup(var.mfa_totp[count.index], "skew")
}

resource "vault_mongodbatlas_secret_backend" "this" {
  count       = length(var.mongodbatlas_secret_backend)
  mount       = try(element(vault_mount.this.*.path, lookup(var.mongodbatlas_secret_backend[count.index], "mount")))
  private_key = sensitive(lookup(var.mongodbatlas_secret_backend[count.index], "private_key"))
  public_key  = sensitive(lookup(var.mongodbatlas_secret_backend[count.index], "public_key"))
  namespace   = try(element(vault_namespace.this.*.id, lookup(var.mongodbatlas_secret_backend[count.index], "namespace_id")))
}

resource "vault_mongodbatlas_secret_role" "this" {
  count           = length(var.mongodbatlas_secret_role)
  mount           = try(element(vault_mount.this.*.path, lookup(var.mongodbatlas_secret_role[count.index], "mount")))
  name            = lookup(var.mongodbatlas_secret_role[count.index], "name")
  roles           = lookup(var.mongodbatlas_secret_role[count.index], "roles")
  namespace       = try(element(vault_namespace.this.*.id, lookup(var.mongodbatlas_secret_role[count.index], "namespace_id")))
  organization_id = lookup(var.mongodbatlas_secret_role[count.index], "organization_id")
  project_id      = lookup(var.mongodbatlas_secret_role[count.index], "project_id")
  project_roles   = lookup(var.mongodbatlas_secret_role[count.index], "project_roles")
  ip_addresses    = lookup(var.mongodbatlas_secret_role[count.index], "ip_addresses")
  cidr_blocks     = lookup(var.mongodbatlas_secret_role[count.index], "cidr_blocks")
  ttl             = lookup(var.mongodbatlas_secret_role[count.index], "ttl")
  max_ttl         = lookup(var.mongodbatlas_secret_role[count.index], "max_ttl")
}

resource "vault_mount" "this" {
  count                        = length(var.mount)
  path                         = lookup(var.mount[count.index], "path")
  type                         = lookup(var.mount[count.index], "type_id") != null ? try(element(vault_mount.this.*.type, lookup(var.mount[count.index], "type_id"))) : lookup(var.mount[count.index], "type")
  namespace                    = try(element(vault_namespace.this.*.id, lookup(var.mount[count.index], "namespace_id")))
  description                  = lookup(var.mount[count.index], "description")
  default_lease_ttl_seconds    = lookup(var.mount[count.index], "default_lease_ttl_seconds")
  max_lease_ttl_seconds        = lookup(var.mount[count.index], "max_lease_ttl_seconds")
  audit_non_hmac_request_keys  = lookup(var.mount[count.index], "audit_non_hmac_request_keys")
  audit_non_hmac_response_keys = lookup(var.mount[count.index], "audit_non_hmac_response_keys")
  local                        = lookup(var.mount[count.index], "local")
  options                      = lookup(var.mount[count.index], "options")
  seal_wrap                    = lookup(var.mount[count.index], "seal_wrap")
  external_entropy_access      = lookup(var.mount[count.index], "external_entropy_access")
  allowed_managed_keys         = lookup(var.mount[count.index], "allowed_managed_keys")
}

resource "vault_namespace" "this" {
  count           = length(var.namespace)
  path            = lookup(var.namespace[count.index], "path")
  namespace       = lookup(var.namespace[count.index], "namespace")
  custom_metadata = lookup(var.namespace[count.index], "custom_metadata")
}

resource "vault_nomad_secret_backend" "this" {
  count                     = length(var.nomad_secret_backend)
  backend                   = lookup(var.nomad_secret_backend[count.index], "backend")
  namespace                 = try(element(vault_namespace.this.*.id, lookup(var.nomad_secret_backend[count.index], "namespace_id")))
  disable_remount           = lookup(var.nomad_secret_backend[count.index], "disable_remount")
  address                   = lookup(var.nomad_secret_backend[count.index], "address")
  ca_cert                   = file(join("/", [path.cwd, "certificate", lookup(var.nomad_secret_backend[count.index], "ca_cert")]))
  client_cert               = file(join("/", [path.cwd, "certificate", lookup(var.nomad_secret_backend[count.index], "client_cert")]))
  client_key                = file(join("/", [path.cwd, "certificate", lookup(var.nomad_secret_backend[count.index], "client_key")]))
  default_lease_ttl_seconds = lookup(var.nomad_secret_backend[count.index], "default_lease_ttl_seconds")
  description               = lookup(var.nomad_secret_backend[count.index], "description")
  local                     = lookup(var.nomad_secret_backend[count.index], "local")
  max_lease_ttl_seconds     = lookup(var.nomad_secret_backend[count.index], "max_lease_ttl_seconds")
  max_token_name_length     = lookup(var.nomad_secret_backend[count.index], "max_token_name_length")
  max_ttl                   = lookup(var.nomad_secret_backend[count.index], "max_ttl")
  token                     = lookup(var.nomad_secret_backend[count.index], "token")
  ttl                       = lookup(var.nomad_secret_backend[count.index], "ttl")
}

resource "vault_nomad_secret_role" "this" {
  count     = length(var.nomad_secret_role)
  backend   = try(element(vault_nomad_secret_backend.this.*.backend, lookup(var.nomad_secret_role[count.index], "backend_id")))
  role      = lookup(var.nomad_secret_role[count.index], "role")
  namespace = try(element(vault_namespace.this.*.id, lookup(var.nomad_secret_role[count.index], "namespace_id")))
  global    = lookup(var.nomad_secret_role[count.index], "global")
  policies  = lookup(var.nomad_secret_role[count.index], "policies")
  type      = lookup(var.nomad_secret_role[count.index], "type")
}

resource "vault_okta_auth_backend" "this" {
  count           = length(var.okta_auth_backend)
  organization    = lookup(var.okta_auth_backend[count.index], "organization")
  namespace       = try(element(vault_namespace.this.*.id, lookup(var.okta_auth_backend[count.index], "namespace")))
  path            = lookup(var.okta_auth_backend[count.index], "path")
  disable_remount = lookup(var.okta_auth_backend[count.index], "disable_remount")
  token           = lookup(var.okta_auth_backend[count.index], "token")
  base_url        = lookup(var.okta_auth_backend[count.index], "base_url")
  bypass_okta_mfa = lookup(var.okta_auth_backend[count.index], "bypass_okta_mfa")
  ttl             = lookup(var.okta_auth_backend[count.index], "ttl")
  max_ttl         = lookup(var.okta_auth_backend[count.index], "max_ttl")

  dynamic "group" {
    for_each = try(lookup(var.okta_auth_backend[count.index], "group")) == null ? [] : ["group"]
    content {
      group_name = lookup(group.value, "group_name")
      policies   = lookup(group.value, "policies")
    }
  }

  dynamic "user" {
    for_each = try(lookup(var.okta_auth_backend[count.index], "user")) == null ? [] : ["user"]
    content {
      username = lookup(user.value, "username")
      groups   = lookup(user.value, "groups")
      policies = lookup(user.value, "policies")
    }
  }
}

resource "vault_okta_auth_backend_group" "this" {
  count      = length(var.okta_auth_backend_group)
  group_name = lookup(var.okta_auth_backend_group[count.index], "group_name")
  path       = try(element(vault_okta_auth_backend.this.*.path, lookup(var.okta_auth_backend_group[count.index], "path_id")))
  namespace  = try(element(vault_namespace.this.*.id, lookup(var.okta_auth_backend_group[count.index], "namespace_id")))
  policies   = lookup(var.okta_auth_backend_group[count.index], "policies")
}

resource "vault_okta_auth_backend_user" "this" {
  count     = length(var.okta_auth_backend_user)
  path      = try(element(vault_okta_auth_backend.this.*.path, lookup(var.okta_auth_backend_user[count.index], "path_id")))
  username  = lookup(var.okta_auth_backend_user[count.index], "username")
  namespace = try(element(vault_namespace.this.*.id, lookup(var.okta_auth_backend_user[count.index], "namespace_id")))
  groups    = lookup(var.okta_auth_backend_user[count.index], "groups")
  policies  = lookup(var.okta_auth_backend_user[count.index], "policies")
}

resource "vault_password_policy" "this" {
  count     = length(var.password_policy)
  name      = lookup(var.password_policy[count.index], "name")
  policy    = lookup(var.password_policy[count.index], "policy")
  namespace = try(element(vault_namespace.this.*.id, lookup(var.password_policy[count.index], "namespace_id")))
}

resource "vault_pki_secret_backend_cert" "this" {
  count                 = length(var.pki_secret_backend_cert)
  backend               = try(element(vault_mount.this.*.path, lookup(var.pki_secret_backend_cert[count.index], "backend_id")))
  common_name           = lookup(var.pki_secret_backend_cert[count.index], "common_name")
  name                  = lookup(var.pki_secret_backend_cert[count.index], "name")
  namespace             = try(element(vault_namespace.this.*.id, lookup(var.pki_secret_backend_cert[count.index], "namespace_id")))
  alt_names             = lookup(var.pki_secret_backend_cert[count.index], "alt_names")
  ip_sans               = lookup(var.pki_secret_backend_cert[count.index], "ip_sans")
  uri_sans              = lookup(var.pki_secret_backend_cert[count.index], "uri_sans")
  other_sans            = lookup(var.pki_secret_backend_cert[count.index], "other_sans")
  user_ids              = lookup(var.pki_secret_backend_cert[count.index], "user_ids")
  ttl                   = lookup(var.pki_secret_backend_cert[count.index], "ttl")
  format                = lookup(var.pki_secret_backend_cert[count.index], "format")
  private_key_format    = lookup(var.pki_secret_backend_cert[count.index], "private_key_format")
  exclude_cn_from_sans  = lookup(var.pki_secret_backend_cert[count.index], "exclude_cn_from_sans")
  min_seconds_remaining = lookup(var.pki_secret_backend_cert[count.index], "min_seconds_remaining")
  auto_renew            = lookup(var.pki_secret_backend_cert[count.index], "auto_renew")
  revoke                = lookup(var.pki_secret_backend_cert[count.index], "revoke")
}

resource "vault_pki_secret_backend_config_ca" "this" {
  count      = length(var.pki_secret_backend_config_ca)
  backend    = try(element(vault_mount.this.*.path, lookup(var.pki_secret_backend_config_ca[count.index], "backend_id")))
  pem_bundle = lookup(var.pki_secret_backend_config_ca[count.index], "pem_bundle")
  namespace  = try(element(vault_namespace.this.*.id, lookup(var.pki_secret_backend_config_ca[count.index], "namespace_id")))
}

resource "vault_pki_secret_backend_config_issuers" "this" {
  count                         = length(var.pki_secret_backend_config_issuers)
  backend                       = try(element(vault_mount.this.*.path, lookup(var.pki_secret_backend_config_issuers[count.index], "backend_id")))
  namespace                     = try(element(vault_namespace.this.*.id, lookup(var.pki_secret_backend_config_issuers[count.index], "namespace_id")))
  default                       = lookup(var.pki_secret_backend_config_issuers[count.index], "default")
  default_follows_latest_issuer = lookup(var.pki_secret_backend_config_issuers[count.index], "default_follows_latest_issuer")
}

resource "vault_pki_secret_backend_config_urls" "this" {
  count                   = length(var.pki_secret_backend_config_urls)
  backend                 = try(element(vault_mount.this.*.path, lookup(var.pki_secret_backend_config_urls[count.index], "backend_id")))
  namespace               = try(element(vault_namespace.this.*.id, lookup(var.pki_secret_backend_config_urls[count.index], "namespace_id")))
  issuing_certificates    = lookup(var.pki_secret_backend_config_urls[count.index], "issuing_certificates")
  crl_distribution_points = lookup(var.pki_secret_backend_config_urls[count.index], "crl_distribution_points")
  ocsp_servers            = lookup(var.pki_secret_backend_config_urls[count.index], "ocsp_servers")
}

resource "vault_pki_secret_backend_crl_config" "this" {
  count                         = length(var.pki_secret_backend_crl_config)
  backend                       = try(element(vault_mount.this.*.path, lookup(var.pki_secret_backend_crl_config[count.index], "backend_id")))
  namespace                     = try(element(vault_namespace.this.*.id, lookup(var.pki_secret_backend_crl_config[count.index], "namespace_id")))
  expiry                        = lookup(var.pki_secret_backend_crl_config[count.index], "expiry")
  disable                       = lookup(var.pki_secret_backend_crl_config[count.index], "disable")
  ocsp_disable                  = lookup(var.pki_secret_backend_crl_config[count.index], "ocsp_disable")
  ocsp_expiry                   = lookup(var.pki_secret_backend_crl_config[count.index], "ocsp_expiry")
  auto_rebuild                  = lookup(var.pki_secret_backend_crl_config[count.index], "auto_rebuild")
  auto_rebuild_grace_period     = lookup(var.pki_secret_backend_crl_config[count.index], "auto_rebuild_grace_period")
  enable_delta                  = lookup(var.pki_secret_backend_crl_config[count.index], "enable_delta")
  delta_rebuild_interval        = lookup(var.pki_secret_backend_crl_config[count.index], "delta_rebuild_interval")
  cross_cluster_revocation      = lookup(var.pki_secret_backend_crl_config[count.index], "cross_cluster_revocation")
  unified_crl                   = lookup(var.pki_secret_backend_crl_config[count.index], "unified_crl")
  unified_crl_on_existing_paths = lookup(var.pki_secret_backend_crl_config[count.index], "unified_crl_on_existing_paths")
}

resource "vault_pki_secret_backend_intermediate_cert_request" "this" {
  count                 = length(var.pki_secret_backend_intermediate_cert_request)
  backend               = try(element(vault_mount.this.*.path, lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "backend_id")))
  common_name           = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "common_name")
  type                  = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "type")
  namespace             = try(element(vault_namespace.this.*.id, lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "namespace_id")))
  alt_names             = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "alt_names")
  ip_sans               = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "ip_sans")
  uri_sans              = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "uri_sans")
  other_sans            = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "other_sans")
  format                = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "format")
  private_key_format    = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "private_key_format")
  key_bits              = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "key_bits")
  key_name              = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "key_name")
  key_ref               = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "key_ref")
  key_type              = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "key_type")
  managed_key_id        = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "managed_key_id")
  managed_key_name      = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "managed_key_name")
  ou                    = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "ou")
  organization          = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "organization")
  country               = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "country")
  locality              = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "locality")
  province              = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "province")
  street_address        = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "street_address")
  postal_code           = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "postal_code")
  add_basic_constraints = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "add_basic_constraints")
}

resource "vault_pki_secret_backend_intermediate_set_signed" "this" {
  count       = length(var.pki_secret_backend_intermediate_set_signed)
  backend     = try(element(vault_mount.this.*.path, lookup(var.pki_secret_backend_intermediate_set_signed[count.index], "backend_id")))
  certificate = try(element(vault_pki_secret_backend_root_sign_intermediate.this.*.certificate, lookup(var.pki_secret_backend_intermediate_set_signed[count.index], "certificate_id")))
  namespace   = try(element(vault_namespace.this.*.id, lookup(var.pki_secret_backend_intermediate_set_signed[count.index], "namespace_id")))
}

resource "vault_pki_secret_backend_issuer" "this" {
  count                          = length(var.pki_secret_backend_issuer)
  backend                        = try(element(vault_mount.this.*.path, lookup(var.pki_secret_backend_issuer[count.index], "backend_id")))
  issuer_ref                     = lookup(var.pki_secret_backend_issuer[count.index], "issuer_ref")
  namespace                      = try(element(vault_namespace.this.*.path, lookup(var.pki_secret_backend_issuer[count.index], "namespace_id")))
  issuer_name                    = lookup(var.pki_secret_backend_issuer[count.index], "issuer_name")
  leaf_not_after_behavior        = lookup(var.pki_secret_backend_issuer[count.index], "leaf_not_after_behavior")
  usage                          = lookup(var.pki_secret_backend_issuer[count.index], "usage")
  revocation_signature_algorithm = lookup(var.pki_secret_backend_issuer[count.index], "revocation_signature_algorithm")
  manual_chain                   = lookup(var.pki_secret_backend_issuer[count.index], "manual_chain")
  issuing_certificates           = lookup(var.pki_secret_backend_issuer[count.index], "issuing_certificates")
  crl_distribution_points        = lookup(var.pki_secret_backend_issuer[count.index], "crl_distribution_points")
  ocsp_servers                   = lookup(var.pki_secret_backend_issuer[count.index], "ocsp_servers")
  enable_aia_url_templating      = lookup(var.pki_secret_backend_issuer[count.index], "enable_aia_url_templating")
}

resource "vault_pki_secret_backend_key" "this" {
  count            = length(var.pki_secret_backend_key)
  backend          = try(element(vault_mount.this.*.path, lookup(var.pki_secret_backend_key[count.index], "backend_id")))
  type             = lookup(var.pki_secret_backend_key[count.index], "type")
  namespace        = try(element(vault_namespace.this.*.id, lookup(var.pki_secret_backend_key[count.index], "namespace_id")))
  key_name         = lookup(var.pki_secret_backend_key[count.index], "key_name")
  key_type         = lookup(var.pki_secret_backend_key[count.index], "key_type")
  key_bits         = lookup(var.pki_secret_backend_key[count.index], "key_bits")
  managed_key_name = lookup(var.pki_secret_backend_key[count.index], "managed_key_name")
  managed_key_id   = lookup(var.pki_secret_backend_key[count.index], "managed_key_id")
}

resource "vault_pki_secret_backend_role" "this" {
  count                              = length(var.pki_secret_backend_role)
  backend                            = try(element(vault_mount.this.*.path, lookup(var.pki_secret_backend_role[count.index], "backend_id")))
  name                               = lookup(var.pki_secret_backend_role[count.index], "name")
  namespace                          = try(element(vault_namespace.this.*.id, lookup(var.pki_secret_backend_role[count.index], "namespace_id")))
  allow_any_name                     = lookup(var.pki_secret_backend_role[count.index], "allow_any_name")
  allow_bare_domains                 = lookup(var.pki_secret_backend_role[count.index], "allow_bare_domains")
  allow_glob_domains                 = lookup(var.pki_secret_backend_role[count.index], "allow_glob_domains")
  allow_ip_sans                      = lookup(var.pki_secret_backend_role[count.index], "allow_ip_sans")
  allow_localhost                    = lookup(var.pki_secret_backend_role[count.index], "allow_localhost")
  allow_subdomains                   = lookup(var.pki_secret_backend_role[count.index], "allow_subdomains")
  allow_wildcard_certificates        = lookup(var.pki_secret_backend_role[count.index], "allow_wildcard_certificates")
  allowed_domains                    = lookup(var.pki_secret_backend_role[count.index], "allowed_domains")
  allowed_domains_template           = lookup(var.pki_secret_backend_role[count.index], "allowed_domains_template")
  allowed_other_sans                 = lookup(var.pki_secret_backend_role[count.index], "allowed_other_sans")
  allowed_serial_numbers             = lookup(var.pki_secret_backend_role[count.index], "allowed_serial_numbers")
  allowed_user_ids                   = lookup(var.pki_secret_backend_role[count.index], "allowed_user_ids")
  allowed_uri_sans                   = lookup(var.pki_secret_backend_role[count.index], "allowed_uri_sans")
  allowed_uri_sans_template          = lookup(var.pki_secret_backend_role[count.index], "allowed_uri_sans_template")
  basic_constraints_valid_for_non_ca = lookup(var.pki_secret_backend_role[count.index], "basic_constraints_valid_for_non_ca")
  client_flag                        = lookup(var.pki_secret_backend_role[count.index], "client_flag")
  code_signing_flag                  = lookup(var.pki_secret_backend_role[count.index], "code_signing_flag")
  country                            = lookup(var.pki_secret_backend_role[count.index], "country")
  email_protection_flag              = lookup(var.pki_secret_backend_role[count.index], "email_protection_flag")
  enforce_hostnames                  = lookup(var.pki_secret_backend_role[count.index], "enforce_hostnames")
  ext_key_usage                      = lookup(var.pki_secret_backend_role[count.index], "ext_key_usage")
  generate_lease                     = lookup(var.pki_secret_backend_role[count.index], "generate_lease")
  issuer_ref                         = lookup(var.pki_secret_backend_role[count.index], "issuer_ref")
  key_bits                           = lookup(var.pki_secret_backend_role[count.index], "key_bits")
  key_type                           = lookup(var.pki_secret_backend_role[count.index], "key_type")
  key_usage                          = lookup(var.pki_secret_backend_role[count.index], "key_usage")
  locality                           = lookup(var.pki_secret_backend_role[count.index], "locality")
  max_ttl                            = lookup(var.pki_secret_backend_role[count.index], "max_ttl")
  no_store                           = lookup(var.pki_secret_backend_role[count.index], "no_store")
  not_before_duration                = lookup(var.pki_secret_backend_role[count.index], "not_before_duration")
  organization                       = lookup(var.pki_secret_backend_role[count.index], "organization")
  ou                                 = lookup(var.pki_secret_backend_role[count.index], "ou")
  province                           = lookup(var.pki_secret_backend_role[count.index], "province")
  postal_code                        = lookup(var.pki_secret_backend_role[count.index], "postal_code")
  policy_identifiers                 = lookup(var.pki_secret_backend_role[count.index], "policy_identifiers")
  require_cn                         = lookup(var.pki_secret_backend_role[count.index], "require_cn")
  server_flag                        = lookup(var.pki_secret_backend_role[count.index], "server_flag")
  street_address                     = lookup(var.pki_secret_backend_role[count.index], "street_address")
  ttl                                = lookup(var.pki_secret_backend_role[count.index], "ttl")
  use_csr_common_name                = lookup(var.pki_secret_backend_role[count.index], "use_csr_common_name")
  use_csr_sans                       = lookup(var.pki_secret_backend_role[count.index], "use_csr_sans")

  dynamic "policy_identifier" {
    for_each = try(lookup(var.pki_secret_backend_role[count.index], "policy_identifier")) == null ? [] : ["policy_identifier"]
    content {
      oid    = lookup(policy_identifier.value, "oid")
      notice = lookup(policy_identifier.value, "notice")
      cps    = lookup(policy_identifier.value, "cps")
    }
  }
}

resource "vault_pki_secret_backend_root_cert" "this" {
  count                 = length(var.pki_secret_backend_root_cert)
  backend               = try(element(vault_mount.this.*.path, lookup(var.pki_secret_backend_root_cert[count.index], "backend_id")))
  common_name           = lookup(var.pki_secret_backend_root_cert[count.index], "common_name")
  type                  = lookup(var.pki_secret_backend_root_cert[count.index], "type")
  namespace             = try(element(vault_namespace.this.*.id, lookup(var.pki_secret_backend_root_cert[count.index], "namespace_id")))
  alt_names             = lookup(var.pki_secret_backend_root_cert[count.index], "alt_names")
  country               = lookup(var.pki_secret_backend_root_cert[count.index], "country")
  exclude_cn_from_sans  = lookup(var.pki_secret_backend_root_cert[count.index], "exclude_cn_from_sans")
  format                = lookup(var.pki_secret_backend_root_cert[count.index], "format")
  ip_sans               = lookup(var.pki_secret_backend_root_cert[count.index], "ip_sans")
  issuer_name           = lookup(var.pki_secret_backend_root_cert[count.index], "issuer_name")
  key_bits              = lookup(var.pki_secret_backend_root_cert[count.index], "key_bits")
  key_name              = lookup(var.pki_secret_backend_root_cert[count.index], "key_name")
  key_ref               = lookup(var.pki_secret_backend_root_cert[count.index], "key_ref")
  key_type              = lookup(var.pki_secret_backend_root_cert[count.index], "key_type")
  locality              = lookup(var.pki_secret_backend_root_cert[count.index], "locality")
  managed_key_id        = lookup(var.pki_secret_backend_root_cert[count.index], "managed_key_id")
  managed_key_name      = lookup(var.pki_secret_backend_root_cert[count.index], "managed_key_name")
  max_path_length       = lookup(var.pki_secret_backend_root_cert[count.index], "max_path_length")
  organization          = lookup(var.pki_secret_backend_root_cert[count.index], "organization")
  other_sans            = lookup(var.pki_secret_backend_root_cert[count.index], "other_sans")
  ou                    = lookup(var.pki_secret_backend_root_cert[count.index], "ou")
  permitted_dns_domains = lookup(var.pki_secret_backend_root_cert[count.index], "permitted_dns_domains")
  postal_code           = lookup(var.pki_secret_backend_root_cert[count.index], "postal_code")
  private_key_format    = lookup(var.pki_secret_backend_root_cert[count.index], "private_key_format")
  province              = lookup(var.pki_secret_backend_root_cert[count.index], "province")
  street_address        = lookup(var.pki_secret_backend_root_cert[count.index], "street_address")
  ttl                   = lookup(var.pki_secret_backend_root_cert[count.index], "ttl")
  uri_sans              = lookup(var.pki_secret_backend_root_cert[count.index], "uri_sans")
}

resource "vault_pki_secret_backend_root_sign_intermediate" "this" {
  count                 = length(var.pki_secret_backend_root_sign_intermediate)
  backend               = try(element(vault_mount.this.*.path, lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "backend_id")))
  common_name           = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "common_name")
  csr                   = try(element(vault_pki_secret_backend_intermediate_cert_request.this.*.csr, lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "csr_id")))
  namespace             = try(element(vault_namespace.this.*.id, lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "namespace_id")))
  alt_names             = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "alt_names")
  country               = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "country")
  exclude_cn_from_sans  = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "exclude_cn_from_sans")
  format                = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "format")
  ip_sans               = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "ip_sans")
  issuer_ref            = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "issuer_ref")
  locality              = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "locality")
  max_path_length       = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "max_path_length")
  organization          = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "organization")
  other_sans            = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "other_sans")
  ou                    = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "ou")
  permitted_dns_domains = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "permitted_dns_domains")
  postal_code           = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "postal_code")
  province              = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "province")
  revoke                = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "revoke")
  street_address        = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "street_address")
  ttl                   = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "ttl")
  uri_sans              = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "uri_sans")
  use_csr_values        = lookup(var.pki_secret_backend_root_sign_intermediate[count.index], "use_csr_values")
}

resource "vault_pki_secret_backend_intermediate_cert_request" "this" {
  count                 = length(var.pki_secret_backend_intermediate_cert_request)
  backend               = try(element(vault_mount.this.*.path, lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "backend_id")))
  common_name           = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "common_name")
  type                  = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "type")
  namespace             = try(element(vault_namespace.this.*.id, lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "namespace_id")))
  add_basic_constraints = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "add_basic_constraints")
  alt_names             = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "alt_names")
  country               = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "country")
  exclude_cn_from_sans  = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "exclude_cn_from_sans")
  format                = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "format")
  ip_sans               = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "ip_sans")
  key_bits              = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "key_bits")
  key_name              = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "key_name")
  key_ref               = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "key_ref")
  key_type              = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "key_type")
  locality              = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "locality")
  managed_key_id        = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "managed_key_id")
  managed_key_name      = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "managed_key_name")
  organization          = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "organization")
  other_sans            = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "other_sans")
  ou                    = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "ou")
  postal_code           = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "postal_code")
  private_key_format    = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "private_key_format")
  province              = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "province")
  street_address        = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "street_address")
  uri_sans              = lookup(var.pki_secret_backend_intermediate_cert_request[count.index], "uri_sans")
}

resource "vault_pki_secret_backend_sign" "this" {
  count                 = length(var.pki_secret_backend_sign)
  backend               = try(element(vault_mount.this.*.path, lookup(var.pki_secret_backend_sign[count.index], "backend_id")))
  common_name           = lookup(var.pki_secret_backend_sign[count.index], "common_name")
  csr                   = lookup(var.pki_secret_backend_sign[count.index], "csr")
  name                  = lookup(var.pki_secret_backend_sign[count.index], "name")
  namespace             = try(element(vault_namespace.this.*.id, lookup(var.pki_secret_backend_sign[count.index], "namespace_id")))
  alt_names             = lookup(var.pki_secret_backend_sign[count.index], "alt_names")
  auto_renew            = lookup(var.pki_secret_backend_sign[count.index], "auto_renew")
  exclude_cn_from_sans  = lookup(var.pki_secret_backend_sign[count.index], "exclude_cn_from_sans")
  format                = lookup(var.pki_secret_backend_sign[count.index], "format")
  ip_sans               = lookup(var.pki_secret_backend_sign[count.index], "ip_sans")
  min_seconds_remaining = lookup(var.pki_secret_backend_sign[count.index], "min_seconds_remaining")
  other_sans            = lookup(var.pki_secret_backend_sign[count.index], "other_sans")
  ttl                   = lookup(var.pki_secret_backend_sign[count.index], "ttl")
  uri_sans              = lookup(var.pki_secret_backend_sign[count.index], "uri_sans")
}

resource "vault_policy" "this" {
  count     = length(var.policy)
  name      = lookup(var.policy[count.index], "name")
  policy    = lookup(var.policy[count.index], "policy")
  namespace = try(element(vault_namespace.this.*.id, lookup(var.policy[count.index], "namespace_id")))
}

resource "vault_quota_lease_count" "this" {
  count      = length(var.quota_lease_count)
  max_leases = lookup(var.quota_lease_count[count.index], "max_leases")
  name       = lookup(var.quota_lease_count[count.index], "name")
  namespace  = try(element(vault_namespace.this.*.id, lookup(var.quota_lease_count[count.index], "namespace")))
  path       = lookup(var.quota_lease_count[count.index], "path")
  role       = lookup(var.quota_lease_count[count.index], "role")
}

resource "vault_quota_rate_limit" "this" {
  count          = length(var.quota_rate_limit)
  name           = lookup(var.quota_rate_limit[count.index], "name")
  rate           = lookup(var.quota_rate_limit[count.index], "rate")
  namespace      = try(element(vault_namespace.this.*.id, lookup(var.quota_rate_limit[count.index], "namespace_id")))
  path           = lookup(var.quota_rate_limit[count.index], "path")
  interval       = lookup(var.quota_rate_limit[count.index], "interval")
  block_interval = lookup(var.quota_rate_limit[count.index], "block_interval")
  role           = lookup(var.quota_rate_limit[count.index], "role")
}

resource "vault_rabbitmq_secret_backend" "this" {
  count                     = length(var.rabbitmq_secret_backend)
  connection_uri            = lookup(var.rabbitmq_secret_backend[count.index], "connection_uri")
  password                  = sensitive(lookup(var.rabbitmq_secret_backend[count.index], "password"))
  username                  = sensitive(lookup(var.rabbitmq_secret_backend[count.index], "username"))
  namespace                 = try(element(vault_namespace.this.*.id, lookup(var.rabbitmq_secret_backend[count.index], "namespace_id")))
  verify_connection         = lookup(var.rabbitmq_secret_backend[count.index], "verify_connection")
  password_policy           = lookup(var.rabbitmq_secret_backend[count.index], "password_policy")
  username_template         = lookup(var.rabbitmq_secret_backend[count.index], "username_template")
  path                      = lookup(var.rabbitmq_secret_backend[count.index], "path")
  disable_remount           = lookup(var.rabbitmq_secret_backend[count.index], "disable_remount")
  description               = lookup(var.rabbitmq_secret_backend[count.index], "description")
  default_lease_ttl_seconds = lookup(var.rabbitmq_secret_backend[count.index], "default_lease_ttl_seconds")
  max_lease_ttl_seconds     = lookup(var.rabbitmq_secret_backend[count.index], "max_lease_ttl_seconds")
}

resource "vault_rabbitmq_secret_backend_role" "this" {
  count     = length(var.rabbitmq_secret_backend_role)
  backend   = try(element(vault_rabbitmq_secret_backend.this.*.path, lookup(var.rabbitmq_secret_backend_role[count.index], "backend_id")))
  name      = lookup(var.rabbitmq_secret_backend_role[count.index], "name")
  namespace = try(element(vault_namespace.this.*.id, lookup(var.rabbitmq_secret_backend_role[count.index], "namespace_id")))
  tags      = lookup(var.rabbitmq_secret_backend_role[count.index], "tags")

  dynamic "vhost" {
    for_each = try(lookup(var.rabbitmq_secret_backend_role[count.index], "vhost")) == null ? [] : ["vhost"]
    content {
      configure = lookup(vhost.value, "configure")
      host      = lookup(vhost.value, "host")
      read      = lookup(vhost.value, "read")
      write     = lookup(vhost.value, "write")
    }
  }

  dynamic "vhost_topic" {
    for_each = try(lookup(var.rabbitmq_secret_backend_role[count.index], "vhost_topic")) == null ? [] : ["vhost_topic"]
    content {
      host = lookup(vhost_topic.value, "host")

      dynamic "vhost" {
        for_each = try(lookup(vhost_topic.value, "vhost")) == null ? [] : ["vhost"]
        content {
          read  = lookup(vhost.value, "read")
          topic = lookup(vhost.value, "topic")
          write = lookup(vhost.value, "write")
        }
      }
    }
  }
}

resource "vault_raft_autopilot" "this" {
  count                              = length(var.raft_autopilot)
  cleanup_dead_servers               = lookup(var.raft_autopilot[count.index], "cleanup_dead_servers")
  dead_server_last_contact_threshold = lookup(var.raft_autopilot[count.index], "dead_server_last_contact_threshold")
  disable_upgrade_migration          = lookup(var.raft_autopilot[count.index], "disable_upgrade_migration")
  last_contact_threshold             = lookup(var.raft_autopilot[count.index], "last_contact_threshold")
  max_trailing_logs                  = lookup(var.raft_autopilot[count.index], "max_trailing_logs")
  min_quorum                         = lookup(var.raft_autopilot[count.index], "min_quorum")
  namespace                          = try(element(vault_namespace.this.*.id, lookup(var.raft_autopilot[count.index], "namespace_id")))
  server_stabilization_time          = lookup(var.raft_autopilot[count.index], "server_stabilization_time")
}

resource "vault_raft_snapshot_agent_config" "this" {
  count                         = length(var.raft_snapshot_agent_config)
  interval_seconds              = lookup(var.raft_snapshot_agent_config[count.index], "interval_seconds")
  name                          = lookup(var.raft_snapshot_agent_config[count.index], "name")
  path_prefix                   = lookup(var.raft_snapshot_agent_config[count.index], "path_prefix")
  storage_type                  = lookup(var.raft_snapshot_agent_config[count.index], "storage_type")
  namespace                     = try(element(vault_namespace.this.*.id, lookup(var.raft_snapshot_agent_config[count.index], "namespace_id")))
  retain                        = lookup(var.raft_snapshot_agent_config[count.index], "retain")
  file_prefix                   = lookup(var.raft_snapshot_agent_config[count.index], "file_prefix")
  local_max_space               = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "local" ? lookup(var.raft_snapshot_agent_config[count.index], "local_max_space") : null
  aws_access_key_id             = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "aws-s3" ? sensitive(lookup(var.raft_snapshot_agent_config[count.index], "aws_access_key_id")) : null
  aws_s3_bucket                 = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "aws-s3" ? lookup(var.raft_snapshot_agent_config[count.index], "aws_s3_bucket") : null
  aws_s3_disable_tls            = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "aws-s3" ? lookup(var.raft_snapshot_agent_config[count.index], "aws_s3_disable_tls") : null
  aws_s3_enable_kms             = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "aws-s3" ? lookup(var.raft_snapshot_agent_config[count.index], "aws_s3_enable_kms") : null
  aws_s3_endpoint               = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "aws-s3" ? lookup(var.raft_snapshot_agent_config[count.index], "aws_s3_endpoint") : null
  aws_s3_force_path_style       = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "aws-s3" ? lookup(var.raft_snapshot_agent_config[count.index], "aws_s3_force_path_style") : null
  aws_s3_kms_key                = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "aws-s3" ? sensitive(lookup(var.raft_snapshot_agent_config[count.index], "aws_s3_kms_key")) : null
  aws_s3_region                 = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "aws-s3" ? lookup(var.raft_snapshot_agent_config[count.index], "aws_s3_region") : null
  aws_s3_server_side_encryption = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "aws-s3" ? lookup(var.raft_snapshot_agent_config[count.index], "aws_s3_server_side_encryption") : null
  aws_secret_access_key         = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "aws-s3" ? sensitive(lookup(var.raft_snapshot_agent_config[count.index], "aws_secret_access_key")) : null
  aws_session_token             = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "aws-s3" ? sensitive(lookup(var.raft_snapshot_agent_config[count.index], "aws_session_token")) : null
  google_disable_tls            = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "google-gcs" ? lookup(var.raft_snapshot_agent_config[count.index], "google_disable_tls") : null
  google_endpoint               = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "google-gcs" ? lookup(var.raft_snapshot_agent_config[count.index], "google_endpoint") : null
  google_gcs_bucket             = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "google-gcs" ? lookup(var.raft_snapshot_agent_config[count.index], "google_gcs_bucket") : null
  google_service_account_key    = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "google-gcs" ? sensitive(lookup(var.raft_snapshot_agent_config[count.index], "google_service_account_key")) : null
  azure_account_key             = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "azure-blob" ? sensitive(lookup(var.raft_snapshot_agent_config[count.index], "azure_account_key")) : null
  azure_account_name            = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "azure-blob" ? lookup(var.raft_snapshot_agent_config[count.index], "azure_account_name") : null
  azure_blob_environment        = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "azure-blob" ? lookup(var.raft_snapshot_agent_config[count.index], "azure_blob_environment") : null
  azure_container_name          = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "azure-blob" ? lookup(var.raft_snapshot_agent_config[count.index], "azure_container_name") : null
  azure_endpoint                = lookup(var.raft_snapshot_agent_config[count.index], "storage_type") == "azure-blob" ? lookup(var.raft_snapshot_agent_config[count.index], "azure_endpoint") : null
}

resource "vault_rgp_policy" "this" {
  count             = length(var.rgp_policy)
  enforcement_level = lookup(var.rgp_policy[count.index], "enforcement_level")
  name              = lookup(var.rgp_policy[count.index], "name")
  policy            = lookup(var.rgp_policy[count.index], "policy")
  namespace         = try(element(vault_namespace.this.*.id, lookup(var.rgp_policy[count.index], "namespace_id")))
}

resource "vault_saml_auth_backend" "this" {
  count            = length(var.saml_auth_backend)
  acs_urls         = lookup(var.saml_auth_backend[count.index], "acs_urls")
  entity_id        = lookup(var.saml_auth_backend[count.index], "entity_id")
  default_role     = lookup(var.saml_auth_backend[count.index], "default_role")
  disable_remount  = lookup(var.saml_auth_backend[count.index], "disable_remount")
  idp_cert         = lookup(var.saml_auth_backend[count.index], "idp_cert")
  idp_entity_id    = lookup(var.saml_auth_backend[count.index], "idp_entity_id")
  idp_metadata_url = lookup(var.saml_auth_backend[count.index], "idp_metadata_url")
  idp_sso_url      = lookup(var.saml_auth_backend[count.index], "idp_sso_url")
  namespace        = try(element(vault_namespace.this.*.id, lookup(var.saml_auth_backend[count.index], "namespace_id")))
  path             = lookup(var.saml_auth_backend[count.index], "path")
  verbose_logging  = lookup(var.saml_auth_backend[count.index], "verbose_logging")
}

resource "vault_saml_auth_backend_role" "this" {
  count                 = length(var.saml_auth_backend_role)
  name                  = lookup(var.saml_auth_backend_role[count.index], "name")
  path                  = try(element(vault_saml_auth_backend.this.*.path, lookup(var.saml_auth_backend_role[count.index], "path_id")))
  namespace             = try(element(vault_namespace.this.*.id, lookup(var.saml_auth_backend_role[count.index], "namespace_id")))
  bound_attributes      = lookup(var.saml_auth_backend_role[count.index], "bound_attributes")
  bound_attributes_type = lookup(var.saml_auth_backend_role[count.index], "bound_attributes_type")
  bound_subjects        = lookup(var.saml_auth_backend_role[count.index], "bound_subjects")
  bound_subjects_type   = lookup(var.saml_auth_backend_role[count.index], "bound_subjects_type")
  token_bound_cidrs     = lookup(var.saml_auth_backend_role[count.index], "token_bound_cidrs")
  groups_attribute      = lookup(var.saml_auth_backend_role[count.index], "groups_attribute")
}

resource "vault_ssh_secret_backend_ca" "this" {
  count                = length(var.ssh_secret_backend_ca)
  namespace            = try(element(vault_namespace.this.*.id, lookup(var.ssh_secret_backend_ca[count.index], "namespace_id")))
  backend              = try(element(vault_mount.this.*.path, lookup(var.ssh_secret_backend_ca[count.index], "backend_id")))
  generate_signing_key = lookup(var.ssh_secret_backend_ca[count.index], "generate_signing_key")
  public_key           = lookup(var.ssh_secret_backend_ca[count.index], "public_key")
  private_key          = lookup(var.ssh_secret_backend_ca[count.index], "private_key")
}

resource "vault_ssh_secret_backend_role" "this" {
  count                    = length(var.ssh_secret_backend_role)
  backend                  = try(element(vault_mount.this.*.path, lookup(var.ssh_secret_backend_role[count.index], "backend_id")))
  key_type                 = lookup(var.ssh_secret_backend_role[count.index], "key_type")
  name                     = lookup(var.ssh_secret_backend_role[count.index], "name")
  namespace                = try(element(vault_namespace.this.*.id, lookup(var.ssh_secret_backend_role[count.index], "namespace_id")))
  algorithm_signer         = lookup(var.ssh_secret_backend_role[count.index], "algorithm_signer")
  allow_bare_domains       = lookup(var.ssh_secret_backend_role[count.index], "allow_bare_domains")
  allow_host_certificates  = lookup(var.ssh_secret_backend_role[count.index], "allow_host_certificates")
  allow_subdomains         = lookup(var.ssh_secret_backend_role[count.index], "allow_subdomains")
  allow_user_certificates  = lookup(var.ssh_secret_backend_role[count.index], "allow_user_certificates")
  allow_user_key_ids       = lookup(var.ssh_secret_backend_role[count.index], "allow_user_key_ids")
  allowed_critical_options = lookup(var.ssh_secret_backend_role[count.index], "allowed_critical_options")
  allowed_domains          = lookup(var.ssh_secret_backend_role[count.index], "allowed_domains")
  allowed_domains_template = lookup(var.ssh_secret_backend_role[count.index], "allowed_domains_template")
  allowed_extensions       = lookup(var.ssh_secret_backend_role[count.index], "allowed_extensions")
  allowed_users            = lookup(var.ssh_secret_backend_role[count.index], "allowed_users")
  allowed_users_template   = lookup(var.ssh_secret_backend_role[count.index], "allowed_users_template")
  cidr_list                = lookup(var.ssh_secret_backend_role[count.index], "cidr_list")
  default_critical_options = lookup(var.ssh_secret_backend_role[count.index], "default_critical_options")
  default_extensions       = lookup(var.ssh_secret_backend_role[count.index], "default_extensions")
  default_user             = lookup(var.ssh_secret_backend_role[count.index], "default_user")
  default_user_template    = lookup(var.ssh_secret_backend_role[count.index], "default_user_template")
  key_id_format            = lookup(var.ssh_secret_backend_role[count.index], "key_id_format")
  max_ttl                  = lookup(var.ssh_secret_backend_role[count.index], "max_ttl")
  not_before_duration      = lookup(var.ssh_secret_backend_role[count.index], "not_before_duration")
  ttl                      = lookup(var.ssh_secret_backend_role[count.index], "ttl")

  dynamic "allowed_user_key_config" {
    for_each = try(lookup(var.ssh_secret_backend_role[count.index], "allowed_user_key_config")) == null ? [] : ["allowed_user_key_config"]
    content {
      lengths = lookup(allowed_user_key_config.value, "lengths")
      type    = lookup(allowed_user_key_config.value, "type")
    }
  }
}

resource "vault_terraform_cloud_secret_backend" "this" {
  count                     = length(var.terraform_cloud_secret_backend)
  namespace                 = try(element(vault_namespace.this.*.id, lookup(var.terraform_cloud_secret_backend[count.index], "namespace_id")))
  token                     = lookup(var.terraform_cloud_secret_backend[count.index], "token")
  backend                   = lookup(var.terraform_cloud_secret_backend[count.index], "backend")
  disable_remount           = lookup(var.terraform_cloud_secret_backend[count.index], "disable_remount")
  description               = lookup(var.terraform_cloud_secret_backend[count.index], "description")
  default_lease_ttl_seconds = lookup(var.terraform_cloud_secret_backend[count.index], "default_lease_ttl_seconds")
  max_lease_ttl_seconds     = lookup(var.terraform_cloud_secret_backend[count.index], "max_lease_ttl_seconds")
}

resource "vault_terraform_cloud_secret_creds" "this" {
  count     = length(var.terraform_cloud_secret_creds)
  backend   = try(element(vault_terraform_cloud_secret_backend.this.*.backend, lookup(var.terraform_cloud_secret_creds[count.index], "backend_id")))
  role      = lookup(var.terraform_cloud_secret_creds[count.index], "role")
  namespace = try(element(vault_namespace.this.*.id, lookup(var.terraform_cloud_secret_creds[count.index], "namespace_id")))
}

resource "vault_terraform_cloud_secret_role" "this" {
  count        = length(var.terraform_cloud_secret_role)
  name         = lookup(var.terraform_cloud_secret_role[count.index], "name")
  backend      = try(element(vault_terraform_cloud_secret_backend.this.*.backend, lookup(var.terraform_cloud_secret_role[count.index], "backend_id")))
  namespace    = try(element(vault_namespace.this.*.id, lookup(var.terraform_cloud_secret_role[count.index], "namespace_id")))
  organization = lookup(var.terraform_cloud_secret_role[count.index], "organization")
  team_id      = lookup(var.terraform_cloud_secret_role[count.index], "team_id")
  user_id      = lookup(var.terraform_cloud_secret_role[count.index], "user_id")
  max_ttl      = lookup(var.terraform_cloud_secret_role[count.index], "max_ttl")
  ttl          = lookup(var.terraform_cloud_secret_role[count.index], "ttl")
}

resource "vault_token" "this" {
  count             = length(var.token)
  namespace         = try(element(vault_namespace.this.*.id, lookup(var.token[count.index], "namespace_id")))
  role_name         = lookup(var.token[count.index], "role_name")
  policies          = lookup(var.token[count.index], "policies")
  no_default_policy = lookup(var.token[count.index], "no_default_policy")
  renewable         = lookup(var.token[count.index], "renewable")
  ttl               = lookup(var.token[count.index], "ttl")
  explicit_max_ttl  = lookup(var.token[count.index], "explicit_max_ttl")
  display_name      = lookup(var.token[count.index], "display_name")
  num_uses          = lookup(var.token[count.index], "num_uses")
  period            = lookup(var.token[count.index], "period")
  renew_min_lease   = lookup(var.token[count.index], "renew_min_lease")
  renew_increment   = lookup(var.token[count.index], "renew_increment")
  metadata          = lookup(var.token[count.index], "metadata")
}

resource "vault_token_auth_backend_role" "this" {
  count                    = length(var.token_auth_backend_role)
  role_name                = lookup(var.token_auth_backend_role[count.index], "role_name")
  namespace                = try(element(vault_namespace.this.*.id, lookup(var.token_auth_backend_role[count.index], "namespace_id")))
  allowed_entity_aliases   = lookup(var.token_auth_backend_role[count.index], "allowed_entity_aliases")
  allowed_policies         = lookup(var.token_auth_backend_role[count.index], "allowed_policies")
  allowed_policies_glob    = lookup(var.token_auth_backend_role[count.index], "allowed_policies_glob")
  disallowed_policies      = lookup(var.token_auth_backend_role[count.index], "disallowed_policies")
  disallowed_policies_glob = lookup(var.token_auth_backend_role[count.index], "disallowed_policies_glob")
  orphan                   = lookup(var.token_auth_backend_role[count.index], "orphan")
  renewable                = lookup(var.token_auth_backend_role[count.index], "renewable")
  path_suffix              = lookup(var.token_auth_backend_role[count.index], "path_suffix")
  token_bound_cidrs        = lookup(var.token_auth_backend_role[count.index], "token_bound_cidrs")
  token_explicit_max_ttl   = lookup(var.token_auth_backend_role[count.index], "token_explicit_max_ttl")
  token_max_ttl            = lookup(var.token_auth_backend_role[count.index], "token_max_ttl")
  token_no_default_policy  = lookup(var.token_auth_backend_role[count.index], "token_no_default_policy")
  token_num_uses           = lookup(var.token_auth_backend_role[count.index], "token_num_uses")
  token_period             = lookup(var.token_auth_backend_role[count.index], "token_period")
  token_policies           = lookup(var.token_auth_backend_role[count.index], "token_policies")
  token_ttl                = lookup(var.token_auth_backend_role[count.index], "token_ttl")
  token_type               = lookup(var.token_auth_backend_role[count.index], "token_type")
}

resource "vault_transform_alphabet" "this" {
  count     = length(var.transform_alphabet)
  name      = lookup(var.transform_alphabet[count.index], "name")
  path      = try(element(vault_mount.this.*.path, lookup(var.transform_alphabet[count.index], "path_id")))
  alphabet  = lookup(var.transform_alphabet[count.index], "alphabet")
  namespace = try(element(vault_namespace.this.*.id, lookup(var.transform_alphabet[count.index], "namespace_id")))
}

resource "vault_transform_role" "this" {
  count           = length(var.transform_role)
  name            = lookup(var.transform_role[count.index], "name")
  path            = try(element(vault_mount.this.*.path, lookup(var.transform_role[count.index], "path_id")))
  namespace       = try(element(vault_namespace.this.*.id, lookup(var.transform_role[count.index], "namespace_id")))
  transformations = lookup(var.transform_role[count.index], "transformations")
}

resource "vault_transform_template" "this" {
  count          = length(var.transform_template)
  name           = lookup(var.transform_template[count.index], "name")
  path           = try(element(vault_mount.this.*.path, lookup(var.transform_template[count.index], "path_id")))
  alphabet       = lookup(var.transform_template[count.index], "alphabet")
  decode_formats = lookup(var.transform_template[count.index], "decode_formats")
  encode_format  = lookup(var.transform_template[count.index], "encode_format")
  namespace      = try(element(vault_namespace.this.*.path, lookup(var.transform_template[count.index], "namespace_id")))
  pattern        = lookup(var.transform_template[count.index], "pattern")
  type           = lookup(var.transform_template[count.index], "type")
}

resource "vault_transform_transformation" "this" {
  count             = length(var.transform_transformation)
  name              = lookup(var.transform_transformation[count.index], "name")
  path              = try(element(vault_mount.this.*.path, lookup(var.transform_transformation[count.index], "path_id")))
  namespace         = try(element(vault_namespace.this.*.id, lookup(var.transform_transformation[count.index], "namespace_id")))
  allowed_roles     = lookup(var.transform_transformation[count.index], "allowed_roles")
  deletion_allowed  = lookup(var.transform_transformation[count.index], "deletion_allowed")
  masking_character = lookup(var.transform_transformation[count.index], "masking_character")
  template          = lookup(var.transform_transformation[count.index], "template")
  templates         = lookup(var.transform_transformation[count.index], "templates")
  tweak_source      = lookup(var.transform_transformation[count.index], "tweak_source")
  type              = lookup(var.transform_transformation[count.index], "type")
}

resource "vault_transit_secret_backend_key" "this" {
  count                  = length(var.transit_secret_backend_key)
  backend                = try(element(vault_mount.this.*.path, lookup(var.transit_secret_backend_key[count.index], "backend_id")))
  name                   = lookup(var.transit_secret_backend_key[count.index], "name")
  namespace              = try(element(vault_namespace.this.*.id, lookup(var.transit_secret_backend_key[count.index], "namespace_id")))
  type                   = lookup(var.transit_secret_backend_key[count.index], "type")
  deletion_allowed       = lookup(var.transit_secret_backend_key[count.index], "deletion_allowed")
  derived                = lookup(var.transit_secret_backend_key[count.index], "derived")
  convergent_encryption  = lookup(var.transit_secret_backend_key[count.index], "convergent_encryption")
  exportable             = lookup(var.transit_secret_backend_key[count.index], "exportable")
  allow_plaintext_backup = lookup(var.transit_secret_backend_key[count.index], "allow_plaintext_backup")
  min_decryption_version = lookup(var.transit_secret_backend_key[count.index], "min_decryption_version")
  min_encryption_version = lookup(var.transit_secret_backend_key[count.index], "min_encryption_version")
  auto_rotate_period     = lookup(var.transit_secret_backend_key[count.index], "auto_rotate_period")
  key_size               = lookup(var.transit_secret_backend_key[count.index], "key_size")
}

resource "vault_transit_secret_cache_config" "this" {
  count     = length(var.transit_secret_cache_config)
  backend   = try(element(vault_mount.this.*.path, lookup(var.transit_secret_cache_config[count.index], "backend_id")))
  size      = lookup(var.transit_secret_cache_config[count.index], "size")
  namespace = try(element(vault_namespace.this.*.id, lookup(var.transit_secret_cache_config[count.index], "namespace_id")))
}