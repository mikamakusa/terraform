resource "aws_prometheus_alert_manager_definition" "this" {
  count        = length(var.workspace) == 0 ? 0 : length(var.alert_manager_definition)
  definition   = lookup(var.alert_manager_definition[count.index], "definition")
  workspace_id = try(element(aws_prometheus_workspace.this.*.id, lookup(var.alert_manager_definition[count.index], "workspace_id")))
}

resource "aws_prometheus_rule_group_namespace" "this" {
  count        = length(var.workspace) == 0 ? 0 : length(var.rule_group_namespace)
  data         = file(join("/", [path.cwd, "rules", lookup(var.rule_group_namespace[count.index], "data")]))
  name         = lookup(var.rule_group_namespace[count.index], "name")
  workspace_id = try(element(aws_prometheus_workspace.this.*.id, lookup(var.rule_group_namespace[count.index], "workspace_id")))
}

resource "aws_prometheus_scraper" "this" {
  count                = length(var.scraper)
  scrape_configuration = file(join("/", [path.cwd, "scrape", lookup(var.scraper[count.index], "scrape_configuration")]))
  alias                = lookup(var.scraper[count.index], "alias")

  dynamic "destination" {
    for_each = lookup(var.scraper[count.index], "destination")
    content {
      dynamic "amp" {
        for_each = lookup(destination.value, "amp")
        content {
          workspace_arn = try(element(aws_prometheus_workspace.this.*.arn, lookup(amp.value, "workspace_id")))
        }
      }
    }
  }

  source {
    eks {
      subnet_ids         = data.aws_eks_cluster.this.vpc_config[0].subnet_ids
      cluster_arn        = data.aws_eks_cluster.this.arn
      security_group_ids = data.aws_eks_cluster.this.vpc_config[0].security_group_ids
    }
  }
}

resource "aws_prometheus_workspace" "this" {
  count       = length(var.workspace)
  alias       = lookup(var.workspace[count.index], "alias")
  kms_key_arn = lookup(var.workspace[count.index], "kms_key_arn")
  tags        = lookup(var.workspace[count.index], "tags")

  logging_configuration {
    log_group_arn = data.aws_cloudwatch_log_group.this.arn
  }
}