variable "account" {
  type = list(object({
    id             = number
    auth_method_id = number
    type           = string
    description    = optional(string)
    login_name     = optional(string)
    name           = optional(string)
    password       = optional(string)
  }))
  default     = []
  description = <<EOF
Required
auth_method_id (String) The resource ID for the auth method.
type (String) The resource type.
Optional
description (String) The account description.
login_name (String) The login name for this account.
name (String) The account name. Defaults to the resource name.
password (String, Sensitive) The account password. Only set on create, changes will not be reflected when updating account.
  EOF
}

variable "account_ldap" {
  type = list(object({
    id             = number
    auth_method_id = number
    description    = optional(string)
    login_name     = optional(string)
    name           = optional(string)
  }))
  default     = []
  description = <<EOF
Required
auth_method_id (String) The resource ID for the auth method.
Optional
description (String) The account description.
login_name (String) The login name for this account.
name (String) The account name. Defaults to the resource name.
type (String, Deprecated) The resource type.
  EOF
}

variable "account_oidc" {
  type = list(object({
    id             = number
    auth_method_id = number
    description    = optional(string)
    issuer         = optional(string)
    name           = optional(string)
    subject        = optional(string)
  }))
  default     = []
  description = <<EOF
Required
auth_method_id (String) The resource ID for the auth method.
Optional
description (String) The account description.
issuer (String) The OIDC issuer.
name (String) The account name. Defaults to the resource name.
subject (String) The OIDC subject.
  EOF
}

variable "account_password" {
  type = list(object({
    id             = number
    auth_method_id = number
    description    = optional(string)
    login_name     = optional(string)
    name           = optional(string)
    password       = optional(string)
  }))
  default     = []
  description = <<EOF
Required
auth_method_id (String) The resource ID for the auth method.
Optional
description (String) The account description.
login_name (String) The login name for this account.
name (String) The account name. Defaults to the resource name.
password (String, Sensitive) The account password. Only set on create, changes will not be reflected when updating account.
type (String, Deprecated) The resource type.
  EOF
}

variable "auth_method" {
  type = list(object({
    id          = number
    scope_id    = number
    type        = string
    description = optional(string)
    name        = optional(string)
  }))
  default     = []
  description = <<EOF
Required
scope_id (String) The scope ID.
type (String) The resource type.
Optional
description (String) The auth method description.
min_login_name_length (Number, Deprecated) The minimum login name length.
min_password_length (Number, Deprecated) The minimum password length.
name (String) The auth method name. Defaults to the resource name.
  EOF
}

