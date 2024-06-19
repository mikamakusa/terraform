resource "google_firebase_project" "this" {
  provider = google-beta
  project  = data.google_project.this.id
}

resource "google_project_service" "this" {
  provider = google-beta
  project  = data.google_project.this.id
  service  = "firebasedatabase.googleapis.com"
}

resource "time_sleep" "this" {
  count           = var.time_sleep ? 1 : 0 && (length(var.android_app) || length(var.web_app) || length(var.apple_app))
  create_duration = var.time_sleep
}

resource "google_apikeys_key" "this" {
  count        = length(var.apikeys_key)
  name         = lookup(var.apikeys_key, "name")
  display_name = lookup(var.apikeys_key, "display_name")
  project      = data.google_project.this.id

  dynamic "restrictions" {
    for_each = lookup(var.apikeys_key[count.index], "restrictions") == null ? [] : ["restrictions"]
    content {
      dynamic "android_key_restrictions" {
        for_each = lookup(restrictions.value, "android_key_restrictions")
        content {
          dynamic "allowed_applications" {
            for_each = lookup(android_key_restrictions.value, "allowed_applications")
            content {
              sha1_fingerprint = lookup(allowed_applications.value, "sha1_fingerprint")
              package_name     = lookup(allowed_applications.value, "package_name")
            }
          }
        }
      }

      dynamic "api_targets" {
        for_each = lookup(var.apikeys_key[count.index], "api_targets") == null ? [] : ["api_targets"]
        content {
          service = lookup(api_targets.value, "service")
          methods = lookup(api_targets.value, "methods")
        }
      }

      dynamic "browser_key_restrictions" {
        for_each = lookup(var.apikeys_key[count.index], "browser_key_restrictions") == null ? [] : ["browser_key_restrictions"]
        content {
          allowed_referrers = lookup(browser_key_restrictions.value, "allowed_referrers")
        }
      }

      dynamic "ios_key_restrictions" {
        for_each = lookup(var.apikeys_key[count.index], "ios_key_restrictions") == null ? [] : ["ios_key_restrictions"]
        content {
          allowed_bundle_ids = lookup(ios_key_restrictions.value, "allowed_bundle_ids")
        }
      }

      dynamic "server_key_restrictions" {
        for_each = lookup(var.apikeys_key[count.index], "server_key_restrictions") == null ? [] : ["server_key_restrictions"]
        content {
          allowed_ips = lookup(server_key_restrictions.value, "allowed_ips")
        }
      }
    }
  }
}

resource "google_storage_bucket" "this" {
  count                       = length(var.storage_bucket)
  provider                    = google-beta
  project                     = data.google_project.this.name
  location                    = lookup(var.storage_bucket[count.index], "location")
  name                        = lookup(var.storage_bucket[count.index], "name")
  uniform_bucket_level_access = true
  force_destroy               = true
}

resource "google_firebase_android_app" "this" {
  count           = length(var.android_app)
  provider        = google-beta
  display_name    = lookup(var.android_app[count.index], "display_name")
  package_name    = lookup(var.android_app[count.index], "package_name")
  sha1_hashes     = lookup(var.android_app[count.index], "sha1_hashes")
  sha256_hashes   = lookup(var.android_app[count.index], "sha256_hashes")
  api_key_id      = try(element(google_apikeys_key.this.*.id, lookup(var.android_app[count.index], "api_key_id")))
  project         = data.google_project.this.name
  deletion_policy = lookup(var.android_app[count.index], "deletion_policy")
}

resource "google_firebase_apple_app" "this" {
  count           = length(var.apple_app)
  bundle_id       = lookup(var.apple_app[count.index], "bundle_id")
  display_name    = lookup(var.apple_app[count.index], "display_name")
  app_store_id    = lookup(var.apple_app[count.index], "app_store_id")
  api_key_id      = try(element(google_apikeys_key.this.*.id, lookup(var.apple_app[count.index], "api_key_id")))
  team_id         = lookup(var.apple_app[count.index], "team_id")
  project         = data.google_project.this.name
  deletion_policy = lookup(var.apple_app[count.index], "deletion_policy")
}

resource "google_firebase_web_app" "this" {
  count           = length(var.web_app)
  display_name    = lookup(var.web_app[count.index], "display_name")
  api_key_id      = try(element(google_apikeys_key.this.*.id, lookup(var.web_app[count.index], "api_key_id")))
  project         = data.google_project.this.name
  deletion_policy = lookup(var.web_app[count.index], "deletion_policy")
}

resource "google_firebase_app_check_app_attest_config" "this" {
  count      = length(var.apple_app) == 0 ? 0 : length(var.app_check_app_attest_config)
  app_id     = try(element(google_firebase_apple_app.this.*.app_id, lookup(var.app_check_app_attest_config[count.index], "app_id")))
  token_ttl  = lookup(var.app_check_app_attest_config[count.index], "token_ttl")
  project    = data.google_project.this.name
  depends_on = [time_sleep.this]
}

