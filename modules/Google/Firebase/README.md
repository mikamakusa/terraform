## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 5.33.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 5.33.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_firebase_android_app.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_firebase_android_app) | resource |
| [google-beta_google_firebase_app_check_play_integrity_config.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_firebase_app_check_play_integrity_config) | resource |
| [google-beta_google_firebase_app_check_recaptcha_enterprise_config.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_firebase_app_check_recaptcha_enterprise_config) | resource |
| [google-beta_google_firebase_app_check_recaptcha_v3_config.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_firebase_app_check_recaptcha_v3_config) | resource |
| [google-beta_google_firebase_database_instance.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_firebase_database_instance) | resource |
| [google-beta_google_firebase_extensions_instance.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_firebase_extensions_instance) | resource |
| [google-beta_google_firebase_hosting_channel.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_firebase_hosting_channel) | resource |
| [google-beta_google_firebase_hosting_custom_domain.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_firebase_hosting_custom_domain) | resource |
| [google-beta_google_firebase_hosting_release.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_firebase_hosting_release) | resource |
| [google-beta_google_firebase_hosting_site.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_firebase_hosting_site) | resource |
| [google-beta_google_firebase_hosting_version.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_firebase_hosting_version) | resource |
| [google-beta_google_firebase_project.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_firebase_project) | resource |
| [google-beta_google_firebase_storage_bucket.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_firebase_storage_bucket) | resource |
| [google-beta_google_project_service.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_project_service) | resource |
| [google-beta_google_storage_bucket.this](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_storage_bucket) | resource |
| [google_apikeys_key.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/apikeys_key) | resource |
| [google_firebase_app_check_app_attest_config.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/firebase_app_check_app_attest_config) | resource |
| [google_firebase_app_check_debug_token.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/firebase_app_check_debug_token) | resource |
| [google_firebase_app_check_device_check_config.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/firebase_app_check_device_check_config) | resource |
| [google_firebase_app_check_service_config.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/firebase_app_check_service_config) | resource |
| [google_firebase_apple_app.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/firebase_apple_app) | resource |
| [google_firebase_web_app.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/firebase_web_app) | resource |
| [google_firebaserules_release.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/firebaserules_release) | resource |
| [google_firebaserules_ruleset.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/resources/firebaserules_ruleset) | resource |
| [time_sleep.this](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [google_project.this](https://registry.terraform.io/providers/hashicorp/google/5.33.0/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_android_app"></a> [android\_app](#input\_android\_app) | n/a | <pre>list(object({<br>    id              = number<br>    display_name    = string<br>    package_name    = string<br>    sha1_hashes     = optional(list(string))<br>    sha256_hashes   = optional(list(string))<br>    api_key_id      = optional(number)<br>    project         = optional(string)<br>    deletion_policy = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_apikeys_key"></a> [apikeys\_key](#input\_apikeys\_key) | n/a | <pre>list(object({<br>    id           = number<br>    name         = string<br>    display_name = optional(string)<br>    restrictions = optional(list(object({<br>      android_key_restrictions = list(object({<br>        allowed_applications = list(object({<br>          sha1_fingerprint = string<br>          package_name     = string<br>        }))<br>      }))<br>      api_targets = optional(list(object({<br>        service = string<br>        methods = optional(list(string))<br>      })))<br>      browser_key_restrictions = optional(list(object({<br>        allowed_referrers = list(string)<br>      })))<br>      ios_key_restrictions = optional(list(object({<br>        allowed_bundle_ids = list(string)<br>      })))<br>      server_key_restrictions = optional(list(object({<br>        allowed_ips = list(string)<br>      })))<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_app_check_app_attest_config"></a> [app\_check\_app\_attest\_config](#input\_app\_check\_app\_attest\_config) | n/a | <pre>list(object({<br>    id        = number<br>    app_id    = number<br>    token_ttl = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_app_check_debug_token"></a> [app\_check\_debug\_token](#input\_app\_check\_debug\_token) | n/a | <pre>list(object({<br>    id           = number<br>    app_id       = number<br>    display_name = string<br>    token        = string<br>  }))</pre> | `[]` | no |
| <a name="input_app_check_device_check_config"></a> [app\_check\_device\_check\_config](#input\_app\_check\_device\_check\_config) | n/a | <pre>list(object({<br>    id          = number<br>    key_id      = string<br>    app_id      = number<br>    private_key = string<br>    token_ttl   = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_app_check_play_integrity_config"></a> [app\_check\_play\_integrity\_config](#input\_app\_check\_play\_integrity\_config) | n/a | <pre>list(object({<br>    id        = number<br>    app_id    = number<br>    token_ttl = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_app_check_recaptcha_enterprise_config"></a> [app\_check\_recaptcha\_enterprise\_config](#input\_app\_check\_recaptcha\_enterprise\_config) | n/a | <pre>list(object({<br>    id        = number<br>    app_id    = number<br>    site_key  = string<br>    token_ttl = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_app_check_recaptcha_v3_config"></a> [app\_check\_recaptcha\_v3\_config](#input\_app\_check\_recaptcha\_v3\_config) | n/a | <pre>list(object({<br>    id          = number<br>    site_secret = string<br>    app_id      = number<br>    token_ttl   = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_app_check_service_config"></a> [app\_check\_service\_config](#input\_app\_check\_service\_config) | n/a | <pre>list(object({<br>    id               = number<br>    service_id       = string<br>    enforcement_mode = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_apple_app"></a> [apple\_app](#input\_apple\_app) | n/a | <pre>list(object({<br>    id              = number<br>    bundle_id       = string<br>    display_name    = string<br>    app_store_id    = optional(string)<br>    api_key_id      = optional(number)<br>    team_id         = optional(string)<br>    deletion_policy = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_database_instance"></a> [database\_instance](#input\_database\_instance) | n/a | <pre>list(object({<br>    id            = number<br>    instance_id   = string<br>    region        = string<br>    type          = optional(string)<br>    desired_state = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_extensions_instance"></a> [extensions\_instance](#input\_extensions\_instance) | n/a | <pre>list(object({<br>    id          = number<br>    instance_id = string<br>    config = list(object({<br>      extension_ref       = string<br>      params              = map(string)<br>      system_params       = optional(map(string))<br>      allowed_event_types = optional(list(string))<br>      eventarc_channel    = optional(string)<br>      extension_version   = optional(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_firebase_storage_bucket"></a> [firebase\_storage\_bucket](#input\_firebase\_storage\_bucket) | n/a | <pre>list(object({<br>    id        = number<br>    bucket_id = number<br>  }))</pre> | `[]` | no |
| <a name="input_firebaserules_release"></a> [firebaserules\_release](#input\_firebaserules\_release) | n/a | <pre>list(object({<br>    id         = number<br>    name       = string<br>    ruleset_id = number<br>  }))</pre> | `[]` | no |
| <a name="input_firebaserules_ruleset"></a> [firebaserules\_ruleset](#input\_firebaserules\_ruleset) | n/a | <pre>list(object({<br>    id = number<br>    source = list(object({<br>      language = optional(string)<br>      files = list(object({<br>        name        = string<br>        content     = string<br>        fingerprint = optional(string)<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_hosting_channel"></a> [hosting\_channel](#input\_hosting\_channel) | n/a | <pre>list(object({<br>    id                     = number<br>    channel_id             = string<br>    site_id                = number<br>    retained_release_count = optional(number)<br>    labels                 = optional(map(string))<br>    expire_time            = optional(string)<br>    ttl                    = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_hosting_custom_domain"></a> [hosting\_custom\_domain](#input\_hosting\_custom\_domain) | n/a | <pre>list(object({<br>    id                    = number<br>    custom_domain         = string<br>    site_id               = number<br>    cert_preference       = optional(string)<br>    redirect_target       = optional(string)<br>    wait_dns_verification = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_hosting_release"></a> [hosting\_release](#input\_hosting\_release) | n/a | <pre>list(object({<br>    id         = number<br>    site_id    = number<br>    type       = optional(string)<br>    message    = optional(string)<br>    channel_id = optional(number)<br>    version_id = optional(number)<br>  }))</pre> | `[]` | no |
| <a name="input_hosting_site"></a> [hosting\_site](#input\_hosting\_site) | n/a | <pre>list(object({<br>    id      = number<br>    app_id  = optional(number)<br>    site_id = optional(string)<br>  }))</pre> | `[]` | no |
| <a name="input_hosting_version"></a> [hosting\_version](#input\_hosting\_version) | n/a | <pre>list(object({<br>    id      = number<br>    site_id = number<br>    config = list(object({<br>      redirects = optional(list(object({<br>        location    = string<br>        status_code = string<br>        glob        = optional(string)<br>        regex       = optional(string)<br>      })), [])<br>      rewrites = optional(list(object({<br>        glob     = optional(string)<br>        regex    = optional(string)<br>        path     = optional(string)<br>        function = optional(string)<br>        run = optional(list(object({<br>          service_id = string<br>          region     = optional(string)<br>        })), [])<br>      })), [])<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | n/a | `map(string)` | `{}` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_storage_bucket"></a> [storage\_bucket](#input\_storage\_bucket) | n/a | <pre>list(object({<br>    id       = number<br>    name     = string<br>    location = string<br>  }))</pre> | `[]` | no |
| <a name="input_time_sleep"></a> [time\_sleep](#input\_time\_sleep) | n/a | `string` | n/a | yes |
| <a name="input_web_app"></a> [web\_app](#input\_web\_app) | n/a | <pre>list(object({<br>    id              = number<br>    display_name    = string<br>    api_key_id      = optional(number)<br>    deletion_policy = optional(string)<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firebase_android_app"></a> [firebase\_android\_app](#output\_firebase\_android\_app) | n/a |
| <a name="output_firebase_apple_app"></a> [firebase\_apple\_app](#output\_firebase\_apple\_app) | n/a |
| <a name="output_firebase_web_app"></a> [firebase\_web\_app](#output\_firebase\_web\_app) | n/a |