variable "auth_method_oidc" {
  type = list(object({
    id                                   = number
    scope_id                             = number
    account_claim_maps                   = optional(list(string))
    allowed_audiences                    = optional(list(string))
    api_url_prefix                       = optional(string)
    callback_url                         = optional(string)
    claims_scopes                        = optional(list(string))
    client_id                            = optional(string)
    client_secret                        = optional(string)
    client_secret_hmac                   = optional(string)
    description                          = optional(string)
    disable_discovered_config_validation = optional(bool)
    idp_ca_certs                         = optional(list(string))
    is_primary_for_scope                 = optional(bool)
    issuer                               = optional(string)
    max_age                              = optional(number)
    name                                 = optional(string)
    prompts                              = optional(list(string))
    signing_algorithms                   = optional(list(string))
    state                                = optional(string)
    type                                 = optional(string)
  }))
  default     = []
  description = <<EOF
Required
scope_id (String) The scope ID.
Optional
account_attribute_maps (List of String) Account attribute maps fullname and email.
anon_group_search (Boolean) Use anon bind when performing LDAP group searches (optional).
bind_dn (String) The distinguished name of entry to bind when performing user and group searches (optional).
bind_password (String) The password to use along with bind-dn performing user and group searches (optional).
bind_password_hmac (String) The HMAC of the bind password returned by the Boundary controller, which is used for comparison after initial setting of the value.
certificates (List of String) PEM-encoded X.509 CA certificate in ASN.1 DER form that can be used as a trust anchor when connecting to an LDAP server(optional). This may be specified multiple times
client_certificate (String) PEM-encoded X.509 client certificate in ASN.1 DER form that can be used to authenticate against an LDAP server(optional).
client_certificate_key (String) PEM-encoded X.509 client certificate key in PKCS #8, ASN.1 DER form used with the client certificate (optional).
client_certificate_key_hmac (String) The HMAC of the client certificate key returned by the Boundary controller, which is used for comparison after initial setting of the value.
dereference_aliases (String) Control how aliases are dereferenced when performing the search. Can be one of: NeverDerefAliases, DerefInSearching, DerefFindingBaseObj, and DerefAlways (optional).
description (String) The auth method description.
discover_dn (Boolean) Use anon bind to discover the bind DN of a user (optional).
enable_groups (Boolean) Find the authenticated user's groups during authentication (optional).
group_attr (String) The attribute that enumerates a user's group membership from entries returned by a group search (optional).
group_dn (String) The base DN under which to perform group search.
group_filter (String) A go template used to construct a LDAP group search filter (optional).
insecure_tls (Boolean) Skip the LDAP server SSL certificate validation (optional) - insecure and use with caution.
is_primary_for_scope (Boolean) When true, makes this auth method the primary auth method for the scope in which it resides. The primary auth method for a scope means the the user will be automatically created when they login using an LDAP account.
maximum_page_size (Number) MaximumPageSize specifies a maximum search result size to use when retrieving the authenticated user's groups (optional).
name (String) The auth method name. Defaults to the resource name.
start_tls (Boolean) Issue StartTLS command after connecting (optional).
state (String) Can be one of 'inactive', 'active-private', or 'active-public'. Defaults to active-public.
type (String) The type of auth method; hardcoded.
upn_domain (String) The userPrincipalDomain used to construct the UPN string for the authenticating user (optional).
urls (List of String) The LDAP URLs that specify LDAP servers to connect to (required). May be specified multiple times.
use_token_groups (Boolean) Use the Active Directory tokenGroups constructed attribute of the user to find the group memberships (optional).
user_attr (String) The attribute on user entry matching the username passed when authenticating (optional).
user_dn (String) The base DN under which to perform user search (optional).
user_filter (String) A go template used to construct a LDAP user search filter (optional).
  EOF
}

variable "auth_method_ldap" {
  type = list(object({
    id                          = number
    scope_id                    = number
    account_attribute_maps      = optional(list(string))
    anon_group_search           = optional(bool)
    bind_dn                     = optional(string)
    bind_password               = optional(string)
    bind_password_hmac          = optional(string)
    certificates                = optional(list(string))
    client_certificate          = optional(string)
    client_certificate_key      = optional(string)
    client_certificate_key_hmac = optional(string)
    dereference_aliases         = optional(string)
    description                 = optional(string)
    discover_dn                 = optional(bool)
    enable_groups               = optional(bool)
    group_attr                  = optional(string)
    group_dn                    = optional(string)
    group_filter                = optional(string)
    insecure_tls                = optional(bool)
    is_primary_for_scope        = optional(bool)
    maximum_page_size           = optional(number)
    name                        = optional(string)
    start_tls                   = optional(bool)
    state                       = optional(string)
    type                        = optional(string)
    upn_domain                  = optional(string)
    urls                        = optional(list(string))
    use_token_groups            = optional(bool)
    user_attr                   = optional(string)
    user_dn                     = optional(string)
    user_filter                 = optional(string)
  }))
  default     = []
  description = <<EOF
Required
scope_id (String) The scope ID.
Optional
account_claim_maps (List of String) Account claim maps for the to_claim of sub.
allowed_audiences (List of String) Audiences for which the provider responses will be allowed
api_url_prefix (String) The API prefix to use when generating callback URLs for the provider. Should be set to an address at which the provider can reach back to the controller.
callback_url (String) The URL that should be provided to the IdP for callbacks.
claims_scopes (List of String) Claims scopes.
client_id (String) The client ID assigned to this auth method from the provider.
client_secret (String, Sensitive) The secret key assigned to this auth method from the provider. Once set, only the hash will be kept and the original value can be removed from configuration.
client_secret_hmac (String) The HMAC of the client secret returned by the Boundary controller, which is used for comparison after initial setting of the value.
description (String) The auth method description.
disable_discovered_config_validation (Boolean) Disables validation logic ensuring that the OIDC provider's information from its discovery endpoint matches the information here. The validation is only performed at create or update time.
idp_ca_certs (List of String) A list of CA certificates to trust when validating the IdP's token signatures.
is_primary_for_scope (Boolean) When true, makes this auth method the primary auth method for the scope in which it resides. The primary auth method for a scope means the user will be automatically created when they login using an OIDC account.
issuer (String) The issuer corresponding to the provider, which must match the issuer field in generated tokens.
max_age (Number) The max age to provide to the provider, indicating how much time is allowed to have passed since the last authentication before the user is challenged again. A value of 0 sets an immediate requirement for all users to reauthenticate, and an unset maxAge results in a Terraform value of -1 and the default TTL of the chosen OIDC will be used.
name (String) The auth method name. Defaults to the resource name.
prompts (List of String) The prompts passed to the identity provider to determine whether to prompt the end-user for reauthentication, account selection or consent. Please note the values passed are case-sensitive. The valid values are: none, login, consent and select_account.
signing_algorithms (List of String) Allowed signing algorithms for the provider's issued tokens.
state (String) Can be one of 'inactive', 'active-private', or 'active-public'. Currently automatically set to active-public.
type (String) The type of auth method; hardcoded.
  EOF
}