resource "google_firebase_app_check_debug_token" "this" {
  count        = length(var.web_app) == 0 ? 0 : length(var.app_check_debug_token)
  app_id       = try(element(google_firebase_web_app.this.*.app_id, lookup(var.app_check_debug_token[count.index], "app_id")))
  display_name = lookup(var.app_check_debug_token[count.index], "display_name")
  token        = lookup(var.app_check_debug_token[count.index], "token")
  project      = data.google_project.this.name
  depends_on   = [time_sleep.this]
}

resource "google_firebase_app_check_device_check_config" "this" {
  count       = length(var.apple_app) == 0 ? 0 : length(var.app_check_device_check_config)
  key_id      = lookup(var.app_check_device_check_config[count.index], "key_id")
  app_id      = try(element(google_firebase_apple_app.this.*.app_id, lookup(var.app_check_device_check_config[count.index], "app_id")))
  private_key = lookup(var.app_check_device_check_config[count.index], "private_key")
  token_ttl   = lookup(var.app_check_device_check_config[count.index], "token_ttl")
  project     = data.google_project.this.name
  depends_on  = [time_sleep.this]
}

resource "google_firebase_app_check_play_integrity_config" "this" {
  count      = length(var.android_app) == 0 ? 0 : length(var.app_check_play_integrity_config)
  provider   = google-beta
  app_id     = try(element(google_firebase_android_app.this.*.app_id, lookup(var.app_check_play_integrity_config[count.index], "app_id")))
  project    = data.google_project.this.name
  token_ttl  = lookup(var.app_check_play_integrity_config[count.index], "token_ttl")
  depends_on = [time_sleep.this]
}

resource "google_firebase_app_check_recaptcha_enterprise_config" "this" {
  count      = length(var.web_app) == 0 ? 0 : length(var.app_check_recaptcha_enterprise_config)
  provider   = google-beta
  app_id     = try(element(google_firebase_web_app.this.*.app_id, lookup(var.app_check_recaptcha_enterprise_config[count.index], "app_id")))
  site_key   = lookup(var.app_check_recaptcha_enterprise_config[count.index], "site_key")
  token_ttl  = lookup(var.app_check_recaptcha_enterprise_config[count.index], "token_ttl")
  project    = data.google_project.this.name
  depends_on = [time_sleep.this]
}

resource "google_firebase_app_check_recaptcha_v3_config" "this" {
  count       = length(var.web_app) == 0 ? 0 : length(var.app_check_recaptcha_v3_config)
  provider    = google-beta
  site_secret = lookup(var.app_check_recaptcha_v3_config[count.index], "site_secret")
  app_id      = try(element(google_firebase_web_app.this.*.app_id, lookup(var.app_check_recaptcha_v3_config[count.index], "app_id")))
  token_ttl   = lookup(var.app_check_recaptcha_v3_config[count.index], "token_ttl")
  project     = data.google_project.this.name
  depends_on  = [time_sleep.this]
}

resource "google_firebase_app_check_service_config" "this" {
  count            = length(var.app_check_service_config)
  service_id       = lookup(var.app_check_service_config[count.index], "service_id")
  enforcement_mode = lookup(var.app_check_service_config[count.index], "enforcement_mode")
  project          = data.google_project.this.name
  depends_on       = [google_project_service.this]
}

resource "google_firebase_extensions_instance" "this" {
  count       = length(var.extensions_instance)
  provider    = google-beta
  project     = data.google_project.this.name
  instance_id = lookup(var.extensions_instance[count.index], "instance_id")

  dynamic "config" {
    for_each = lookup(var.extensions_instance[count.index], "config")
    content {
      extension_ref       = lookup(config.value, "extension_ref")
      params              = lookup(config.value, "params")
      system_params       = lookup(config.value, "system_params")
      allowed_event_types = lookup(config.value, "allowed_event_types")
      eventarc_channel    = lookup(config.value, "eventarc_channel")
      extension_version   = lookup(config.value, "extension_version")
    }
  }
}

resource "google_firebase_hosting_channel" "this" {
  count                  = length(var.hosting_site) == 0 ? 0 : length(var.hosting_channel)
  provider               = google-beta
  channel_id             = lookup(var.hosting_channel[count.index], "channel_id")
  site_id                = try(element(google_firebase_hosting_site.this.*.site_id, lookup(var.hosting_channel[count.index], "site_id")))
  retained_release_count = lookup(var.hosting_channel[count.index], "retained_release_count")
  labels                 = merge(var.labels, lookup(var.hosting_channel[count.index], "labels"))
  expire_time            = lookup(var.hosting_channel[count.index], "expire_time")
  ttl                    = lookup(var.hosting_channel[count.index], "ttl")
}

