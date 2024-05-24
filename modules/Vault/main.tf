resource "vault_ad_secret_backend" "this" {
  count                        = length(var.ad_secret_backend)
  binddn                       = lookup(var.ad_secret_backend[count.index], "binddn")
  bindpass                     = lookup(var.ad_secret_backend[count.index], "bindpass")
  namespace                    = lookup(var.ad_secret_backend[count.index], "namespace")
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
  namespace             = lookup(var.ad_secret_library[count.index], "namespace")
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
  namespace            = lookup(var.ad_secret_role[count.index], "namespace")
  ttl                  = lookup(var.ad_secret_role[count.index], "ttl")
}

resource "vault_alicloud_auth_backend_role" "this" {
  count     = length(var.alicloud_auth_backend_role) == "0" ? "0" : length(var.auth_backend)
  arn       = lookup(var.alicloud_auth_backend_role[count.index], "arn")
  role      = lookup(var.alicloud_auth_backend_role[count.index], "role")
  namespace = lookup(var.alicloud_auth_backend_role[count.index], "namespace")
  backend = try(
    element(vault_auth_backend.this.*.path, lookup(var.alicloud_auth_backend_role[count.index], "backend_id"))
  )
}

resource "vault_approle_auth_backend_login" "this" {
  count     = length(var.approle_auth_backend_login) == "0" ? "0" : length(var.approle_auth_backend_role)
  role_id   = try(element(vault_approle_auth_backend_role.this.*.role_id, lookup(var.approle_auth_backend_login[count.index], "role_id")))
  namespace = lookup(var.approle_auth_backend_login[count.index], "namespace")
  secret_id = try(element(vault_approle_auth_backend_role_secret_id.this.*.secret_id, lookup(var.approle_auth_backend_login[count.index], "secret_id")))
  backend   = try(element(vault_auth_backend.this.*.path, lookup(var.approle_auth_backend_login[count.index], "backend_id")))
}

resource "vault_approle_auth_backend_role" "this" {
  count                 = length(var.approle_auth_backend_role)
  role_name             = lookup(var.approle_auth_backend_role[count.index], "role_name")
  namespace             = lookup(var.approle_auth_backend_role[count.index], "namespace")
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
  namespace             = lookup(var.approle_auth_backend_role_secret_id[count.index], "namespace")
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
  namespace   = lookup(var.audit[count.index], "namespace")
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
  namespace       = lookup(var.auth_backend[count.index], "namespace")
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
  aws_public_cert = file(lookup(var.aws_auth_backend_cert[count.index], "aws_public_cert"))
  cert_name       = lookup(var.aws_auth_backend_cert[count.index], "cert_name")
  namespace       = lookup(var.aws_auth_backend_cert[count.index], "namespace")
  type            = lookup(var.aws_auth_backend_cert[count.index], "type")
  backend         = try(element(vault_auth_backend.this.*.path, lookup(var.aws_auth_backend_cert[count.index], "backend_id")))
}

resource "vault_aws_auth_backend_client" "this" {
  count                      = length(var.aws_auth_backend_client)
  namespace                  = lookup(var.aws_auth_backend_client[count.index], "namespace")
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
  namespace    = lookup(var.aws_auth_backend_config_identity[count.index], "namespace")
  iam_alias    = lookup(var.aws_auth_backend_config_identity[count.index], "iam_alias")
  iam_metadata = lookup(var.aws_auth_backend_config_identity[count.index], "iam_metadata")
  ec2_alias    = lookup(var.aws_auth_backend_config_identity[count.index], "ec2_alias")
  ec2_metadata = lookup(var.aws_auth_backend_config_identity[count.index], "ec2_metadata")
  backend      = try(element(vault_auth_backend.this.*.path, lookup(var.aws_auth_backend_config_identity[count.index], "backend_id")))
}

resource "vault_aws_auth_backend_identity_whitelist" "this" {
  count                 = length(var.aws_auth_backend_identity_whitelist)
  namespace             = lookup(var.aws_auth_backend_identity_whitelist[count.index], "namespace")
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
  namespace                 = lookup(var.aws_auth_backend_role_tag[count.index], "namespace")
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
  namespace             = lookup(var.aws_auth_backend_roletag_blacklist[count.index], "namespace")
  safety_buffer         = lookup(var.aws_auth_backend_roletag_blacklist[count.index], "safety_buffer")
  disable_periodic_tidy = lookup(var.aws_auth_backend_roletag_blacklist[count.index], "disable_periodic_tidy")
}