variable "auth_method_password" {
  type = list(object({
    id                    = number
    scope_id              = number
    description           = optional(string)
    min_login_name_length = optional(number)
    min_password_length   = optional(number)
    name                  = optional(string)
    type                  = optional(string)
  }))
  default     = []
  description = <<EOF
Required
scope_id (String) The scope ID.
Optional
description (String) The auth method description.
min_login_name_length (Number) The minimum login name length.
min_password_length (Number) The minimum password length.
name (String) The auth method name. Defaults to the resource name.
type (String) The resource type, hardcoded per resource
  EOF
}

variable "credential_json" {
  type = list(object({
    id                  = number
    credential_store_id = number
    object              = string
    description         = optional(string)
    name                = optional(string)
  }))
  default     = []
  description = <<EOF
Required
credential_store_id (String) The credential store in which to save this json credential.
object (String, Sensitive) The object for the this json credential. Either values encoded with the "jsonencode" function, pre-escaped JSON string, or a file
Optional
description (String) The description of this json credential.
name (String) The name of this json credential. Defaults to the resource name.
  EOF
}

variable "credential_library_vault" {
  type = list(object({
    id                           = number
    credential_store_id          = number
    path                         = string
    credential_mapping_overrides = optional(map(string))
    credential_type              = optional(string)
    description                  = optional(string)
    http_method                  = optional(string)
    http_request_body            = optional(string)
    name                         = optional(string)
  }))
  default     = []
  description = <<EOF
Required
credential_store_id (String) The ID of the credential store that this library belongs to.
path (String) The path in Vault to request credentials from.
Optional
credential_mapping_overrides (Map of String) The credential mapping override.
credential_type (String) The type of credential the library generates. Cannot be updated on an existing resource.
description (String) The Vault credential library description.
http_method (String) The HTTP method the library uses when requesting credentials from Vault. Defaults to 'GET'
http_request_body (String) The body of the HTTP request the library sends to Vault when requesting credentials. Only valid if http_method is set to POST.
name (String) The Vault credential library name. Defaults to the resource name.
  EOF
}

variable "credential_library_vault_ssh_certificate" {
  type = list(object({
    id                  = number
    credential_store_id = number
    path                = string
    username            = string
    critical_options    = optional(map(string))
    description         = optional(string)
    extensions          = optional(map(string))
    key_bits            = optional(number)
    key_id              = optional(string)
    key_type            = optional(string)
    name                = optional(string)
    ttl                 = optional(string)
  }))
  default     = []
  description = <<EOF
Required
credential_store_id (String) The ID of the credential store that this library belongs to.
path (String) The path in Vault to request credentials from.
username (String) The username to use with the certificate returned by the library.
Optional
additional_valid_principals (List of String) Principals to be signed as "valid_principles" in addition to username.
critical_options (Map of String) Specifies a map of the critical options that the certificate should be signed for.
description (String) The Vault credential library description.
extensions (Map of String) Specifies a map of the extensions that the certificate should be signed for.
key_bits (Number) Specifies the number of bits to use for the generated keys.
key_id (String) Specifies the key id a certificate should have.
key_type (String) Specifies the desired key type; must be ed25519, ecdsa, or rsa.
name (String) The Vault credential library name. Defaults to the resource name.
ttl (String) Specifies the requested time to live for a certificate returned from the library.
  EOF
}