resource "google_firebase_hosting_custom_domain" "this" {
  count                 = length(var.hosting_site) == 0 ? 0 : length(var.hosting_custom_domain)
  provider              = google-beta
  custom_domain         = lookup(var.hosting_custom_domain[count.index], "custom_domain")
  site_id               = try(element(google_firebase_hosting_site.this.*.site_id, lookup(var.hosting_custom_domain[count.index], "site_id", )))
  cert_preference       = lookup(var.hosting_custom_domain[count.index], "cert_preference")
  redirect_target       = lookup(var.hosting_custom_domain[count.index], "redirect_target")
  wait_dns_verification = lookup(var.hosting_custom_domain[count.index], "wait_dns_verification")
  project               = data.google_project.this.name
}

resource "google_firebase_hosting_release" "this" {
  count        = length(var.hosting_site) == 0 ? 0 : length(var.hosting_release)
  provider     = google-beta
  site_id      = try(element(google_firebase_hosting_site.this.*.site_id, lookup(var.hosting_release[count.index], "site_id")))
  type         = lookup(var.hosting_release[count.index], "type")
  message      = lookup(var.hosting_release[count.index], "message")
  channel_id   = try(element(google_firebase_hosting_channel.this.*.id, lookup(var.hosting_release[count.index], "channel_id")))
  version_name = try(element(google_firebase_hosting_version.this.*.name, lookup(var.hosting_release[count.index], "version_id")))
}

resource "google_firebase_hosting_site" "this" {
  count    = length(var.hosting_site)
  provider = google-beta
  project  = data.google_project.this.name
  app_id   = try(element(google_firebase_web_app.this.*.app_id, lookup(var.hosting_site[count.index], "app_id")))
  site_id  = lookup(var.hosting_site[count.index], "site_id")
}

resource "google_firebase_hosting_version" "this" {
  count    = length(var.hosting_site) == 0 ? 0 : length(var.hosting_version)
  provider = google-beta
  site_id  = try(element(google_firebase_hosting_site.this.*.site_id, lookup(var.hosting_version[count.index], "site_id")))

  dynamic "config" {
    for_each = lookup(var.hosting_version[count.index], "config")
    content {
      dynamic "redirects" {
        for_each = try(lookup(config.value, "redirects")) == null ? [] : ["redirects"]
        content {
          location    = lookup(redirects.value, "location")
          status_code = lookup(redirects.value, "status_code")
          glob        = lookup(redirects.value, "glob")
          regex       = lookup(redirects.value, "regex")
        }
      }

      dynamic "rewrites" {
        for_each = try(lookup(config.value, "rewrites")) == null ? [] : ["rewrites"]
        content {
          glob     = lookup(rewrites.value, "glob")
          regex    = lookup(rewrites.value, "regex")
          path     = lookup(rewrites.value, "path")
          function = lookup(rewrites.value, "function")

          dynamic "run" {
            for_each = try(lookup(rewrites.value, "run")) == null ? [] : ["run"]
            content {
              service_id = lookup(run.value, "service_id")
              region     = lookup(run.value, "region")
            }
          }
        }
      }
    }
  }
}

resource "google_firebase_database_instance" "this" {
  count         = length(var.database_instance)
  instance_id   = lookup(var.database_instance[count.index], "instance_id")
  region        = lookup(var.database_instance[count.index], "region")
  type          = lookup(var.database_instance[count.index], "type")
  desired_state = lookup(var.database_instance[count.index], "desired_state")
  project       = google_firebase_project.this.project
  provider      = google-beta
}

resource "google_firebase_storage_bucket" "this" {
  count     = length(var.storage_bucket) == 0 ? 0 : length(var.firebase_storage_bucket)
  provider  = google-beta
  project   = data.google_project.this.id
  bucket_id = try(element(google_storage_bucket.this.*.id, lookup(var.firebase_storage_bucket[count.index], "bucket_id")))
}

resource "google_firebaserules_release" "this" {
  count        = length(var.firebaserules_ruleset) == 0 ? 0 : length(var.firebaserules_release)
  project      = data.google_project.this.name
  name         = lookup(var.firebaserules_release[count.index], "name")
  ruleset_name = try(element(google_firebaserules_ruleset.this.*.name, lookup(var.firebaserules_release[count.index], "ruleset_id")))
}

resource "google_firebaserules_ruleset" "this" {
  count   = length(var.firebaserules_ruleset)
  project = data.google_project.this.name

  dynamic "source" {
    for_each = lookup(var.firebaserules_ruleset[count.index], "source")
    content {
      language = lookup(source.value, "language")
      dynamic "files" {
        for_each = lookup(source.value, "files")
        content {
          name        = lookup(files.value, "name")
          content     = lookup(files.value, "content")
          fingerprint = lookup(files.value, "fingerprint")
        }
      }
    }
  }
}