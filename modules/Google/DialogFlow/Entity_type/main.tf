resource "google_dialogflow_entity_type" "entity_type" {
  depends_on              = [var.depends]
  count                   = length(var.entity_type)
  display_name            = lookup(var.entity_type[count.index], "display_name")
  kind                    = lookup(var.entity_type[count.index], "kind")
  enable_fuzzy_extraction = lookup(var.entity_type[count.index], "enable_fuzzy_extraction")
  project                 = var.project

  dynamic "entities" {
    for_each = lookup(var.entity_type[count.index], "entities")
    content {
      value    = lookup(entities.value, "value")
      synonyms = lookup(entities.value, "synonyms")
    }
  }
}