variable "credential_ssh_private_key" {
  type = list(object({
    id                     = number
    credential_store_id    = number
    private_key            = string
    username               = string
    description            = optional(string)
    name                   = optional(string)
    private_key_passphrase = optional(string)
  }))
  default     = []
  description = <<EOF
Required
credential_store_id (String) ID of the credential store this credential belongs to.
private_key (String, Sensitive) The private key associated with the credential.
username (String) The username associated with the credential.
Optional
description (String) The description of the credential.
name (String) The name of the credential. Defaults to the resource name.
private_key_passphrase (String, Sensitive) The passphrase of the private key associated with the credential.
  EOF
}

variable "credential_store_static" {
  type = list(object({
    id          = number
    scope_id    = number
    description = string
    name        = string
  }))
  default     = []
  description = <<EOF
Required
scope_id (String) The scope for this credential store.
Optional
description (String) The static credential store description.
name (String) The static credential store name. Defaults to the resource name.
  EOF
}

variable "credential_store_vault" {
  type = list(object({
    id                     = number
    address                = string
    scope_id               = number
    token                  = string
    ca_cert                = optional(string)
    client_certificate     = optional(string)
    client_certificate_key = optional(string)
    description            = optional(string)
    name                   = optional(string)
    namespace              = optional(string)
    tls_server_name        = optional(string)
    tls_skip_verify        = optional(bool)
    worker_filter          = optional(string)
  }))
  default     = []
  description = <<EOF
Required
address (String) The address to Vault server. This should be a complete URL such as 'https://127.0.0.1:8200'
scope_id (String) The scope for this credential store.
token (String, Sensitive) A token used for accessing Vault.
Optional
ca_cert (String) A PEM-encoded CA certificate to verify the Vault server's TLS certificate.
client_certificate (String) A PEM-encoded client certificate to use for TLS authentication to the Vault server.
client_certificate_key (String, Sensitive) A PEM-encoded private key matching the client certificate from 'client_certificate'.
description (String) The Vault credential store description.
name (String) The Vault credential store name. Defaults to the resource name.
namespace (String) The namespace within Vault to use.
tls_server_name (String) Name to use as the SNI host when connecting to Vault via TLS.
tls_skip_verify (Boolean) Whether or not to skip TLS verification.
worker_filter (String) HCP Only. A filter used to control which PKI workers can handle Vault requests. This allows the use of private Vault instances with Boundary.
  EOF
}

variable "credential_username_password" {
  type = list(object({
    id                  = number
    credential_store_id = number
    password            = string
    username            = string
    description         = optional(string)
    name                = optional(string)
  }))
  default     = []
  description = <<EOF
Required
credential_store_id (String) The credential store in which to save this username/password credential.
password (String, Sensitive) The password of this username/password credential.
username (String) The username of this username/password credential.
Optional
description (String) The description of this username/password credential.
name (String) The name of this username/password credential. Defaults to the resource name.
  EOF
}

variable "group" {
  type = list(object({
    id          = number
    scope_id    = number
    description = optional(string)
    member_ids  = optional(list(number))
    name        = optional(string)
  }))
  default     = []
  description = <<EOF
Required
scope_id (String) The scope ID in which the resource is created. Defaults to the provider's default_scope if unset.
Optional
description (String) The group description.
member_ids (Set of String) Resource IDs for group members, these are most likely boundary users.
name (String) The group name. Defaults to the resource name.
  EOF
}

variable "host" {
  type = list(object({
    id              = number
    host_catalog_id = number
    type            = string
    address         = optional(string)
    description     = optional(string)
    name            = optional(string)
  }))
  default     = []
  description = <<EOF
Required
host_catalog_id (String)
type (String) The type of host
Optional
address (String) The static address of the host resource as <IP> (note: port assignment occurs in the target resource definition, do not add :port here) or a domain name.
description (String) The host description.
name (String) The host name. Defaults to the resource name.
  EOF
}

