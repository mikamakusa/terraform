resource "digitalocean_app" "app" {
  count = length(var.app)

  dynamic "spec" {
    for_each = [for i in lookup(var.app[count.index], "spec") : {
      name    = i.name
      region  = i.region
      domains = i.domains
      service = lookup(i, "service")
    }]
    content {
      name    = spec.value.name
      region  = spec.value.region
      domains = spec.value.domains
      dynamic "service" {
        for_each = [for s in spec.service.value : {
          name               = s.name
          build_command      = s.build_command
          dockerfile_path    = s.dockerfile_path
          source_dir         = s.source_dir
          run_command        = s.run_command
          environment_slug   = s.environment_slug
          instance_size_slug = s.instance_size_slug
          instance_count     = s.instance_count
          http_port          = s.http_port
          git                = lookup(s, "git", null)
          github             = lookup(s, "github", null)
          env                = lookup(s, "env", null)
          health_check       = lookup(s, "health_check", null)
          route              = lookup(s, "route", null)
        }]
        content {
          name               = service.value.name
          build_command      = service.value.build_command
          dockerfile_path    = service.value.dockerfile_path
          source_dir         = service.value.source_dir
          run_command        = service.value.run_command
          environment_slug   = service.value.environment_slug
          instance_size_slug = service.value.instance_size_slug
          instance_count     = service.value.instance_count
          http_port          = service.value.http_port
          dynamic "git" {
            for_each = service.value.git == null ? [] : [for g in service.value.git : {
              repo_clone_url = g.repo_clone_url
              branch         = g.branch
            }]
            content {
              repo_clone_url = git.value.repo_clone_url
              branch         = git.value.branch
            }
          }
          dynamic "github" {
            for_each = service.value.github == null ? [] : [for gh in service.value.github : {
              repo           = gh.repo
              branch         = gh.branch
              deploy_on_push = gh.deploy_on_push
            }]
            content {
              repo           = github.value.repo
              branch         = github.value.branch
              deploy_on_push = github.value.deploy_on_push
            }
          }
          dynamic "env" {
            for_each = service.value.env == null ? [] : [for e in service.value.env : {
              key   = e.key
              value = e.value
              scope = e.scope
              type  = e.type
            }]
            content {
              key   = env.value.key
              value = env.value.value
              scope = env.value.scope
              type  = env.value.type
            }
          }
          dynamic "route" {
            for_each = service.value.route == null ? [] : [for r in service.value.route : {
              path = r.path
            }]
            content {
              path = route.value.path
            }
          }
          dynamic "health_check" {
            for_each = service.value.health_check == null ? [] : [for hc in service.value.health_check : {
              http_path             = hc.http_path
              initial_delay_seconds = hc.initial_delay_seconds
              period_seconds        = hc.period_seconds
              timeout_seconds       = hc.timeout_seconds
              success_threshold     = hc.success_threshold
              failure_threshold     = hc.failure_threshold
            }]
            content {
              http_path             = health_check.value.http_path
              initial_delay_seconds = health_check.value.initial_delay_seconds
              period_seconds        = health_check.value.period_seconds
              timeout_seconds       = health_check.value.timeout_seconds
              success_threshold     = health_check.value.success_threshold
              failure_threshold     = health_check.value.failure_threshold
            }
          }
        }
      }
    }
  }
  dynamic "worker" {
    for_each = lookup(var.app[count.index], "worker") == null ? [] : [for w in lookup(var.app[count.index], "worker") : {
      name               = w.name
      build_command      = w.build_command
      dockerfile_path    = w.dockerfile_path
      source_dir         = w.source_dir
      run_command        = w.run_command
      environment_slug   = w.environment_slug
      instance_size_slug = w.instance_size_slug
      instance_count     = w.instance_count
      http_port          = w.http_port
      git                = lookup(w, "git", null)
      github             = lookup(w, "github", null)
      env                = lookup(w, "env", null)
    }]
    content {
      name               = worker.value.name
      build_command      = worker.value.build_command
      dockerfile_path    = worker.value.dockerfile_path
      source_dir         = worker.value.source_dir
      run_command        = worker.value.run_command
      environment_slug   = worker.value.environment_slug
      instance_size_slug = worker.value.instance_size_slug
      instance_count     = worker.value.instance_count
      http_port          = worker.value.http_port
      dynamic "git" {
        for_each = worker.value.git == null ? [] : [for g in worker.value.git : {
          repo_clone_url = g.repo_clone_url
          branch         = g.branch
        }]
        content {
          repo_clone_url = git.value.repo_clone_url
          branch         = git.value.branch
        }
      }
      dynamic "github" {
        for_each = worker.value.github == null ? [] : [for gh in worker.value.github : {
          repo           = gw.repo
          branch         = gw.branch
          deploy_on_push = gw.deploy_on_push
        }]
        content {
          repo           = github.value.repo
          branch         = github.value.branch
          deploy_on_push = github.value.deploy_on_push
        }
      }
      dynamic "env" {
        for_each = worker.value.env == null ? [] : [for e in worker.value.env : {
          key   = e.key
          value = e.value
          scope = e.scope
          type  = e.type
        }]
        content {
          key   = env.value.key
          value = env.value.value
          scope = env.value.scope
          type  = env.value.type
        }
      }
    }
  }

  dynamic "static_site" {
    for_each = lookup(var.app[count.index], "static_site") == null ? [] : [for ss in lookup(var.app[count.index], "static_site") : {
      name               = ss.name
      build_command      = ss.build_command
      dockerfile_path    = ss.dockerfile_path
      source_dir         = ss.source_dir
      run_command        = ss.run_command
      environment_slug   = ss.environment_slug
      instance_size_slug = ss.instance_size_slug
      instance_count     = ss.instance_count
      http_port          = ss.http_port
      git                = lookup(ss, "git", null)
      github             = lookup(ss, "github", null)
      env                = lookup(ss, "env", null)
      health_check       = lookup(ss, "health_check", null)
    }]
    content {
      name               = static_site.value.name
      build_command      = static_site.value.build_command
      dockerfile_path    = static_site.value.dockerfile_path
      source_dir         = static_site.value.source_dir
      run_command        = static_site.value.run_command
      environment_slug   = static_site.value.environment_slug
      instance_size_slug = static_site.value.instance_size_slug
      instance_count     = static_site.value.instance_count
      http_port          = static_site.value.http_port
      dynamic "git" {
        for_each = static_site.value.git == null ? [] : [for g in static_site.value.git : {
          repo_clone_url = g.repo_clone_url
          branch         = g.branch
        }]
        content {
          repo_clone_url = git.value.repo_clone_url
          branch         = git.value.branch
        }
      }
      dynamic "github" {
        for_each = static_site.value.github == null ? [] : [for gh in static_site.value.github : {
          repo           = gh.repo
          branch         = gh.branch
          deploy_on_push = gh.deploy_on_push
        }]
        content {
          repo           = github.value.repo
          branch         = github.value.branch
          deploy_on_push = github.value.deploy_on_push
        }
      }
      dynamic "env" {
        for_each = static_site.value.env == null ? [] : [for e in static_site.value.env : {
          key   = e.key
          value = e.value
          scope = e.scope
          type  = e.type
        }]
        content {
          key   = env.value.key
          value = env.value.value
          scope = env.value.scope
          type  = env.value.type
        }
      }
      dynamic "route" {
        for_each = static_site.value.route == null ? [] : [for r in static_site.value.route : {
          path = r.path
        }]
        content {
          path = route.value.path
        }
      }
    }
  }
}