resource "vault_aws_auth_backend_sts_role" "this" {
  count      = length(var.aws_auth_backend_sts_role)
  account_id = lookup(var.aws_auth_backend_sts_role[count.index], "account_id")
  sts_role   = lookup(var.aws_auth_backend_sts_role[count.index], "sts_role")
  namespace  = lookup(var.aws_auth_backend_sts_role[count.index], "namespace")
  backend    = try(element(vault_auth_backend.this.*.path, lookup(var.aws_auth_backend_sts_role[count.index], "backend_id")))
}

resource "vault_aws_secret_backend" "this" {
  count                     = length(var.aws_secret_backend)
  access_key                = lookup(var.aws_secret_backend[count.index], "access_key")
  secret_key                = lookup(var.aws_secret_backend[count.index], "secret_key")
  namespace                 = lookup(var.aws_secret_backend[count.index], "namespace")
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
  namespace                = lookup(var.aws_secret_backend_role[count.index], "namespace")
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
  namespace       = lookup(var.aws_secret_backend_static_role[count.index], "namespace")
  backend         = try(element(vault_auth_backend.this.*.path, lookup(var.aws_secret_backend_static_role[count.index], "backend_id")))
}

resource "vault_azure_auth_backend_config" "this" {
  resource      = lookup(var.azure_auth_backend_config[count.index], "resource")
  tenant_id     = lookup(var.azure_auth_backend_config[count.index], "tenant_id")
  namespace     = lookup(var.azure_auth_backend_config[count.index], "namespace")
  backend       = try(element(vault_auth_backend.this.*.path, lookup(var.azure_auth_backend_config[count.index], "backend_id")))
  client_id     = sensitive(lookup(var.azure_auth_backend_config[count.index], "client_id"))
  client_secret = sensitive(lookup(var.azure_auth_backend_config[count.index], "client_secret"))
  environment   = lookup(var.azure_auth_backend_config[count.index], "environment")
}

resource "vault_azure_auth_backend_role" "this" {
  count                       = length(var.azure_auth_backend_role)
  role                        = lookup(var.azure_auth_backend_role[count.index], "role")
  backend                     = try(element(vault_auth_backend.this.*.path, lookup(var.azure_auth_backend_role[count.index], "backend_id")))
  namespace                   = lookup(var.azure_auth_backend_role[count.index], "namespace")
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
  namespace               = lookup(var.azure_secret_backend[count.index], "namespace")
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
  namespace             = lookup(var.azure_secret_backend_role[count.index], "namespace")
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
  namespace                    = lookup(var.cert_auth_backend_role[count.index], "namespace")
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
  namespace                 = lookup(var.consul_secret_backend[count.index], "namespace")
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
  namespace          = lookup(var.consul_secret_backend_role[count.index], "namespace")
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
  namespace                = lookup(var.database_secret_backend_connection[count.index], "namespace")
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
  namespace             = lookup(var.database_secret_backend_role[count.index], "namespace")
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
  namespace           = lookup(var.database_secret_backend_static_role[count.index], "namespace")
  rotation_period     = lookup(var.database_secret_backend_static_role[count.index], "rotation_period")
  rotation_schedule   = lookup(var.database_secret_backend_static_role[count.index], "rotation_schedule")
  rotation_statements = lookup(var.database_secret_backend_static_role[count.index], "rotation_statements")
  rotation_window     = lookup(var.database_secret_backend_static_role[count.index], "rotation_window")
}

resource "vault_database_secrets_mount" "this" {
  count = length(var.database_secrets_mount)
  path  = ""
}

resource "vault_egp_policy" "this" {
  count             = length(var.egp_policy)
  enforcement_level = ""
  name              = ""
  paths             = []
  policy            = ""
}

resource "vault_gcp_auth_backend" "this" {
  count = length(var.gcp_auth_backend)
}

resource "vault_gcp_auth_backend_role" "this" {
  count = length(var.gcp_auth_backend_role)
  role  = ""
  type  = ""
}

resource "vault_gcp_secret_backend" "this" {
  count = length(var.gcp_secret_backend)
}

resource "vault_gcp_secret_impersonated_account" "this" {
  count                 = length(var.gcp_secret_impersonated_account)
  backend               = ""
  impersonated_account  = ""
  service_account_email = ""
}

resource "vault_gcp_secret_roleset" "this" {
  count   = length(var.gcp_secret_roleset)
  backend = ""
  project = ""
  roleset = ""
}

resource "vault_gcp_secret_static_account" "this" {
  count                 = length(var.gcp_secret_static_account)
  backend               = ""
  service_account_email = ""
  static_account        = ""
}