variable "host_catalog" {
  type = list(object({
    id          = number
    scope_id    = number
    type        = string
    description = optional(string)
    name        = optional(string)
  }))
  default     = []
  description = <<EOF
Required
scope_id (String) The scope ID in which the resource is created.
type (String) The host catalog type. Only static is supported.
Optional
description (String) The host catalog description.
name (String) The host catalog name. Defaults to the resource name.
  EOF
}

variable "host_catalog_plugin" {
  type = list(object({
    id                                         = number
    scope_id                                   = number
    attributes_json                            = optional(string)
    description                                = optional(string)
    internal_force_update                      = optional(string)
    internal_hmac_used_for_secrets_config_hmac = optional(string)
    internal_secrets_config_hmac               = optional(string)
    name                                       = optional(string)
    plugin_id                                  = optional(string)
    plugin_name                                = optional(string)
    secrets_hmac                               = optional(string)
    secrets_json                               = optional(string)
  }))
  default     = []
  description = <<EOF
Required
scope_id (String) The scope ID in which the resource is created.
Optional
attributes_json (String) The attributes for the host catalog. Either values encoded with the "jsonencode" function, pre-escaped JSON string, or a file:// or env:// path. Set to a string "null" or remove the block to clear all attributes in the host catalog.
description (String) The host catalog description.
internal_force_update (String) Internal only. Used to force update so that we can always check the value of secrets.
internal_hmac_used_for_secrets_config_hmac (String) Internal only. The Boundary-provided HMAC used to calculate the current value of the HMAC'd config. Used for drift detection.
internal_secrets_config_hmac (String) Internal only. HMAC of (serverSecretsHmac + config secrets). Used for proper secrets handling.
name (String) The host catalog name. Defaults to the resource name.
plugin_id (String) The ID of the plugin that should back the resource. This or plugin_name must be defined.
plugin_name (String) The name of the plugin that should back the resource. This or plugin_id must be defined.
secrets_hmac (String) The HMAC'd secrets value returned from the server.
secrets_json (String, Sensitive) The secrets for the host catalog. Either values encoded with the "jsonencode" function, pre-escaped JSON string, or a file:// or env:// path. Set to a string "null" to clear any existing values. NOTE: Unlike "attributes_json", removing this block will NOT clear secrets from the host catalog; this allows injecting secrets for one call, then removing them for storage.
  EOF
}

variable "host_catalog_static" {
  type = list(object({
    id          = number
    scope_id    = number
    description = optional(string)
    name        = optional(string)
  }))
  default     = []
  description = <<EOF
Required
scope_id (String) The scope ID in which the resource is created.
Optional
description (String) The host catalog description.
name (String) The host catalog name. Defaults to the resource name.
  EOF
}

variable "host_set" {
  type = list(object({
    id              = number
    host_catalog_id = number
    type            = string
    description     = optional(string)
    host_ids        = optional(list(number))
    name            = optional(string)
  }))
  default     = []
  description = <<EOF
Required
host_catalog_id (String) The catalog for the host set.
type (String) The type of host set
Optional
description (String) The host set description.
host_ids (Set of String) The list of host IDs contained in this set.
name (String) The host set name. Defaults to the resource name.
  EOF
}

variable "host_set_plugin" {
  type = list(object({
    id                    = number
    host_catalog_id       = number
    attributes_json       = optional(string)
    description           = optional(string)
    name                  = optional(string)
    preferred_endpoints   = optional(list(string))
    sync_interval_seconds = optional(number)
    type                  = optional(string)
  }))
  default     = []
  description = <<EOF
Required
host_catalog_id (String) The catalog for the host set.
Optional
attributes_json (String) The attributes for the host set. Either values encoded with the "jsonencode" function, pre-escaped JSON string, or a file:// or env:// path. Set to a string "null" or remove the block to clear all attributes in the host set.
description (String) The host set description.
name (String) The host set name. Defaults to the resource name.
preferred_endpoints (List of String) The ordered list of preferred endpoints.
sync_interval_seconds (Number) The value to set for the sync interval seconds.
type (String) The type of host set
  EOF
}

