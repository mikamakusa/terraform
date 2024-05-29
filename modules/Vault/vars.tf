variable "ad_secret_backend" {
  type = list(object({
    id                           = number
    binddn                       = string
    bindpass                     = string
    namespace_id                 = optional(number)
    backend                      = optional(string)
    disable_remount              = optional(bool)
    anonymous_group_search       = optional(bool)
    case_sensitive_names         = optional(bool)
    certificate                  = optional(string)
    client_tls_cert              = optional(string)
    client_tls_key               = optional(string)
    default_lease_ttl_seconds    = optional(number)
    deny_null_bind               = optional(bool)
    description                  = optional(string)
    discoverdn                   = optional(bool)
    groupattr                    = optional(string)
    groupdn                      = optional(string)
    groupfilter                  = optional(string)
    insecure_tls                 = optional(bool)
    last_rotation_tolerance      = optional(number)
    local                        = optional(bool)
    max_lease_ttl_seconds        = optional(number)
    max_ttl                      = optional(number)
    password_policy              = optional(string)
    request_timeout              = optional(number)
    starttls                     = optional(bool)
    tls_max_version              = optional(string)
    tls_min_version              = optional(string)
    ttl                          = optional(number)
    use_pre111_group_cn_behavior = optional(bool)
    use_token_groups             = optional(bool)
    userattr                     = optional(string)
    userdn                       = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
backend - (Optional) The unique path this backend should be mounted at. Must not begin or end with a /. Defaults to ad.
disable_remount - (Optional) If set, opts out of mount migration on path updates. See here for more info on Mount Migration
anonymous_group_search - (Optional) Use anonymous binds when performing LDAP group searches (if true the initial credentials will still be used for the initial connection test).
binddn - (Required) Distinguished name of object to bind when performing user and group search.
bindpass - (Required) Password to use along with binddn when performing user search.
case_sensitive_names - (Optional) If set, user and group names assigned to policies within the backend will be case sensitive. Otherwise, names will be normalized to lower case.
certificate - (Optional) CA certificate to use when verifying LDAP server certificate, must be x509 PEM encoded.
client_tls_cert - (Optional) Client certificate to provide to the LDAP server, must be x509 PEM encoded.
client_tls_key - (Optional) Client certificate key to provide to the LDAP server, must be x509 PEM encoded.
default_lease_ttl_seconds - (Optional) Default lease duration for secrets in seconds.
deny_null_bind - (Optional) Denies an unauthenticated LDAP bind request if the user's password is empty; defaults to true.
description - (Optional) Human-friendly description of the mount for the Active Directory backend.
discoverdn - (Optional) Use anonymous bind to discover the bind Distinguished Name of a user.
groupattr - (Optional) LDAP attribute to follow on objects returned by in order to enumerate user group membership. Examples: cn or memberOf, etc. Defaults to cn.
groupdn - (Optional) LDAP search base to use for group membership search (eg: ou=Groups,dc=example,dc=org).
groupfilter - (Optional) Go template for querying group membership of user (optional) The template can access the following context variables: UserDN, Username. Defaults to (|(memberUid={{.Username}})(member={{.UserDN}})(uniqueMember={{.UserDN}}))
insecure_tls - (Optional) Skip LDAP server SSL Certificate verification. This is not recommended for production. Defaults to false.
last_rotation_tolerance - (Optional) The number of seconds after a Vault rotation where, if Active Directory shows a later rotation, it should be considered out-of-band
local - (Optional) Mark the secrets engine as local-only. Local engines are not replicated or removed by replication.Tolerance duration to use when checking the last rotation time.
max_lease_ttl_seconds - (Optional) Maximum possible lease duration for secrets in seconds.
max_ttl - (Optional) In seconds, the maximum password time-to-live.
password_policy - (Optional) Name of the password policy to use to generate passwords.
request_timeout - (Optional) Timeout, in seconds, for the connection when making requests against the server before returning back an error.
starttls - (Optional) Issue a StartTLS command after establishing unencrypted connection.
tls_max_version - (Optional) Maximum TLS version to use. Accepted values are tls10, tls11, tls12 or tls13. Defaults to tls12.
tls_min_version - (Optional) Minimum TLS version to use. Accepted values are tls10, tls11, tls12 or tls13. Defaults to tls12.
ttl - (Optional) In seconds, the default password time-to-live.
upndomain - (Optional) Enables userPrincipalDomain login with [username]@UPNDomain.
url - (Required) LDAP URL to connect to. Multiple URLs can be specified by concatenating them with commas; they will be tried in-order. Defaults to ldap://127.0.0.1.
use_pre111_group_cn_behavior - (Optional) In Vault 1.1.1 a fix for handling group CN values of different cases unfortunately introduced a regression that could cause previously defined groups to not be found due to a change in the resulting name. If set true, the pre-1.1.1 behavior for matching group CNs will be used. This is only needed in some upgrade scenarios for backwards compatibility. It is enabled by default if the config is upgraded but disabled by default on new configurations.
use_token_groups - (Optional) If true, use the Active Directory tokenGroups constructed attribute of the user to find the group memberships. This will find all security groups including nested ones.
userattr - (Optional) Attribute used when searching users. Defaults to cn.
userdn - (Optional) LDAP domain to use for users (eg: ou=People,dc=example,dc=org)`.
EOF
}

variable "ad_secret_library" {
  type = list(object({
    id                    = number
    backend_id            = number
    name                  = string
    service_account_names = list(string)
    namespace_id          = optional(number)
    ttl                   = optional(number)
    max_ttl               = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
backend_id - (Required) The id the AD secret backend.
name - (Required) The name to identify this set of service accounts. Must be unique within the backend.
service_account_names - (Required) Specifies the slice of service accounts mapped to this set.
ttl - (Optional) The password time-to-live in seconds. Defaults to the configuration ttl if not provided.
max_ttl - (Optional) The maximum password time-to-live in seconds. Defaults to the configuration max_ttl if not provided.
EOF
}

variable "ad_secret_role" {
  type = list(object({
    id                   = number
    backend_id           = number
    role                 = string
    service_account_name = string
    namespace_id         = optional(number)
    ttl                  = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
backend_id - (Required) The id ofthe AD secret backend.
role - (Required) The name to identify this role within the backend. Must be unique within the backend.
service_account_name - (Required) Specifies the name of the Active Directory service account mapped to this role.
ttl - (Optional) The password time-to-live in seconds. Defaults to the configuration ttl if not provided.
EOF
}

variable "alicloud_auth_backend_role" {
  type = list(object({
    id           = number
    arn          = string
    role         = string
    namespace_id = optional(number)
    backend_id   = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
role - (Required; Forces new resource) Name of the role. Must correspond with the name of the role reflected in the arn.
arn - (Required) The role's arn.
backend - (Optional; Forces new resource) Path to the mounted AliCloud auth backend. Defaults to alicloud
EOF
}

variable "approle_auth_backend_login" {
  type = list(object({
    id           = number
    role_id      = number
    namespace_id = optional(number)
    secret_id    = optional(number)
    backend_id   = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
role_id - (Required) The ID of the role to log in with.
secret_id - (Optional) The secret ID of the role to log in with. Required unless bind_secret_id is set to false on the role.
backend - The unique path of the Vault backend to log in with.
EOF
}

variable "approle_auth_backend_role" {
  type = list(object({
    id                    = number
    role_id               = string
    namespace_id          = optional(number)
    role_id               = optional(number)
    bind_secret_id        = optional(bool)
    secret_id_bound_cidrs = optional(list(string))
    secret_id_num_uses    = optional(number)
    secret_id_ttl         = optional(number)
    backend_id            = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
role_name - (Required) The name of the role.
role_id - (Optional) The RoleID of this role. If not specified, one will be auto-generated.
bind_secret_id - (Optional) Whether or not to require secret_id to be presented when logging in using this AppRole. Defaults to true.
secret_id_bound_cidrs - (Optional) If set, specifies blocks of IP addresses which can perform the login operation.
secret_id_num_uses - (Optional) The number of times any particular SecretID can be used to fetch a token from this AppRole, after which the SecretID will expire. A value of zero will allow unlimited uses.
secret_id_ttl - (Optional) The number of seconds after which any SecretID expires.
backend_id - (Optional) The id of the auth backend to configure.
EOF
}

variable "approle_auth_backend_role_secret_id" {
  type = list(object({
    id                    = number
    role_name             = number
    backend_id            = optional(number)
    namespace_id          = optional(number)
    metadata              = optional(string)
    cidr_list             = optional(list(string))
    secret_id             = optional(number)
    wrapping_ttl          = optional(string)
    with_wrapped_accessor = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
role_name - (Required) The name of the role to create the SecretID for.
backend_id - (Optional) The id of the auth backend to configure.
metadata - (Optional) A JSON-encoded string containing metadata in key-value pairs to be set on tokens issued with this SecretID.
cidr_list - (Optional) If set, specifies blocks of IP addresses which can perform the login operation using this SecretID.
secret_id - (Optional) The SecretID to be created. If set, uses "Push" mode. Defaults to Vault auto-generating SecretIDs.
wrapping_ttl - (Optional) If set, the SecretID response will be response-wrapped and available for the duration specified. Only a single unwrapping of the token is allowed.
with_wrapped_accessor - (Optional) Set to true to use the wrapped secret-id accessor as the resource ID. If false (default value), a fresh secret ID will be regenerated whenever the wrapping token is expired or invalidated through unwrapping.
EOF
}

variable "audit" {
  type = list(object({
    id           = number
    options      = map(string)
    type         = string
    namespace_id = optional(number)
    path         = optional(string)
    description  = optional(string)
    local        = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
type - (Required) Type of the audit device, such as 'file'.
path - (optional) The path to mount the audit device. This defaults to the type.
description - (Optional) Human-friendly description of the audit device.
local - (Optional) Specifies if the audit device is a local only. Local audit devices are not replicated nor (if a secondary) removed by replication.
options - (Required) Configuration options to pass to the audit device itself.
EOF
}

variable "audit_request_header" {
  type = list(object({
    id   = number
    name = string
    hmac = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
name - (Required) The name of the request header to audit.
hmac - (Optional) Whether this header's value should be HMAC'd in the audit logs.
EOF
}

variable "auth_backend" {
  type = list(object({
    id              = number
    type            = string
    namespace_id    = optional(number)
    path            = optional(string)
    disable_remount = optional(bool)
    description     = optional(string)
    local           = optional(bool)
    tune = optional(list(object({
      default_lease_ttl            = optional(string)
      max_lease_ttl                = optional(string)
      audit_non_hmac_request_keys  = optional(list(string))
      audit_non_hmac_response_keys = optional(list(string))
      listing_visibility           = optional(string)
      passthrough_request_headers  = optional(list(string))
      allowed_response_headers     = optional(list(string))
      token_type                   = optional(string)
    })), [])
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
type - (Required) The name of the auth method type.
path - (Optional) The path to mount the auth method — this defaults to the name of the type.
disable_remount - (Optional) If set, opts out of mount migration on path updates. See here for more info on Mount Migration
description - (Optional) A description of the auth method.
local - (Optional) Specifies if the auth method is local only.
tune - (Optional) Extra configuration block. Structure is documented below.

The tune block is used to tune the auth backend:
default_lease_ttl - (Optional) Specifies the default time-to-live. If set, this overrides the global default. Must be a valid duration string
max_lease_ttl - (Optional) Specifies the maximum time-to-live. If set, this overrides the global default. Must be a valid duration string
audit_non_hmac_response_keys - (Optional) Specifies the list of keys that will not be HMAC'd by audit devices in the response data object.
audit_non_hmac_request_keys - (Optional) Specifies the list of keys that will not be HMAC'd by audit devices in the request data object.
listing_visibility - (Optional) Specifies whether to show this mount in the UI-specific listing endpoint. Valid values are "unauth" or "hidden".
passthrough_request_headers - (Optional) List of headers to whitelist and pass from the request to the backend.
allowed_response_headers - (Optional) List of headers to whitelist and allowing a plugin to include them in the response.
token_type - (Optional) Specifies the type of tokens that should be returned by the mount. Valid values are "default-service", "default-batch", "service", "batch".
EOF
}

variable "aws_auth_backend_cert" {
  type = list(object({
    id              = number
    aws_public_cert = string
    cert_name       = string
    namespace_id    = optional(number)
    type            = optional(string)
    backend_id      = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
cert_name - (Required) The name of the certificate.
aws_public_cert - (Required) The Base64 encoded AWS Public key required to verify PKCS7 signature of the EC2 instance metadata. You can find this key in the AWS documentation.
type - (Optional) Either "pkcs7" or "identity", indicating the type of document which can be verified using the given certificate. Defaults to "pkcs7".
backend_id - (Optional) The id the AWS auth backend being configured was mounted at.
EOF
}

variable "aws_auth_backend_client" {
  type = list(object({
    id                         = number
    namespace_id               = optional(number)
    backend_id                 = optional(number)
    access_key                 = optional(string)
    secret_key                 = optional(string)
    ec2_endpoint               = optional(string)
    iam_endpoint               = optional(string)
    iam_server_id_header_value = optional(string)
    sts_endpoint               = optional(string)
    sts_region                 = optional(string)
    use_sts_region_from_client = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
backend_id - (Optional) The id the AWS auth backend being configured was mounted at. Defaults to aws.
access_key - (Optional) The AWS access key that Vault should use for the auth backend.
secret_key - (Optional) The AWS secret key that Vault should use for the auth backend.
ec2_endpoint - (Optional) Override the URL Vault uses when making EC2 API calls.
iam_endpoint - (Optional) Override the URL Vault uses when making IAM API calls.
sts_endpoint - (Optional) Override the URL Vault uses when making STS API calls.
sts_region - (Optional) Override the default region when making STS API calls. The sts_endpoint argument must be set when using sts_region.
use_sts_region_from_client - (Optional) Available in Vault v1.15+. If set, overrides both sts_endpoint and sts_region to instead use the region specified in the client request headers for IAM-based authentication. This can be useful when you have client requests coming from different regions and want flexibility in which regional STS API is used.
iam_server_id_header_value - (Optional) The value to require in the X-Vault-AWS-IAM-Server-ID header as part of GetCallerIdentity requests that are used in the IAM auth method.
EOF
}

variable "aws_auth_backend_config_identity" {
  type = list(object({
    id           = number
    namespace    = optional(string)
    iam_alias    = optional(string)
    iam_metadata = optional(list(string))
    ec2_alias    = optional(string)
    ec2_metadata = optional(list(string))
    backend_id   = number
  }))
  default     = []
  description = <<EOF
EOF
}

variable "aws_auth_backend_identity_whitelist" {
  type = list(object({
    id                    = number
    namespace             = optional(string)
    backend               = optional(number)
    safety_buffer         = optional(number)
    disable_periodic_tidy = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
backend_id - (Optional) The id of the AWS backend being configured.
safety_buffer - (Optional) The amount of extra time, in minutes, that must have passed beyond the roletag expiration, before it is removed from the backend storage.
disable_periodic_tidy - (Optional) If set to true, disables the periodic tidying of the identity-whitelist entries.
EOF
}

variable "aws_auth_backend_login" {
  type = list(object({
    id                      = number
    namespace               = optional(string)
    backend_id              = optional(number)
    role                    = optional(string)
    identity                = optional(string)
    signature               = optional(string)
    pkcs7                   = optional(string)
    nonce                   = optional(string)
    iam_http_request_method = optional(string)
    iam_request_url         = optional(string)
    iam_request_body        = optional(string)
    iam_request_headers     = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
backend_id - (Optional) The id of the AWS auth backend. Defaults to 'aws'.
role - (Optional) The name of the AWS auth backend role to create tokens against.
identity - (Optional) The base64-encoded EC2 instance identity document to authenticate with. Can be retrieved from the EC2 metadata server.
signature - (Optional) The base64-encoded SHA256 RSA signature of the instance identity document to authenticate with, with all newline characters removed. Can be retrieved from the EC2 metadata server.
pkcs7 - (Optional) The PKCS#7 signature of the identity document to authenticate with, with all newline characters removed. Can be retrieved from the EC2 metadata server.
nonce - (Optional) The unique nonce to be used for login requests. Can be set to a user-specified value, or will contain the server-generated value once a token is issued. EC2 instances can only acquire a single token until the whitelist is tidied again unless they keep track of this nonce.
iam_http_request_method - (Optional) The HTTP method used in the signed IAM request.
iam_request_url - (Optional) The base64-encoded HTTP URL used in the signed request.
iam_request_body - (Optional) The base64-encoded body of the signed request.
iam_request_headers - (Optional) The base64-encoded, JSON serialized representation of the GetCallerIdentity HTTP request headers.
EOF
}

variable "aws_auth_backend_role" {
  type = list(object({
    id                              = number
    role                            = string
    backend_id                      = optional(number)
    namespace                       = optional(number)
    auth_type                       = optional(string)
    allow_instance_migration        = optional(bool)
    bound_account_ids               = optional(list(string))
    bound_ami_ids                   = optional(list(string))
    bound_ec2_instance_ids          = optional(list(string))
    bound_iam_instance_profile_arns = optional(list(string))
    bound_iam_principal_arns        = optional(list(string))
    bound_iam_role_arns             = optional(list(string))
    bound_regions                   = optional(list(string))
    bound_subnet_ids                = optional(list(string))
    bound_vpc_ids                   = optional(list(string))
    inferred_aws_region             = optional(string)
    inferred_entity_type            = optional(string)
    role_tag                        = optional(string)
    resolve_aws_unique_ids          = optional(bool)
    disallow_reauthentication       = optional(bool)
    token_bound_cidrs               = optional(list(string))
    token_explicit_max_ttl          = optional(number)
    token_max_ttl                   = optional(number)
    token_no_default_policy         = optional(bool)
    token_num_uses                  = optional(number)
    token_period                    = optional(number)
    token_policies                  = optional(list(string))
    token_ttl                       = optional(number)
    token_type                      = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
role - (Required) The name of the role.
auth_type - (Optional) The auth type permitted for this role. Valid choices are ec2 and iam. Defaults to iam.
bound_ami_ids - (Optional) If set, defines a constraint on the EC2 instances that can perform the login operation that they should be using the AMI ID specified by this field. auth_type must be set to ec2 or inferred_entity_type must be set to ec2_instance to use this constraint.
bound_account_ids - (Optional) If set, defines a constraint on the EC2 instances that can perform the login operation that they should be using the account ID specified by this field. auth_type must be set to ec2 or inferred_entity_type must be set to ec2_instance to use this constraint.
bound_regions - (Optional) If set, defines a constraint on the EC2 instances that can perform the login operation that the region in their identity document must match the one specified by this field. auth_type must be set to ec2 or inferred_entity_type must be set to ec2_instance to use this constraint.
bound_vpc_ids - (Optional) If set, defines a constraint on the EC2 instances that can perform the login operation that they be associated with the VPC ID that matches the value specified by this field. auth_type must be set to ec2 or inferred_entity_type must be set to ec2_instance to use this constraint.
bound_subnet_ids - (Optional) If set, defines a constraint on the EC2 instances that can perform the login operation that they be associated with the subnet ID that matches the value specified by this field. auth_type must be set to ec2 or inferred_entity_type must be set to ec2_instance to use this constraint.
bound_iam_role_arns - (Optional) If set, defines a constraint on the EC2 instances that can perform the login operation that they must match the IAM role ARN specified by this field. auth_type must be set to ec2 or inferred_entity_type must be set to ec2_instance to use this constraint.
bound_iam_instance_profile_arns - (Optional) If set, defines a constraint on the EC2 instances that can perform the login operation that they must be associated with an IAM instance profile ARN which has a prefix that matches the value specified by this field. The value is prefix-matched as though it were a glob ending in *. auth_type must be set to ec2 or inferred_entity_type must be set to ec2_instance to use this constraint.
role_tag - (Optional) If set, enable role tags for this role. The value set for this field should be the key of the tag on the EC2 instance. auth_type must be set to ec2 or inferred_entity_type must be set to ec2_instance to use this constraint.
bound_iam_principal_arns - (Optional) If set, defines the IAM principal that must be authenticated when auth_type is set to iam. Wildcards are supported at the end of the ARN.
inferred_entity_type - (Optional) If set, instructs Vault to turn on inferencing. The only valid value is ec2_instance, which instructs Vault to infer that the role comes from an EC2 instance in an IAM instance profile. This only applies when auth_type is set to iam.
inferred_aws_region - (Optional) When inferred_entity_type is set, this is the region to search for the inferred entities. Required if inferred_entity_type is set. This only applies when auth_type is set to iam.
resolve_aws_unique_ids - (Optional, Forces new resource) Only valid when auth_type is iam. If set to true, the bound_iam_principal_arns are resolved to AWS Unique IDs for the bound principal ARN. This field is ignored when a bound_iam_principal_arn ends in a wildcard. Resolving to unique IDs more closely mimics the behavior of AWS services in that if an IAM user or role is deleted and a new one is recreated with the same name, those new users or roles won't get access to roles in Vault that were permissioned to the prior principals of the same name. Defaults to true. Once set to true, this cannot be changed to false without recreating the role.
allow_instance_migration - (Optional) If set to true, allows migration of the underlying instance where the client resides.
disallow_reauthentication - (Optional) IF set to true, only allows a single token to be granted per instance ID. This can only be set when auth_type is set to ec2.
backend_id - (Optional) id of the aws auth backend.

Common Token Arguments
These arguments are common across several Authentication Token resources since Vault 1.2.
token_ttl - (Optional) The incremental lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time.
token_max_ttl - (Optional) The maximum lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time.
token_period - (Optional) If set, indicates that the token generated using this role should never expire. The token should be renewed within the duration specified by this value. At each renewal, the token's TTL will be set to the value of this field. Specified in seconds.
token_policies - (Optional) List of policies to encode onto generated tokens. Depending on the auth method, this list may be supplemented by user/group/other values.
token_bound_cidrs - (Optional) List of CIDR blocks; if set, specifies blocks of IP addresses which can authenticate successfully, and ties the resulting token to these blocks as well.
token_explicit_max_ttl - (Optional) If set, will encode an explicit max TTL onto the token in number of seconds. This is a hard cap even if token_ttl and token_max_ttl would otherwise allow a renewal.
token_no_default_policy - (Optional) If set, the default policy will not be set on generated tokens; otherwise it will be added to the policies set in token_policies.
token_num_uses - (Optional) The maximum number of times a generated token may be used (within its lifetime); 0 means unlimited.
token_type - (Optional) The type of token that should be generated. Can be service, batch, or default to use the mount's tuned default (which unless changed will be service tokens). For token store roles, there are two additional possibilities: default-service and default-batch which specify the type to return unless the client requests a different type at generation time.
EOF
}

variable "aws_auth_backend_role_tag" {
  type = list(object({
    id                        = number
    role                      = string
    namespace                 = optional(string)
    backend_id                = optional(number)
    policies                  = optional(list(string))
    max_ttl                   = optional(string)
    instance_id               = optional(string)
    allow_instance_migration  = optional(bool)
    disallow_reauthentication = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
role - (Required) The name of the AWS auth backend role to read role tags from, with no leading or trailing /s.
backend_id - (Optional) The id of the AWS auth backend to read role tags from, with no leading or trailing /s. Defaults to "aws".
policies - (Optional) The policies to be associated with the tag. Must be a subset of the policies associated with the role.
max_ttl - (Optional) The maximum TTL of the tokens issued using this role.
instance_id - (Optional) Instance ID for which this tag is intended for. If set, the created tag can only be used by the instance with the given ID.
allow_instance_migration - (Optional) If set, allows migration of the underlying instances where the client resides. Use with caution.
disallow_reauthentication - (Optional) If set, only allows a single token to be granted per instance ID.
EOF
}

variable "aws_auth_backend_roletag_blacklist" {
  type = list(object({
    id                    = number
    backend_id            = number
    namespace             = optional(string)
    safety_buffer         = optional(number)
    disable_periodic_tidy = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
backend_id - (Required) The path the AWS auth backend being configured was mounted at.
safety_buffer - (Optional) The amount of extra time that must have passed beyond the roletag expiration, before it is removed from the backend storage. Defaults to 259,200 seconds, or 72 hours.
disable_periodic_tidy - (Optional) If set to true, disables the periodic tidying of the roletag blacklist entries. Defaults to false.
EOF
}

variable "aws_auth_backend_sts_role" {
  type = list(object({
    id         = number
    account_id = string
    sts_role   = string
    namespace  = optional(string)
    backend_id = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
account_id - (Optional) The AWS account ID to configure the STS role for.
sts_role - (Optional) The STS role to assume when verifying requests made by EC2 instances in the account specified by account_id.
backend_id - (Optional) The id the AWS auth backend being configured was mounted at. Defaults to aws.
EOF
}

variable "aws_secret_backend" {
  type = list(object({
    id                        = number
    access_key                = optional(string)
    secret_key                = optional(string)
    namespace                 = optional(string)
    region                    = optional(string)
    backend_id                = optional(number)
    disable_remount           = optional(bool)
    description               = optional(string)
    default_lease_ttl_seconds = optional(number)
    max_lease_ttl_seconds     = optional(number)
    iam_endpoint              = optional(string)
    sts_endpoint              = optional(string)
    username_template         = optional(string)
    local                     = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
access_key - (Optional) The AWS Access Key ID this backend should use to issue new credentials. Vault uses the official AWS SDK to authenticate, and thus can also use standard AWS environment credentials, shared file credentials or IAM role/ECS task credentials.
secret_key - (Optional) The AWS Secret Key this backend should use to issue new credentials. Vault uses the official AWS SDK to authenticate, and thus can also use standard AWS environment credentials, shared file credentials or IAM role/ECS task credentials.
region - (Optional) The AWS region for API calls. Defaults to us-east-1.
backend_id - (Optional) The unique path this backend should be mounted at. Must not begin or end with a /. Defaults to aws.
disable_remount - (Optional) If set, opts out of mount migration on path updates. See here for more info on Mount Migration
description - (Optional) A human-friendly description for this backend.
default_lease_ttl_seconds - (Optional) The default TTL for credentials issued by this backend.
max_lease_ttl_seconds - (Optional) The maximum TTL that can be requested for credentials issued by this backend.
iam_endpoint - (Optional) Specifies a custom HTTP IAM endpoint to use.
sts_endpoint - (Optional) Specifies a custom HTTP STS endpoint to use.
username_template - (Optional) Template describing how dynamic usernames are generated. The username template is used to generate both IAM usernames (capped at 64 characters) and STS usernames (capped at 32 characters). If no template is provided the field defaults to the template:
local - (Optional) Specifies whether the secrets mount will be marked as local. Local mounts are not replicated to performance replicas.
EOF
}

variable "aws_secret_backend_role" {
  type = list(object({
    id                       = number
    backend_id               = number
    credential_type          = string
    name                     = string
    namespace                = optional(string)
    role_arns                = optional(list(string))
    policy_arns              = optional(list(string))
    policy_document          = optional(string)
    iam_groups               = optional(list(string))
    max_sts_ttl              = optional(number)
    user_path                = optional(string)
    permissions_boundary_arn = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
backend_id - (Required) The id the AWS secret backend is mounted at, with no leading or trailing /s.
name - (Required) The name to identify this role within the backend. Must be unique within the backend.
credential_type - (Required) Specifies the type of credential to be used when retrieving credentials from the role. Must be one of iam_user, assumed_role, or federation_token.
role_arns - (Optional) Specifies the ARNs of the AWS roles this Vault role is allowed to assume. Required when credential_type is assumed_role and prohibited otherwise.
policy_arns - (Optional) Specifies a list of AWS managed policy ARNs. The behavior depends on the credential type. With iam_user, the policies will be attached to IAM users when they are requested. With assumed_role and federation_token, the policy ARNs will act as a filter on what the credentials can do, similar to policy_document. When credential_type is iam_user or federation_token, at least one of policy_document or policy_arns must be specified.
policy_document - (Optional) The IAM policy document for the role. The behavior depends on the credential type. With iam_user, the policy document will be attached to the IAM user generated and augment the permissions the IAM user has. With assumed_role and federation_token, the policy document will act as a filter on what the credentials can do, similar to policy_arns.
iam_groups (Optional) - A list of IAM group names. IAM users generated against this vault role will be added to these IAM Groups. For a credential type of assumed_role or federation_token, the policies sent to the corresponding AWS call (sts:AssumeRole or sts:GetFederation) will be the policies from each group in iam_groups combined with the policy_document and policy_arns parameters.
default_sts_ttl - (Optional) The default TTL in seconds for STS credentials. When a TTL is not specified when STS credentials are requested, and a default TTL is specified on the role, then this default TTL will be used. Valid only when credential_type is one of assumed_role or federation_token.
max_sts_ttl - (Optional) The max allowed TTL in seconds for STS credentials (credentials TTL are capped to max_sts_ttl). Valid only when credential_type is one of assumed_role or federation_token.
user_path - (Optional) The path for the user name. Valid only when credential_type is iam_user. Default is /.
permissions_boundary_arn - (Optional) The ARN of the AWS Permissions Boundary to attach to IAM users created in the role. Valid only when credential_type is iam_user. If not specified, then no permissions boundary policy will be attached.
EOF
}

variable "aws_secret_backend_static_role" {
  type = list(object({
    id              = number
    name            = string
    rotation_period = number
    username        = string
    namespace       = optional(string)
    backend_id      = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
backend_id - (Optional) The id of this backend should be mounted at.
name - (Required) The name to identify this role within the backend. Must be unique within the backend.
username - (Required) The username of the existing AWS IAM to manage password rotation for.
rotation_period - (Required) How often Vault should rotate the password of the user entry.
EOF
}

variable "azure_auth_backend_config" {
  type = list(object({
    id            = number
    resource      = string
    tenant_id     = string
    namespace     = optional(string)
    backend_id    = optional(number)
    client_id     = optional(string)
    client_secret = optional(string)
    environment   = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
tenant_id - (Required) The tenant id for the Azure Active Directory organization.
resource - (Required) The configured URL for the application registered in Azure Active Directory.
backend_id - (Optional) The id of the Azure auth backend being configured was mounted at.
client_id - (Optional) The client id for credentials to query the Azure APIs. Currently read permissions to query compute resources are required.
client_secret - (Optional) The client secret for credentials to query the Azure APIs.
environment - (Optional) The Azure cloud environment. Valid values: AzurePublicCloud, AzureUSGovernmentCloud, AzureChinaCloud, AzureGermanCloud. Defaults to AzurePublicCloud.
EOF
}

variable "azure_auth_backend_role" {
  type = list(object({
    id                          = number
    role                        = string
    backend_id                  = optional(number)
    namespace                   = optional(string)
    bound_service_principal_ids = optional(list(string))
    bound_group_ids             = optional(list(string))
    bound_locations             = optional(list(string))
    bound_resource_groups       = optional(list(string))
    bound_subscription_ids      = optional(list(string))
    bound_scale_sets            = optional(list(string))
    token_bound_cidrs           = optional(list(string))
    token_explicit_max_ttl      = optional(number)
    token_max_ttl               = optional(number)
    token_no_default_policy     = optional(bool)
    token_num_uses              = optional(number)
    token_period                = optional(number)
    token_policies              = optional(list(string))
    token_ttl                   = optional(number)
    token_type                  = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
role - (Required) The name of the role.
backend_id - (Optional) The id of the Azure auth backend being configured was mounted at.
bound_service_principal_ids - (Optional) If set, defines a constraint on the service principals that can perform the login operation that they should be possess the ids specified by this field.
bound_group_ids - (Optional) If set, defines a constraint on the groups that can perform the login operation that they should be using the group ID specified by this field.
bound_locations - (Optional) If set, defines a constraint on the virtual machines that can perform the login operation that the location in their identity document must match the one specified by this field.
bound_subscription_ids - (Optional) If set, defines a constraint on the subscriptions that can perform the login operation to ones which matches the value specified by this field.
bound_resource_groups - (Optional) If set, defines a constraint on the virtual machines that can perform the login operation that they be associated with the resource group that matches the value specified by this field.
bound_scale_sets - (Optional) If set, defines a constraint on the virtual machines that can perform the login operation that they must match the scale set specified by this field.

Common Token Arguments
These arguments are common across several Authentication Token resources since Vault 1.2.
token_ttl - (Optional) The incremental lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time.
token_max_ttl - (Optional) The maximum lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time.
token_period - (Optional) If set, indicates that the token generated using this role should never expire. The token should be renewed within the duration specified by this value. At each renewal, the token's TTL will be set to the value of this field. Specified in seconds.
token_policies - (Optional) List of policies to encode onto generated tokens. Depending on the auth method, this list may be supplemented by user/group/other values.
token_bound_cidrs - (Optional) List of CIDR blocks; if set, specifies blocks of IP addresses which can authenticate successfully, and ties the resulting token to these blocks as well.
token_explicit_max_ttl - (Optional) If set, will encode an explicit max TTL onto the token in number of seconds. This is a hard cap even if token_ttl and token_max_ttl would otherwise allow a renewal.
token_no_default_policy - (Optional) If set, the default policy will not be set on generated tokens; otherwise it will be added to the policies set in token_policies.
token_num_uses - (Optional) The maximum number of times a generated token may be used (within its lifetime); 0 means unlimited.
token_type - (Optional) The type of token that should be generated. Can be service, batch, or default to use the mount's tuned default (which unless changed will be service tokens). For token store roles, there are two additional possibilities: default-service and default-batch which specify the type to return unless the client requests a different type at generation time.
EOF
}

variable "azure_secret_backend" {
  type = list(object({
    id                      = number
    subscription_id         = string
    tenant_id               = string
    namespace               = optional(string)
    use_microsoft_graph_api = optional(bool)
    client_id               = optional(string)
    client_secret           = optional(string)
    environment             = optional(string)
    path                    = optional(string)
    disable_remount         = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
subscription_id (string: <required>) - The subscription id for the Azure Active Directory.
use_microsoft_graph_api (bool: <optional>) - Indicates whether the secrets engine should use the Microsoft Graph API. This parameter has been deprecated and will be ignored in vault-1.12+. For more information, please refer to the Vault docs
tenant_id (string: <required>) - The tenant id for the Azure Active Directory.
client_id (string:"") - The OAuth2 client id to connect to Azure.
client_secret (string:"") - The OAuth2 client secret to connect to Azure.
environment (string:"") - The Azure environment.
path (<optional>) - The path to the backend should be mounted at. Defaults to azure.
disable_remount - (Optional) If set, opts out of mount migration on path updates.
EOF
}

variable "azure_secret_backend_role" {
  type = list(object({
    id                    = number
    role                  = string
    namespace             = optional(string)
    backend               = optional(number)
    application_object_id = optional(string)
    ttl                   = optional(string)
    max_ttl               = optional(string)
    azure_groups = optional(list(object({
      group_name = string
    })), [])
    azure_roles = optional(list(object({
      scope     = string
      role_id   = optional(string)
      role_name = optional(string)
    })), [])
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
role - (Required) Name of the Azure role
backend_id - (Optional) id of the mounted Azure auth backend
azure_groups - (Optional) List of Azure groups to be assigned to the generated service principal.
azure_roles - (Optional) List of Azure roles to be assigned to the generated service principal.
application_object_id - (Optional) Application Object ID for an existing service principal that will be used instead of creating dynamic service principals. If present, azure_roles and permanently_delete will be ignored.
permanently_delete - (Optional) Indicates whether the applications and service principals created by Vault will be permanently deleted when the corresponding leases expire. Defaults to false. For Vault v1.12+.
ttl – (Optional) Specifies the default TTL for service principals generated using this role. Accepts time suffixed strings ("1h") or an integer number of seconds. Defaults to the system/engine default TTL time.
max_ttl – (Optional) Specifies the maximum TTL for service principals generated using this role. Accepts time suffixed strings ("1h") or an integer number of seconds. Defaults to the system/engine max TTL time.
EOF
}

variable "cert_auth_backend_role" {
  type = list(object({
    id                           = number
    certificate                  = string
    name                         = string
    backend_id                   = optional(number)
    namespace                    = optional(string)
    allowed_names                = optional(set(string))
    allowed_common_names         = optional(set(string))
    allowed_dns_sans             = optional(set(string))
    allowed_email_sans           = optional(set(string))
    allowed_organizational_units = optional(set(string))
    allowed_uri_sans             = optional(set(string))
    required_extensions          = optional(set(string))
    display_name                 = optional(string)
    ocsp_enabled                 = optional(bool)
    ocsp_ca_certificates         = optional(string)
    ocsp_fail_open               = optional(bool)
    ocsp_query_all_servers       = optional(bool)
    ocsp_servers_override        = optional(set(string))
    token_bound_cidrs            = optional(list(string))
    token_explicit_max_ttl       = optional(number)
    token_max_ttl                = optional(number)
    token_no_default_policy      = optional(bool)
    token_num_uses               = optional(number)
    token_period                 = optional(number)
    token_policies               = optional(list(string))
    token_ttl                    = optional(number)
    token_type                   = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
backend_id - (Optional) id of the mounted Cert auth backend
name - (Required string) Name of the role
certificate - (Required string) CA certificate used to validate client certificates
allowed_names - (Optional string) DEPRECATED: Please use the individual allowed_X_sans parameters instead. Allowed subject names for authenticated client certificates
allowed_common_names - (Optional array: []) Allowed the common names for authenticated client certificates
allowed_dns_sans - (Optional array: []) Allowed alternative dns names for authenticated client certificates
allowed_email_sans - (Optional array: []) Allowed emails for authenticated client certificates
allowed_uri_sans - (Optional array: []) Allowed URIs for authenticated client certificates
allowed_organizational_units - (Optional array: []) Allowed organization units for authenticated client certificates.
required_extensions - (Optional array: []) TLS extensions required on client certificates
display_name - (Optional string: "") The name to display on tokens issued under this role.
ocsp_enabled (Optional bool: false) - If enabled, validate certificates' revocation status using OCSP. Requires Vault version 1.13+.
ocsp_ca_certificates (Optional string: "") Any additional CA certificates needed to verify OCSP responses. Provided as base64 encoded PEM data. Requires Vault version 1.13+.
ocsp_servers_override (Optional array: []): A comma-separated list of OCSP server addresses. If unset, the OCSP server is determined from the AuthorityInformationAccess extension on the certificate being inspected. Requires Vault version 1.13+.
ocsp_fail_open (Optional bool: false) - If true and an OCSP response cannot be fetched or is of an unknown status, the login will proceed as if the certificate has not been revoked. Requires Vault version 1.13+.
ocsp_query_all_servers (Optional bool: false) - If set to true, rather than accepting the first successful OCSP response, query all servers and consider the certificate valid only if all servers agree. Requires Vault version 1.13+.

Common Token Argument :
These arguments are common across several Authentication Token resources since Vault 1.2.
token_ttl - (Optional) The incremental lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time.
token_max_ttl - (Optional) The maximum lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time.
token_period - (Optional) If set, indicates that the token generated using this role should never expire. The token should be renewed within the duration specified by this value. At each renewal, the token's TTL will be set to the value of this field. Specified in seconds.
token_policies - (Optional) List of policies to encode onto generated tokens. Depending on the auth method, this list may be supplemented by user/group/other values.
token_bound_cidrs - (Optional) List of CIDR blocks; if set, specifies blocks of IP addresses which can authenticate successfully, and ties the resulting token to these blocks as well.
token_explicit_max_ttl - (Optional) If set, will encode an explicit max TTL onto the token in number of seconds. This is a hard cap even if token_ttl and token_max_ttl would otherwise allow a renewal.
token_no_default_policy - (Optional) If set, the default policy will not be set on generated tokens; otherwise it will be added to the policies set in token_policies.
token_num_uses - (Optional) The maximum number of times a generated token may be used (within its lifetime); 0 means unlimited.
token_type - (Optional) The type of token that should be generated. Can be service, batch, or default to use the mount's tuned default (which unless changed will be service tokens). For token store roles, there are two additional possibilities: default-service and default-batch which specify the type to return unless the client requests a different type at generation time.
EOF
}

variable "consul_secret_backend" {
  type = list(object({
    id                        = number
    address                   = string
    namespace                 = optional(string)
    token                     = optional(string)
    bootstrap                 = optional(bool)
    path                      = optional(string)
    disable_remount           = optional(bool)
    description               = optional(string)
    scheme                    = optional(string)
    ca_cert                   = optional(string)
    client_cert               = optional(string)
    client_key                = optional(string)
    default_lease_ttl_seconds = optional(number)
    max_lease_ttl_seconds     = optional(number)
    local                     = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
token - (Optional) The Consul management token this backend should use to issue new tokens. This field is required when bootstrap is false.
bootstrap - (Optional) Denotes that the resource is used to bootstrap the Consul ACL system.
path - (Optional) The unique location this backend should be mounted at. Must not begin or end with a /. Defaults to consul.
disable_remount - (Optional) If set, opts out of mount migration on path updates. See here for more info on Mount Migration
description - (Optional) A human-friendly description for this backend.
address - (Required) Specifies the address of the Consul instance, provided as "host:port" like "127.0.0.1:8500".
scheme - (Optional) Specifies the URL scheme to use. Defaults to http.
ca_cert - (Optional) CA certificate to use when verifying Consul server certificate, must be x509 PEM encoded.
client_cert - (Optional) Client certificate used for Consul's TLS communication, must be x509 PEM encoded and if this is set you need to also set client_key.
client_key - (Optional) Client key used for Consul's TLS communication, must be x509 PEM encoded and if this is set you need to also set client_cert.
default_lease_ttl_seconds - (Optional) The default TTL for credentials issued by this backend.
max_lease_ttl_seconds - (Optional) The maximum TTL that can be requested for credentials issued by this backend.
local - (Optional) Specifies if the secret backend is local only.
EOF
}

variable "consul_secret_backend_role" {
  type = list(object({
    id                 = number
    name               = string
    namespace          = optional(string)
    backend_id         = optional(number)
    policies           = optional(list(string))
    consul_policies    = optional(list(string))
    consul_namespace   = optional(string)
    consul_roles       = optional(list(string))
    service_identities = optional(list(string))
    node_identities    = optional(list(string))
    partition          = optional(string)
    max_ttl            = optional(number)
    ttl                = optional(number)
    local              = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
backend_id - (Optional) The id of an existing Consul secrets backend mount.
name - (Required) The name of the Consul secrets engine role to create.
policies - (Optional) The list of Consul ACL policies to associate with these roles. NOTE: The new parameter consul_policies should be used in favor of this. This parameter, policies, remains supported for legacy users, but Vault has deprecated this field.
consul_policies - (Optional)SEE NOTE The list of Consul ACL policies to associate with these roles.
consul_roles - (Optional)SEE NOTE Set of Consul roles to attach to the token. Applicable for Vault 1.10+ with Consul 1.5+.
service_identities - (Optional)SEE NOTE Set of Consul service identities to attach to the token. Applicable for Vault 1.11+ with Consul 1.5+.
node_identities - (Optional)SEE NOTE Set of Consul node identities to attach to the token. Applicable for Vault 1.11+ with Consul 1.8+.
consul_namespace - (Optional) The Consul namespace that the token will be created in. Applicable for Vault 1.10+ and Consul 1.7+".
partition - (Optional) The admin partition that the token will be created in. Applicable for Vault 1.10+ and Consul 1.11+".
max_ttl - (Optional) Maximum TTL for leases associated with this role, in seconds.
ttl - (Optional) Specifies the TTL for this role.
local - (Optional) Indicates that the token should not be replicated globally and instead be local to the current datacenter.
EOF
}

variable "database_secret_backend_connection" {
  type = list(object({
    id                       = number
    backend_id               = number
    name                     = string
    namespace                = optional(string)
    plugin_name              = optional(string)
    verify_connection        = optional(bool)
    allowed_roles            = optional(list(string))
    root_rotation_statements = optional(list(string))
    data                     = optional(map(string))
    cassandra = optional(list(object({
      hosts            = optional(list(string))
      username         = optional(string)
      password         = optional(string)
      port             = optional(number)
      tls              = optional(bool)
      insecure_tls     = optional(bool)
      pem_bundle       = optional(string)
      pem_json         = optional(string)
      protocol_version = optional(number)
      connect_timeout  = optional(number)
    })), [])
    couchbase = optional(list(object({
      hosts             = optional(list(string))
      password          = optional(string)
      username          = optional(string)
      tls               = optional(bool)
      insecure_tls      = optional(bool)
      base64_pem        = optional(string)
      bucket_name       = optional(string)
      username_template = optional(string)
    })), [])
    elasticsearch = optional(list(object({
      password          = string
      url               = string
      username          = string
      tls_server_name   = optional(string)
      ca_cert           = optional(string)
      ca_path           = optional(string)
      client_cert       = optional(string)
      client_key        = optional(string)
      insecure          = optional(bool)
      username_template = optional(string)
    })), [])
    hana = optional(list(object({
      connection_url          = optional(string)
      max_connection_lifetime = optional(number)
      max_idle_connections    = optional(number)
      max_open_connections    = optional(number)
      username                = optional(string)
      password                = optional(string)
      disable_escaping        = optional(bool)
    })), [])
    influxdb = optional(list(object({
      host              = string
      password          = string
      username          = string
      tls               = optional(bool)
      insecure_tls      = optional(bool)
      pem_bundle        = optional(string)
      pem_json          = optional(string)
      username_template = optional(string)
      connect_timeout   = optional(number)
    })), [])
    mongodb = optional(list(object({
      connection_url    = optional(string)
      username          = optional(string)
      username_template = optional(string)
      password          = optional(string)
    })), [])
    mongodbatlas = optional(list(object({
      private_key = string
      project_id  = string
      public_key  = string
    })), [])
    mssql = optional(list(object({
      connection_url          = optional(string)
      max_connection_lifetime = optional(number)
      max_idle_connections    = optional(number)
      max_open_connections    = optional(number)
      username_template       = optional(string)
      username                = optional(string)
      password                = optional(string)
      disable_escaping        = optional(bool)
      contained_db            = optional(bool)
    })), [])
    mysql = optional(list(object({
      connection_url          = optional(string)
      max_connection_lifetime = optional(number)
      max_idle_connections    = optional(number)
      max_open_connections    = optional(number)
      username                = optional(string)
      password                = optional(string)
      auth_type               = optional(string)
      service_account_json    = optional(string)
      tls_certificate_key     = optional(string)
      tls_ca                  = optional(string)
      username_template       = optional(string)
    })), [])
    postgresql = optional(list(object({
      connection_url          = optional(string)
      max_connection_lifetime = optional(number)
      max_idle_connections    = optional(number)
      max_open_connections    = optional(number)
      username                = optional(string)
      password                = optional(string)
      auth_type               = optional(string)
      service_account_json    = optional(string)
      username_template       = optional(string)
    })), [])
    oracle = optional(list(object({
      connection_url          = optional(string)
      max_connection_lifetime = optional(number)
      max_idle_connections    = optional(number)
      max_open_connections    = optional(number)
      username                = optional(string)
      password                = optional(string)
      username_template       = optional(string)
    })), [])
    snowflake = optional(list(object({
      connection_url          = optional(string)
      max_connection_lifetime = optional(number)
      max_idle_connections    = optional(number)
      max_open_connections    = optional(number)
      username                = optional(string)
      password                = optional(string)
      username_template       = optional(string)
    })), [])
    redis = optional(list(object({
      host         = string
      password     = string
      username     = string
      tls          = optional(bool)
      insecure_tls = optional(bool)
      ca_cert      = optional(string)
    })), [])
    redis_elasticache = optional(list(object({
      url      = optional(string)
      username = optional(string)
      password = optional(string)
      region   = optional(string)
    })), [])
    redshift = optional(list(object({
      connection_url          = optional(string)
      max_connection_lifetime = optional(number)
      max_idle_connections    = optional(number)
      max_open_connections    = optional(number)
      username                = optional(string)
      password                = optional(string)
      username_template       = optional(string)
      disable_escaping        = optional(bool)
    })), [])
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
name - (Required) A unique name to give the database connection.
backend_id - (Required) The id of the Vault mount to configure.
plugin_name - (Optional) Specifies the name of the plugin to use.
verify_connection - (Optional) Whether the connection should be verified on initial configuration or not.
allowed_roles - (Optional) A list of roles that are allowed to use this connection.
root_rotation_statements - (Optional) A list of database statements to be executed to rotate the root user's credentials.
data - (Optional) A map of sensitive data to pass to the endpoint. Useful for templated connection strings.
cassandra - (Optional) A nested block containing configuration options for Cassandra connections.
couchbase - (Optional) A nested block containing configuration options for Couchbase connections.
mongodb - (Optional) A nested block containing configuration options for MongoDB connections.
mongodbatlas - (Optional) A nested block containing configuration options for MongoDB Atlas connections.
hana - (Optional) A nested block containing configuration options for SAP HanaDB connections.
mssql - (Optional) A nested block containing configuration options for MSSQL connections.
mysql - (Optional) A nested block containing configuration options for MySQL connections.
postgresql - (Optional) A nested block containing configuration options for PostgreSQL connections.
oracle - (Optional) A nested block containing configuration options for Oracle connections.
elasticsearch - (Optional) A nested block containing configuration options for Elasticsearch connections.
snowflake - (Optional) A nested block containing configuration options for Snowflake connections.
influxdb - (Optional) A nested block containing configuration options for InfluxDB connections.
redis - (Optional) A nested block containing configuration options for Redis connections.
redis_elasticache - (Optional) A nested block containing configuration options for Redis ElastiCache connections.
Exactly one of the nested blocks of configuration options must be supplied.

Cassandra Configuration Options
hosts - (Required) The hosts to connect to.
username - (Required) The username to authenticate with.
password - (Required) The password to authenticate with.
port - (Optional) The default port to connect to if no port is specified as part of the host.
tls - (Optional) Whether to use TLS when connecting to Cassandra.
insecure_tls - (Optional) Whether to skip verification of the server certificate when using TLS.
pem_bundle - (Optional) Concatenated PEM blocks configuring the certificate chain.
pem_json - (Optional) A JSON structure configuring the certificate chain.
protocol_version - (Optional) The CQL protocol version to use.
connect_timeout - (Optional) The number of seconds to use as a connection timeout.

Couchbase Configuration Options
hosts - (Required) A set of Couchbase URIs to connect to. Must use couchbases:// scheme if tls is true.
username - (Required) Specifies the username for Vault to use.
password - (Required) Specifies the password corresponding to the given username.
tls - (Optional) Whether to use TLS when connecting to Couchbase.
insecure_tls - (Optional) Whether to skip verification of the server certificate when using TLS.
base64_pem - (Optional) Required if tls is true. Specifies the certificate authority of the Couchbase server, as a PEM certificate that has been base64 encoded.
bucket_name - (Optional) Required for Couchbase versions prior to 6.5.0. This is only used to verify vault's connection to the server.
username_template - (Optional) Template describing how dynamic usernames are generated.

InfluxDB Configuration Options
host - (Required) The host to connect to.
username - (Required) The username to authenticate with.
password - (Required) The password to authenticate with.
port - (Optional) The default port to connect to if no port is specified as part of the host.
tls - (Optional) Whether to use TLS when connecting to Cassandra.
insecure_tls - (Optional) Whether to skip verification of the server certificate when using TLS.
pem_bundle - (Optional) Concatenated PEM blocks configuring the certificate chain.
pem_json - (Optional) A JSON structure configuring the certificate chain.
username_template - (Optional) Template describing how dynamic usernames are generated.
connect_timeout - (Optional) The number of seconds to use as a connection timeout.

Redis Configuration Options
host - (Required) The host to connect to.
username - (Required) The username to authenticate with.
password - (Required) The password to authenticate with.
port - (Required) The default port to connect to if no port is specified as part of the host.
tls - (Optional) Whether to use TLS when connecting to Redis.
insecure_tls - (Optional) Whether to skip verification of the server certificate when using TLS.
ca_cert - (Optional) The contents of a PEM-encoded CA cert file to use to verify the Redis server's identity.

Redis ElastiCache Configuration Options
url - (Required) The url to connect to including the port; e.g. master.my-cluster.xxxxxx.use1.cache.amazonaws.com:6379.
username - (Optional) The AWS access key id to authenticate with. If omitted Vault tries to infer from the credential provider chain instead.
password - (Optional) The AWS secret access key to authenticate with. If omitted Vault tries to infer from the credential provider chain instead.
region - (Optional) The region where the ElastiCache cluster is hosted. If omitted Vault tries to infer from the environment instead.

MongoDB Configuration Options
connection_url - (Required) A URL containing connection information. See the Vault docs for an example.
username - (Optional) The root credential username used in the connection URL.
password - (Optional) The root credential password used in the connection URL.
username_template - (Optional) For Vault v1.7+. The template to use for username generation. See the Vault docs

MongoDB Atlas Configuration Options
public_key - (Required) The Public Programmatic API Key used to authenticate with the MongoDB Atlas API.
private_key - (Required) The Private Programmatic API Key used to connect with MongoDB Atlas API.
project_id - (Required) The Project ID the Database User should be created within.

SAP HanaDB Configuration Options
connection_url - (Required) A URL containing connection information. See the Vault docs for an example.
max_open_connections - (Optional) The maximum number of open connections to use.
max_idle_connections - (Optional) The maximum number of idle connections to maintain.
max_connection_lifetime - (Optional) The maximum number of seconds to keep a connection alive for.
username - (Optional) The root credential username used in the connection URL.
password - (Optional) The root credential password used in the connection URL.
disable_escaping - (Optional) Disable special character escaping in username and password.

MSSQL Configuration Options
connection_url - (Required) A URL containing connection information. See the Vault docs for an example.
max_open_connections - (Optional) The maximum number of open connections to use.
max_idle_connections - (Optional) The maximum number of idle connections to maintain.
max_connection_lifetime - (Optional) The maximum number of seconds to keep a connection alive for.
username_template - (Optional) For Vault v1.7+. The template to use for username generation. See the Vault docs
username - (Optional) The root credential username used in the connection URL.
password - (Optional) The root credential password used in the connection URL.
disable_escaping - (Optional) Disable special character escaping in username and password.
contained_db - (Optional bool: false) For Vault v1.9+. Set to true when the target is a Contained Database, e.g. AzureSQL. See the Vault docs

MySQL Configuration Options
connection_url - (Required) A URL containing connection information. See the Vault docs for an example.
max_open_connections - (Optional) The maximum number of open connections to use.
max_idle_connections - (Optional) The maximum number of idle connections to maintain.
max_connection_lifetime - (Optional) The maximum number of seconds to keep a connection alive for.
username - (Optional) The root credential username used in the connection URL.
password - (Optional) The root credential password used in the connection URL.
auth_type - (Optional) Enable IAM authentication to a Google Cloud instance when set to gcp_iam
service_account_json - (Optional) JSON encoding of an IAM access key. Requires auth_type to be gcp_iam.
tls_certificate_key - (Optional) x509 certificate for connecting to the database. This must be a PEM encoded version of the private key and the certificate combined.
tls_ca - (Optional) x509 CA file for validating the certificate presented by the MySQL server. Must be PEM encoded.
username_template - (Optional) For Vault v1.7+. The template to use for username generation. See the Vault docs

PostgreSQL Configuration Options
connection_url - (Required) A URL containing connection information. See the Vault docs for an example.
max_open_connections - (Optional) The maximum number of open connections to use.
max_idle_connections - (Optional) The maximum number of idle connections to maintain.
max_connection_lifetime - (Optional) The maximum number of seconds to keep a connection alive for.
username - (Optional) The root credential username used in the connection URL.
password - (Optional) The root credential password used in the connection URL.
auth_type - (Optional) Enable IAM authentication to a Google Cloud instance when set to gcp_iam
service_account_json - (Optional) JSON encoding of an IAM access key. Requires auth_type to be gcp_iam.
disable_escaping - (Optional) Disable special character escaping in username and password.
username_template - (Optional) For Vault v1.7+. The template to use for username generation. See the Vault docs

Oracle Configuration Options
connection_url - (Required) A URL containing connection information. See the Vault docs for an example.
max_open_connections - (Optional) The maximum number of open connections to use.
max_idle_connections - (Optional) The maximum number of idle connections to maintain.
username - (Optional) The root credential username used in the connection URL.
password - (Optional) The root credential password used in the connection URL.
max_connection_lifetime - (Optional) The maximum number of seconds to keep a connection alive for.
username_template - (Optional) For Vault v1.7+. The template to use for username generation. See the Vault docs
split_statements - (Optional) Enable spliting statements after semi-colons.
disconnect_sessions - (Optional) Enable the built-in session disconnect mechanism.

Elasticsearch Configuration Options
url - (Required) The URL for Elasticsearch's API. https requires certificate by trusted CA if used.
username - (Required) The username to be used in the connection.
password - (Required) The password to be used in the connection.
ca_cert - (Optional) The path to a PEM-encoded CA cert file to use to verify the Elasticsearch server's identity.
ca_path - (Optional) The path to a directory of PEM-encoded CA cert files to use to verify the Elasticsearch server's identity.
client_cert - (Optional) The path to the certificate for the Elasticsearch client to present for communication.
client_key - (Optional) The path to the key for the Elasticsearch client to use for communication.
tls_server_name - (Optional) This, if set, is used to set the SNI host when connecting via TLS.
insecure - (Optional) Whether to disable certificate verification.
username_template - (Optional) For Vault v1.7+. The template to use for username generation. See Vault docs for more details.

Snowflake Configuration Options
connection_url - (Required) A URL containing connection information. See the Vault docs for an example.
max_open_connections - (Optional) The maximum number of open connections to use.
max_idle_connections - (Optional) The maximum number of idle connections to maintain.
max_connection_lifetime - (Optional) The maximum number of seconds to keep a connection alive for.
username - (Optional) The username to be used in the connection (the account admin level).
password - (Optional) The password to be used in the connection.
username_template - (Optional) - Template describing how dynamic usernames are generated.

Redshift Configuration Options
connection_url - (Required) Specifies the Redshift DSN. See the Vault docs for an example.
max_open_connections - (Optional) The maximum number of open connections to the database.
max_idle_connections - (Optional) The maximum number of idle connections to the database.
max_connection_lifetime - (Optional) The maximum amount of time a connection may be reused.
username - (Optional) The root credential username used in the connection URL.
password - (Optional) The root credential password used in the connection URL.
disable_escaping - (Optional) Disable special character escaping in username and password.
username_template - (Optional) - Template describing how dynamic usernames are generated.
EOF
}

variable "database_secret_backend_role" {
  type = list(object({
    id                    = number
    backend_id            = number
    creation_statements   = list(string)
    db_name               = string
    name                  = string
    namespace             = optional(string)
    credential_config     = optional(map(string))
    credential_type       = optional(string)
    revocation_statements = optional(list(string))
    renew_statements      = optional(list(string))
    rollback_statements   = optional(list(string))
    default_ttl           = optional(number)
    max_ttl               = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
name - (Required) A unique name to give the role.
backend_id - (Required) The id of the Vault mount to configure.
db_name - (Required) The unique name of the database connection to use for the role.
creation_statements - (Required) The database statements to execute when creating a user.
revocation_statements - (Optional) The database statements to execute when revoking a user.
rollback_statements - (Optional) The database statements to execute when rolling back creation due to an error.
renew_statements - (Optional) The database statements to execute when renewing a user.
default_ttl - (Optional) The default number of seconds for leases for this role.
max_ttl - (Optional) The maximum number of seconds for leases for this role.
credential_type (Optional) – Specifies the type of credential that will be generated for the role. Options include: password, rsa_private_key, client_certificate. See the plugin's API page for credential types supported by individual databases.
credential_config (Optional) – Specifies the configuration for the given credential_type.

The following options are available for each credential_type value:
password
password_policy (Optional) - The policy used for password generation. If not provided, defaults to the password policy of the database configuration.
rsa_private_key
key_bits (Optional) - The bit size of the RSA key to generate. Options include: 2048, 3072, 4096.
format (Optional) - The output format of the generated private key credential. The private key will be returned from the API in PEM encoding. Options include: pkcs8.

client_certificate
common_name_template (Optional) - A username template to be used for the client certificate common name.
ca_cert (Optional) - The PEM-encoded CA certificate.
ca_private_key (Optional) - The PEM-encoded private key for the given ca_cert.
key_type (Required) - Specifies the desired key type. Options include: rsa, ed25519, ec.
key_bits (Optional) - Number of bits to use for the generated keys. Options include: 2048 (default), 3072, 4096; with key_type=ec, allowed values are: 224, 256 (default), 384, 521; ignored with key_type=ed25519.
signature_bits (Optional) - The number of bits to use in the signature algorithm. Options include: 256 (default), 384, 512.
EOF
}

variable "database_secret_backend_static_role" {
  type = list(object({
    id                  = number
    backend_id          = number
    db_name             = string
    name                = string
    username            = string
    namespace           = optional(string)
    rotation_period     = optional(number)
    rotation_schedule   = optional(string)
    rotation_statements = optional(list(string))
    rotation_window     = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
name - (Required) A unique name to give the static role.
backend_id - (Required) The id of the Vault mount to configure.
db_name - (Required) The unique name of the database connection to use for the static role.
username - (Required) The database username that this static role corresponds to.
rotation_period - The amount of time Vault should wait before rotating the password, in seconds. Mutually exclusive with rotation_schedule.
rotation_schedule - A cron-style string that will define the schedule on which rotations should occur. Mutually exclusive with rotation_period.
rotation_window - (Optional) The amount of time, in seconds, in which rotations are allowed to occur starting from a given rotation_schedule.
rotation_statements - (Optional) Database statements to execute to rotate the password for the configured database user.
EOF
}

variable "database_secrets_mount" {
  type = list(object({
    id                           = number
    path                         = string
    description                  = optional(string)
    default_lease_ttl_seconds    = optional(number)
    max_lease_ttl_seconds        = optional(number)
    audit_non_hmac_request_keys  = optional(list(string))
    audit_non_hmac_response_keys = optional(list(string))
    local                        = optional(bool)
    options                      = optional(map(string))
    seal_wrap                    = optional(bool)
    external_entropy_access      = optional(bool)
    allowed_managed_keys         = optional(list(string))
    namespace_id                 = optional(number)
    cassandra = optional(list(object({
      name             = string
      username         = optional(string)
      password         = optional(string)
      port             = optional(number)
      tls              = optional(bool)
      insecure_tls     = optional(bool)
      pem_bundle       = optional(string)
      pem_json         = optional(string)
      protocol_version = optional(number)
      connect_timeout  = optional(number)
    })), [])
    couchbase = optional(list(object({
      hosts             = list(string)
      name              = string
      password          = string
      username          = string
      tls               = optional(bool)
      insecure_tls      = optional(bool)
      base64_pem        = optional(string)
      bucket_name       = optional(string)
      username_template = optional(string)
    })), [])
    elasticsearch = optional(list(object({
      name              = string
      password          = string
      url               = string
      username          = string
      tls_server_name   = optional(string)
      ca_cert           = optional(string)
      ca_path           = optional(string)
      client_cert       = optional(string)
      client_key        = optional(string)
      insecure          = optional(bool)
      username_template = optional(string)
    })), [])
    hana = optional(list(object({
      name                    = string
      connection_url          = optional(string)
      max_connection_lifetime = optional(number)
      max_idle_connections    = optional(number)
      max_open_connections    = optional(number)
      username                = optional(string)
      password                = optional(string)
      disable_escaping        = optional(bool)
    })), [])
    influxdb = optional(list(object({
      name              = string
      host              = string
      password          = string
      username          = string
      tls               = optional(bool)
      insecure_tls      = optional(bool)
      pem_bundle        = optional(string)
      pem_json          = optional(string)
      username_template = optional(string)
      connect_timeout   = optional(number)
    })), [])
    mongodb = optional(list(object({
      name              = string
      connection_url    = optional(string)
      username          = optional(string)
      username_template = optional(string)
      password          = optional(string)
    })), [])
    mongodbatlas = optional(list(object({
      private_key = string
      project_id  = string
      public_key  = string
    })), [])
    mssql = optional(list(object({
      name                    = string
      connection_url          = optional(string)
      max_connection_lifetime = optional(number)
      max_idle_connections    = optional(number)
      max_open_connections    = optional(number)
      username_template       = optional(string)
      username                = optional(string)
      password                = optional(string)
      disable_escaping        = optional(bool)
      contained_db            = optional(bool)
    })), [])
    mysql = optional(list(object({
      name                    = string
      connection_url          = optional(string)
      max_connection_lifetime = optional(number)
      max_idle_connections    = optional(number)
      max_open_connections    = optional(number)
      username                = optional(string)
      password                = optional(string)
      auth_type               = optional(string)
      service_account_json    = optional(string)
      tls_certificate_key     = optional(string)
      tls_ca                  = optional(string)
      username_template       = optional(string)
    })), [])
    postgresql = optional(list(object({
      name                    = string
      connection_url          = optional(string)
      max_connection_lifetime = optional(number)
      max_idle_connections    = optional(number)
      max_open_connections    = optional(number)
      username                = optional(string)
      password                = optional(string)
      auth_type               = optional(string)
      service_account_json    = optional(string)
      username_template       = optional(string)
    })), [])
    oracle = optional(list(object({
      name                    = string
      connection_url          = optional(string)
      max_connection_lifetime = optional(number)
      max_idle_connections    = optional(number)
      max_open_connections    = optional(number)
      username                = optional(string)
      password                = optional(string)
      username_template       = optional(string)
    })), [])
    snowflake = optional(list(object({
      name                    = string
      connection_url          = optional(string)
      max_connection_lifetime = optional(number)
      max_idle_connections    = optional(number)
      max_open_connections    = optional(number)
      username                = optional(string)
      password                = optional(string)
      username_template       = optional(string)
    })), [])
    redis = optional(list(object({
      name         = string
      host         = string
      password     = string
      username     = string
      tls          = optional(bool)
      insecure_tls = optional(bool)
      ca_cert      = optional(string)
    })), [])
    redis_elasticache = optional(list(object({
      name     = string
      url      = string
      username = optional(string)
      password = optional(string)
      region   = optional(string)
    })), [])
    redshift = optional(list(object({
      name                    = string
      connection_url          = optional(string)
      max_connection_lifetime = optional(number)
      max_idle_connections    = optional(number)
      max_open_connections    = optional(number)
      username                = optional(string)
      password                = optional(string)
      username_template       = optional(string)
      disable_escaping        = optional(bool)
    })), [])
  }))
  default     = []
  description = <<EOF
The following arguments are supported for the Vault mount:
path - (Required) Where the secret backend will be mounted
description - (Optional) Human-friendly description of the mount
default_lease_ttl_seconds - (Optional) Default lease duration for tokens and secrets in seconds
max_lease_ttl_seconds - (Optional) Maximum possible lease duration for tokens and secrets in seconds
audit_non_hmac_response_keys - (Optional) Specifies the list of keys that will not be HMAC'd by audit devices in the response data object.
audit_non_hmac_request_keys - (Optional) Specifies the list of keys that will not be HMAC'd by audit devices in the request data object.
local - (Optional) Boolean flag that can be explicitly set to true to enforce local mount in HA environment
options - (Optional) Specifies mount type specific options that are passed to the backend
seal_wrap - (Optional) Boolean flag that can be explicitly set to true to enable seal wrapping for the mount, causing values stored by the mount to be wrapped by the seal's encryption capability
external_entropy_access - (Optional) Boolean flag that can be explicitly set to true to enable the secrets engine to access Vault's external entropy source
allowed_managed_keys - (Optional) Set of managed key registry entry names that the mount in question is allowed to access
The following arguments are common to all database engines:
plugin_name - (Optional) Specifies the name of the plugin to use.
verify_connection - (Optional) Whether the connection should be verified on initial configuration or not.
allowed_roles - (Optional) A list of roles that are allowed to use this connection.
root_rotation_statements - (Optional) A list of database statements to be executed to rotate the root user's credentials.
data - (Optional) A map of sensitive data to pass to the endpoint. Useful for templated connection strings.

Supported list of database secrets engines that can be configured:
cassandra - (Optional) A nested block containing configuration options for Cassandra connecti
couchbase - (Optional) A nested block containing configuration options for Couchbase connecti
elasticsearch - (Optional) A nested block containing configuration options for Elasticsearch
hana - (Optional) A nested block containing configuration options for SAP HanaDB connections.
mongodb - (Optional) A nested block containing configuration options for MongoDB connections.
mongodbatlas - (Optional) A nested block containing configuration options for MongoDB Atlas connections.
mssql - (Optional) A nested block containing configuration options for MSSQL connections.
mysql - (Optional) A nested block containing configuration options for MySQL connections.
mysql_rds - (Optional) A nested block containing configuration options for RDS MySQL connections.
mysql_aurora - (Optional) A nested block containing configuration options for Aurora MySQL connections.
mysql_legacy - (Optional) A nested block containing configuration options for legacy MySQL connections.
oracle - (Optional) A nested block containing configuration options for Oracle connections.
postgresql - (Optional) A nested block containing configuration options for PostgreSQL connections.
redshift - (Optional) A nested block containing configuration options for AWS Redshift connections.
snowflake - (Optional) A nested block containing configuration options for Snowflake connections.
influxdb - (Optional) A nested block containing configuration options for InfluxDB connections.
redis - (Optional) A nested block containing configuration options for Redis connections.
redis_elasticache - (Optional) A nested block containing configuration options for Redis ElastiCache connections.

Cassandra Configuration Options
hosts - (Required) The hosts to connect to.
username - (Required) The username to authenticate with.
password - (Required) The password to authenticate with.
port - (Optional) The default port to connect to if no port is specified as part of the host.
tls - (Optional) Whether to use TLS when connecting to Cassandra.
insecure_tls - (Optional) Whether to skip verification of the server certificate when using TLS.
pem_bundle - (Optional) Concatenated PEM blocks configuring the certificate chain.
pem_json - (Optional) A JSON structure configuring the certificate chain.
protocol_version - (Optional) The CQL protocol version to use.
connect_timeout - (Optional) The number of seconds to use as a connection timeout.

Couchbase Configuration Options
hosts - (Required) A set of Couchbase URIs to connect to. Must use couchbases:// scheme if tls is true.
username - (Required) Specifies the username for Vault to use.
password - (Required) Specifies the password corresponding to the given username.
tls - (Optional) Whether to use TLS when connecting to Couchbase.
insecure_tls - (Optional) Whether to skip verification of the server certificate when using TLS.
base64_pem - (Optional) Required if tls is true. Specifies the certificate authority of the Couchbase server, as a PEM certificate that has been base64 encoded.
bucket_name - (Optional) Required for Couchbase versions prior to 6.5.0. This is only used to verify vault's connection to the server.
username_template - (Optional) Template describing how dynamic usernames are generated.

Elasticsearch Configuration Options
url - (Required) The URL for Elasticsearch's API. https requires certificate by trusted CA if used.
username - (Required) The username to be used in the connection.
password - (Required) The password to be used in the connection.
ca_cert - (Optional) The path to a PEM-encoded CA cert file to use to verify the Elasticsearch server's identity.
ca_path - (Optional) The path to a directory of PEM-encoded CA cert files to use to verify the Elasticsearch server's identity.
client_cert - (Optional) The path to the certificate for the Elasticsearch client to present for communication.
client_key - (Optional) The path to the key for the Elasticsearch client to use for communication.
tls_server_name - (Optional) This, if set, is used to set the SNI host when connecting via TLS.
insecure - (Optional) Whether to disable certificate verification.
username_template - (Optional) For Vault v1.7+. The template to use for username generation.

InfluxDB Configuration Options
host - (Required) The host to connect to.
username - (Required) The username to authenticate with.
password - (Required) The password to authenticate with.
port - (Optional) The default port to connect to if no port is specified as part of the host.
tls - (Optional) Whether to use TLS when connecting to Cassandra.
insecure_tls - (Optional) Whether to skip verification of the server certificate when using TLS.
pem_bundle - (Optional) Concatenated PEM blocks configuring the certificate chain.
pem_json - (Optional) A JSON structure configuring the certificate chain.
username_template - (Optional) Template describing how dynamic usernames are generated.
connect_timeout - (Optional) The number of seconds to use as a connection timeout.

MongoDB Configuration Options
connection_url - (Required) A URL containing connection information.
username - (Optional) The root credential username used in the connection URL.
password - (Optional) The root credential password used in the connection URL.
username_template - (Optional) For Vault v1.7+. The template to use for username generation.

MongoDB Atlas Configuration Options
public_key - (Required) The Public Programmatic API Key used to authenticate with the MongoDB Atlas API.
private_key - (Required) The Private Programmatic API Key used to connect with MongoDB Atlas API.
project_id - (Required) The Project ID the Database User should be created within.

SAP HanaDB Configuration Options
connection_url - (Required) A URL containing connection information.
max_open_connections - (Optional) The maximum number of open connections to use.
max_idle_connections - (Optional) The maximum number of idle connections to maintain.
max_connection_lifetime - (Optional) The maximum number of seconds to keep a connection alive for.
username - (Optional) The root credential username used in the connection URL.
password - (Optional) The root credential password used in the connection URL.
disable_escaping - (Optional) Disable special character escaping in username and password.

MSSQL Configuration Options
connection_url - (Required) A URL containing connection information.
max_open_connections - (Optional) The maximum number of open connections to use.
max_idle_connections - (Optional) The maximum number of idle connections to maintain.
max_connection_lifetime - (Optional) The maximum number of seconds to keep a connection alive for.
username_template - (Optional) For Vault v1.7+. The template to use for username generation.
username - (Optional) The root credential username used in the connection URL.
password - (Optional) The root credential password used in the connection URL.
disable_escaping - (Optional) Disable special character escaping in username and password.
contained_db - (Optional bool: false) For Vault v1.9+. Set to true when the target is a Contained Database, e.g. AzureSQL.

MySQL Configuration Options
connection_url - (Required) A URL containing connection information.
max_open_connections - (Optional) The maximum number of open connections to use.
max_idle_connections - (Optional) The maximum number of idle connections to maintain.
max_connection_lifetime - (Optional) The maximum number of seconds to keep a connection alive for.
username - (Optional) The root credential username used in the connection URL.
password - (Optional) The root credential password used in the connection URL.
tls_certificate_key - (Optional) x509 certificate for connecting to the database. This must be a PEM encoded version of the private key and the certificate combined.
tls_ca - (Optional) x509 CA file for validating the certificate presented by the MySQL server. Must be PEM encoded.
username_template - (Optional) For Vault v1.7+. The template to use for username generation.

Oracle Configuration Options
connection_url - (Required) A URL containing connection information.
max_open_connections - (Optional) The maximum number of open connections to use.
max_idle_connections - (Optional) The maximum number of idle connections to maintain.
username - (Optional) The root credential username used in the connection URL.
password - (Optional) The root credential password used in the connection URL.
max_connection_lifetime - (Optional) The maximum number of seconds to keep a connection alive for.
username_template - (Optional) For Vault v1.7+. The template to use for username generation.

PostgreSQL Configuration Options
connection_url - (Required) A URL containing connection information.
max_open_connections - (Optional) The maximum number of open connections to use.
max_idle_connections - (Optional) The maximum number of idle connections to maintain.
max_connection_lifetime - (Optional) The maximum number of seconds to keep a connection alive for.
username - (Optional) The root credential username used in the connection URL.
password - (Optional) The root credential password used in the connection URL.
disable_escaping - (Optional) Disable special character escaping in username and password.
username_template - (Optional) For Vault v1.7+. The template to use for username generation. See Vault docs

Redis Configuration Options
host - (Required) The host to connect to.
username - (Required) The username to authenticate with.
password - (Required) The password to authenticate with.
port - (Optional) The default port to connect to if no port is specified as part of the host.
tls - (Optional) Whether to use TLS when connecting to Redis.
insecure_tls - (Optional) Whether to skip verification of the server certificate when using TLS.
ca_cert - (Optional) The contents of a PEM-encoded CA cert file to use to verify the Redis server's identity.

Redis ElastiCache Configuration Options
url - (Required) The configuration endpoint for the ElastiCache cluster to connect to.
username - (Optional) The AWS access key id to use to talk to ElastiCache. If omitted the credentials chain provider is used instead.
password - (Optional) The AWS secret key id to use to talk to ElastiCache. If omitted the credentials chain provider is used instead.
region - (Optional) The AWS region where the ElastiCache cluster is hosted. If omitted the plugin tries to infer the region from the environment.

AWS Redshift Configuration Options
connection_url - (Required) Specifies the Redshift DSN. See Vault docs
max_open_connections - (Optional) The maximum number of open connections to the database.
max_idle_connections - (Optional) The maximum number of idle connections to the database.
max_connection_lifetime - (Optional) The maximum amount of time a connection may be reused.
username - (Optional) The root credential username used in the connection URL.
password - (Optional) The root credential password used in the connection URL.
disable_escaping - (Optional) Disable special character escaping in username and password.
username_template - (Optional) - Template describing how dynamic usernames are generated.

Snowflake Configuration Options
connection_url - (Required) A URL containing connection information.
max_open_connections - (Optional) The maximum number of open connections to use.
max_idle_connections - (Optional) The maximum number of idle connections to maintain.
max_connection_lifetime - (Optional) The maximum number of seconds to keep a connection alive for.
username - (Optional) The username to be used in the connection (the account admin level).
password - (Optional) The password to be used in the connection.
username_template - (Optional) - Template describing how dynamic usernames are generated.
EOF
}

variable "egp_policy" {
  type = list(object({
    id                = number
    enforcement_level = string
    name              = string
    paths             = list(string)
    policy            = string
    namespace         = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
name - (Required) The name of the policy
paths - (Required) List of paths to which the policy will be applied to
enforcement_level - (Required) Enforcement level of Sentinel policy. Can be either advisory or soft-mandatory or hard-mandatory
policy - (Required) String containing a Sentinel policy
EOF

  validation {
    condition = alltrue([
      for i in var.egp_policy : contains(["advisory", "soft-mandatory", "hard-mandatory"], i.enforcement_level)
    ])
    error_message = "Valid values are 'advisory', 'soft-mandatory' or 'hard-mandatory'."
  }
}

variable "gcp_auth_backend" {
  type = list(object({
    id              = number
    namespace       = optional(string)
    credentials     = optional(string)
    path            = optional(string)
    disable_remount = optional(bool)
    description     = optional(string)
    local           = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
credentials - A JSON string containing the contents of a GCP credentials file. If this value is empty, Vault will try to use Application Default Credentials from the machine on which the Vault server is running.
path - (Optional) The path to mount the auth method — this defaults to 'gcp'.
disable_remount - (Optional) If set, opts out of mount migration on path updates. See here for more info on Mount Migration
description - (Optional) A description of the auth method.
local - (Optional) Specifies if the auth method is local only.
custom_endpoint - (Optional) Specifies overrides to service endpoints used when making API requests. This allows specific requests made during authentication to target alternative service endpoints for use in Private Google Access environments. Requires Vault 1.11+.
Overrides are set at the subdomain level using the following keys:
api - Replaces the service endpoint used in API requests to https://www.googleapis.com.
iam - Replaces the service endpoint used in API requests to https://iam.googleapis.com.
crm - Replaces the service endpoint used in API requests to https://cloudresourcemanager.googleapis.com.
compute - Replaces the service endpoint used in API requests to https://compute.googleapis.com.
The endpoint value provided for a given key has the form of scheme://host:port. The scheme:// and :port portions of the endpoint value are optional.
EOF
}

variable "gcp_auth_backend_role" {
  type = list(object({
    id                      = number
    role                    = string
    type                    = string
    backend_id              = number
    namespace               = optional(string)
    bound_instance_groups   = optional(list(string))
    bound_labels            = optional(list(string))
    bound_projects          = optional(list(string))
    bound_regions           = optional(list(string))
    bound_service_accounts  = optional(list(string))
    bound_zones             = optional(list(string))
    token_bound_cidrs       = optional(list(string))
    token_explicit_max_ttl  = optional(number)
    token_max_ttl           = optional(number)
    token_no_default_policy = optional(bool)
    token_num_uses          = optional(number)
    token_period            = optional(number)
    token_policies          = optional(list(string))
    token_ttl               = optional(number)
    token_type              = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
role - (Required) Name of the GCP role
type - (Required) Type of GCP authentication role (either gce or iam)
bound_projects - (Optional) An array of GCP project IDs. Only entities belonging to this project can authenticate under the role.
backend - (Optional) Path to the mounted GCP auth backend
bound_service_accounts - (Optional) GCP Service Accounts allowed to issue tokens under this role. (Note: Required if role is iam)

iam-only Parameters
max_jwt_exp - (Optional) The number of seconds past the time of authentication that the login param JWT must expire within. For example, if a user attempts to login with a token that expires within an hour and this is set to 15 minutes, Vault will return an error prompting the user to create a new signed JWT with a shorter exp. The GCE metadata tokens currently do not allow the exp claim to be customized.
allow_gce_inference - (Optional) A flag to determine if this role should allow GCE instances to authenticate by inferring service accounts from the GCE identity metadata token.

gce-only Parameters
The following parameters are only valid when the role is of type "gce":
bound_zones - (Optional) The list of zones that a GCE instance must belong to in order to be authenticated. If bound_instance_groups is provided, it is assumed to be a zonal group and the group must belong to this zone.
bound_regions - (Optional) The list of regions that a GCE instance must belong to in order to be authenticated. If bound_instance_groups is provided, it is assumed to be a regional group and the group must belong to this region. If bound_zones are provided, this attribute is ignored.
bound_instance_groups - (Optional) The instance groups that an authorized instance must belong to in order to be authenticated. If specified, either bound_zones or bound_regions must be set too.
bound_labels - (Optional) A comma-separated list of GCP labels formatted as "key:value" strings that must be set on authorized GCE instances. Because GCP labels are not currently ACL'd, we recommend that this be used in conjunction with other restrictions.
bound_projects - (Optional) GCP Projects that the role exists within
For more details on the usage of each argument consult the Vault GCP API documentation.

Common Token Arguments
These arguments are common across several Authentication Token resources since Vault 1.2.
token_ttl - (Optional) The incremental lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time.
token_max_ttl - (Optional) The maximum lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time.
token_period - (Optional) If set, indicates that the token generated using this role should never expire. The token should be renewed within the duration specified by this value. At each renewal, the token's TTL will be set to the value of this field. Specified in seconds.
token_policies - (Optional) List of policies to encode onto generated tokens. Depending on the auth method, this list may be supplemented by user/group/other values.
token_bound_cidrs - (Optional) List of CIDR blocks; if set, specifies blocks of IP addresses which can authenticate successfully, and ties the resulting token to these blocks as well.
token_explicit_max_ttl - (Optional) If set, will encode an explicit max TTL onto the token in number of seconds. This is a hard cap even if token_ttl and token_max_ttl would otherwise allow a renewal.
token_no_default_policy - (Optional) If set, the default policy will not be set on generated tokens; otherwise it will be added to the policies set in token_policies.
token_num_uses - (Optional) The maximum number of times a generated token may be used (within its lifetime); 0 means unlimited.
token_type - (Optional) The type of token that should be generated. Can be service, batch, or default to use the mount's tuned default (which unless changed will be service tokens). For token store roles, there are two additional possibilities: default-service and default-batch which specify the type to return unless the client requests a different type at generation time.
EOF

  validation {
    condition = alltrue([
      for role in var.gcp_auth_backend_role : contains(["gce", "iam"], role.type)
    ])
    error_message = "Valid values are 'gce' or 'iam'."
  }
}

variable "gcp_secret_backend" {
  type = list(object({
    id                        = number
    credentials               = optional(string)
    namespace                 = optional(string)
    path                      = optional(string)
    disable_remount           = optional(bool)
    description               = optional(string)
    default_lease_ttl_seconds = optional(number)
    max_lease_ttl_seconds     = optional(number)
    local                     = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
credentials - (Optional) The GCP service account credentials in JSON format.
path - (Optional) The unique path this backend should be mounted at. Must not begin or end with a /. Defaults to gcp.
disable_remount - (Optional) If set, opts out of mount migration on path updates. See here for more info on Mount Migration
description - (Optional) A human-friendly description for this backend.
default_lease_ttl_seconds - (Optional) The default TTL for credentials issued by this backend. Defaults to '0'.
max_lease_ttl_seconds - (Optional) The maximum TTL that can be requested for credentials issued by this backend. Defaults to '0'.
local - (Optional) Boolean flag that can be explicitly set to true to enforce local mount in HA environment
EOF
}

variable "gcp_secret_impersonated_account" {
  type = list(object({
    id                    = number
    backend_id            = number
    impersonated_account  = string
    service_account_email = string
    token_scopes          = list(string)
    namespace_id          = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
backend - (Required, Forces new resource) Path where the GCP Secrets Engine is mounted
impersonated_account - (Required, Forces new resource) Name of the Impersonated Account to create
service_account_email - (Required, Forces new resource) Email of the GCP service account to impersonate.
token_scopes - (Required) List of OAuth scopes to assign to access tokens generated under this impersonated account.
EOF
}

variable "gcp_secret_roleset" {
  type = list(object({
    id           = number
    backend_id   = number
    project      = string
    roleset      = string
    namespace    = optional(string)
    secret_type  = optional(string)
    token_scopes = optional(list(string))
    binding = optional(list(object({
      resource = string
      roles    = list(string)
    })), [])
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
backend - (Required, Forces new resource) Path where the GCP Secrets Engine is mounted
roleset - (Required, Forces new resource) Name of the Roleset to create
project - (Required, Forces new resource) Name of the GCP project that this roleset's service account will belong to.
secret_type - (Optional, Forces new resource) Type of secret generated for this role set. Accepted values: access_token, service_account_key. Defaults to access_token.
token_scopes - (Optional, Required for secret_type = "access_token") List of OAuth scopes to assign to access_token secrets generated under this role set (access_token role sets only).
binding - (Required) Bindings to create for this roleset. This can be specified multiple times for multiple bindings. Structure is documented below.

The binding block supports:
resource - (Required) Resource or resource path for which IAM policy information will be bound. The resource path may be specified in a few different formats.
roles - (Required) List of GCP IAM roles for the resource.
EOF

  validation {
    condition = alltrue([
      for secret in var.gcp_secret_roleset : contains(["access_token", "service_account_key"], secret.secret_type)
    ])
    error_message = "Valid values are 'access_token' or 'service_account_key'."
  }
}

variable "gcp_secret_static_account" {
  type = list(object({
    id                    = number
    backend_id            = number
    service_account_email = string
    static_account        = string
    namespace             = optional(string)
    secret_type           = optional(string)
    token_scopes          = optional(list(string))
    binding = optional(list(object({
      resource = string
      roles    = list(string)
    })), [])
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
backend - (Required, Forces new resource) Path where the GCP Secrets Engine is mounted
static_account - (Required, Forces new resource) Name of the Static Account to create
service_account_email - (Required, Forces new resource) Email of the GCP service account to manage.
secret_type - (Optional, Forces new resource) Type of secret generated for this static account. Accepted values: access_token, service_account_key. Defaults to access_token.
token_scopes - (Optional, Required for secret_type = "access_token") List of OAuth scopes to assign to access_token secrets generated under this static account (access_token static accounts only).
binding - (Optional) Bindings to create for this static account. This can be specified multiple times for multiple bindings. Structure is documented below.

The binding block supports:
resource - (Required) Resource or resource path for which IAM policy information will be bound. The resource path may be specified in a few different formats.
roles - (Required) List of GCP IAM roles for the resource.
EOF

  validation {
    condition = alltrue([
      for secret in var.gcp_secret_static_account : contains(["access_token", "service_account_key"], secret.secret_type)
    ])
    error_message = "Valid values are 'access_token' or 'service_account_key'."
  }
}

variable "generic_endpoint" {
  type = list(object({
    id                   = number
    data_json            = string
    path                 = string
    namespace            = optional(string)
    disable_read         = optional(bool)
    disable_delete       = optional(bool)
    ignore_absent_fields = optional(bool)
    write_fields         = optional(list(string))
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
path - (Required) The full logical path at which to write the given data. Consult each backend's documentation to see which endpoints support the PUT methods and to determine whether they also support DELETE and GET.
data_json - (Required) String containing a JSON-encoded object that will be written to the given path as the secret data.
disable_read - (Optional) True/false. Set this to true if your vault authentication is not able to read the data or if the endpoint does not support the GET method. Setting this to true will break drift detection. You should set this to true for endpoints that are write-only. Defaults to false.
disable_delete: - (Optional) True/false. Set this to true if your vault authentication is not able to delete the data or if the endpoint does not support the DELETE method. Defaults to false.
ignore_absent_fields: - (Optional) True/false. If set to true, ignore any fields present when the endpoint is read but that were not in data_json. Also, if a field that was written is not returned when the endpoint is read, treat that field as being up to date. You should set this to true when writing to endpoint that, when read, returns a different set of fields from the ones you wrote, as is common with many configuration endpoints. Defaults to false.
write_fields: - (Optional). A list of fields that should be returned in write_data_json and write_data. If omitted, data returned by the write operation is not available to the resource or included in state. This helps to avoid accidental storage of sensitive values in state. Some endpoints, such as many dynamic secrets endpoints, return data from writing to an endpoint rather than reading it. You should use write_fields if you need information returned in this way.
EOF
}

variable "generic_secret" {
  type = list(object({
    id                  = number
    data_json           = string
    path                = string
    namespace           = optional(string)
    disable_read        = optional(bool)
    delete_all_versions = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
path - (Required) The full logical path at which to write the given data. To write data into the "generic" secret backend mounted in Vault by default, this should be prefixed with secret/. Writing to other backends with this resource is possible; consult each backend's documentation to see which endpoints support the PUT and DELETE methods.
data_json - (Required) String containing a JSON-encoded object that will be written as the secret data at the given path.
disable_read - (Optional) true/false. Set this to true if your vault authentication is not able to read the data. Setting this to true will break drift detection. Defaults to false.
delete_all_versions - (Optional) true/false. Only applicable for kv-v2 stores. If set to true, permanently deletes all versions for the specified key. The default behavior is to only delete the latest version of the secret.
EOF
}

variable "github_auth_backend" {
  type = list(object({
    id              = number
    organization    = string
    namespace       = optional(string)
    path            = optional(string)
    disable_remount = optional(bool)
    organization_id = optional(number)
    base_url        = optional(string)
    description     = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
path - (Optional) Path where the auth backend is mounted. Defaults to auth/github if not specified.
disable_remount - (Optional) If set, opts out of mount migration on path updates. See here for more info on Mount Migration
organization - (Required) The organization configured users must be part of.
organization_id (Optional) The ID of the organization users must be part of. Vault will attempt to fetch and set this value if it is not provided. (Vault 1.10+)
base_url - (Optional) The API endpoint to use. Useful if you are running GitHub Enterprise or an API-compatible authentication server.
description - (Optional) Specifies the description of the mount. This overrides the current stored value, if any.
EOF
}

variable "github_team" {
  type = list(object({
    id         = number
    team       = string
    backend_id = optional(number)
    namespace  = optional(string)
    policies   = optional(list(string))
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
backend - (Required) Path where the github auth backend is mounted. Defaults to github if not specified.
team - (Required) GitHub team name in "slugified" format, for example: Terraform Developers -> terraform-developers.
policies - (Optional) An array of strings specifying the policies to be set on tokens issued using this role.
EOF
}

variable "github_user" {
  type = list(object({
    id         = number
    user       = string
    backend_id = optional(number)
    namespace  = optional(string)
    policies   = optional(list(string))
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
backend - (Required) Path where the github auth backend is mounted. Defaults to github if not specified.
user - (Required) GitHub user name.
policies - (Optional) An array of strings specifying the policies to be set on tokens issued using this role.
EOF
}

variable "identity_entity" {
  type = list(object({
    id                = number
    namespace         = optional(string)
    name              = optional(string)
    policies          = optional(list(string))
    external_policies = optional(bool)
    metadata          = optional(map(string))
    disabled          = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
name - (Required) Name of the identity entity to create.
policies - (Optional) A list of policies to apply to the entity.
metadata - (Optional) A Map of additional metadata to associate with the user.
disabled - (Optional) True/false Is this entity currently disabled. Defaults to false
external_policies - (Optional) false by default. If set to true, this resource will ignore any policies return from Vault or specified in the resource. You can use vault_identity_entity_policies to manage policies for this entity in a decoupled manner.
EOF
}

variable "identity_entity_alias" {
  type = list(object({
    id             = number
    canonical_id   = string
    mount_accessor = string
    name           = string
    namespace      = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
name - (Required) Name of the alias. Name should be the identifier of the client in the authentication source. For example, if the alias belongs to userpass backend, the name should be a valid username within userpass backend. If alias belongs to GitHub, it should be the GitHub username.
mount_accessor - (Required) Accessor of the mount to which the alias should belong to.
canonical_id - (Required) Entity ID to which this alias belongs to.
EOF
}

variable "identity_entity_policies" {
  type = list(object({
    id        = number
    entity_id = number
    policies  = list(string)
    namespace = optional(string)
    exclusive = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
policies - (Required) List of policies to assign to the entity
entity_id - (Required) Entity ID to assign policies to.
exclusive - (Optional) Defaults to true.
If true, this resource will take exclusive control of the policies assigned to the entity and will set it equal to what is specified in the resource.
If set to false, this resource will simply ensure that the policies specified in the resource are present in the entity. When destroying the resource, the resource will ensure that the policies specified in the resource are removed.
EOF
}

variable "identity_group" {
  type = list(object({
    id                         = number
    namespace_id               = optional(number)
    name                       = optional(string)
    type                       = optional(string)
    policies                   = optional(list(string))
    external_policies          = optional(bool)
    external_member_group_ids  = optional(bool)
    external_member_entity_ids = optional(bool)
    metadata                   = optional(map(string))
    member_entity_ids          = optional(list(string))
    member_group_ids           = optional(list(string))
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
name - (Required, Forces new resource) Name of the identity group to create.
type - (Optional, Forces new resource) Type of the group, internal or external. Defaults to internal.
policies - (Optional) A list of policies to apply to the group.
metadata - (Optional) A Map of additional metadata to associate with the group.
member_group_ids - (Optional) A list of Group IDs to be assigned as group members. Not allowed on external groups.
member_entity_ids - (Optional) A list of Entity IDs to be assigned as group members. Not allowed on external groups.
external_policies - (Optional) false by default. If set to true, this resource will ignore any policies returned from Vault or specified in the resource. You can use vault_identity_group_policies to manage policies for this group in a decoupled manner.
external_member_entity_ids - (Optional) false by default. If set to true, this resource will ignore any Entity IDs returned from Vault or specified in the resource. You can use vault_identity_group_member_entity_ids to manage Entity IDs for this group in a decoupled manner.
external_member_group_ids - (Optional) false by default. If set to true, this resource will ignore any Group IDs returned from Vault or specified in the resource. You can use vault_identity_group_member_group_ids to manage Group IDs for this group in a decoupled manner.
EOF

  validation {
    condition = alltrue([
      for group in var.identity_group : contains(["internal", "external"], group.type)
    ])
    error_message = "Valid values are 'internal' or 'external'."
  }
}

variable "identity_group_alias" {
  type = list(object({
    id                = number
    canonical_id      = number
    mount_accessor_id = number
    name              = string
    namespace         = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
name - (Required, Forces new resource) Name of the group alias to create.
mount_accessor - (Required) Mount accessor of the authentication backend to which this alias belongs to.
canonical_id - (Required) ID of the group to which this is an alias.
EOF
}

variable "identity_group_member_entity_ids" {
  type = list(object({
    id                = number
    group_id          = number
    namespace         = optional(string)
    member_entity_ids = list(number)
    exclusive         = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
member_entity_ids - (Required) List of member entities that belong to the group
group_id - (Required) Group ID to assign member entities to.
exclusive - (Optional) Defaults to true.
If true, this resource will take exclusive control of the member entities that belong to the group and will set it equal to what is specified in the resource.
If set to false, this resource will simply ensure that the member entities specified in the resource are present in the group. When destroying the resource, the resource will ensure that the member entities specified in the resource are removed.
EOF
}

variable "identity_group_member_group_ids" {
  type = list(object({
    id                = number
    group_id          = number
    namespace         = optional(string)
    member_entity_ids = list(number)
    exclusive         = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
member_group_ids - (Required) List of member groups that belong to the group
group_id - (Required) Group ID to assign member entities to.
exclusive - (Optional) Defaults to true.
EOF
}

variable "identity_group_policies" {
  type = list(object({
    id        = number
    group_id  = number
    policies  = list(string)
    namespace = optional(string)
    exclusive = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
policies - (Required) List of policies to assign to the group
group_id - (Required) Group ID to assign policies to.
exclusive - (Optional) Defaults to true.
EOF
}

variable "identity_mfa_duo" {
  type = list(object({
    id              = number
    api_hostname    = string
    integration_key = string
    secret_key      = string
    namespace       = optional(string)
    push_info       = optional(string)
    use_passcode    = optional(bool)
    username_format = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
api_hostname - (Required) API hostname for Duo
integration_key - (Required) Integration key for Duo
secret_key - (Required) Secret key for Duo
mount_accessor - (Optional) Mount accessor.
namespace - (Optional) Target namespace. (requires Enterprise)
push_info - (Optional) Push information for Duo.
use_passcode - (Optional) Require passcode upon MFA validation.
username_format - (Optional) A template string for mapping Identity names to MFA methods.
EOF
}

variable "identity_mfa_login_enforcement" {
  type = list(object({
    id                    = number
    mfa_method_ids        = list(number)
    name                  = string
    auth_method_accessors = optional(string)
    auth_method_types     = optional(string)
    identity_entity_ids   = optional(list(number))
    identity_group_ids    = optional(list(number))
    namespace             = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
mfa_method_ids - (Required) Set of MFA method UUIDs.
name - (Required) Login enforcement name.
auth_method_accessors - (Optional) Set of auth method accessor IDs.
auth_method_types - (Optional) Set of auth method types.
identity_entity_ids - (Optional) Set of identity entity IDs.
identity_group_ids - (Optional) Set of identity group IDs.
namespace - (Optional) Target namespace. (requires Enterprise)
EOF
}

variable "identity_mfa_okta" {
  type = list(object({
    id              = number
    api_token       = string
    org_name        = string
    base_url        = optional(string)
    namespace       = optional(string)
    primary_email   = optional(bool)
    username_format = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
api_token - (Required) Okta API token.
org_name - (Required) Name of the organization to be used in the Okta API.
base_url - (Optional) The base domain to use for API requests.
mount_accessor - (Optional) Mount accessor.
namespace - (Optional) Target namespace. (requires Enterprise)
primary_email - (Optional) Only match the primary email for the account.
username_format - (Optional) A template string for mapping Identity names to MFA methods.
EOF
}

variable "identity_mfa_pingid" {
  type = list(object({
    id                   = number
    settings_file_base64 = string
    namespace            = optional(string)
    username_format      = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
settings_file_base64 - (Required) A base64-encoded third-party settings contents as retrieved from PingID's configuration page.
admin_url - (Optional) The admin URL, derived from "settings_file_base64"
authenticator_url - (Optional) A unique identifier of the organization, derived from "settings_file_base64"
idp_url - (Optional) The IDP URL, derived from "settings_file_base64"
mount_accessor - (Optional) Mount accessor.
namespace - (Optional) Target namespace. (requires Enterprise)
org_alias - (Optional) The name of the PingID client organization, derived from "settings_file_base64"
use_signature - (Optional) Use signature value, derived from "settings_file_base64"
username_format - (Optional) A template string for mapping Identity names to MFA methods.
EOF
}

variable "identity_mfa_totp" {
  type = list(object({
    id                      = number
    issuer                  = string
    algorithm               = optional(string)
    digits                  = optional(number)
    key_size                = optional(number)
    max_validation_attempts = optional(number)
    namespace               = optional(string)
    period                  = optional(number)
    qr_size                 = optional(number)
    skew                    = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
issuer - (Required) The name of the key's issuing organization.
algorithm - (Optional) Specifies the hashing algorithm used to generate the TOTP code. Options include SHA1, SHA256, SHA512.
digits - (Optional) The number of digits in the generated TOTP token. This value can either be 6 or 8
key_size - (Optional) Specifies the size in bytes of the generated key.
max_validation_attempts - (Optional) The maximum number of consecutive failed validation attempts allowed.
mount_accessor - (Optional) Mount accessor.
namespace - (Optional) Target namespace. (requires Enterprise)
period - (Optional) The length of time in seconds used to generate a counter for the TOTP token calculation.
qr_size - (Optional) The pixel size of the generated square QR code.
skew - (Optional) The number of delay periods that are allowed when validating a TOTP token. This value can either be 0 or 1.
EOF
}

variable "identity_oidc" {
  type = list(object({
    id        = number
    namespace = optional(string)
    issuer    = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
issuer - (Optional) Issuer URL to be used in the iss claim of the token. If not set, Vault's api_addr will be used. The issuer is a case sensitive URL using the https scheme that contains scheme, host, and optionally, port number and path components, but no query or fragment components.
EOF
}

variable "identity_oidc_assignment" {
  type = list(object({
    id         = number
    name       = string
    entity_ids = optional(list(number))
    group_ids  = optional(list(number))
    namespace  = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
name - (Required) The name of the assignment.
entity_ids - (Optional) A set of Vault entity IDs.
group_ids - (Optional) A set of Vault group IDs.
EOF
}

variable "identity_oidc_client" {
  type = list(object({
    id               = number
    name             = string
    key              = optional(string)
    redirect_uris    = optional(list(string))
    assignments      = optional(list(string))
    id_token_ttl     = optional(number)
    access_token_ttl = optional(number)
    client_type      = optional(string)
    namespace        = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
name - (Required) The name of the client.
key - (Optional) A reference to a named key resource in Vault. This cannot be modified after creation. If not provided, the default key is used.
redirect_uris - (Optional) Redirection URI values used by the client. One of these values must exactly match the redirect_uri parameter value used in each authentication request.
assignments - (Optional) A list of assignment resources associated with the client.
id_token_ttl - (Optional) The time-to-live for ID tokens obtained by the client. The value should be less than the verification_ttl on the key.
access_token_ttl - (Optional) The time-to-live for access tokens obtained by the client.
client_type - (Optional) The client type based on its ability to maintain confidentiality of credentials. The following client types are supported: confidential, public. Defaults to confidential.
EOF

  validation {
    condition = alltrue([
      for client in var.identity_oidc_client : contains(["confidential", "public"], client.client_type)
    ])
    error_message = "Valid values are 'confidential' or 'public'."
  }
}

variable "identity_oidc_key" {
  type = list(object({
    id                 = number
    name               = string
    namespace          = optional(string)
    rotation_period    = optional(number)
    verification_ttl   = optional(number)
    algorithm          = optional(string)
    allowed_client_ids = optional(list(number))
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
name - (Required; Forces new resource) Name of the OIDC Key to create.
rotation_period - (Optional) How often to generate a new signing key in number of seconds
verification_ttl - (Optional) "Controls how long the public portion of a signing key will be available for verification after being rotated in seconds.
algorithm - (Optional) Signing algorithm to use. Signing algorithm to use. Allowed values are: RS256 (default), RS384, RS512, ES256, ES384, ES512, EdDSA.
allowed_client_ids: Array of role client ID allowed to use this key for signing. If empty, no roles are allowed. If ["*"], all roles are allowed.
EOF
}

variable "identity_oidc_key_allowed_client_id" {
  type = list(object({
    id                = number
    allowed_client_id = number
    key_id            = number
    namespace         = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
key_name - (Required; Forces new resource) Name of the OIDC Key allow the Client ID.
allowed_client_id - (Required; Forces new resource) Client ID to allow usage with the OIDC named key
EOF
}

variable "identity_oidc_provider" {
  type = list(object({
    id                 = number
    name               = string
    allowed_client_ids = optional(list(number))
    issuer_host        = optional(string)
    https_enabled      = optional(bool)
    namespace          = optional(string)
    scopes_ids         = optional(list(number))
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
name - (Required) The name of the provider.
https_enabled - (Optional) Set to true if the issuer endpoint uses HTTPS.
issuer_host - (Optional) The host for the issuer. Can be either host or host:port.
allowed_client_ids - (Optional) The client IDs that are permitted to use the provider. If empty, no clients are allowed. If *, all clients are allowed.
scopes_supported - (Optional) The scopes available for requesting on the provider.
EOF
}

variable "identity_oidc_role" {
  type = list(object({
    id        = number
    key_id    = number
    name      = string
    template  = optional(string)
    ttl       = optional(number)
    client_id = optional(number)
    namespace = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
name - (Required; Forces new resource) Name of the OIDC Role to create.
key - (Required; Forces new resource) A configured named key, the key must already exist before tokens can be issued.
template - (Optional) The template string to use for generating tokens. This may be in string-ified JSON or base64 format. See the documentation for the template format.
ttl - (Optional) TTL of the tokens generated against the role in number of seconds.
client_id - (Optional) The value that will be included in the aud field of all the OIDC identity tokens issued by this role
EOF
}

variable "identity_oidc_scope" {
  type = list(object({
    id          = number
    name        = string
    template    = optional(string)
    description = optional(string)
    namespace   = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
name - (Required) The name of the scope. The openid scope name is reserved.
template - (Optional) The template string for the scope. This may be provided as escaped JSON or base64 encoded JSON.
description - (Optional) A description of the scope.
EOF
}

variable "jwt_auth_backend" {
  type = list(object({
    id                     = number
    namespace_id           = optional(number)
    namespace_in_state     = optional(bool)
    path                   = optional(string)
    disable_remount        = optional(bool)
    type                   = optional(string)
    description            = optional(string)
    oidc_client_id         = optional(string)
    oidc_client_secret     = optional(string)
    oidc_discovery_ca_pem  = optional(string)
    oidc_discovery_url     = optional(string)
    oidc_response_mode     = optional(string)
    oidc_response_types    = optional(list(string))
    jwks_ca_pem            = optional(string)
    jwks_url               = optional(string)
    jwt_supported_algs     = optional(list(string))
    jwt_validation_pubkeys = optional(list(string))
    default_role           = optional(string)
    provider_config        = optional(map(string))
    local                  = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
path - (Required) Path to mount the JWT/OIDC auth backend
disable_remount - (Optional) If set, opts out of mount migration on path updates. See here for more info on Mount Migration
type - (Optional) Type of auth backend. Should be one of jwt or oidc. Default - jwt
description - (Optional) The description of the auth backend
oidc_discovery_url - (Optional) The OIDC Discovery URL, without any .well-known component (base path). Cannot be used in combination with jwt_validation_pubkeys
oidc_discovery_ca_pem - (Optional) The CA certificate or chain of certificates, in PEM format, to use to validate connections to the OIDC Discovery URL. If not set, system certificates are used
oidc_client_id - (Optional) Client ID used for OIDC backends
oidc_client_secret - (Optional) Client Secret used for OIDC backends
oidc_response_mode - (Optional) The response mode to be used in the OAuth2 request. Allowed values are query and form_post. Defaults to query. If using Vault namespaces, and oidc_response_mode is form_post, then namespace_in_state should be set to false.
oidc_response_types - (Optional) List of response types to request. Allowed values are 'code' and 'id_token'. Defaults to ["code"]. Note: id_token may only be used if oidc_response_mode is set to form_post.
jwks_url - (Optional) JWKS URL to use to authenticate signatures. Cannot be used with "oidc_discovery_url" or "jwt_validation_pubkeys".
jwks_ca_pem - (Optional) The CA certificate or chain of certificates, in PEM format, to use to validate connections to the JWKS URL. If not set, system certificates are used.
jwt_validation_pubkeys - (Optional) A list of PEM-encoded public keys to use to authenticate signatures locally. Cannot be used in combination with oidc_discovery_url
bound_issuer - (Optional) The value against which to match the iss claim in a JWT
jwt_supported_algs - (Optional) A list of supported signing algorithms. Vault 1.1.0 defaults to [RS256] but future or past versions of Vault may differ
default_role - (Optional) The default role to use if none is provided during login
provider_config - (Optional) Provider specific handling configuration. All values may be strings, and the provider will convert to the appropriate type when configuring Vault.
local - (Optional) Specifies if the auth method is local only.
namespace_in_state - (Optional) Pass namespace in the OIDC state parameter instead of as a separate query parameter. With this setting, the allowed redirect URL(s) in Vault and on the provider side should not contain a namespace query parameter. This means only one redirect URL entry needs to be maintained on the OIDC provider side for all vault namespaces that will be authenticating against it. Defaults to true for new configs
EOF
}

variable "jwt_auth_backend_role" {
  type = list(object({
    id                           = number
    backend_id                   = optional(number)
    role_name                    = optional(string)
    user_claim                   = optional(string)
    role_type                    = optional(string)
    bound_audiences              = optional(list(string))
    bound_claims                 = optional(map(string))
    bound_claims_type            = optional(string)
    bound_subject                = optional(string)
    disable_bound_claims_parsing = optional(bool)
    user_claim_json_pointer      = optional(bool)
    claim_mappings               = optional(map(string))
    clock_skew_leeway            = optional(number)
    oidc_scopes                  = optional(list(string))
    groups_claim                 = optional(string)
    allowed_redirect_uris        = optional(list(string))
    expiration_leeway            = optional(number)
    not_before_leeway            = optional(number)
    verbose_oidc_logging         = optional(bool)
    max_age                      = optional(number)
    namespace_id                 = optional(number)
    token_bound_cidrs            = optional(list(string))
    token_explicit_max_ttl       = optional(number)
    token_max_ttl                = optional(number)
    token_num_uses               = optional(number)
    token_no_default_policy      = optional(bool)
    token_policies               = optional(list(string))
    token_period                 = optional(number)
    token_ttl                    = optional(number)
    token_type                   = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
role_name - (Required) The name of the role.
role_type - (Optional) Type of role, either "oidc" (default) or "jwt".
bound_audiences - (For "jwt" roles, at least one of bound_audiences, bound_subject, bound_claims or token_bound_cidrs is required. Optional for "oidc" roles.) List of aud claims to match against. Any match is sufficient.
user_claim - (Required) The claim to use to uniquely identify the user; this will be used as the name for the Identity entity alias created due to a successful login.
user_claim_json_pointer - (Optional) Specifies if the user_claim value uses JSON pointer syntax for referencing claims. By default, the user_claim value will not use JSON pointer. Requires Vault 1.11+.
bound_subject - (Optional) If set, requires that the sub claim matches this value.
bound_claims - (Optional) If set, a map of claims to values to match against. A claim's value must be a string, which may contain one value or multiple comma-separated values, e.g. "red" or "red,green,blue".
bound_claims_type - (Optional) How to interpret values in the claims/values map (bound_claims): can be either string (exact match) or glob (wildcard match). Requires Vault 1.4.0 or above.
claim_mappings - (Optional) If set, a map of claims (keys) to be copied to specified metadata fields (values).
oidc_scopes - (Optional) If set, a list of OIDC scopes to be used with an OIDC role. The standard scope "openid" is automatically included and need not be specified.
groups_claim - (Optional) The claim to use to uniquely identify the set of groups to which the user belongs; this will be used as the names for the Identity group aliases created due to a successful login. The claim value must be a list of strings.
backend - (Optional) The unique name of the auth backend to configure. Defaults to jwt.
allowed_redirect_uris - (Optional) The list of allowed values for redirect_uri during OIDC logins. Required for OIDC roles
clock_skew_leeway - (Optional) The amount of leeway to add to all claims to account for clock skew, in seconds. Defaults to 60 seconds if set to 0 and can be disabled if set to -1. Only applicable with "jwt" roles.
expiration_leeway - (Optional) The amount of leeway to add to expiration (exp) claims to account for clock skew, in seconds. Defaults to 60 seconds if set to 0 and can be disabled if set to -1. Only applicable with "jwt" roles.
not_before_leeway - (Optional) The amount of leeway to add to not before (nbf) claims to account for clock skew, in seconds. Defaults to 60 seconds if set to 0 and can be disabled if set to -1. Only applicable with "jwt" roles.
verbose_oidc_logging - (Optional) Log received OIDC tokens and claims when debug-level logging is active. Not recommended in production since sensitive information may be present in OIDC responses.
max_age - (Optional) Specifies the allowable elapsed time in seconds since the last time the user was actively authenticated with the OIDC provider.

Common Token Arguments:
These arguments are common across several Authentication Token resources since Vault 1.2.
token_ttl - (Optional) The incremental lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time.
token_max_ttl - (Optional) The maximum lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time.
token_period - (Optional) If set, indicates that the token generated using this role should never expire. The token should be renewed within the duration specified by this value. At each renewal, the token's TTL will be set to the value of this field. Specified in seconds.
token_policies - (Optional) List of policies to encode onto generated tokens. Depending on the auth method, this list may be supplemented by user/group/other values.
token_bound_cidrs - (Optional) List of CIDR blocks; if set, specifies blocks of IP addresses which can authenticate successfully, and ties the resulting token to these blocks as well.
token_explicit_max_ttl - (Optional) If set, will encode an explicit max TTL onto the token in number of seconds. This is a hard cap even if token_ttl and token_max_ttl would otherwise allow a renewal.
token_no_default_policy - (Optional) If set, the default policy will not be set on generated tokens; otherwise it will be added to the policies set in token_policies.
token_num_uses - (Optional) The maximum number of times a generated token may be used (within its lifetime); 0 means unlimited.
token_type - (Optional) The type of token that should be generated. Can be service, batch, or default to use the mount's tuned default (which unless changed will be service tokens). For token store roles, there are two additional possibilities: default-service and default-batch which specify the type to return unless the client requests a different type at generation time.
EOF
}

variable "kmip_secret_backend" {
  type = list(object({
    id                          = number
    path                        = string
    namespace                   = optional(string)
    disable_remount             = optional(bool)
    description                 = optional(string)
    listen_addrs                = optional(list(string))
    server_hostnames            = optional(list(string))
    server_ips                  = optional(list(string))
    tls_ca_key_bits             = optional(number)
    tls_ca_key_type             = optional(string)
    tls_min_version             = optional(string)
    default_tls_client_key_bits = optional(number)
    default_tls_client_key_type = optional(string)
    default_tls_client_ttl      = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
path - (Required) The unique path this backend should be mounted at. Must not begin or end with a /. Defaults to kmip.
disable_remount - (Optional) If set, opts out of mount migration on path updates. See here for more info on Mount Migration
description - (Optional) A human-friendly description for this backend.
listen_addrs - (Optional) Addresses the KMIP server should listen on (host:port).
server_hostnames - (Optional) Hostnames to include in the server's TLS certificate as SAN DNS names. The first will be used as the common name (CN).
server_ips - (Optional) IPs to include in the server's TLS certificate as SAN IP addresses.
tls_ca_key_type - (Optional) CA key type, rsa or ec.
tls_ca_key_bits - (Optional) CA key bits, valid values depend on key type.
tls_min_version - (Optional) Minimum TLS version to accept.
default_tls_client_key_type - (Optional) Client certificate key type, rsa or ec.
default_tls_client_key_bits - (Optional) Client certificate key bits, valid values depend on key type.
default_tls_client_key_type - (Optional) Client certificate key type, rsa or ec.
EOF

  validation {
    condition = alltrue([
      for secret in var.kmip_secret_backend : contains(["rsa", "ec"], secret.default_tls_client_key_type)
    ])
    error_message = "Valid values are 'rsa' or 'ec'."
  }
}

variable "kmip_secret_role" {
  type = list(object({
    id                           = number
    path_id                      = number
    scope                        = optional(string)
    namespace                    = optional(string)
    tls_client_key_bits          = optional(number)
    tls_client_key_type          = optional(string)
    tls_client_ttl               = optional(number)
    operation_activate           = optional(bool)
    operation_add_attribute      = optional(bool)
    operation_all                = optional(bool)
    operation_create             = optional(bool)
    operation_destroy            = optional(bool)
    operation_discover_versions  = optional(bool)
    operation_get                = optional(bool)
    operation_get_attribute_list = optional(bool)
    operation_get_attributes     = optional(bool)
    operation_locate             = optional(bool)
    operation_none               = optional(bool)
    operation_register           = optional(bool)
    operation_rekey              = optional(bool)
    operation_revoke             = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
path - (Required) The unique path this backend should be mounted at. Must not begin or end with a /. Defaults to kmip.
scope - (Required) Name of the scope.
role - (Required) Name of the role.
tls_client_key_type - (Optional) Client certificate key type, rsa or ec.
tls_client_key_bits - (Optional) Client certificate key bits, valid values depend on key type.
tls_client_ttl - (Optional) Client certificate TTL in seconds.
operation_activate - (Optional) Grant permission to use the KMIP Activate operation.
operation_add_attribute - (Optional) Grant permission to use the KMIP Add Attribute operation.
operation_all - (Optional) Grant all permissions to this role. May not be specified with any other operation_* params.
operation_create - (Optional) Grant permission to use the KMIP Create operation.
operation_destroy - (Optional) Grant permission to use the KMIP Destroy operation.
operation_discover_versions - (Optional) Grant permission to use the KMIP Discover Version operation.
operation_get - (Optional) Grant permission to use the KMIP Get operation.
operation_get_attribute_list - (Optional) Grant permission to use the KMIP Get Atrribute List operation.
operation_get_attributes - (Optional) Grant permission to use the KMIP Get Atrributes operation.
operation_locate - (Optional) Grant permission to use the KMIP Get Locate operation.
operation_none - (Optional) Remove all permissions from this role. May not be specified with any other operation_* params.
operation_register - (Optional) Grant permission to use the KMIP Register operation.
operation_rekey - (Optional) Grant permission to use the KMIP Rekey operation.
operation_revoke - (Optional) Grant permission to use the KMIP Revoke operation.
EOF

  validation {
    condition = alltrue([
      for secret in var.kmip_secret_role : contains(["rsa", "ec"], secret.tls_client_key_type)
    ])
    error_message = "Valid values are 'rsa' or 'ec'."
  }
}

variable "kmip_secret_scope" {
  type = list(object({
    id        = number
    path_id   = number
    scope     = string
    force     = optional(bool)
    namespace = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
path - (Required) The unique path this backend should be mounted at. Must not begin or end with a /. Defaults to kmip.
scope - (Required) Name of the scope.
force - (Optional) Boolean field to force deletion even if there are managed objects in the scope.
EOF
}

variable "kubernetes_auth_backend_config" {
  type = list(object({
    id                     = number
    kubernetes_host        = string
    backend_id             = optional(number)
    kubernetes_ca_cert     = optional(string)
    token_reviewer_jwt     = optional(string)
    issuer                 = optional(string)
    namespace              = optional(string)
    disable_iss_validation = optional(bool)
    disable_local_ca_jwt   = optional(bool)
    pem_keys               = optional(list(string))
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
kubernetes_host - (Required) Host must be a host string, a host:port pair, or a URL to the base of the Kubernetes API server.
kubernetes_ca_cert - (Optional) PEM encoded CA cert for use by the TLS client used to talk with the Kubernetes API.
token_reviewer_jwt - (Optional) A service account JWT (or other token) used as a bearer token to access the TokenReview API to validate other JWTs during login. If not set the JWT used for login will be used to access the API.
pem_keys - (Optional) List of PEM-formatted public keys or certificates used to verify the signatures of Kubernetes service account JWTs. If a certificate is given, its public key will be extracted. Not every installation of Kubernetes exposes these keys.
issuer - (Optional) JWT issuer. If no issuer is specified, kubernetes.io/serviceaccount will be used as the default issuer.
disable_iss_validation - (Optional) Disable JWT issuer validation. Allows to skip ISS validation. Requires Vault v1.5.4+ or Vault auth kubernetes plugin v0.7.1+
disable_local_ca_jwt - (Optional) Disable defaulting to the local CA cert and service account JWT when running in a Kubernetes pod. Requires Vault v1.5.4+ or Vault auth kubernetes plugin v0.7.1+
EOF
}

variable "kubernetes_auth_backend_role" {
  type = list(object({
    id                               = number
    bound_service_account_names      = list(string)
    bound_service_account_namespaces = list(string)
    role_name                        = string
    backend_id                       = optional(number)
    audience                         = optional(string)
    alias_name_source                = optional(string)
    token_type                       = optional(string)
    token_bound_cidrs                = optional(list(string))
    token_policies                   = optional(list(string))
    token_explicit_max_ttl           = optional(number)
    token_max_ttl                    = optional(number)
    token_num_uses                   = optional(number)
    token_period                     = optional(number)
    token_ttl                        = optional(number)
    token_no_default_policy          = optional(bool)
    namespace_id                     = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
role_name - (Required) Name of the role.
bound_service_account_names - (Required) List of service account names able to access this role. If set to ["*"] all names are allowed, both this and bound_service_account_namespaces can not be "*".
bound_service_account_namespaces - (Required) List of namespaces allowed to access this role. If set to ["*"] all namespaces are allowed, both this and bound_service_account_names can not be set to "*".
backend - (Optional) Unique name of the kubernetes backend to configure.
audience - (Optional) Audience claim to verify in the JWT.

Common Token Arguments
These arguments are common across several Authentication Token resources since Vault 1.2. Its current value will be referenced at renewal time.
token_max_ttl - (Optional) The maximum lifetime for generated tokens in number of seconds. Its current value will be referenced at renewal time.
token_period - (Optional) If set, indicates that the token generated using this role should never expire. The token should be renewed within the duration specified by this value. At each renewal, the token's TTL will be set to the value of this field. Specified in seconds.
token_policies - (Optional) List of policies to encode onto generated tokens. Depending on the auth method, this list may be supplemented by user/group/other values.
token_bound_cidrs - (Optional) List of CIDR blocks; if set, specifies blocks of IP addresses which can authenticate successfully, and ties the resulting token to these blocks as well.
token_explicit_max_ttl - (Optional) If set, will encode an explicit max TTL onto the token in number of seconds. This is a hard cap even if token_ttl and token_max_ttl would otherwise allow a renewal.
token_no_default_policy - (Optional) If set, the default policy will not be set on generated tokens; otherwise it will be added to the policies set in token_policies.
token_num_uses - (Optional) The maximum number of times a generated token may be used (within its lifetime); 0 means unlimited.
token_type - (Optional) The type of token that should be generated. Can be service, batch, or default to use the mount's tuned default (which unless changed will be service tokens). For token store roles, there are two additional possibilities: default-service and default-batch which specify the type to return unless the client requests a different type at generation time.
EOF
}

variable "kubernetes_secret_backend" {
  type = list(object({
    id                   = number
    path                 = string
    namespace            = optional(string)
    kubernetes_ca_cert   = optional(string)
    kubernetes_host      = optional(string)
    service_account_jwt  = optional(string)
    disable_local_ca_jwt = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
kubernetes_host - (Optional) The Kubernetes API URL to connect to. Required if the standard pod environment variables KUBERNETES_SERVICE_HOST or KUBERNETES_SERVICE_PORT are not set on the host that Vault is running on.
kubernetes_ca_cert - (Optional) A PEM-encoded CA certificate used by the secrets engine to verify the Kubernetes API server certificate. Defaults to the local pod’s CA if Vault is running in Kubernetes. Otherwise, defaults to the root CA set where Vault is running.
service_account_jwt - (Optional) The JSON web token of the service account used by the secrets engine to manage Kubernetes credentials. Defaults to the local pod’s JWT if Vault is running in Kubernetes.
disable_local_ca_jwt - (Optional) Disable defaulting to the local CA certificate and service account JWT when Vault is running in a Kubernetes pod.
EOF
}

variable "kubernetes_secret_backend_role" {
  type = list(object({
    id                            = number
    allowed_kubernetes_namespaces = list(string)
    backend_id                    = number
    name                          = string
    namespace                     = optional(string)
    name_template                 = optional(string)
    token_max_ttl                 = optional(number)
    token_default_ttl             = optional(number)
    kubernetes_role_name          = optional(string)
    kubernetes_role_type          = optional(string)
    generated_role_rules          = optional(string)
    extra_annotations             = optional(map(string))
    extra_labels                  = optional(map(string))
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
name - (Required) The name of the role.
backend - (Required) The path of the Kubernetes Secrets Engine backend mount to create the role in.
allowed_kubernetes_namespaces - (Optional) The list of Kubernetes namespaces this role can generate credentials for. If set to * all namespaces are allowed. If set with allowed_kubernetes_namespace_selector, the conditions are ORed.
allowed_kubernetes_namespace_selector - (Optional) A label selector for Kubernetes namespaces in which credentials can be generated. Accepts either a JSON or YAML object. The value should be of type LabelSelector. If set with allowed_kubernetes_namespace, the conditions are ORed.
token_max_ttl - (Optional) The maximum TTL for generated Kubernetes tokens in seconds.
token_default_ttl - (Optional) The default TTL for generated Kubernetes tokens in seconds.
service_account_name - (Optional) The pre-existing service account to generate tokens for. Mutually exclusive with kubernetes_role_name and generated_role_rules. If set, only a Kubernetes token will be created when credentials are requested.
kubernetes_role_name - (Optional) The pre-existing Role or ClusterRole to bind a generated service account to. Mutually exclusive with service_account_name and generated_role_rules. If set, Kubernetes token, service account, and role binding objects will be created when credentials are requested.
kubernetes_role_type - (Optional) Specifies whether the Kubernetes role is a Role or ClusterRole.
generated_role_rules - (Optional) The Role or ClusterRole rules to use when generating a role. Accepts either JSON or YAML formatted rules. Mutually exclusive with service_account_name and kubernetes_role_name. If set, the entire chain of Kubernetes objects will be generated when credentials are requested.
name_template - (Optional) The name template to use when generating service accounts, roles and role bindings. If unset, a default template is used.
extra_annotations - (Optional) Additional annotations to apply to all generated Kubernetes objects.
extra_labels - (Optional) Additional labels to apply to all generated Kubernetes objects.
EOF
}

variable "kv_secret" {
  type = list(object({
    id        = number
    data_json = string
    path_id   = number
    namespace = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
path - (Required) Full path of the KV-V1 secret.
data_json - (Required) JSON-encoded string that will be written as the secret data at the given path.
  EOF
}

variable "kv_secret_backend_v2" {
  type = list(object({
    id                   = number
    mount_id             = number
    namespace            = optional(string)
    max_versions         = optional(number)
    cas_required         = optional(bool)
    delete_version_after = optional(number)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
mount - (Required) Path where KV-V2 engine is mounted.
max_versions - (Optional) The number of versions to keep per key.
cas_required - (Optional) If true, all keys will require the cas parameter to be set on all write requests.
delete_version_after - (Optional) If set, specifies the length of time before a version is deleted. Accepts duration in integer seconds.
  EOF
}

variable "kv_secret_v2" {
  type = list(object({
    id                  = number
    data_json           = string
    mount               = number
    name                = string
    namespace           = optional(string)
    cas                 = optional(number)
    disable_read        = optional(bool)
    delete_all_versions = optional(bool)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
mount - (Required) Path where KV-V2 engine is mounted.
name - (Required) Full name of the secret. For a nested secret the name is the nested path excluding the mount and data prefix. For example, for a secret at kvv2/data/foo/bar/baz the name is foo/bar/baz.
cas - (Optional) This flag is required if cas_required is set to true on either the secret or the engine's config. In order for a write operation to be successful, cas must be set to the current version of the secret.
options - (Optional) An object that holds option settings.
disable_read - (Optional) If set to true, disables reading secret from Vault; note: drift won't be detected.
delete_all_versions - (Optional) If set to true, permanently deletes all versions for the specified key.
data_json - (Required) JSON-encoded string that will be written as the secret data at the given path.
custom_metadata - (Optional) A nested block that allows configuring metadata for the KV secret. Refer to the Configuration Options for more info.
  EOF
}


variable "ldap_auth_backend" {
  type = list(object({
    id                   = number
    url                  = string
    starttls             = optional(bool)
    case_sensitive_names = optional(bool)
    insecure_tls         = optional(bool)
    deny_null_bind       = optional(bool)
    discoverdn           = optional(bool)
    disable_remount      = optional(bool)
    use_token_groups     = optional(bool)
    username_as_alias    = optional(bool)
    local                = optional(bool)
    token_num_uses       = optional(number)
    max_page_size        = optional(number)
    tls_min_version      = optional(string)
    tls_max_version      = optional(string)
    certificate          = optional(string)
    client_tls_cert      = optional(string)
    client_tls_key       = optional(string)
    binddn               = optional(string)
    bindpass             = optional(string)
    upndomain            = optional(string)
    groupattr            = optional(string)
    groupdn              = optional(string)
    groupfilter          = optional(string)
    path                 = optional(string)
    description          = optional(string)
    namespace_id         = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "ldap_auth_backend_group" {
  type = list(object({
    id         = number
    groupname  = string
    namespace  = optional(string)
    policies   = optional(list(string))
    backend_id = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "ldap_auth_backend_user" {
  type = list(object({
    id        = number
    username  = string
    backend   = optional(number)
    groups    = optional(list(number))
    policies  = optional(list(string))
    namespace = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "ldap_secret_backend" {
  type = list(object({
    id                           = number
    binddn                       = string
    bindpass                     = string
    path                         = optional(string)
    url                          = optional(string)
    certificate                  = optional(string)
    client_tls_cert              = optional(string)
    client_tls_key               = optional(string)
    description                  = optional(string)
    upndomain                    = optional(string)
    password_policy              = optional(string)
    schema                       = optional(string)
    userattr                     = optional(string)
    userdn                       = optional(string)
    audit_non_hmac_request_keys  = optional(list(string))
    audit_non_hmac_response_keys = optional(list(string))
    connection_timeout           = optional(number)
    default_lease_ttl_seconds    = optional(number)
    max_lease_ttl_seconds        = optional(number)
    request_timeout              = optional(number)
    starttls                     = optional(bool)
    insecure_tls                 = optional(bool)
    local                        = optional(bool)
    disable_remount              = optional(bool)
    namespace_id                 = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "ldap_secret_backend_dynamic_role" {
  type = list(object({
    id                = number
    creation_ldif     = string
    deletion_ldif     = string
    role_name         = string
    namespace         = optional(string)
    mount             = optional(number)
    rollback_ldif     = optional(string)
    username_template = optional(string)
    default_ttl       = optional(number)
    max_ttl           = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "ldap_secret_backend_library_set" {
  type = list(object({
    id                           = number
    name                         = string
    service_account_names        = list(string)
    mount                        = number
    namespace                    = optional(string)
    ttl                          = optional(number)
    max_ttl                      = optional(number)
    disable_check_in_enforcement = optional(bool)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "ldap_secret_backend_static_role" {
  type = list(object({
    id              = number
    role_name       = string
    rotation_period = number
    username        = string
    mount           = optional(number)
    namespace       = optional(string)
    dn              = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "managed_keys" {
  type = list(object({
    id        = number
    namespace = optional(string)
    aws = optional(list(object({
      access_key         = string
      key_bits           = string
      key_type           = string
      kms_key            = string
      name               = string
      secret_key         = string
      curve              = optional(string)
      endpoint           = optional(string)
      region             = optional(string)
      allow_generate_key = optional(bool)
      allow_replace_key  = optional(bool)
      allow_store_key    = optional(bool)
    })), [])
    azure = optional(list(object({
      client_id          = string
      client_secret      = string
      key_name           = string
      key_type           = string
      name               = string
      tenant_id          = string
      vault_name         = string
      environment        = optional(string)
      resource           = optional(string)
      key_bits           = optional(string)
      allow_generate_key = optional(bool)
      allow_replace_key  = optional(bool)
      allow_store_key    = optional(bool)
    })), [])
    pkcs = optional(list(object({
      key_id             = string
      key_label          = string
      library            = string
      mechanism          = string
      name               = string
      pin                = string
      token_label        = optional(string)
      curve              = optional(string)
      key_bits           = optional(string)
      force_rw_session   = optional(string)
      allow_generate_key = optional(bool)
      allow_replace_key  = optional(bool)
      allow_store_key    = optional(bool)
    })), [])
  }))
  default     = []
  description = <<EOF
EOF
}

variable "mfa_duo" {
  type = list(object({
    id              = number
    api_hostname    = string
    integration_key = string
    mount_accessor  = number
    name            = string
    secret_key      = string
    username_format = string
    namespace       = optional(string)
    push_info       = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "mfa_okta" {
  type = list(object({
    id              = number
    api_token       = string
    mount_accessor  = number
    name            = string
    org_name        = string
    namespace       = optional(string)
    username_format = optional(string)
    base_url        = optional(string)
    primary_email   = optional(bool)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "mfa_pingid" {
  type = list(object({
    id                   = number
    mount_accessor       = number
    name                 = string
    settings_file_base64 = string
    namespace_id         = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "mfa_totp" {
  type = list(object({
    id           = number
    issuer       = string
    name         = string
    namespace_id = optional(number)
    period       = optional(number)
    key_size     = optional(number)
    qr_size      = optional(number)
    algorithm    = optional(string)
    digits       = optional(number)
    skew         = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "mongodbatlas_secret_backend" {
  type = list(object({
    id           = number
    mount        = number
    private_key  = string
    public_key   = string
    namespace_id = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "mongodbatlas_secret_role" {
  type = list(object({
    id              = number
    mount           = number
    name            = string
    roles           = list(string)
    namespace_id    = optional(number)
    organization_id = optional(string)
    project_id      = optional(string)
    project_roles   = optional(list(string))
    ip_addresses    = optional(list(string))
    cidr_blocks     = optional(list(string))
    ttl             = optional(string)
    max_ttl         = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "mount" {
  type = list(object({
    id                           = number
    path                         = string
    type                         = string
    type_id                      = optional(number)
    namespace_id                 = optional(number)
    description                  = optional(string)
    default_lease_ttl_seconds    = optional(number)
    max_lease_ttl_seconds        = optional(number)
    audit_non_hmac_request_keys  = optional(list(string))
    audit_non_hmac_response_keys = optional(list(string))
    local                        = optional(bool)
    options                      = optional(map(string))
    seal_wrap                    = optional(bool)
    external_entropy_access      = optional(bool)
    allowed_managed_keys         = optional(list(string))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "namespace" {
  type = list(object({
    id              = number
    path            = string
    namespace       = optional(string)
    custom_metadata = optional(map(string))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "nomad_secret_backend" {
  type = list(object({
    id                        = number
    backend                   = optional(string)
    namespace_id              = optional(number)
    disable_remount           = optional(bool)
    address                   = optional(string)
    ca_cert                   = optional(string)
    client_cert               = optional(string)
    client_key                = optional(string)
    default_lease_ttl_seconds = optional(number)
    description               = optional(string)
    local                     = optional(bool)
    max_lease_ttl_seconds     = optional(number)
    max_token_name_length     = optional(number)
    max_ttl                   = optional(number)
    token                     = optional(string)
    ttl                       = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "nomad_secret_role" {
  type = list(object({
    id           = number
    backend_id   = optional(number)
    role         = optional(string)
    namespace_id = optional(number)
    global       = optional(bool)
    policies     = optional(list(string))
    type         = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "okta_auth_backend" {
  type = list(object({
    id              = number
    organization    = string
    namespace_id    = optional(number)
    path            = optional(string)
    disable_remount = optional(bool)
    token           = optional(string)
    base_url        = optional(string)
    bypass_okta_mfa = optional(bool)
    ttl             = optional(string)
    max_ttl         = optional(string)
    group = optional(list(object({
      group_name = optional(string)
      policies   = optional(list(string))
    })), [])
    user = optional(list(object({
      username = optional(string)
      groups   = optional(list(string))
      policies = optional(list(string))
    })), [])
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "okta_auth_backend_group" {
  type = list(object({
    id           = number
    group_name   = string
    path_id      = number
    namespace_id = optional(number)
    policies     = optional(list(string))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "okta_auth_backend_user" {
  type = list(object({
    id           = number
    path_id      = number
    username     = string
    namespace_id = optional(number)
    groups       = optional(list(string))
    policies     = optional(list(string))
  }))
  default     = []
  description = <<EOF
  EOF
}

variable "password_policy" {
  type = list(object({
    id           = number
    name         = string
    policy       = string
    namespace_id = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "pki_secret_backend_cert" {
  type = list(object({
    id                    = number
    backend_id            = number
    common_name           = string
    name                  = string
    namespace_id          = optional(number)
    alt_names             = optional(list(string))
    ip_sans               = optional(list(string))
    uri_sans              = optional(list(string))
    other_sans            = optional(list(string))
    user_ids              = optional(list(string))
    ttl                   = optional(string)
    format                = optional(string)
    private_key_format    = optional(string)
    exclude_cn_from_sans  = optional(bool)
    min_seconds_remaining = optional(number)
    auto_renew            = optional(bool)
    revoke                = optional(bool)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "pki_secret_backend_config_ca" {
  type = list(object({
    id           = number
    backend_id   = number
    pem_bundle   = string
    namespace_id = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "pki_secret_backend_config_issuers" {
  type = list(object({
    id                            = number
    backend_id                    = number
    namespace_id                  = optional(number)
    default                       = optional(string)
    default_follows_latest_issuer = optional(bool)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "pki_secret_backend_config_urls" {
  type = list(object({
    id                      = number
    backend_id              = number
    namespace_id            = optional(number)
    issuing_certificates    = optional(list(string))
    crl_distribution_points = optional(list(string))
    ocsp_servers            = optional(list(string))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "pki_secret_backend_crl_config" {
  type = list(object({
    id                            = number
    backend_id                    = number
    namespace_id                  = optional(number)
    expiry                        = optional(string)
    disable                       = optional(bool)
    ocsp_disable                  = optional(bool)
    ocsp_expiry                   = optional(string)
    auto_rebuild                  = optional(bool)
    auto_rebuild_grace_period     = optional(string)
    enable_delta                  = optional(bool)
    delta_rebuild_interval        = optional(string)
    cross_cluster_revocation      = optional(bool)
    unified_crl                   = optional(bool)
    unified_crl_on_existing_paths = optional(bool)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "pki_secret_backend_intermediate_cert_request" {
  type = list(object({
    id                    = number
    backend_id            = number
    common_name           = string
    type                  = string
    namespace_id          = optional(number)
    alt_names             = optional(list(string))
    ip_sans               = optional(list(string))
    uri_sans              = optional(list(string))
    other_sans            = optional(list(string))
    format                = optional(string)
    private_key_format    = optional(string)
    key_bits              = optional(number)
    key_name              = optional(string)
    key_ref               = optional(string)
    key_type              = optional(string)
    managed_key_id        = optional(string)
    managed_key_name      = optional(string)
    ou                    = optional(string)
    organization          = optional(string)
    country               = optional(string)
    locality              = optional(string)
    province              = optional(string)
    street_address        = optional(string)
    postal_code           = optional(string)
    add_basic_constraints = optional(bool)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "pki_secret_backend_intermediate_set_signed" {
  type = list(object({
    id             = number
    backend_id     = number
    certificate_id = number
    namespace      = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "pki_secret_backend_issuer" {
  type = list(object({
    id                             = number
    backend_id                     = number
    issuer_ref                     = string
    namespace_id                   = optional(string)
    issuer_name                    = optional(string)
    leaf_not_after_behavior        = optional(string)
    usage                          = optional(string)
    revocation_signature_algorithm = optional(string)
    manual_chain                   = optional(list(string))
    issuing_certificates           = optional(list(string))
    crl_distribution_points        = optional(list(string))
    ocsp_servers                   = optional(list(string))
    enable_aia_url_templating      = optional(bool)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "pki_secret_backend_key" {
  type = list(object({
    id               = number
    backend_id       = number
    type             = string
    namespace_id     = optional(number)
    key_name         = optional(string)
    key_type         = optional(string)
    key_bits         = optional(number)
    managed_key_name = optional(string)
    managed_key_id   = optional(string)
  }))
  default     = []
  description = <<EOF
The following arguments are supported:
namespace - (Optional) The namespace to provision the resource in. The value should not contain leading or trailing forward slashes. The namespace is always relative to the provider's configured namespace. Available only for Vault Enterprise.
backend - (Required) The path the PKI secret backend is mounted at, with no leading or trailing /s.
type - (Required) Specifies the type of the key to create. Can be exported,internal or kms.
key_name - (Optional) When a new key is created with this request, optionally specifies the name for this. The global ref default may not be used as a name.
key_type - (Optional) Specifies the desired key type; must be rsa, ed25519 or ec.
key_bits - (Optional) Specifies the number of bits to use for the generated keys. Allowed values are 0 (universal default); with key_type=rsa, allowed values are: 2048 (default), 3072, or 4096; with key_type=ec, allowed values are: 224, 256 (default), 384, or 521; ignored with key_type=ed25519.
managed_key_name - (Optional) The managed key's configured name.
managed_key_id - (Optional) The managed key's UUID.
EOF

  validation {
    condition = alltrue([
      for key in var.pki_secret_backend_key : contains(["exported", "internal", "kms"], key.type)
    ])
    error_message = "Valid values are 'exported', 'internal' or 'kms'."
  }

  validation {
    condition = alltrue([
      for key in var.pki_secret_backend_key : contains(["rsa", "ed25519", "ec"], key.key_type)
    ])
    error_message = "Valid values are 'rsa', 'ed25519' or 'ec'."
  }
}

variable "pki_secret_backend_role" {
  type = list(object({
    id                                 = number
    backend_id                         = number
    name                               = string
    namespace_id                       = optional(number)
    allow_any_name                     = optional(bool)
    allow_bare_domains                 = optional(bool)
    allow_glob_domains                 = optional(bool)
    allow_ip_sans                      = optional(bool)
    allow_localhost                    = optional(bool)
    allow_subdomains                   = optional(bool)
    allow_wildcard_certificates        = optional(bool)
    allowed_domains                    = optional(list(string))
    allowed_domains_template           = optional(bool)
    allowed_other_sans                 = optional(list(string))
    allowed_serial_numbers             = optional(list(string))
    allowed_user_ids                   = optional(list(string))
    allowed_uri_sans                   = optional(list(string))
    allowed_uri_sans_template          = optional(bool)
    basic_constraints_valid_for_non_ca = optional(bool)
    client_flag                        = optional(bool)
    code_signing_flag                  = optional(bool)
    country                            = optional(list(string))
    email_protection_flag              = optional(bool)
    enforce_hostnames                  = optional(bool)
    ext_key_usage                      = optional(list(string))
    generate_lease                     = optional(bool)
    issuer_ref                         = optional(string)
    key_bits                           = optional(number)
    key_type                           = optional(string)
    key_usage                          = optional(list(string))
    locality                           = optional(list(string))
    max_ttl                            = optional(string)
    no_store                           = optional(bool)
    not_before_duration                = optional(string)
    organization                       = optional(list(string))
    ou                                 = optional(list(string))
    province                           = optional(list(string))
    postal_code                        = optional(list(string))
    policy_identifiers                 = optional(list(string))
    require_cn                         = optional(bool)
    server_flag                        = optional(bool)
    street_address                     = optional(list(string))
    ttl                                = optional(string)
    use_csr_common_name                = optional(bool)
    use_csr_sans                       = optional(bool)
    policy_identifier = optional(list(object({
      oid    = string
      notice = optional(string)
      cps    = optional(string)
    })), [])
  }))
  default     = []
  description = <<EOF
EOF
  validation {
    condition = alltrue([
      for key in var.pki_secret_backend_key : contains(["rsa", "ed25519", "ec", "any"], key.key_type)
    ])
    error_message = "Valid values are 'any', 'rsa', 'ed25519' or 'ec'."
  }
}

variable "pki_secret_backend_root_cert" {
  type = list(object({
    id                    = number
    backend_id            = number
    common_name           = string
    type                  = string
    namespace_id          = optional(number)
    alt_names             = optional(list(string))
    country               = optional(string)
    exclude_cn_from_sans  = optional(bool)
    format                = optional(string)
    ip_sans               = optional(list(string))
    issuer_name           = optional(string)
    key_bits              = optional(number)
    key_name              = optional(string)
    key_ref               = optional(string)
    key_type              = optional(string)
    locality              = optional(string)
    managed_key_id        = optional(string)
    managed_key_name      = optional(string)
    max_path_length       = optional(number)
    organization          = optional(string)
    other_sans            = optional(list(string))
    ou                    = optional(string)
    permitted_dns_domains = optional(list(string))
    postal_code           = optional(string)
    private_key_format    = optional(string)
    province              = optional(string)
    street_address        = optional(string)
    ttl                   = optional(string)
    uri_sans              = optional(list(string))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "pki_secret_backend_root_sign_intermediate" {
  type = list(object({
    id                    = number
    backend_id            = number
    common_name           = string
    csr_id                = number
    namespace_id          = optional(number)
    alt_names             = optional(list(string))
    country               = optional(string)
    exclude_cn_from_sans  = optional(bool)
    format                = optional(string)
    ip_sans               = optional(list(string))
    issuer_ref            = optional(string)
    locality              = optional(string)
    max_path_length       = optional(number)
    organization          = optional(string)
    other_sans            = optional(list(string))
    ou                    = optional(string)
    permitted_dns_domains = optional(list(string))
    postal_code           = optional(string)
    province              = optional(string)
    revoke                = optional(bool)
    street_address        = optional(string)
    ttl                   = optional(string)
    uri_sans              = optional(list(string))
    use_csr_values        = optional(bool)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "vault_pki_secret_backend_intermediate_cert_request" {
  type = list(object({
    id                    = number
    backend_id            = number
    common_name           = string
    type                  = string
    namespace_id          = optional(number)
    add_basic_constraints = optional(bool)
    alt_names             = optional(list(string))
    country               = optional(string)
    exclude_cn_from_sans  = optional(bool)
    format                = optional(string)
    ip_sans               = optional(list(string))
    key_bits              = optional(number)
    key_name              = optional(string)
    key_ref               = optional(string)
    key_type              = optional(string)
    locality              = optional(string)
    managed_key_id        = optional(string)
    managed_key_name      = optional(string)
    organization          = optional(string)
    other_sans            = optional(list(string))
    ou                    = optional(string)
    postal_code           = optional(string)
    private_key_format    = optional(string)
    province              = optional(string)
    street_address        = optional(string)
    uri_sans              = optional(list(string))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "pki_secret_backend_sign" {
  type = list(object({
    id                    = number
    backend_id            = number
    common_name           = string
    csr                   = string
    name                  = string
    namespace_id          = optional(number)
    alt_names             = optional(list(string))
    auto_renew            = optional(bool)
    exclude_cn_from_sans  = optional(bool)
    format                = optional(string)
    ip_sans               = optional(list(string))
    min_seconds_remaining = optional(number)
    other_sans            = optional(list(string))
    ttl                   = optional(string)
    uri_sans              = optional(list(string))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "policy" {
  type = list(object({
    id           = number
    name         = string
    policy       = string
    namespace_id = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "quota_lease_count" {
  type = list(object({
    id           = number
    max_leases   = number
    name         = string
    namespace_id = optional(number)
    path         = optional(string)
    role         = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "quota_rate_limit" {
  type = list(object({
    id             = number
    name           = string
    rate           = number
    namespace_id   = optional(number)
    path           = optional(string)
    interval       = optional(number)
    block_interval = optional(number)
    role           = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "rabbitmq_secret_backend" {
  type = list(object({
    id                        = number
    connection_uri            = string
    password                  = string
    username                  = string
    namespace                 = optional(number)
    verify_connection         = optional(bool)
    password_policy           = optional(string)
    username_template         = optional(string)
    path                      = optional(string)
    disable_remount           = optional(bool)
    description               = optional(string)
    default_lease_ttl_seconds = optional(number)
    max_lease_ttl_seconds     = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "rabbitmq_secret_backend_role" {
  type = list(object({
    id           = number
    backend_id   = number
    name         = string
    namespace_id = optional(number)
    tags         = optional(string)
    vhost = optional(list(object({
      configure = string
      host      = string
      read      = string
      write     = string
    })), [])
    vhost_topic = optional(list(object({
      host = string
      vhost = optional(list(object({
        read  = string
        topic = string
        write = string
      })), [])
    })), [])
  }))
  default     = []
  description = <<EOF
EOF
}

variable "raft_autopilot" {
  type = list(object({
    id                                 = number
    cleanup_dead_servers               = optional(bool)
    dead_server_last_contact_threshold = optional(string)
    disable_upgrade_migration          = optional(bool)
    last_contact_threshold             = optional(string)
    max_trailing_logs                  = optional(number)
    min_quorum                         = optional(number)
    namespace_id                       = optional(number)
    server_stabilization_time          = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "raft_snapshot_agent_config" {
  type = list(object({
    id                            = number
    interval_seconds              = number
    name                          = string
    path_prefix                   = string
    storage_type                  = string
    namespace                     = optional(number)
    retain                        = optional(number)
    file_prefix                   = optional(string)
    local_max_space               = optional(string)
    aws_access_key_id             = optional(string)
    aws_s3_bucket                 = optional(string)
    aws_s3_disable_tls            = optional(bool)
    aws_s3_enable_kms             = optional(bool)
    aws_s3_endpoint               = optional(string)
    aws_s3_force_path_style       = optional(bool)
    aws_s3_kms_key                = optional(string)
    aws_s3_region                 = optional(string)
    aws_s3_server_side_encryption = optional(bool)
    aws_secret_access_key         = optional(string)
    aws_session_token             = optional(string)
    google_disable_tls            = optional(bool)
    google_endpoint               = optional(string)
    google_gcs_bucket             = optional(string)
    google_service_account_key    = optional(string)
    azure_account_key             = optional(string)
    azure_account_name            = optional(string)
    azure_blob_environment        = optional(string)
    azure_container_name          = optional(string)
    azure_endpoint                = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "rgp_policy" {
  type = list(object({
    id                = number
    enforcement_level = string
    name              = string
    policy            = string
    namespace_id      = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "saml_auth_backend" {
  type = list(object({
    id               = number
    acs_urls         = list(string)
    entity_id        = string
    default_role     = optional(string)
    disable_remount  = optional(bool)
    idp_cert         = optional(string)
    idp_entity_id    = optional(string)
    idp_metadata_url = optional(string)
    idp_sso_url      = optional(string)
    namespace_id     = optional(number)
    path             = optional(string)
    verbose_logging  = optional(bool)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "saml_auth_backend_role" {
  type = list(object({
    id                    = number
    name                  = string
    path_id               = number
    namespace_id          = optional(number)
    bound_attributes      = optional(map(string))
    bound_attributes_type = optional(string)
    bound_subjects        = optional(list(string))
    bound_subjects_type   = optional(string)
    token_bound_cidrs     = optional(list(string))
    groups_attribute      = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "ssh_secret_backend_ca" {
  type = list(object({
    id                   = number
    namespace_id         = optional(number)
    backend_id           = optional(number)
    generate_signing_key = optional(bool)
    public_key           = optional(string)
    private_key          = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "ssh_secret_backend_role" {
  type = list(object({
    id                       = number
    backend_id               = number
    key_type                 = string
    name                     = string
    namespace_id             = optional(number)
    algorithm_signer         = optional(string)
    allow_bare_domains       = optional(bool)
    allow_host_certificates  = optional(bool)
    allow_subdomains         = optional(bool)
    allow_user_certificates  = optional(bool)
    allow_user_key_ids       = optional(bool)
    allowed_critical_options = optional(string)
    allowed_domains          = optional(string)
    allowed_domains_template = optional(bool)
    allowed_extensions       = optional(string)
    allowed_users            = optional(string)
    allowed_users_template   = optional(bool)
    cidr_list                = optional(string)
    default_critical_options = optional(map(string))
    default_extensions       = optional(map(string))
    default_user             = optional(string)
    default_user_template    = optional(bool)
    key_id_format            = optional(string)
    max_ttl                  = optional(string)
    not_before_duration      = optional(string)
    ttl                      = optional(string)
    allowed_user_key_config = optional(list(object({
      lengths = list(number)
      type    = string
    })), [])
  }))
  default     = []
  description = <<EOF
EOF
}

variable "terraform_cloud_secret_backend" {
  type = list(object({
    id                        = number
    namespace_id              = optional(number)
    token                     = optional(string)
    backend                   = optional(string)
    disable_remount           = optional(bool)
    description               = optional(string)
    default_lease_ttl_seconds = optional(number)
    max_lease_ttl_seconds     = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "terraform_cloud_secret_creds" {
  type = list(object({
    id           = number
    backend_id   = number
    role         = string
    namespace_id = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "terraform_cloud_secret_role" {
  type = list(object({
    id           = number
    name         = string
    backend_id   = optional(number)
    namespace_id = optional(number)
    organization = optional(string)
    team_id      = optional(string)
    user_id      = optional(string)
    max_ttl      = optional(number)
    ttl          = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "token" {
  type = list(object({
    id                = number
    namespace_id      = optional(number)
    role_name         = optional(string)
    policies          = optional(list(string))
    no_default_policy = optional(bool)
    renewable         = optional(bool)
    ttl               = optional(string)
    explicit_max_ttl  = optional(string)
    display_name      = optional(string)
    num_uses          = optional(number)
    period            = optional(string)
    renew_min_lease   = optional(number)
    renew_increment   = optional(number)
    metadata          = optional(map(string))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "token_auth_backend_role" {
  type = list(object({
    id                       = number
    role_name                = string
    namespace_id             = optional(number)
    allowed_entity_aliases   = optional(list(string))
    allowed_policies         = optional(list(string))
    allowed_policies_glob    = optional(list(string))
    disallowed_policies      = optional(list(string))
    disallowed_policies_glob = optional(list(string))
    orphan                   = optional(bool)
    renewable                = optional(bool)
    path_suffix              = optional(string)
    token_bound_cidrs        = optional(list(string))
    token_explicit_max_ttl   = optional(number)
    token_max_ttl            = optional(number)
    token_no_default_policy  = optional(bool)
    token_num_uses           = optional(number)
    token_period             = optional(number)
    token_policies           = optional(list(string))
    token_ttl                = optional(number)
    token_type               = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "transform_alphabet" {
  type = list(object({
    id           = number
    name         = string
    path_id      = number
    alphabet     = optional(string)
    namespace_id = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "transform_role" {
  type = list(object({
    id              = number
    name            = string
    path_id         = number
    namespace_id    = optional(number)
    transformations = optional(list(string))
  }))
  default     = []
  description = <<EOF
EOF
}

variable "transform_template" {
  type = list(object({
    id             = number
    name           = string
    path_id        = number
    alphabet       = optional(string)
    decode_formats = optional(map(string))
    encode_format  = optional(string)
    namespace_id   = optional(number)
    pattern        = optional(string)
    type           = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "transform_transformation" {
  type = list(object({
    id                = number
    name              = string
    path_id           = number
    namespace_id      = optional(number)
    allowed_roles     = optional(list(string))
    deletion_allowed  = optional(bool)
    masking_character = optional(string)
    template          = optional(string)
    templates         = optional(list(string))
    tweak_source      = optional(string)
    type              = optional(string)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "transit_secret_backend_key" {
  type = list(object({
    id                     = number
    backend_id             = number
    name                   = string
    namespace_id           = optional(number)
    type                   = optional(string)
    deletion_allowed       = optional(bool)
    derived                = optional(bool)
    convergent_encryption  = optional(bool)
    exportable             = optional(bool)
    allow_plaintext_backup = optional(bool)
    min_decryption_version = optional(number)
    min_encryption_version = optional(number)
    auto_rotate_period     = optional(number)
    key_size               = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}

variable "transit_secret_cache_config" {
  type = list(object({
    id           = number
    backend_id   = number
    size         = number
    namespace_id = optional(number)
  }))
  default     = []
  description = <<EOF
EOF
}