resource "vault_generic_endpoint" "this" {
  count     = length(var.generic_endpoint)
  data_json = ""
  path      = ""
}

resource "vault_generic_secret" "this" {
  count     = length(var.generic_secret)
  data_json = ""
  path      = ""
}

resource "vault_github_auth_backend" "this" {
  count        = length(var.github_auth_backend)
  organization = ""
}

resource "vault_github_team" "this" {
  count = length(var.github_team)
  team  = ""
}

resource "vault_github_user" "this" {
  count = length(var.github_user)
  user  = ""
}

resource "vault_identity_entity" "this" {
  count = length(var.identity_entity)
}

resource "vault_identity_entity_alias" "this" {
  count          = length(var.identity_entity_alias)
  canonical_id   = ""
  mount_accessor = ""
  name           = ""
}

resource "vault_identity_entity_policies" "this" {
  entity_id = ""
  policies  = []
}

resource "vault_identity_group" "this" {}

resource "vault_identity_group_alias" "this" {
  canonical_id   = ""
  mount_accessor = ""
  name           = ""
}

resource "vault_identity_group_member_entity_ids" "this" {
  group_id = ""
}

resource "vault_identity_group_member_group_ids" "this" {
  group_id = ""
}

resource "vault_identity_group_policies" "this" {
  group_id = ""
  policies = []
}

resource "vault_identity_mfa_duo" "this" {
  api_hostname    = ""
  integration_key = ""
  secret_key      = ""
}

resource "vault_identity_mfa_login_enforcement" "this" {
  mfa_method_ids = []
  name           = ""
}

resource "vault_identity_mfa_okta" "this" {
  api_token = ""
  org_name  = ""
}

resource "vault_identity_mfa_pingid" "this" {
  settings_file_base64 = ""
}

resource "vault_identity_mfa_totp" "this" {
  issuer = ""
}

resource "vault_identity_oidc" "this" {}

resource "vault_identity_oidc_assignment" "this" {
  name = ""
}

resource "vault_identity_oidc_client" "this" {
  name = ""
}

resource "vault_identity_oidc_key" "this" {
  name = ""
}

resource "vault_identity_oidc_key_allowed_client_id" "this" {
  allowed_client_id = ""
  key_name          = ""
}

resource "vault_identity_oidc_provider" "this" {
  name = ""
}

resource "vault_identity_oidc_role" "this" {
  key  = ""
  name = ""
}

resource "vault_identity_oidc_scope" "this" {
  name = ""
}

resource "vault_jwt_auth_backend" "this" {}

resource "vault_jwt_auth_backend_role" "this" {
  role_name  = ""
  user_claim = ""
}

resource "vault_kmip_secret_backend" "this" {
  path = ""
}

resource "vault_kmip_secret_role" "this" {
  path  = ""
  role  = ""
  scope = ""
}

resource "vault_kmip_secret_scope" "this" {
  path  = ""
  scope = ""
}

resource "vault_kubernetes_auth_backend_config" "this" {
  kubernetes_host = ""
}

resource "vault_kubernetes_auth_backend_role" "this" {
  bound_service_account_names      = []
  bound_service_account_namespaces = []
  role_name                        = ""
}

resource "vault_kubernetes_secret_backend" "this" {
  path = ""
}

resource "vault_kubernetes_secret_backend_role" "this" {
  allowed_kubernetes_namespaces = []
  backend                       = ""
  name                          = ""
}

resource "vault_kmip_secret_scope" "this" {
  path  = ""
  scope = ""
}

resource "vault_kmip_secret_role" "this" {
  path  = ""
  role  = ""
  scope = ""
}

resource "vault_kmip_secret_backend" "this" {
  path = ""
}

resource "vault_ldap_auth_backend" "this" {
  url = ""
}

resource "vault_ldap_auth_backend_group" "this" {
  groupname = ""
}

resource "vault_ldap_auth_backend_user" "this" {
  username = ""
}

resource "vault_ldap_secret_backend" "this" {
  binddn   = ""
  bindpass = ""
}

resource "vault_ldap_secret_backend_dynamic_role" "this" {
  creation_ldif = ""
  deletion_ldif = ""
  role_name     = ""
}

resource "vault_ldap_secret_backend_library_set" "this" {
  name                  = ""
  service_account_names = []
}

resource "vault_ldap_secret_backend_static_role" "this" {
  role_name       = ""
  rotation_period = 0
  username        = ""
}

resource "vault_managed_keys" "this" {}

resource "vault_mfa_duo" "this" {
  api_hostname    = ""
  integration_key = ""
  mount_accessor  = ""
  name            = ""
  secret_key      = ""
}