variable "host_set_static" {
  type = list(object({
    id              = number
    host_catalog_id = number
    description     = optional(string)
    host_ids        = optional(list(number))
    name            = optional(string)
    type            = optional(string)
  }))
  default     = []
  description = <<EOF
Required
host_catalog_id (String) The catalog for the host set.
Optional
description (String) The host set description.
host_ids (Set of String) The list of host IDs contained in this set.
name (String) The host set name. Defaults to the resource name.
type (String) The type of host set
  EOF
}

variable "host_static" {
  type = list(object({
    id              = number
    host_catalog_id = number
    address         = optional(string)
    description     = optional(string)
    name            = optional(string)
    type            = optional(string)
  }))
  default     = []
  description = <<EOF
Required
host_catalog_id (String)
Optional
address (String) The static address of the host resource as <IP> (note: port assignment occurs in the target resource definition, do not add :port here) or a domain name.
description (String) The host description.
name (String) The host name. Defaults to the resource name.
type (String) The type of host
  EOF
}

variable "managed_group" {
  type = list(object({
    id             = number
    auth_method_id = number
    filter         = string
    description    = optional(string)
    name           = optional(string)
  }))
  default     = []
  description = <<EOF
Required
auth_method_id (String) The resource ID for the auth method.
filter (String) Boolean expression to filter the workers for this managed group.
Optional
description (String) The managed group description.
name (String) The managed group name. Defaults to the resource name.
  EOF
}

variable "managed_group_ldap" {
  type = list(object({
    id             = number
    auth_method_id = number
    group_names    = list(string)
    description    = optional(string)
    name           = optional(string)
  }))
  default     = []
  description = <<EOF
Required
auth_method_id (String) The resource ID for the auth method.
group_names (List of String) The list of groups that make up the managed group.
Optional
description (String) The managed group description.
name (String) The managed group name. Defaults to the resource name.
  EOF
}

variable "role" {
  type = list(object({
    id             = number
    scope_id       = number
    description    = optional(string)
    grant_strings  = optional(list(string))
    name           = optional(string)
    principal_ids  = optional(list(number))
  }))
  default     = []
  description = <<EOF
Required
scope_id (String) The scope ID in which the resource is created. Defaults to the provider's default_scope if unset.
Optional
description (String) The role description.
grant_scope_id (String, Deprecated) For Boundary 0.15+, use grant_scope_ids instead. The scope for which the grants in the role should apply.
grant_scope_ids (Set of String) A list of scopes for which the grants in this role should apply, which can include the special values "this", "children", or "descendants"
grant_strings (Set of String) A list of stringified grants for the role.
name (String) The role name. Defaults to the resource name.
principal_ids (Set of String) A list of principal (user or group) IDs to add as principals on the role.
  EOF
}

variable "scope" {
  type = list(object({
    id                       = number
    scope_id                 = number
    auto_create_admin_role   = optional(bool)
    auto_create_default_role = optional(bool)
    description              = optional(string)
    global_scope             = optional(bool)
    name                     = optional(string)
  }))
  default     = []
  description = <<EOF
Required
scope_id (String) The scope ID containing the sub scope resource.
Optional
auto_create_admin_role (Boolean) If set, when a new scope is created, the provider will not disable the functionality that automatically creates a role in the new scope and gives permissions to manage the scope to the provider's user. Marking this true makes for simpler HCL but results in role resources that are unmanaged by Terraform.
auto_create_default_role (Boolean) Only relevant when creating an org scope. If set, when a new scope is created, the provider will not disable the functionality that automatically creates a role in the new scope and gives listing of scopes and auth methods and the ability to authenticate to the anonymous user. Marking this true makes for simpler HCL but results in role resources that are unmanaged by Terraform.
description (String) The scope description.
global_scope (Boolean) Indicates that the scope containing this value is the global scope, which triggers some specialized behavior to allow it to be imported and managed.
name (String) The scope name. Defaults to the resource name.
  EOF
}

