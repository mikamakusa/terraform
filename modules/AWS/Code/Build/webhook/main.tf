resource "aws_codebuild_webhook" "webhook" {
  count         = length(var.webhook)
  project_name  = element(var.project_name, lookup(var.webhook[count.index], "project_id"))
  branch_filter = lookup(var.webhook[count.index], "branch_filter")

  dynamic "filter_group" {
    for_each = lookup(var.webhook[count.index], "branch_filter") != null ? [] : [for i in lookup(var.webhook[count.index], "filter_group") : {
      filter = lookup(i, "filter", null)
    }]
    content {
      dynamic "filter" {
        for_each = [for i in filter_group.value.filter : {
          pattern                 = i.pattern
          type                    = i.type
          exclude_matched_pattern = i.exclude_matched_pattern
        }]
        content {
          pattern                 = filter.value.pattern
          type                    = filter.value.type
          exclude_matched_pattern = filter.value.exclude_matched_pattern
        }
      }
    }
  }
}