resource "vault_mfa_okta" "this" {
  api_token      = ""
  mount_accessor = ""
  name           = ""
  org_name       = ""
}

resource "vault_mfa_pingid" "this" {
  mount_accessor       = ""
  name                 = ""
  settings_file_base64 = ""
}

resource "vault_mfa_totp" "this" {
  issuer = ""
  name   = ""
}

resource "vault_mongodbatlas_secret_backend" "this" {
  mount       = ""
  private_key = ""
  public_key  = ""
}

resource "vault_mongodbatlas_secret_role" "this" {
  mount = ""
  name  = ""
  roles = []
}

resource "vault_mount" "this" {
  path = ""
  type = ""
}

resource "vault_namespace" "this" {
  path = ""
}

resource "vault_nomad_secret_backend" "this" {}

resource "vault_nomad_secret_role" "this" {
  backend = ""
  role    = ""
}

resource "vault_password_policy" "this" {
  name   = ""
  policy = ""
}

resource "vault_pki_secret_backend_cert" "this" {
  backend     = ""
  common_name = ""
  name        = ""
}

resource "vault_pki_secret_backend_config_ca" "this" {
  backend    = ""
  pem_bundle = ""
}

resource "vault_pki_secret_backend_config_issuers" "this" {
  backend = ""
}

resource "vault_pki_secret_backend_config_urls" "this" {
  backend = ""
}

resource "vault_pki_secret_backend_crl_config" "this" {
  backend = ""
}

resource "vault_pki_secret_backend_intermediate_cert_request" "this" {
  backend     = ""
  common_name = ""
  type        = ""
}

resource "vault_pki_secret_backend_intermediate_set_signed" "this" {
  backend     = ""
  certificate = ""
}

resource "vault_pki_secret_backend_issuer" "this" {
  backend    = ""
  issuer_ref = ""
}

resource "vault_pki_secret_backend_key" "this" {
  backend = ""
  type    = ""
}

resource "vault_pki_secret_backend_role" "this" {
  backend = ""
  name    = ""
}

resource "vault_pki_secret_backend_root_cert" "this" {
  backend     = ""
  common_name = ""
  type        = ""
}

resource "vault_pki_secret_backend_root_sign_intermediate" "this" {
  backend     = ""
  common_name = ""
  csr         = ""
}

resource "vault_pki_secret_backend_sign" "this" {
  backend     = ""
  common_name = ""
  csr         = ""
  name        = ""
}

resource "vault_policy" "this" {
  name   = ""
  policy = ""
}

resource "vault_quota_lease_count" "this" {
  max_leases = 0
  name       = ""
}

resource "vault_quota_rate_limit" "this" {
  name = ""
  rate = 0
}

resource "vault_rabbitmq_secret_backend" "this" {
  connection_uri = ""
  password       = ""
  username       = ""
}

resource "vault_rabbitmq_secret_backend_role" "this" {
  backend = ""
  name    = ""
}

resource "vault_raft_autopilot" "this" {}

resource "vault_raft_snapshot_agent_config" "this" {
  interval_seconds = 0
  name             = ""
  path_prefix      = ""
  storage_type     = ""
}

resource "vault_rgp_policy" "this" {
  enforcement_level = ""
  name              = ""
  policy            = ""
}

resource "vault_saml_auth_backend" "this" {
  acs_urls  = []
  entity_id = ""
}

resource "vault_saml_auth_backend_role" "this" {
  name = ""
  path = ""
}

resource "vault_ssh_secret_backend_ca" "this" {}

resource "vault_ssh_secret_backend_role" "this" {
  backend  = ""
  key_type = ""
  name     = ""
}

resource "vault_terraform_cloud_secret_backend" "this" {}

resource "vault_terraform_cloud_secret_creds" "this" {
  backend = ""
  role    = ""
}

resource "vault_terraform_cloud_secret_role" "this" {
  name = ""
}

resource "vault_token" "this" {}

resource "vault_token_auth_backend_role" "this" {
  role_name = ""
}

resource "vault_transform_alphabet" "this" {
  name = ""
  path = ""
}

resource "vault_transform_role" "this" {
  name = ""
  path = ""
}

resource "vault_transform_template" "this" {
  name = ""
  path = ""
}

resource "vault_transform_transformation" "this" {
  name = ""
  path = ""
}

resource "vault_transit_secret_backend_key" "this" {
  backend = ""
  name    = ""
}

resource "vault_transit_secret_cache_config" "this" {
  backend = ""
  size    = 0
}