variable "storage_bucket" {
  type = list(object({
    id              = number
    bucket_name     = string
    scope_id        = number
    secrets_json    = optional(string)
    worker_filter   = string
    attributes_json = optional(string)
    bucket_prefix   = optional(string)
    description     = optional(string)
    name            = optional(string)
    plugin_id       = optional(string)
    plugin_name     = optional(string)
  }))
  default     = []
  description = <<EOF
Required
bucket_name (String) The name of the bucket within the external object store service.
scope_id (String) The scope for this storage bucket.
worker_filter (String) Filters to the worker(s) that can handle requests for this storage bucket. The filter must match an existing worker in order to create a storage bucket.
Optional
attributes_json (String) The attributes for the storage bucket. The "region" attribute field is required when creating an AWS storage bucket. Values are either encoded with the "jsonencode" function, pre-escaped JSON string, or a file:// or env:// path. Set to a string "null" or remove the block to clear all attributes in the storage bucket.
bucket_prefix (String) The prefix used to organize the data held within the external object store.
description (String) The storage bucket description.
name (String) The storage bucket name. Defaults to the resource name.
plugin_id (String) The ID of the plugin that should back the resource. This or plugin_name must be defined.
plugin_name (String) The name of the plugin that should back the resource. This or plugin_id must be defined.
secrets_json (String, Sensitive) The secrets for the storage bucket. Either values encoded with the "jsonencode" function, pre-escaped JSON string, or a file:// or env:// path. Set to a string "null" to clear any existing values. NOTE: Unlike "attributes_json", removing this block will NOT clear secrets from the storage bucket; this allows injecting secrets for one call, then removing them for storage.
  EOF
}

variable "target" {
  type = list(object({
    id                                         = number
    scope_id                                   = number
    type                                       = string
    address                                    = optional(string)
    brokered_credential_source_ids             = optional(list(number))
    default_client_port                        = optional(number)
    default_port                               = optional(number)
    description                                = optional(string)
    egress_worker_filter                       = optional(string)
    enable_session_recording                   = optional(bool)
    host_source_ids                            = optional(list(number))
    ingress_worker_filter                      = optional(string)
    injected_application_credential_source_ids = optional(list(number))
    name                                       = optional(string)
    session_connection_limit                   = optional(number)
    session_max_seconds                        = optional(number)
    storage_bucket_id                          = optional(number)
  }))
  default     = []
  description = <<EOF
Required
scope_id (String) The scope ID in which the resource is created. Defaults to the provider's default_scope if unset.
type (String) The target resource type.
Optional
address (String) Optionally, a valid network address to connect to for this target. Cannot be used alongside host_source_ids.
brokered_credential_source_ids (Set of String) A list of brokered credential source ID's.
default_client_port (Number) The default client port for this target.
default_port (Number) The default port for this target.
description (String) The target description.
egress_worker_filter (String) Boolean expression to filter the workers used to access this target
enable_session_recording (Boolean) HCP/Ent Only. Enable sessions recording for this target. Only applicable for SSH targets.
host_source_ids (Set of String) A list of host source ID's. Cannot be used alongside address.
ingress_worker_filter (String) HCP Only. Boolean expression to filter the workers a user will connect to when initiating a session against this target
injected_application_credential_source_ids (Set of String) A list of injected application credential source ID's.
name (String) The target name. Defaults to the resource name.
session_connection_limit (Number)
session_max_seconds (Number)
storage_bucket_id (String) HCP/Ent Only. Storage bucket for this target. Only applicable for SSH targets.
  EOF
}

variable "user" {
  type = list(object({
    id          = number
    scope_id    = number
    account_ids = optional(list(number))
    description = optional(string)
    name        = optional(string)
  }))
  default     = []
  description = <<EOF
Required
scope_id (String) The scope ID in which the resource is created. Defaults to the provider's default_scope if unset.
Optional
account_ids (Set of String) Account ID's to associate with this user resource.
description (String) The user description.
name (String) The username. Defaults to the resource name.
  EOF
}

variable "worker" {
  type = list(object({
    id                          = number
    description                 = optional(string)
    name                        = optional(string)
    scope_id                    = optional(number)
    worker_generated_auth_token = optional(string)
  }))
  default     = []
  description = <<EOF
Optional
description (String) The description for the worker.
name (String) The name for the worker.
scope_id (String) The scope for the worker. Defaults to global.
worker_generated_auth_token (String) The worker authentication token required to register the worker for the worker-led authentication flow. Leaving this blank will result in a controller generated token.
Read-Only
address (String) The accessible address of the self managed worker.
authorized_actions (List of String) A list of actions that the worker is entitled to perform.
controller_generated_activation_token (String) A single use token generated by the controller to be passed to the self-managed worker.
id (String) The ID of the worker.
  EOF
}
